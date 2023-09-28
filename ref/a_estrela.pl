% ##################
% SOLVE RUBIK'S CUBE
% ##################




% solve(+Rubik'sCube, -Steps) :- List of steps solving Rubik'sCube with specified algorithm.
solve(Rubik, Solution) :- solve_basic(Rubik,Solution).








% ###############################
% RUBIK'S CUBE SOLVING ALGORITHMS
% ###############################




% solve_basic(+Rubik'sCube,-Steps) :- List of Steps solving our "Rubik'sCube".
% Simple recursive approach.
solve_basic(Rubik,[]) :- solved(Rubik). 
solve_basic(Rubik,[NewMove | Moves]) :- solve_basic(NewState,Moves), move(NewMove, Rubik, NewState).

% solve_Astar_1(+Rubik'sCube,-Steps) :- List of steps solving our "Rubik'sCube".
% A star approach. Using metric based on function h_function1 (number of wrongly placed colors).
solve_Astar_1(Rubik,Steps) :- solve_Astar(Rubik,Steps,h_function1), !.

% solve_Astar_3(+Rubik'sCube,-Steps)  :- List of steps solving our "Rubik'sCube".
% A star approach. Using metric based on function h_function3 (number of wrongly placed little cubes).







% #############
% A* COMPONENTS
% #############




% solve_Astar(+Rubik'sCube,-Steps,+H_func) :- Search steps solving Rubik'sCube using A*,
% 									The algorithm is based on a NodeList, List of nodes with data [Rubik,Steps,F,D],
% 									
% 										where Rubik is a state of a cube, Steps is a list of moves from Rubik'sCube to Rubik, F is a value of function F and D is a number
% 										of steps from start .. DistanceFromStart,
% 									
% 									and that NodeList is ordered by value of function F, with no repeated Rubik's State of nodes,
% 									And the algorithm takes the cheapest element, finds all children/followers, inserts them into NodeList until the solved state is found.  
solve_Astar(Rubik,Steps,H_func) :- f_function(Rubik,FunctionF,0,H_func),search([[Rubik,[],FunctionF,0]],ReversedSteps,H_func), reverse(ReversedSteps,Steps).

% search(+NodeList,-Steps,+H_func) :- take cheapest node, first one of NodeList,
% 			 look for all his followers and create a new NodeList with them, still ordered by value of function F 
% 			 until the solved Rubik is found.
search([[Rubik,Steps,_,_]|_],Steps,_) :- solved(Rubik).
search([CheapestNode|NodeList],Steps,H_func) :- find_followers(CheapestNode,AllFollowers,H_func),insert_followers(AllFollowers,NodeList,NewNodeList),search(NewNodeList,Steps,H_func).

% find_followers(+Node,-AllFollowers,+H_func) :- find all followers (passed in AllFollowers) for actual node 'Node' using bagof. 
find_followers([Rubik,Steps,_,DistanceFromStart],AllFollowers,H_func) :- bagof([Follower,[Move|Steps],F,NewDistanceFromStart],
           (NewDistanceFromStart is DistanceFromStart+1,move(Move,Rubik,Follower),f_function(Follower,F,NewDistanceFromStart,H_func)),
           AllFollowers).

% insert_followers(+ListToInsert,+NodeList,-NewNodeList) :- NewNodeList is a list created by inserting nodes from ListToInsert into NodeList,
% 													still ordered by function F and without repeated same states of Rubiks. 
insert_followers([ElementToInsert|ListToInsert],NodeList,NewNodeList) :- insert_single(ElementToInsert,NodeList,NodeListWithOneInserted), insert_followers(ListToInsert,NodeListWithOneInserted,NewNodeList).
insert_followers([],NodeList,NodeList).

% insert_single(+ElementToInsert, +NodeList, -NodeListWithThatElement) :- NodeListWithThatElement is a result of inserted ElementToInsert into NodeList,
% 															ElementToInsert has to have a uniq Rubik State (or there is a cheaper version of this state)
% 															and all elements before ElementToInsert have a cheaper value of function F and the first (-> all) elment after
% 															ElementToInsert should be more expensive.
insert_single(ElementToInsert,NodeList,NodeList) :- repeating_nodes(ElementToInsert,NodeList),!.
insert_single(ElementToInsert,[X|NodeList],[ElementToInsert,X|NodeList]) :- not_ordered_nodes_by_F(ElementToInsert,X),!.
insert_single(ElementToInsert,[X|NodeList],[X|NodeListWithOneInserted]) :- insert_single(ElementToInsert,NodeList,NodeListWithOneInserted),!.
insert_single(ElementToInsert,[],[ElementToInsert]).

% repeating_nodes(?ElemnetToInsert, ?NodeList) :- false, if there is not a same element for ElementToInsert as a head of NodeList (with same State),
% 											in a way insert_single is using it .. false, if there is not same element in whole list, 
% 											otherwise true.
repeating_nodes([Rubik,_,_,_], [[Rubik,_,_,_]|_]).

% not_ordered_nodes_by_F(?Node1,?Node2) :- Comparing two nodes, whether the Node1 has cheaper value of function F, then Node2. 
not_ordered_nodes_by_F( [_,_,FunctionF1,_], [_,_,FunctionF2,_] ) :- FunctionF1 < FunctionF2.

% f_function(+Rubik'sCube,-FunctionF,+DistanceFromStart,+H_func) :- FunctionF is result of sum of DistanceFromStart (number of steps) and FunctionH (using H_func function) for Rubik'sCube.
f_function(Rubik,FunctionF,DistanceFromStart,H_func) :- call(H_func,Rubik,FunctionH),FunctionF is DistanceFromStart + FunctionH.








% ####################################################
% H FUNCTIONS FOR A* ALGORITHM FOR EACH OF OUR METRICS
% ####################################################




% h_function1(+Rubik'sCube, -H) :- "Rubik'sCube" has value of H. That value is based on the number of correct colers.
% The maximum value of H is 48, when all colers of the cube "Rubik'sCube" are wrongly placed.
h_function1(R, H) :- h_singleFields(R, H).

% h_function2(+Rubik'sCube, -H) :- "Rubik'sCube" has value of H. That value is based on the number of moves we need to solve the cube.
% Basically, function takes maximum value of three components - number of moves to solve corners, to solve half od edges and to solve the resting half of edges.
% .. h(n) = max {h_{corners}(n), h_{e1}(n), h_{e2}(n)}
% Inspiration from here http://www.diva-portal.org/smash/get/diva2:816583/FULLTEXT01.pdf
%
% Only problem is that we don't know the number of moves. So we have two options 1) pregenerate all situations and their distances 2) find the number with some other solver.
h_function2(R, H) :- h_max(R, H).


% h_function3(+Rubik'sCube, -H) :- "Rubik'sCube" has value of H. That value is based on the number of correct little cubes.
% The maximum value of H is 20, when all little cubes of the cube "Rubik'sCube" are wrongly placed.
h_function3(R, H) :- h_littleCubes(R, N), H is 20 - N.








% ###################
% FIRST METRIC FOR A*
% ###################




% h_singleFields(+Rubik'sCube, -H) :- H is a number of wrongly placed colors in our cube "Rubik'sCube".
h_singleFields(rubik(A1,A2,A3,A4,B1,B2,B3,B4,C1,C2,C3,C4,D1,D2,D3,D4,E1,E2,E3,E4,F1,F2,F3,F4), H) :-
     same(A1, w, N11), same(A2, w, N12), same(A3, w, N13), same(A4, w, N14),
     same(B1, g, N21), same(B2, g, N22), same(B3, g, N23), same(B4, g, N24),
     same(C1, r, N31), same(C2, r, N32), same(C3, r, N33), same(C4, r, N34),
     same(D1, b, N41), same(D2, b, N42), same(D3, b, N43), same(D4, b, N44),
     same(E1, o, N51), same(E2, o, N52), same(E3, o, N53), same(E4, E5, N54),
     same(F1, y, N61), same(F2, y, N62), same(F3, y, N63), same(F4, y, N64),
     H is 16-N11-N12-N13-N14-N21-N22-N23-N24-N31-N32-N33-N34-N41-N42-N43-N44-N51-N52-N53-N54-N61-N62-N63-N64.

 % a1 a3 a7 a9

% same(+Color1, +Color2, -Num) :- For C1 == C2 we have Num = 1. Otherwise N = 0.
same(C1,C2,N) :- C1 == C2, !, N = 1.
same(C1,C2,N) :- C1 \= C2, N = 0.











% ##########################
% SITUATIONS OF RUBIK'S CUBE
% ##########################




%solved(?Rubik'sCube) :- Rubik'sCube is solved cube.
solved(rubik(W,W,W,W,G,G,G,G,R,R,R,R,B,B,B,B,O,O,O,O,Y,Y,Y,Y)).






% ####################################################
% DATA STRUCTURE OF RUBIK'S CUBE WITH MOVES DEFINITION
% ####################################################




%move(clockwise_up, CubeBefore, CubeAfter) :- If we rotate 'up' side ('W'hite color) in clockwise direction of CubeBefore, we get CubeAfter.
%							
move(clockwise_UP,
    rubik(W1,W2,W3,W4,G1,G2,G3,G4,R1,R2,R3,R4,B1,B2,B3,B4,O1,O2,O3,O4,Y1,Y2,Y3,Y4),
    rubik(W1,W2,W3,W4,R1,R2,G3,G4,B1,B2,R3,R4,O1,O2,B3,B4,G1,G2,O3,O4,Y1,Y2,Y3,Y4),
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_UP,Before,After) :- move(clockwise_UP,After,Before).



%move(clockwise_down, CubeBefore, CubeAfter) :- If we rotate 'down' side ('Y'ellow color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_DOWN,
    rubik(W1,W2,W3,W4,G1,G2,G3,G4,R1,R2,R3,R4,B1,B2,B3,B4,O1,O2,O3,O4,Y1,Y2,Y3,Y4),
    rubik(W1,W2,W3,W4,G1,G2,R3,R4,R1,R2,B3,B4,B1,B2,O3,O4,O1,O2,G3,G4,Y2,Y4,Y1,Y3),
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_DOWN,Before,After) :- move(clockwise_DOWN,After,Before).



%move(clockwise_left, CubeBefore, CubeAfter) :- If we rotate 'left' side ('G'reen color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_LEFT,
    rubik(W1,W2,W3,W4,G1,G2,G3,G4,R1,R2,R3,R4,B1,B2,B3,B4,O1,O2,O3,O4,Y1,Y2,Y3,Y4),
    rubik(O4,W2,O2,W4,G3,G1,G4,G2,W1,R2,W3,R4,B1,B2,B3,B4,O1,Y3,O3,Y1,R1,Y2,R3,Y4),
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_LEFT,Before,After) :- move(clockwise_LEFT,After,Before).



%move(clockwise_right, CubeBefore, CubeAfter) :- If we rotate 'right' side ('B'lue color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_RIGHT,
    rubik(W1,W2,W3,W4,G1,G2,G3,G4,R1,R2,R3,R4,B1,B2,B3,B4,O1,O2,O3,O4,Y1,Y2,Y3,Y4),
    rubik(W1,R2,W3,R4,G1,G2,G3,G4,R1,Y2,R3,Y4,B3,B1,B4,B2,W4,O2,W2,O4,Y1,O3,Y3,O1),

% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_RIGHT,Before,After) :- move(clockwise_RIGHT,After,Before).



%move(clockwise_front, CubeBefore, CubeAfter) :- If we rotate 'front' side ('R'ed color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_FRONT,
    rubik(W1,W2,W3,W4,G1,G2,G3,G4,R1,R2,R3,R4,B1,B2,B3,B4,O1,O2,O3,O4,Y1,Y2,Y3,Y4),
    rubik(W1,W2,G4,G2,G1,Y1,G3,Y2,R3,R1,R4,R2,W3,B2,W4,B4,O1,O2,O3,O4,B3,B1,Y3,Y4),
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_FRONT,Before,After) :- move(clockwise_FRONT,After,Before).



%move(clockwise_back, CubeBefore, CubeAfter) :- If we rotate 'back' side ('O'range color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_BACK,
    rubik(W1,W2,W3,W4,G1,G2,G3,G4,R1,R2,R3,R4,B1,B2,B3,B4,O1,O2,O3,O4,Y1,Y2,Y3,Y4),
    rubik(G3,G1,W3,W4,Y3,G2,Y4,G4,R1,R2,R3,R4,B1,W1,B3,W3,O2,O4,O1,O3,Y1,Y2,B4,B2),
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_BACK,Before,After) :- move(clockwise_BACK,After,Before).











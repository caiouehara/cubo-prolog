%------------------------------------------------------------
% resolva2(No,Solucao) Solucao é um caminho acíclico
% (na ordem reversa) entre nó inicial No e um nó final
resolva2(No,Solucao) :-
  depthFirst([],No,Solucao).

% depthFirst(Caminho,No,Solucao) estende o caminho [No|Caminho]
% até um nó final obtendo Solucao
depthFirst(Caminho,No,[No|Caminho]) :-
  final(No).
depthFirst(Caminho,No,S) :-
  s(No,No1),
  \+ pertence(No1,Caminho),            % evita um ciclo
  depthFirst([No|Caminho],No1,S).

pertence(E,[E|_]).
pertence(E,[_|T]) :-
  pertence(E,T).
%------------------------------------------------------------
% resolva3(No,Solucao,L) Solucao é um caminho acíclico
% (na ordem reversa) entre nó inicial No uma solução
% L é o limite de profundidade da busca
resolva3(No,Solucao,L) :-
  depthFirstLimited([],No,Solucao,L).

% depthFirstLimited(Caminho,No,Solucao,L) estende o caminho
% [No|Caminho] até um nó final obtendo Solucao com
% profundidade não maior que L
depthFirstLimited(Caminho,No,[No|Caminho],_) :-
  final(No).
depthFirstLimited(Caminho,No,S,L) :-
  L > 0,
  s(No,No1),
  \+ pertence(No1,Caminho),            % evita um ciclo
  L1 is L - 1,
  depthFirstLimited([No|Caminho],No1,S,L1).
%------------------------------------------------------------
% resolva41(No,Solucao) Solucao é um caminho acíclico
% (na ordem reversa) entre nó inicial No uma solução
resolva41(No,Solucao) :-
  depthFirstIterativeDeepening(No, Solucao, 0).

depthFirstIterativeDeepening(No,Solucao,Limite) :-
  depthFirstLimited([],No,Solucao,Limite).
depthFirstIterativeDeepening(No,Solucao,Limite) :-
  NovoLimite is Limite + 1,
  NovoLimite < 9999,          % constante arbitrária
  depthFirstIterativeDeepening(No,Solucao,NovoLimite).
%------------------------------------------------------------
% resolva5(No,Solucao) Solucao é um caminho acíclico
% (na ordem reversa) entre nó inicial No uma solução
resolva5(No,Solucao) :-
  breadthFirst([[No]],Solucao).

% breadthFirst([Caminho1,Caminhos2,...],Solucao) Solucao é uma
% extensão para um nó final de um dos caminhos
breadthFirst([[No|Caminho]|_],[No|Caminho]) :-
  final(No).
breadthFirst([Caminho|Caminhos],Solucao) :-
  estender(Caminho,NovosCaminhos),
  append(Caminhos,NovosCaminhos,Caminhos1),
  breadthFirst(Caminhos1,Solucao).

estender([No|Caminho],NovosCaminhos) :-
  findall([NovoNo,No|Caminho],
          (s(No,NovoNo), \+ pertence(NovoNo,[No|Caminho])),
          NovosCaminhos).
%------------------------------------------------------------
% resolva6(No,Solucao) Solucao é um caminho acíclico (na ordem reversa) entre nó inicial No até uma solução
resolva6(No,Solucao) :-
  uniformCost([[No]:0],Solucao).

uniformCost([[No|Caminho]:Custo|_],[No|Caminho]:Custo) :-
  final(No).
uniformCost([Caminho:Custo|Caminhos],Solucao) :-
  estender2(Caminho:Custo,NovosCaminhos),
  fila_prioridade(NovosCaminhos,Caminhos,Caminhos1),
  uniformCost(Caminhos1,Solucao).

estender2([No|Caminho]:CustoAcumulado,NovosCaminhos) :-
  findall([NovoNo,No|Caminho]:NovoCusto,
          (s(No,NovoNo,Custo), \+ pertence(NovoNo,[No|Caminho]), NovoCusto is CustoAcumulado + Custo),
          NovosCaminhos).

% fila_prioridade(NovosCaminhos,CaminhosExistentes,CaminhosOrdenados)
% concatena (com prioridade) os NovosCaminhos em CaminhosExistenes formando CaminhosOrdenados
% assumindo que CaminhosExistentes ja esta ordenado por prioridade (ou seja, por custo)
fila_prioridade([],L,L).
fila_prioridade([Caminho:Custo|Caminhos],Existente,Final) :-
  insert(Caminho:Custo,Existente,ExistenteAumentado),
  fila_prioridade(Caminhos,ExistenteAumentado,Final).

insert(Caminho:Custo,[Path:Cost|Paths],[Path:Cost|NewPaths]) :-
  Custo > Cost, !,
  insert(Caminho:Custo,Paths,NewPaths).
insert(C,Paths,[C|Paths]).
%------------------------------------------------------------
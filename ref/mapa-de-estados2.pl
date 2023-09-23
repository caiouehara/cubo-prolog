% grafo exemplo
aresta(a,b,4).
aresta(a,d,3).
aresta(a,s,3).
aresta(b,c,4).
aresta(b,g,2).
aresta(b,s,5).
aresta(c,e,2).
aresta(d,g,5).


% relacao sucessor s(X,Y,Custo) que eh verdadeira se ha um movimento permitido no espaco de estados do noh X para o noh Y
% ou seja, Y eh um sucessor de X ao custo Custo
s(X,Y,Custo) :-
  aresta(X,Y,Custo) ; aresta(Y,X,Custo).

% final(X) que eh verdadeira se X eh um estado final
final(g).


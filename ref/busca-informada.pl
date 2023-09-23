% Assuma que 9999 é maior que qualquer valor-f 
resolvai1(No, Solucao) :-
    expandir([], l(No, 0/0), 9999, _, sim, Solucao).

% expandir(P, Arvore, Limite, Arvore1, Resolvido, Solucao)
% P é um caminho entre o nó inicial da busca e a subárvore Arvore,
% Arvore1 é a Arvore expandida até Limite. Se um nó final é encontrado
% então Solucao é a solução e Resolvido = sim

%busca informada
% Caso 1: nó folha final, construir caminho da solução
expandir(P, l(N, _), _, _, sim, [N|P]) :-
    final(N).

% Caso 2: nó folha, valor-f <= Limite. Gerar sucessores e expandir dentro de Limite
expandir(P, l(N, F/G), Limite, Arvore1, Resolvido, Solucao) :-
    F =< Limite,
    (findall(M/Custo, (s(N,M,Custo), \+ pertence(M,P)), Vizinhos),
     Vizinhos \= [],
     !, % nó N tem sucessores
     avalie(G, Vizinhos, Ts), % crie subárvores
     melhorf(Ts, F1), % valor-f do melhor sucessor
     expandir(P, t(N, F1/G, Ts), Limite, Arvore1, Resolvido, Solucao)
    ;
    Resolvido = nunca % N não tem sucessores – beco sem saída
    ).

% Caso 3: não-folha, valor-f <= Limite. Expanda a subárvore mais
% promissora; dependendo dos resultados, o predicado continue
% decide como proceder

expandir(P, t(N, F/G, [T|Ts]), Limite, Arvore1, Resolvido, Solucao) :-
    F =< Limite,
    melhorf(Ts, MF),
    min(Limite, MF, Limite1), % Limite1 = min(Limite,MF)
    expandir([N|P], T, Limite1, T1, Resolvido1, Solucao),
    continue(P, t(N, F/G, [T1|Ts]), Limite, Arvore1, Resolvido1, Resolvido, Solucao).

% Caso 4: não-folha com subárvores vazias
% Beco sem saída que nunca será resolvido
expandir(_, t(_, _, []), _, _, nunca, _) :- !.

% Caso 5: valor f > Limite, árvore não pode crescer
expandir(_, Arvore, Limite, Arvore, nao, _) :-
    f(Arvore, F),
    F > Limite.

% continue(Caminho, Arvore, Limite, NovaArvore, SubarvoreResolvida, ArvoreResolvida, Solucao)

continue(_, _, _, _, sim, sim, _). % solução encontrada

continue(P, t(N, F/G, [T1|Ts]), Limite, Arvore1, nao, Resolvido, Solucao) :-
    inserir(T1, Ts, NTs),
    melhorf(NTs, F1),
    expandir(P, t(N, F1/G, NTs), Limite, Arvore1, Resolvido, Solucao).

continue(P, t(N, F/G, [T1|Ts]), Limite, Arvore1, nunca, Resolvido, Solucao) :-
    melhorf(Ts, F1),
    expandir(P, t(N, F1/G, Ts), Limite, Arvore1, Resolvido, Solucao).

% avalie(G0, [No1/Custo1, ...], [l(MelhorNo, MelhorF/G, ...)])
% ordena a lista de folhas pelos seus valores-f

avalie(_, [], []).

avalie(G0, [N/C|NaoAvaliados], Ts) :-
    G is G0 + C,
    h(N, H),
    F is G + H,
    avalie(G0, NaoAvaliados, Avaliados),
    inserir(l(N, F/G), Avaliados, Ts).

% insere T na lista de árvores Ts mantendo a ordem dos valores-f
inserir(T, Ts, [T|Ts]) :-
    f(T, F),
    melhorf(Ts, F1),
    F =< F1, !.

inserir(T, [T1|Ts], [T1|Ts1]) :-
    inserir(T, Ts, Ts1).

% Obter o valor f
f(l(_, F/_), F). % valor-f de uma folha
f(t(_, F/_, _), F). % valor-f de uma árvore

melhorf([T|_], F) :- % melhor valor-f de uma lista de árvores
    f(T, F).

melhorf([], 9999). % Nenhuma árvore: definir valor-f ruim

min(X, Y, X) :-
    X =< Y, !.

min(X, Y, Y).
pertence(E, [E|_]).

pertence(E, [_|T]) :-
    pertence(E, T).
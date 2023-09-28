main :-
    write('Bem-vindo ao solucionador de cubo mágico 2x2x2!'), nl,
    write('Este programa recebe o estado inicial de um cubo embaralhado e retorna a primeira sequencia de movimentos encontrada que organiza-o.'), nl,
    write('Para inserir o estado inicial do cubo, insira uma lista de 24 cores entre colchetes, por exemplo: [a,a,a,a,b,b,b,b,c,c,c,c,d,d,d,d,e,e,e,e,f,f,f,f].'), nl,
    write('Digite "sair." para sair do programa.'), nl,
    read(EstadoInicial),
    processar_entrada(EstadoInicial).

processar_entrada(sair) :-
    write('Saindo do programa. Até logo!'), nl.

processar_entrada(EstadoInicial) :-
    resolver_cubo(EstadoInicial), nl,
    main.

resolver_cubo(EstadoInicial) :-
    busca_n_i(X, EstadoInicial, EstadoFinal),
    estado_final(EstadoFinal),
    write('Solução encontrada: '), nl,
    write(X), nl.

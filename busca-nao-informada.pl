%busca não informada
busca_n_i([], C, C).
busca_n_i([M | T], C, E) :- 
    busca_n_i(T, D, E), 
    move(M, C, D).

%exemplo de uso
%busca_n_i(X, cubo(a,a,a,a, b,b,b,b, c,c,c,c, d,d,d,d, e,e,e,e, f,f,f,f), C), estado_final(C).
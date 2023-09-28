%busca não informada
busca_n_i([], C, C).
busca_n_i([M | T], C, E) :- 
    busca_n_i(T, D, E), 
    move(M, C, D).

%exemplo de uso
%busca_n_i(X, cubo(a,a,a,a, b,b,b,b, c,c,c,c, d,d,d,d, e,e,e,e, f,f,f,f), C), estado_final(C).
%busca_n_i(X, cubo(a,a,b,b, b,e,b,e, c,c,c,c, a,d,a,d, d,d,e,e, f,f,f,f), C), estado_final(C).
%busca_n_i(X, cubo(w,b,b,b, r,w,w,b, r,r,o,y, y,o,o,r, y,g,g,g, o,y,g,w), C), estado_final(C).
%busca_n_i(X, cubo(r,b,r,b, b,w,y,g, g,y,r,w, o,o,b,o, y,r,o,g, g,w,y,w), C), estado_final(C).

%novo exemplo de uso no predicado main
%cubo(a,a,a,a, b,b,b,b, c,c,c,c, d,d,d,d, e,e,e,e, f,f,f,f)
%cubo(a,a,b,b, b,e,b,e, c,c,c,c, a,d,a,d, d,d,e,e, f,f,f,f)
%cubo(w,b,b,b, r,w,w,b, r,r,o,y, y,o,o,r, y,g,g,g, o,y,g,w)
%cubo(r,b,r,b, b,w,y,g, g,y,r,w, o,o,b,o, y,r,o,g, g,w,y,w)


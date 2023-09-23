% operadores 8-puzzle

% mover a esquerda na linha superior
move(left,[X1, 0,X3,X4,X5,X6,X7,X8,X9],[ 0,X1,X3,X4,X5,X6,X7,X8,X9]).
move(left,[X1,X2,0, X4,X5,X6,X7,X8,X9],[X1, 0,X2,X4,X5,X6,X7,X8,X9]).
% mover a esquerda na linha central
move(left,[X1,X2,X3,X4, 0,X6,X7,X8,X9],[X1,X2,X3, 0,X4,X6,X7,X8,X9]).
move(left,[X1,X2,X3,X4,X5, 0,X7,X8,X9],[X1,X2,X3,X4,0,X5,X7,X8,X9]).
% mover a esquerda na linha inferior
move(left,[X1,X2,X3,X4,X5,X6,X7, 0,X9],[X1,X2,X3,X4,X5,X6, 0,X7,X9]).
move(left,[X1,X2,X3,X4,X5,X6,X7,X8, 0],[X1,X2,X3,X4,X5,X6,X7, 0,X8]).

% mover a direita na linha superior
move(right,[0,X2,X3,X4,X5,X6,X7,X8,X9],[X2, 0,X3,X4,X5,X6,X7,X8,X9]).
move(right,[X1,0,X3,X4,X5,X6,X7,X8,X9],[X1,X3, 0,X4,X5,X6,X7,X8,X9]).
% mover a direita na linha central
move(right,[X1,X2,X3, 0,X5,X6,X7,X8,X9],[X1,X2,X3,X5, 0,X6,X7,X8,X9]).
move(right,[X1,X2,X3,X4, 0,X6,X7,X8,X9],[X1,X2,X3,X4,X6, 0,X7,X8,X9]).
% mover a direita na linha inferior
move(right,[X1,X2,X3,X4,X5,X6, 0,X8,X9],[X1,X2,X3,X4,X5,X6,X8,0,X9]).
move(right,[X1,X2,X3,X4,X5,X6,X7, 0,X9],[X1,X2,X3,X4,X5,X6,X7,X9,0]).

% mover para cima a partir da linha central
move(up,[X1,X2,X3, 0,X5,X6, X7,X8,X9], [0,X2,X3, X1,X5,X6, X7,X8,X9]).
move(up,[X1,X2,X3, X4,0,X6, X7,X8,X9], [X1,0,X3, X4,X2,X6, X7,X8,X9]).
move(up,[X1,X2,X3, X4,X5,0, X7,X8,X9], [X1,X2,0, X4,X5,X3, X7,X8,X9]).
% mover para cima a partir da linha inferior
move(up,[X1,X2,X3, X4,X5,X6, 0,X8,X9], [X1,X2,X3, 0,X5,X6, X4,X8,X9]).
move(up,[X1,X2,X3, X4,X5,X6, X7,0,X9], [X1,X2,X3, X4,0,X6, X7,X5,X9]).
move(up,[X1,X2,X3, X4,X5,X6, X7,X8,0], [X1,X2,X3, X4,X5,0, X7,X8,X6]).

% mover para baixo a partir da linha superior
move(down,[ 0,X2,X3,X4,X5,X6,X7,X8,X9],[X4,X2,X3, 0,X5,X6,X7,X8,X9]).
move(down,[X1, 0,X3,X4,X5,X6,X7,X8,X9],[X1,X5,X3,X4, 0,X6,X7,X8,X9]).
move(down,[X1,X2, 0,X4,X5,X6,X7,X8,X9],[X1,X2,X6,X4,X5, 0,X7,X8,X9]).
% mover para baixo a partir da linha central
move(down,[X1,X2,X3, 0,X5,X6,X7,X8,X9],[X1,X2,X3,X7,X5,X6, 0,X8,X9]).
move(down,[X1,X2,X3,X4, 0,X6,X7,X8,X9],[X1,X2,X3,X4,X8,X6,X7, 0,X9]).
move(down,[X1,X2,X3,X4,X5, 0,X7,X8,X9],[X1,X2,X3,X4,X5,X9,X7,X8, 0]).

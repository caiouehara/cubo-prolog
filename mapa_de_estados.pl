%      Inicio:               Move u:               Move f:               Move r:

%       U1 U2	              U3 U1                 U1 U2                 U1 B2
%       U3 U4                 U4 U2                 L4 L2                 U3 B4
% L1 L2 F1 F2 R1 R2     F1 F2 R1 R2 B4 B3     L1 D1 F3 F1 U3 R2     L1 L2 F1 U2 R2 R4
% L3 L4 F3 F4 R3 R4		L3 L4 F3 F4 R3 R4     L3 D2 F4 F2 U4 R4     L3 L4 F3 U4 R1 R3
%       D1 D2                 D1 D2                 R3 R1                 D1 F2
%       D3 D4                 D3 D4                 D3 D4                 D3 F4
%       B1 B2                 B1 B2                 B1 B2                 B1 D2
%       B3 B4                 L2 L1                 B3 B4                 B3 D4

estado_final(cubo(Y,Y,Y,Y,O,O,O,O,B,B,B,B,R,R,R,R,W,W,W,W,G,G,G,G)).

% deslocamente horizontal da primeira linha para a esquerda
move(u,cubo(U1,U2,U3,U4,L1,L2,L3,L4,F1,F2,F3,F4,R1,R2,R3,R4,D1,D2,D3,D4,B1,B2,B3,B4),
    cubo(U3,U1,U4,U2,F1,F2,L3,L4,R1,R2,F3,F4,B4,B3,R3,R4,D1,D2,D3,D4,B1,B2,L2,L1)).

% rotação da face frontal no sentido horário
move(f,cubo(U1,U2,U3,U4,L1,L2,L3,L4,F1,F2,F3,F4,R1,R2,R3,R4,D1,D2,D3,D4,B1,B2,B3,B4),
    cubo(U1,U2,L4,L2,L1,D1,L3,D2,F3,F1,F4,F2,U3,R2,U4,R4,R3,R1,D3,D4,B1,B2,B3,B4)).

% deslocamento vertical da segunda coluna para baixo
move(r,cubo(U1,U2,U3,U4,L1,L2,L3,L4,F1,F2,F3,F4,R1,R2,R3,R4,D1,D2,D3,D4,B1,B2,B3,B4),
    cubo(U1,B2,U3,B4,L1,L2,L3,L4,F1,U2,F3,U4,R2,R4,R1,R3,D1,F2,D3,F4,B1,D2,B3,D4)).

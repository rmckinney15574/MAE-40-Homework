clear
syms s R L C c1 Vi          % Laplace variable s, parameters, input V0
syms V0 Vm Il Ir Ic Iload    % variables to be solved for (output is V1)
eqn1= Vi-Vm == s*L*Il         % Component eqns
eqn2= Ic == s*C*(Vm-V0)
eqn3= V0 == Ir * R
eqn4= V0 == (R/c1)*Iload
eqn5= Ic == Ir + Iload    % KCLs
eqn6= Il == Ic
A=solve(eqn1,eqn2,eqn3,eqn4,eqn5,eqn6,V0,Vm,Il,Ir,Ic,Iload); % do the solve
A.V0/Vi   % output of interest (V0), divided by input (V1)

A = [0, 1, s*L, 0, 0, 0;
    s*C, -s*C, 0, 0, 1, 0;
    1, 0, 0, -R, 0, 0;
    1, 0, 0, 0, 0, -R/c1;
    0, 0, 0, -1, 1, -1;
    0, 0, 1, 0, -1, 0];

b = [ Vi; 0; 0; 0; 0; 0 ];

A = A\b
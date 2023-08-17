%% Question 1

clc; close all; clear all; syms s Vi Vs C L R R1 R2 Rload % Add Rload symbol

A1  =[ 1   -1      -1        0;    % I_L =Ic +IRload
      0   1      0       -L*s;    % Vi-Vo=LdIc/dt
      0    -C*s   1       0;    % Ic = CdVo/dt
      0     0    0   1]; % Vo = IRload*Rload

b1  =[ 0; Vi; 0; 0]; % Add an additional equation for the load current Io
x1 = A1\b1;

disp('Question 1');
I_L1 = x1(1)
I_c1 = x1(2)
I_R1_load = x1(3)
V_01 = x1(4)

omega3 = 10; 
F_LPF2_undamped = RR_tf([omega3^2],[1 0 omega3^2]);

figure; 
RR_bode(F_LPF2_undamped);

%% Question 2

close all; 

omega4 = 10;

zeta_val = [0.1, 0.7, 1];

for i = 1:length(zeta_val)
    zeta = zeta_val(i);
    
    %tf
    num = omega4^2;
    den = [1, 2*zeta*omega4, omega4^2];
    
    H = RR_tf(num, den);
    
    %plot
    figure
    RR_bode(H);
end

% Discussion
    % Increasing L or C will decrease omega4
    % Omega4 = 1 / sqrt(L * C)
    % zeta gets smaller as you increase Rload
    % zeta = 1 / (2 * Rload * sqrt(L / C))
    
%% Question 3

syms s Vi Vs C L R R1 R2 Rd Cd % Add Rload symbol

A2  =[ 1   -1      -1        0;    % I_L =Ic +IRload
      L*s   0      0       1;    % Vi-Vo=LdIc/dt
      0    -C*s   1       0;    % Ic = CdVo/dt
      1/Rd     0    0   1/(s*Cd)]; % Vo = IRload*Rload

b2  =[ 0; Vi; 0; 0]; % Add an additional equation for the load current Io
x2 = A2\b2;

disp('Question 3')
I_L2 = x2(1)
I_c2 = x2(2)
V_02 = x2(3)
I_b2 = x2(4)

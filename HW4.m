clc
clear all;
close all;
syms s Vi Vm Vo Vo_A Vo_B Vd C L R Ic Il Il_A Il_B Ir t 

% There are 4 phases for the circuit

%% Phase 1: Button On, No Diode

% x = [Vo Vm   Il  Ic  Ir ]
A1 =[ 0   s   0   0   0  ;    % Vi = Vm*s
      0 -1/L  s   0   0  ;    % Il_A = (s*Il)  - Vm/L
      s  0   0  -1/C  0  ;    % Vo_A = (s*Vo) - Ic/C 
     -1   0   0   0   R  ;    % 0 = Ir*R - Vo
      0   0   0   1   1 ];    % 0 = Ir + Ic
  
b1 = [ Vi ; Il_A; Vo_A; 0; 0]; 

x1 = A1\b1;

Vo1 = x1(1)
Il1 = x1(3)

%% Phase 2: Button On, With Diode

% x = [Vo Vm   Il  Ic  Ir ]
A2 =[ s  -s   0   0   0  ;    % Vd = (Vo*s) - (Vm*s)
      0 -1/L  s   0   0  ;    % Il_A = (s*Il)  - Vm/L
      s   0   0 -1/C  0  ;    % Vo_A = (s*Vo) - Ic/C 
     -1   0   0   0   R  ;    % 0 = Ir*R - Vo
      0   0   1   1   1 ];    % 0 = Ir + Ic + Il
      
b2 =[ Vd; Il_A; Vo_A; 0; 0]; 

x2 = A2\b2;

Vo2 = x2(1)
Il2 = x2(3)

%% Phase 3: Button Off, No Diode

% x = [Vo Vm   Il  Ic  Ir ]
A3 =[ 0 -1/L  s   0   0  ;    % Il_b = s*Il - Vm/L
      0   0   0   1   1  ;    % 0 = Ic + Ir
     -1   0   0   0   R  ;    % 0 = Ir*R - Vo  
      0   0   1   1   1  ;    % 0 = Ir + Ic + Il
      s  0   0  -1/C  0 ];    % Vo_B = s*Vo - Ic/C

b3 =[ Il_B;0; 0; 0; Vo_B]; 

x3 = A3\b3;

Vo3 = x3(1)
Il3 = x3(3)

%% Phase 4: Button Off, With Diode

% x = [Vo Vm   Il  Ic  Ir ]
A4 =[ 0  -1/L  s  0   0  ;    % Il_B = s*Il - Vm/L 
      s   0   0 -1/C  0  ;    % Vo_B = s*Vo - Ic/C
     -1   0   0   0   R  ;    % 0 =Ir*R - Vo   
      s  -s   0   0   0  ;    % Vd = Vo*s - Vm*s
      0   0   1   1   1 ];    % 0 = Il + Ic + Ir

b4 =[ Il_B; Vo_B; 0; Vd; 0]; 

x4 = A4\b4;

Vo4 = x4(1)
Il4 = x4(3)

%% Inverse Laplace
% Phases go from 1-4-2 

% Phase 1
Vo1_t = ilaplace(Vo1)
Il1_t = ilaplace(Il1)

% Phase 4
Vo4_t = ilaplace(Vo4)
Il4_t = ilaplace(Il4)

% Phase 2
Vo2_t = ilaplace(Vo2)
Il2_t = ilaplace(Il2)
function sa=simulator_env(sa,del)

% sa=simulator_env(sa,del)
%
% Simulate environmental parameters variation: humidity, temperature, light
% intensity. 
%
% sa: state of the plant.
% del: delta of light.
% 
% Agostini - 01.10.2020

% Copyright (c) 2020 by Alejandro Agostini

% global dt

T=sa.env.T;
H=sa.env.H;
L=sa.env.L;

% % Temperature
% T1 = 0;
% T = T + T1 * dt;
% T=max(0,T);
% 
% % Humidity
% H1 = 0;
% H = H + H1 * dt;
% H=max(0,H);

% ligth
% L1 = 0;
% L = L + L1 * dt;
L = L + del;
L=max(0,L);

sa.env.T=T;
sa.env.H=H;
sa.env.L=L;
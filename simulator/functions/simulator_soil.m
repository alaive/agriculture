function sa=simulator_soil(sa,dsn,dsw)

% sa=simulator_soil(sa,dsn,dsw)
%
% Simulate the evolution of water and nutrient in the soil.
%
% sa: state of the plant.
% dsn: dose of nutrient.
% dsw: dose of water.
% 
% Agostini - 01.10.2020

% Copyright (c) 2020 by Alejandro Agostini

global dt
global kNutSize
global kWaterSize kWaterEvap
global maxN maxW

n=sa.soil.n;
w=sa.soil.w;

% Need plant att.
if isempty(sa.plant.leaves) % if no leaves
    sz=0; 
else
    sz=mean(cat(1,sa.plant.leaves.sz));
end

% nutrient
% first simulate the decrement
n1 = - kNutSize*sz;
n = n + n1*dt;
n = max(0,n);
n = n + dsn/maxN;
%alpha=0.1;
%n = n + alpha*(dsn/maxN-n);
%n = n + dsn;
n = min(1,n);


%water
% first simulate the decrement
w1 = - kWaterSize*sz - kWaterEvap*w;
w = w + w1*dt; 
w = max(0,w);
w = w + dsw/maxW;
%alpha=0.1;
%w = w + alpha*(dsw/maxW-w);
%w = w + dsw;
w = min(1,w);


sa.soil.n=n;
sa.soil.w=w;
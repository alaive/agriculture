 function [sa,Lsa,hNL,kplant,t]=simulator_ini()

%  [sa,Lsa,hNL,kplant,t]=plant_ini()
%
% % Random initialization of a plant parameters.
% 
% INPUT: 
% sa: state of the plant, soil, and environment.
% Lsa: history of states.
% hNL: history number of leaves.
% kplant: strenght of the plant.
% t: simulated time.
%
% Agostini - 08.10.2020

% Copyright (c) 2020 by Alejandro Agostini


global which_kplant

% time
t=0;

% STATE OF THE PLANT
sa.plant.leaves=[]; % no leaves
sa.plant.stem=0; % ini length of stem=0

% STATE OF THE ENVIRONMENT
sa.env.T=21; % Temperature
sa.env.H=50; % Humidity: ranges in [0,100]
sa.env.L=1000; % Ligth: ranges in [0 2000]

% STATE OF THE SOIL
sa.soil.w=0.5; % water saturation 0-1
sa.soil.n=0.5; % nutrients saturation 0-1

Lsa=[];
hNL=1;

% define strength of the plant 
switch which_kplant
    
    case 0
        kplant=1;
        
    case 1
        % Weak plant gain krand=0.5. Strong plant krand=1;   
        kplant=(1-0.5)*round(rand) + 0.5; % binary: weak or strong
        
    case 2
        kplant=(1-0.5)*rand + 0.5; % continuous: weak 0.5 to strong 1
        
    case 3
        kplant=(1-0.8)*rand + 0.8; % continuous: weak 0.8 to strong 1
        
    case 4
        vk=[0.5 0.75 1];
        ixs=ceil(length(vk)*rand);
        kplant=vk(ixs);
        
    case 5
        vk=[0.5 0.625 0.75 0.875 1];
        ixs=ceil(length(vk)*rand);
        kplant=vk(ixs);
        
    case 6
        kplant=0.5;
        
    case 7
        kplant=0.625;
        
    case 8
        kplant=0.75;
        
end
        

% time
t=t+1; 
function [sa,Lsa] = main(sa,aa,plantID)

% sa=main(sa,aa,plantID)
%
% Simulate the behaviour of the plant, enironment, and soil.
%
% sa: state of plant, soil, and environment.
% aa: input of water, nutrient, and light.
% plantID: plant unique ID
% Lsa: history of states.
% 
% Agostini - 01.10.2020

% Copyright (c) 2020 by Alejandro Agostini


global dt act_interval

% reinitialize random sequence
% MATLAB 7.7 OR HIGHER
RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));


filenamePlant=['../data/plant_' num2str(plantID) '.mat'];
try
    % load history of the plant
    load(filenamePlant);
catch
    disp(['No stored history for plant ' num2str(plantID)  '.']);          
    % random initialization of a plant
    [sa,Lsa,hNL,kplant,t]=simulator_ini();  
end

global krand
krand=kplant;
    

%-------------
% ONE STEP SIMULATION CONDISERING THE EVENTS
%-------------

% SAMPLE
saAnt=sa;

% ACTION
dsw=aa(1);
dsn=aa(2);
del=aa(3);

% ENVIRONMENT
sa=simulator_env(sa,del);

% SOIL
sa=simulator_soil(sa,dsn,dsw);

% PLANT
[sa,hNL]=simulator_plant(sa,Lsa,hNL,krand,t);

% SAMPLE
sample.sai=saAnt;
sample.aa=aa;
sample.sao=sa;
Lsa=[Lsa;sample];

t=t+1;


%---------------
% SIMULATION WITHOUT EVENTS
%---------------
% Note: since the event takes place at an instant of time the simulation is
% carried out first at that instance of time and then for the rest of the
% time involved in the action interval (act_interval). 
% The event is assumed to occur at the first time step n the simulation (the first dt)

% ACTION
aa=zeros(1,5);
dsw=aa(1);
dsn=aa(2);
del=aa(3);

NN=act_interval/dt;

for i=1:NN-1  %the first step (dt) was considered with events, thus the -1.
    
    saAnt=sa;

    % ENVIRONMENT
    sa=simulator_env(sa,del);

    % SOIL
    sa=simulator_soil(sa,dsn,dsw);

    % PLANT
    [sa,hNL]=simulator_plant(sa,Lsa,hNL,krand,t);   

    % SAMPLE
    sample.sai=saAnt;
    sample.aa=aa;
    sample.sao=sa;
    Lsa=[Lsa;sample];
    

%     % PLOT
%     PLANT_SIM_PLOT(Lsa);
%     pause(0.1);
    
    t=t+1;
    
end

% % PLOT
% PLANT_SIM_PLOT(Lsa);
% pause(0.1);

save(filenamePlant,'Lsa','sa','hNL','kplant','t');


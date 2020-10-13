function demo

% Run a demo of the plant simulation and plot final results. 
%
% Agostini - 01.10.2020

addpath ../params

% Set demo specifications
Nit = 400; % Numbe rof iterations. One iteration per hour.
plantID = '9999';

% remove files if already created.
filename=['../data/plant_' num2str(plantID) '.mat'];
if isfile(filename)
     delete(filename);
end

% Set parameters
parameters_simulator();
NACTIONS = 3;

% Initialization
aa=zeros(1,NACTIONS);
sa=[];
it=0;

% Loop (one iteration per hour)
while it<=Nit
        
    % Every 10 hours provides input w/n/l
    if mod(it,24)==0
        aa(1)=2; % water
        aa(2)=1.5; % nutrient
        % aa(3)=100; % light
    else
        aa=zeros(1,NACTIONS);
    end
    
    % simulate
    [sa,Lsa]=main(sa,aa,plantID);
    
    % plot
    if mod(it,24)==0
        if not(isempty(Lsa(end).sai.plant.leaves))
            simulator_plot(Lsa,Nit);
            pause(0.1);
        end
    end
    
    it=it+1;
    
end

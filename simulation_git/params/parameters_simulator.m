function params=parameters_simulator()

% Definition of the parameters for the simulation of the plant using delay
% differencial equations and the plant initialization.
%
% Agostini - 08.10.2020

% incremental time step for simulation (in min)
global dt
dt=30;

% action interval: should be provided by the user (in min)
global act_interval
act_interval=60; 

% delay for the delay response of the plant in the simulation (TAU time 
% steps (dt) in the past).
global TAU % in min
%TAU=2*60/dt; %in min
TAU=(60*25)/dt; % 25 hours

% parameters for models

% STRENGTH
global which_kplant
% 0: kplant=1.
% 4: selected randomly from [0.5 0.75 1]
% 5: selected randomly from [0.5 0.625 0.75 0.875 1];
which_kplant=0; 

% SOIL
global kNutSize
kNutSize=1e-4;
global kWaterSize kWaterEvap
kWaterSize=1.5e-4;
kWaterEvap=1e-4;
global maxW maxN % normalization factors
maxW=2;
maxN=2; 

% PLANT
% reference values for increment/decrement per day
refStemGrowth=0.1; % cm/day. NOTE: could also be diff for each att.
refLeafGrowth=1; %cm2/day
refColorGrowth=0.1; %saturation/day
refWater=0.5; %reference saturation to refLeaf/StemGrowth
refNut=0.5; %saturation
refLight=2000; % units of light
refAge=390*24; % minutes 
refStemSize=10; %cm
refLeafSize=2.1; %cm2
refNLeaves=8; %ref number of leaves
dayTime=60*24; % assuming dt in minutes


global kStemWater kStemNut kStemSize
kStemWater=refStemGrowth/(dayTime*refWater);
kStemNut=refStemGrowth/(dayTime*refNut);
kStemSize=refStemGrowth/(dayTime*refStemSize);

global kLeafSizeWater kLeafSizeNut kLeafSizeLight kLeafSize kLeafSizeNLeaves
kLeafSizeWater=refLeafGrowth/(dayTime*refWater);
kLeafSizeNut=refLeafGrowth/(dayTime*refNut);
kLeafSizeLight=refLeafGrowth/(dayTime*refLight);
kLeafSize=refLeafGrowth/(dayTime*refLeafSize);
kLeafSizeNLeaves=refLeafGrowth/(dayTime*refNLeaves);

global kLeafColorWater kLeafColorNut kLeafColorAge
kLeafColorWater=refColorGrowth/(dayTime*refWater);
kLeafColorNut=refColorGrowth/(dayTime*refNut);
kLeafColorAge=refColorGrowth/(dayTime*refAge);

% THRESHOLDS FOR LEAVES
global THR_YELLOW
THR_YELLOW=0.9; % 0.7

global THR_FALL
THR_FALL=0.6; % 0.5


params=1;

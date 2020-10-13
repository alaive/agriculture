function [LL,hNL]=simulator_plant_leaf_management(LL,stem,vw,vn,hNL,t)

% [LL,hNL]=simulator_plant_leaf_management(LL,stem,vw,vn,hNL,t)
%
% Generate or remove leaves from the plant according to plant history and
% leaves health. See also simulator_plant.m.
%
% LL: list of leaves.
% stem: height of stem.
% vw: history of water in soil.
% vn: history of nutrient in soil.
% hNL: history of number of leaves.
% t: simulated time.
% 
% Agostini - 01.10.2020


global THR_FALL

% GENERATION
if stem>0
    if (mean(vw)>0.1 && mean(vn)>0.1)
        if isempty(LL)
            L.sz=0;
            L.color=1; % color measures the level of healthiness [0 1];
            L.age=0;
            L.ID=hNL;
            L.birth=t;
            hNL=hNL+1;
            LL=[LL;L];
        elseif (mean(cat(1,LL.sz))>3.5 && size(LL,1)<11)
            L.sz=0;
            L.color=1; % color measures the level of healthiness [0 1];
            L.age=0;
            L.ID=hNL;
            L.birth=t;
            hNL=hNL+1;
            LL=[LL;L];
        end
            
        
    end
end

% ELIMINATION
if not(isempty(LL))
    vcolor=cat(1,LL.color);
    ixs=find(vcolor<THR_FALL);
    if not(isempty(ixs))
        disp(['Leaves ' num2str(ixs) ' eliminated.']);
    end
    ixs=setxor(1:size(LL,1),ixs);
    LL=LL(ixs);
end

        

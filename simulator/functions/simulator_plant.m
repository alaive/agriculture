function [sa,hNL]=simulator_plant(sa,Lsa,hNL,krand,t)

%  [sa,hNL]=simulator_plant(sa,Lsa,hNL,krand,t);
%
% One-step plant simulator with delayed (TAU) effect.
%
% sa: state of the plant.
% Lsa: history of the plant.
% hNL: history of number of leaves.
% krand: randomly ini plant strength (see simulator_ini.m).
% t: simulated time.
%
% Agostini - 08.10.2020


global TAU
global dt
global kStemWater kStemNut kStemSize
global kLeafSizeWater kLeafSizeNut kLeafSizeLight kLeafSize kLeafSizeNLeaves
global kLeafColorWater kLeafColorNut kLeafColorAge

if size(Lsa,1)>TAU % only if water was poured TAU ago

    LL=sa.plant.leaves;
    stem=sa.plant.stem;
    
    vsa=cat(1,Lsa.sai);
    vsoil=cat(1,vsa.soil);
    venv=cat(1,vsa.env);

    vw=cat(1,vsoil.w);
    vn=cat(1,vsoil.n);
    vL=cat(1,venv.L);
    
    % stem
    stem1 = krand*(...
            kStemWater * vw(end-TAU)...
          + kStemNut * vn(end-TAU)...
          - kStemSize * stem...
          );
      
    stem1 = max(stem1,0);
    stem = stem + stem1 * dt;
    
    % leaves
    if not(isempty(LL))
        NL=size(LL,1);
    else
        NL = 0;
    end
    for i=1:NL % for each leaf
        
        L=LL(i);
        sz=L.sz;
        color=L.color;
        age=L.age;
        
        % age
        age = age + 1 * dt;

        % size  
        sz1 = krand*(...
              kLeafSizeWater * vw(end-TAU)...
            + kLeafSizeNut * vn(end-TAU)...
            + kLeafSizeLight * vL(end-TAU)...
            - kLeafSize * sz...
            - kLeafSizeNLeaves * NL...
            );
        sz1 = max(sz1,0);
        sz = sz + sz1 * dt;
        
        % color
        color1 = krand*(...
                 kLeafColorWater * (vw(end-TAU)-0.5)...
               + kLeafColorNut * (vn(end-TAU)-0.5)...
               - kLeafColorAge * age...
               );
        color = color + color1 * dt;
        color=max(0,color);
        color=min(1,color);
           
        L.sz=sz;
        L.color=color;
        L.age=age;
        LL(i)=L;
        
    end
    
    [LL,hNL]=simulator_plant_leaf_management(LL,stem,vw,vn,hNL,t);
    if isempty(LL)
        LL = [];
    end
    
    sa.plant.leaves=LL;
    sa.plant.stem=stem;
end

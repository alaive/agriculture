function simulator_plot(Lsa,Nit)

global dt
global act_interval


% PLOT RESULTS
% load(filename);

vsa=cat(1,Lsa.sai);
vplants=cat(1,vsa.plant);
venv=cat(1,vsa.env);
vsoil=cat(1,vsa.soil);

% plot plant evolution
vleaves=cat(1,vplants.leaves);
vID=cat(1,vleaves.ID);
vsz=cat(1,vleaves.sz);
vcolor=cat(1,vleaves.color);
vt=cat(1,vleaves.birth);

midcolor = [0 0 0;
               0.33 0 0;
               0.66 0 0;
               1 0 0;
               0 0.33 0;
               0 0.66 0;
               0 1 0;
               0 0 0.33;
               0 0 0.66;
               0 0 1;
               0.33 0.33 0.33;
               0.66 0.66 0.66;
               0.33 0 0.33;
               0.66 0 0.66;
               0.33 0.33 0;
               0 0.33 0.33;
               0.66 0.66 0;
               0 0.66 0.66;
               0.5 0.5 0.5;
               0.5 0.5 0;
               0.5 0 0.5];

IDs=unique(vID);
for i=1:length(IDs)
    
    ixs=(vID==IDs(i));
    tt=vt(ixs);
    t=tt(1);
    
    % color ID of leaf
    vidcolor = midcolor(i,:);
    
    subplot(2,2,1);
    hold on;
    vout=vsz(ixs);
    vin=(t:t+length(vout)-1)*dt/act_interval;
    plot(vin,vout,'color',vidcolor); 
    xlim([0 Nit*act_interval/60]);
    ylim([0 10]);
    title('Size of leaves');

    
    subplot(2,2,2);
    hold on;
    vout=vcolor(ixs);
    vin=(t:t+length(vout)-1)*dt/act_interval;
    plot(vin,vout,'color',vidcolor); 
    xlim([0 Nit*act_interval/60]);
    ylim([0 1.1])
    title('Color of leaves');
  
end

% plot soil parameters evolution (dose once per hour)
vw=cat(1,vsoil.w);
vn=cat(1,vsoil.n);

subplot(2,2,3);
vin=(0:length(vw)-1)*dt/act_interval;
plot(vin,vw);
xlim([0 Nit*act_interval/60]);
title('Water');
xlabel('time (hours)');


subplot(2,2,4);
vin=(0:length(vn)-1)*dt/act_interval;
plot(vin,vn);
xlim([0 Nit*act_interval/60]);
title('Nutrient');
xlabel('time (hours)');


disp(['Number of generated leaves ' num2str(length(IDs))]);
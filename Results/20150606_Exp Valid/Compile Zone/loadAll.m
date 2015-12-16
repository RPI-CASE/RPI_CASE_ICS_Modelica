%% Load parameters from all files to compar
clc;
clear all;

err = [0,0,0];
per_err = [0,0,0];

total_err = 0;
total_per_err = 0;


load('ICSolar.ICS_Skeleton_20_Feb_2015_v5.mat','Egen_arrayTotal',...
    'measured_Egen_arrayTotal','Qgen_arrayTotal','measured_Qgen_arrayTotal',...
    'Start','End','G_DN_6mods');
%observed 
o_Egen = measured_Egen_arrayTotal(Start:End);
o_Qgen = measured_Qgen_arrayTotal(Start:End); 
o_Gdn_6mods = G_DN_6mods(:,Start:End);

% simulated
s_Egen = Egen_arrayTotal(Start:End); 
s_Qgen = Qgen_arrayTotal(Start:End); 

[err(1),per_err(1)] = RMSE(o_Qgen, s_Qgen);





load('ICSolar.ICS_Skeleton_19_Mar_2015_v5.mat','Egen_arrayTotal',...
    'measured_Egen_arrayTotal','Qgen_arrayTotal','measured_Qgen_arrayTotal',...
    'Start','End','G_DN_6mods');
%trimmed observed 
temp1 = measured_Egen_arrayTotal(Start:End);
temp2 = measured_Qgen_arrayTotal(Start:End); 

%trimmed simulated
temp3 = Egen_arrayTotal(Start:End); 
temp4 = Qgen_arrayTotal(Start:End); 

[err(2),per_err(2)] = RMSE(temp2, temp4);

%observed 
o_Egen = [o_Egen measured_Egen_arrayTotal(Start:End)];
o_Qgen = [o_Qgen measured_Qgen_arrayTotal(Start:End)];
o_Gdn_6mods = [o_Gdn_6mods G_DN_6mods(:,Start:End)];

% simulated
s_Egen = [s_Egen Egen_arrayTotal(Start:End)]; 
s_Qgen = [s_Qgen Qgen_arrayTotal(Start:End)]; 









load('ICSolar.ICS_Skeleton_23_Mar_2015_v5.mat','Egen_arrayTotal',...
    'measured_Egen_arrayTotal','Qgen_arrayTotal','measured_Qgen_arrayTotal',...
    'Start','End','G_DN_6mods');

%trimmed observed 
temp1 = measured_Egen_arrayTotal(Start:End);
temp2 = measured_Qgen_arrayTotal(Start:End); 

%trimmed simulated
temp3 = Egen_arrayTotal(Start:End); 
temp4 = Qgen_arrayTotal(Start:End); 

[err(3),per_err(3)] = RMSE(temp2, temp4);


%observed 
o_Egen = [o_Egen measured_Egen_arrayTotal(Start:End)];
o_Qgen = [o_Qgen measured_Qgen_arrayTotal(Start:End)];
o_Gdn_6mods = [o_Gdn_6mods G_DN_6mods(:,Start:End)];
eta_egen_all = o_Egen./o_Gdn_6mods;
 


% simulated
s_Egen = [s_Egen Egen_arrayTotal(Start:End)]; 
s_Qgen = [s_Qgen Qgen_arrayTotal(Start:End)]; 


[total_err,total_per_err] = RMSE(o_Qgen, s_Qgen);


edges = [0.18:0.002:0.22];

histogram(eta_egen_all,edges);

figure;

rgbValue = [189,191,49];
projColor = rgbValue/255;
etaRGB = [13,115,187];
etaColor = etaRGB/255;


[n,x]=hist(eta_egen_all,edges);
bar(x,n,'FaceColo','k');


leg = legend('\itI_{hemi} \rmfrequency', '\it\epsilon_{cogen,proj} \rm(per bin)','\it\eta_{cogen,proj} \rm(per bin)',...
    'Location','northoutside','orientation','horizontal');
lp=get(leg,'position');
set(leg,'position',[-0.01,-0.05,lp(3:4)]);
set(gca,'Xgrid','on');
set(gca,'Ygrid','on');
xlabel('\it\eta_{E_{gen}} \rm(%)','FontSize',20,'FontName','Arial')
ylabel('Frequency','FontSize',20)
%set(findall('-property','Fontname'),'Fontname','Arial');


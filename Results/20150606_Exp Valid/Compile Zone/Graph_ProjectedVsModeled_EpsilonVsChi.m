clear all;


Blueish = [0 0.45 0.74];
Yellowish = [0.75 0.75 0];

figure('Color',[1 1 1]);
hold on;

% title({'\chi vs \epsilon','Measured and Projected Total Array'},...
%     'FontSize',18,...
%     'FontName','Arial Narrow');

xlabel(strcat('\chi',sprintf('(%cC m^2 / W)',char(176))),...
    'FontName','Arial Narrow',...
     'FontSize',22,...
    'FontWeight','bold');
set(gca,'XGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');

ylabel('\epsilon',...
    'FontName','Arial Narrow',...
    'FontSize',22,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');


axis([0 55 0 0.3]);

%Plot 20-Feb
load('ICSolar.ICS_Skeleton_23_Mar_2015.mat','chi_arrayTotal',...
    'measured_Ex_epsilon','measured_T_HTFin','measured_T_cavAvg','Start',...
    'End','day');

Color = Blueish;

%trimmed obseverd chi and epsilon
t_o_chi = chi_arrayTotal(:,Start:End);
t_o_epsilon_arrayTotal = measured_Ex_epsilon(:,Start:End);
t_o_deltaT = measured_T_HTFin(:,Start:End) - measured_T_cavAvg(:,Start:End);


%need to transpose in order to scatter plot
chi_trans = transpose(t_o_chi);
Ex_epsilon_trans = transpose(t_o_epsilon_arrayTotal);

f=fit(t_o_deltaT',t_o_epsilon_arrayTotal','poly1');

scatter(t_o_deltaT',t_o_epsilon_arrayTotal',...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...
    day,' \chi vs \epsilon'));

% Predicted at experimental 
predict_chi = [0, 0.018, 0.036, 0.054, 0.089, 0.143];
predict_eps = [0.136, 0.143, 0.148, 0.150, 0.148, 0.132];

f=fit(predict_chi',predict_eps','poly2');
x=0:.01:.2;
y=f(x);
% 
% plot(x,y,'LineStyle',':',...
%     'DisplayName','Predicted Fit',...
%     'Color',Color,...
%     'LineWidth',3);

%Plot Projected
load('PROJECTED_ICSolar.ICS_Skeleton_20_Feb_2015.mat','chi_arrayTotal',...
    'Ex_epsilon','measured_T_HTFin','measured_T_cavAvg','Start',...
    'End','day');

Color = Yellowish;

%trimmed obseverd chi and epsilon
t_o_chi = chi_arrayTotal(:,Start:End);
t_o_epsilon_arrayTotal = Ex_epsilon(:,Start:End);
t_o_deltaT = measured_T_HTFin(:,Start:End) - measured_T_cavAvg(:,Start:End);



% f=fit(chi_trans,Ex_epsilon_trans,'poly1');

scatter(t_o_deltaT',t_o_epsilon_arrayTotal',...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...
    day,' \chi vs \epsilon'));

% Predicted at experimental 
predict_chi = [0,0.063, 0.125];
predict_eps = [0.223, 0.251, 0.252];

f=fit(predict_chi',predict_eps','poly2');
x=0:.01:.2;
y=f(x);

% plot(x,y,'LineStyle',':',...
%     'DisplayName','Predicted Fit',...
%     'Color',Color,...
%     'LineWidth',3);


legend('show');
set(legend,'FontName','Arial Narrow');

filename = strcat(day,' Projected Chi vs Epsilon');
savefig(filename);
print(filename,'-dpng');


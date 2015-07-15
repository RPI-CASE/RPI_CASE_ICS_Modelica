Blueish = [0 0.45 0.74];
Yellowish = [0.75 0.75 0];
Redish = [0.85 0.33 0.1];

figure('Color',[1 1 1]);
hold on;

% title({'\chi vs \epsilon','Measured Total Array'},...
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

axis([0 0.14 0 0.4]);

%Plot 20-Feb
load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','chi_arrayTotal',...
    'measured_Ex_epsilon','Start','End','day');

Color = Blueish;

%trimmed obseverd chi and epsilon
t_o_chi = chi_arrayTotal(:,Start:End);
t_o_epsilon_arrayTotal = measured_Ex_epsilon(:,Start:End);

%need to transpose in order to scatter plot
chi_trans = transpose(t_o_chi);
Ex_epsilon_trans = transpose(t_o_epsilon_arrayTotal);

f=fit(chi_trans,Ex_epsilon_trans,'poly1');

scatter(chi_trans,Ex_epsilon_trans,...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...
    day,' \chi vs \epsilon'));

x=0:.01:.2;
y=f(x);

plot(x,y,'LineStyle',':',...
    'DisplayName',strcat(day, ' Linear Bestfit'),...
    'Color',Color,...
    'LineWidth',3);


%Plot 19-Mar
load('ICSolar.ICS_Skeleton_19_Mar_2015.mat','chi_arrayTotal',...
    'measured_Ex_epsilon','Start','End','day');

Color = Yellowish;

%trimmed obseverd chi and epsilon
t_o_chi = chi_arrayTotal(:,Start:End);
t_o_epsilon_arrayTotal = measured_Ex_epsilon(:,Start:End);

%need to transpose in order to scatter plot
chi_trans = transpose(t_o_chi);
Ex_epsilon_trans = transpose(t_o_epsilon_arrayTotal);

f=fit(chi_trans,Ex_epsilon_trans,'poly1');

scatter(chi_trans,Ex_epsilon_trans,...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...
    day,' \chi vs \epsilon'));

x=0:.01:.2;
y=f(x);

plot(x,y,'LineStyle',':',...
    'DisplayName',strcat(day, ' Linear Bestfit'),...
    'Color',Color,...
    'LineWidth',3);

%Plot 23-Mar
load('ICSolar.ICS_Skeleton_23_Mar_2015.mat','chi_arrayTotal',...
    'measured_Ex_epsilon','Start','End','day');

Color = Redish;

%trimmed obseverd chi and epsilon
t_o_chi = chi_arrayTotal(:,Start:End);
t_o_epsilon_arrayTotal = measured_Ex_epsilon(:,Start:End);

%need to transpose in order to scatter plot
chi_trans = transpose(t_o_chi);
Ex_epsilon_trans = transpose(t_o_epsilon_arrayTotal);

f=fit(chi_trans,Ex_epsilon_trans,'poly1');

scatter(chi_trans,Ex_epsilon_trans,...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...
    day,' \chi vs \epsilon'));

x=0:.01:.2;
y=f(x);

plot(x,y,'LineStyle',':',...
    'DisplayName',strcat(day, ' Linear Bestfit'),...
    'Color',Color,...
    'LineWidth',3);




legend('show');
set(legend,'FontName','Arial Narrow');

filename = 'Chi vs Epsilon - Whole Array for 3 datasets';
savefig(filename);
print(filename,'-dpng');

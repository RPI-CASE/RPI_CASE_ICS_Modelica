load('T85C_F5.0.mat')

for i = 1:8765
   Tcav = ics_envelopecassette1.cavityheatbalance1.CavityHeatCapacity.T(i);
   
   if G_DN(i) < 0
       G_DN(i) = 0;
   end
   
   chi(i) = (temp_flowport_a(i)-Tcav)/(G_DN(i));
   
   if chi(i) > 1
       chi(i) = 1;
   elseif chi(i) < 0
       chi(i) = 0;
   end
end

ExvsChi = [];
c = 1;
%figure
%hold
for i = 1:8765
    if and(and(chi(i)>0.001,chi(i)<1),Ex_epsilon(i)>0)
        ExvsChi(c,1) = G_DN(i); %chi(i); 
        ExvsChi(c,2) = eta_E(i)/0.93 + Ex_epsilon(i); % Ex_epsilon(i);
        ExvsChi(c,3) = eta_E(i)/0.93;
        ExvsChi(c,4) = eta_Q(i)/0.93;
        ExvsChi(c,5) = G_DN(i);
        %ExvsChi(c,5) = eta_E(i)/0.93 + Ex_epsilon(i);
        %plot(chi(i),Ex_epsilon(i), '.')
        c = c+1;
    end
end
% coeffs = polyfit(ExvsChi(:,1),ExvsChi(:,2),2);
% fittedX = linspace(min(ExvsChi(:,1)),max(ExvsChi(:,1)),200);
% fittedY = polyval(coeffs, fittedX);
% [r2, rmse] = rsquare(ExvsChi(:,2),fittedY);
% 
% hold on;
% plot(fittedX, fittedY, 'r-', 'LineWidth', 3);

d = 2;
x = ExvsChi(:,1); 
y = ExvsChi(:,2); 
p = polyfit(x,y,d); 
polyfit_str = [num2str(p)];
xfit = linspace(min(x),max(x),length(y));
yfit = polyval(p,xfit); 
yresid = y - yfit';
SSresid = sum(yresid.^2);
SStotal = (length(y)-1)*var(y);
rsq = (SSresid/SStotal)*(length(y)-1)/(length(y)-length(p)) - 1;

%[r2, rmse] = rsquare(y,yfit); 
% figure; 
%Plot epsilon_exergy
hold all;
plot(x,y,'.'); 
 
% plot best fit
plot(xfit,yfit,'-', 'LineWidth', 3); 
% plot Egen efficiency
%plot(x,ExvsChi(:,3),'g.')
% plot Qgen efficiency 
%plot(x,ExvsChi(:,4),'r.')
%plot(x,ExvsChi(:,5),'m.')
title(strcat(['Tinlet = ' num2str(max(temp_flowport_a)) ' ; R^2 = ' num2str(rsq) ' ; degrees of freedom = ' num2str(d) ' ; coefficients = ' polyfit_str])) 
xlabel('$\chi = \frac{(T_{inlet}-T_{cav})}{\left(GDN\right)}$', 'Interpreter','LaTeX','FontSize',20)
ylabel('$\varepsilon_{exergy} = \frac{m_{flow} \times cp \times \left(T_{outlet}-T_{inlet}-T_{amb} \times \log(\frac{T_{outlet}}{T_{inlet}})\right)}{( GDN \times 0.93)}$', 'Interpreter','LaTeX','FontSize',20)
% axis([0.05 0.3 0.0 0.06])
% ylabh = get(gca,'ylabel');
% set(ylabh,'Position',get(ylabh,'Position') - [0 0 0])

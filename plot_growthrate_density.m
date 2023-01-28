%plot growth rate of density
z_start=round((-2*pi/(3*kbar)+pi)/h); %corresponding to z=-2pi/3k 
z_end=round((2*pi/(3*kbar)+pi)/h);%corresponding to z=2pi/3k
reduced_density= density(:,z_start:z_end);
min_density=min(reduced_density,[],2);
dn=1-min_density(100);
x_data=T(:,1);
y_data=abs(max_ue-1)/due;
% f=fit(x_data,y_data,'exp1')
% hold on
% gm=1.2e6;
% hold on
% plot(f,x_data,y_data)
% legend("data","fit")
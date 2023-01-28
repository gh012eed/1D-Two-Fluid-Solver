%plot growth rate
z_start=round((-2*pi/(3*kbar)+pi)/h); %corresponding to z=-2pi/3k 
z_end=round((2*pi/(3*kbar)+pi)/h);%corresponding to z=2pi/3k
reduced_ue= -1*u_e(:,z_start:z_end);
max_ue=max(reduced_ue,[],2);
due=ue0-1;
x_data=T(:,1);
y_data=abs(max_ue-1)/due;
f=fit(x_data,y_data,'exp1')
gm=1.2e6;
plot(u_e(1,z_start:z_end))
figure
plot(f,x_data,y_data)
legend("data","fit")
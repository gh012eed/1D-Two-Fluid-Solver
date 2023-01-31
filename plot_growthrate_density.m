%plot growth rate
z_start=round((-2*pi/(3*kbar)+pi)/h); 
z_end=round((2*pi/(3*kbar)+pi)/h);
reduced_n= density(:,z_start:z_end);
min_n=min(reduced_n,[],2);%min density as a function of time
x_data=T(:,1);
y_data=abs(min_n-n0);
fs=30

kz=628;
u=uref*ue0;
me=9.1e-31;
mi=70000*me;
vte=5.9e5;
theory=kz*sqrt(me/mi*(u*u-vte*vte));
theory_ref=theory*tref;%growth rate in reference units

figure

plot(x_data,y_data,'linewidth',2)
hold on
plot(x_data,y_data(1)*exp(theory_ref*x_data),'linewidth',2)

l=6;
w=6*2.5;
fig=gcf;
fig.Units='inches';
fig.Position=[1,1,w,l];
ax=gca;
ax.FontSize = fs;
ylabel('$\Delta \bar{u}_e$','Interpreter','latex','fontsize',fs+18)
xlabel('$\bar{t}$','Interpreter','latex','fontsize',fs+18)
%ylim([1,5])
legend("data","fit",'fontsize',fs)
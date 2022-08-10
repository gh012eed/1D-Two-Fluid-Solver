function plot_function(variable,y_label,tf)
    p=8;
    h=2*pi/2^p;
    ld=1/2;%try 1/128 will take >an hour 
    dt=h*ld;
    z=(-pi+h):h:pi;%grid points excluding z=0
    t=0:dt:tf;


    M=length(t);
    kbar=2*pi;
    z_start=round((-2*pi/(3*kbar)+pi)/h); %corresponding to z=-2pi/3k
    z_end=round((2*pi/(3*kbar)+pi)/h);%corresponding to z=2pi/3k
    %z_start=1;
    %z_end=N;
    %figure size
    l=4.5;
    w=9;
    fs=18;%fontsize

    T1=round(M/3);
    T2=round(2*M/3);
    T3=round(3*M/3);
    lw=1.5;
    %plot with SI units
    z_units=1;%cm
    figure
    plot(z(z_start:z_end)*z_units,variable(1,z_start:z_end),'-','linewidth',lw)
    hold on
    plot(z(z_start:z_end)*z_units,variable(T1,z_start:z_end),'--','linewidth',lw)
    hold on
    plot(z(z_start:z_end)*z_units,variable(T2,z_start:z_end),':','linewidth',lw)
    hold on
    plot(z(z_start:z_end)*z_units,variable(T3,z_start:z_end),'-.','linewidth',lw)

    ylabel(y_label,'Interpreter','latex')
    xlabel('$\bar{z}$','Interpreter','latex')
    leg1=legend('$\overline{t}=0$',sprintf('$\\overline{t}$=%0.2f',(T1-1)*dt),sprintf('$\\overline{t}$=%0.2f',(T2-1)*dt),sprintf('$\\overline{t}$=%0.2f',(T3-1)*dt),'Location','southeast','NumColumns',2);
    set(leg1,'Interpreter','latex');
    set(leg1,'FontSize',14);
    fig=gcf;
    fig.Units='inches';
    fig.Position=[1,1,w,l];
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',fs);
end
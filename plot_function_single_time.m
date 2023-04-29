function plot_function_single_time(variable,y_label,t_in,limy,y_lim)
%variable: a MxN matrix.  data for plotting
%y_label: label of y axis
%t_in: time index of plotting
%limy:if True. set limy to y_lim parameter
    p=8;
    h=2*pi/2^p;
    ld=1/2;%try 1/128 will take >an hour 
    dt=h*ld;
    z=(-pi+h):h:pi;%grid points excluding z=0

    kbar=2*pi;
    z_start=round((-4*pi/(3*kbar)+pi)/h); %corresponding to z=-2pi/3k 
    z_end=round((4*pi/(3*kbar)+pi)/h);%corresponding to z=2pi/3k
    %z_start=1;
    %z_end=N;
    %figure size
    l=6;
    w=l*2.5;
    fs=30;%fontsize

    lw=2.5;
    temp_count=1;
    plot(z(z_start:z_end),variable(t_in,z_start:z_end),'linewidth',lw,'color','magenta')
    legendInfo{temp_count}=sprintf('$\\overline{t}$=%0.2f',(t_in-1)*dt); 
    if limy
        ylim(y_lim)
    end
    leg1=legend(legendInfo,'Location','eastoutside','NumColumns',1);
    set(leg1,'Interpreter','latex');
    set(leg1,'FontSize',fs+4);
    fig=gcf;
    fig.Units='inches';
    fig.Position=[1,1,w,l];
    ax=gca;
    ax.FontSize = fs;
    ylabel(y_label,'Interpreter','latex','fontsize',fs+18)
    xlabel('$\bar{z}$','Interpreter','latex','fontsize',fs+18)
end
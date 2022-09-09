function plot_function(variable,y_label,tf,limy,y_lim)
%variable: a MxN matrix.  data for plotting
%y_label: label of y axis
%tf: finial time from solver.m
%limy:if True. set limy to y_lim parameter
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
    
    %T_list=round(1:M:M+1);
    %T_list(end)=M;
    T_list=[2*M/3];
    lw=1.5;
    %plot with SI units
    %all_marks = {'o','+','*','.','x','s','d','^','v','>','<','p','h'};
    all_line_styles={'--','-',':','-.'};
    figure
    temp_count=1;
    legendInfo=cell(length(T_list),1);
    for T=T_list        
        plot(z(z_start:z_end),variable(T,z_start:z_end),'linewidth',lw,...
            'linestyle',all_line_styles{mod(temp_count,4)+1})
        hold on
        legendInfo{temp_count}=sprintf('$\\overline{t}$=%0.2f',(T-1)*dt); 
        temp_count=temp_count+1;
    end
    hold off
    if limy
        ylim(y_lim)
    end
    ylabel(y_label,'Interpreter','latex')
    xlabel('$\bar{z}$','Interpreter','latex')
    leg1=legend(legendInfo,'Location','southeast','NumColumns',2);
%     leg1=legend('$\overline{t}=0$',sprintf('$\\overline{t}$=%0.2f',(T1-1)*dt),...
%     sprintf('$\\overline{t}$=%0.2f',(T2-1)*dt),...
%     sprintf('$\\overline{t}$=%0.2f',(T3-1)*dt),...
%     sprintf('$\\overline{t}$=%0.2f',(T4-1)*dt),...
%     sprintf('$\\overline{t}$=%0.2f',(T5-1)*dt),...
%     'Location','southeast','NumColumns',2);
    set(leg1,'Interpreter','latex');
    set(leg1,'FontSize',14);
    fig=gcf;
    fig.Units='inches';
    fig.Position=[1,1,w,l];
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',fs);

end
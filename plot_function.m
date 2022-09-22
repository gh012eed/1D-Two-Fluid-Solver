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
    w=l*3;
    fs=20;%fontsize
    
    T_list=round(1:M/3:M+1);
    T_list(end)=M;
    %T_list=[M];
    lw=2;
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

    leg1=legend(legendInfo,'Location','southeast','NumColumns',2);
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
T_list=round(1:M/15:M+1);
T_list(end)=M;
for t=T_list
    f = figure('visible','off');
    plot_function_single_time(density,'$\bar{n}$',t,true,[0.7,1.1])
    formatSpec = "density_%d.jpg";
    saveas(f,sprintf(formatSpec,t))
end


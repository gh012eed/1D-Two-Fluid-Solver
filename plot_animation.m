T_list=round(1:M/15:M+1);
T_list(end)=M;
for t=T_list
    f = figure('visible','off');
    plot_function_single_time(-u_e,'$|\bar{u}_e|$',t,true,[0,5.2])
    formatSpec = "ue_%d.jpg";
    saveas(f,sprintf(formatSpec,t))
end


function [ starttimes,rn,un ] = change( g,r,u,p )
%% 将一个作业长度不等的多机调度问题转换为长度相等的作业的多机调度问题
    %剩余作业的最大处理时间，新的处理时间
    pmax = max(p);
    %新的释放时间和最晚开始时间
    rn=pmax*floor(r/pmax);
    un=pmax*floor(u/pmax);
    %二分查找确定使用最少的机器个数
    if all(rn)==0%rn中存在0
        rn=rn+1;
        un=un+1;
    end
    m = getm(g,rn,un,pmax);
    %生成一个可行调度
    [~,starttimes] = shedule(m * g,rn,un,pmax);
end
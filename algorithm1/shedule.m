function [ flag,starttimes ] = shedule( m,r,u,p )
%% 多台处理器作业调度优化
% starttimes：可行的调度
% r：作业的释放时间
% u：作业的最迟开始时间
% m：机器的台数
% p：作业的处理时间，所有的作业处理时间相同

    %作业总时间
    B=sort([r u]);
    rmin = min(B);
    umax = max(B);
    %以时间为顶点
    T = rmin:umax;
    %图G中边的权重
    G=ones(length(T))*inf;
    %标识图G中的边
    M=zeros(length(T));
    M = existsedge( M,rmin,umax,r,u,p)';
    for i=1:length(T)
        for j=1:length(T)
            %判断是否存在边，若存在，则计算边的权重
            if M(i,j) == 1
                if i < j
                    G(i,j)=m;
                else
                    count = 0;
                    for k = 1:length(r)
                        if r(k) >= j && u(k) <= i
                            count = count + 1;
                        end
                    end
                    G(i,j)=-count;
                end
            end
        end
    end

    %绘出调度图
    %graph(G);
    %求解问题
    [flag,dis] = bellmanford(G,umax);
    if flag
        %确定各个作业的开始时间
        [~,ind]=sort(u);
        starttimes = zeros(1,length(u));
        k=1;
        for i=1:length(T)-1
            if dis(i) ~= dis(i+1)
                %当前时刻i开始的作业个数
                tmp = dis(i+1) - dis(i);
                while(tmp > 0)
                    starttimes(ind(k)) = i;
                    k = k+1;
                    tmp = tmp - 1;
                end
            end
        end
    else
        starttimes=[];
    end
end
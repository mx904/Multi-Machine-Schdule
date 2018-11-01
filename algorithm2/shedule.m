function [ flag,starttimes ] = shedule( m,r,u,p )
%% 多台处理器作业调度优化
% starttimes：可行的调度
% r：作业的释放时间
% u：作业的最迟开始时间，注意最迟开始时间r最大等于u-1
% m：机器的台数
% p：作业的处理时间，所有的作业处理时间相同
    %bellman算法对最晚开始时间的理解不同
    %例如算法理解的r=[1 4 4 4];u=[4 4 10 4];m=4;p=3;
    %我们理解的r=[1 4 4 4];u=[5 5 11 5];m=4;p=3;
    %因此，为了便于理解，这里对u统一做了加1处理。
    u=u+1;
    %作业总时间
    B=sort([r u]);
    umax = max(B);
    %以时间为顶点
    T = 1:umax;
    %图G中边的权重
    G=ones(length(T))*inf;
    %标识图G中的边
    M=zeros(length(T));
    M = existsedge( M,r,u,p)';
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
    graph(G);
    %求解问题
    [flag,dis] = bellmanford(G,umax);
    if flag
        %确定各个作业的开始时间
        [~,ind]=sort(u);
        starttimes = zeros(1,length(u));
        %可能前面存在inf，代表没有作业开始
        location = find(dis~=inf,1);
        dis(dis==inf)=dis(location);
        %根据差分约束系统的解的性质，得到各个时刻运行的作业的个数
        dis=dis+length(u);
        %作业编号ind(k)
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
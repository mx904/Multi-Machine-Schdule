function [ newstarttimes ] = optimalshedule( starttimes,m,g,r,u,p )
%% 多台多处理器作业调度优化
% starttimes：可行的调度
% r：作业的释放时间
% u：作业的最迟开始时间
% m：机器的台数
% g：每台机器上处理器的个数
% p：作业的处理时间，所有的作业处理时间相同
    
    rmin = min(r);
    umax = max(u);
    %未调度的作业
    U=1:length(r);
    %优化后的调度时间
    newstarttimes = zeros(1,length(r));
    K=[];
    P=[];
    t=rmin;
    while t <= umax && ~isempty(U)
        %待调度的作业，记录其下标
        Stmp = [];
        s = max(t,starttimes);
        %遍历未调度作业的集合，统计在t和t+p之间开始的作业的个数
        count = 0;
        for i=1:length(U)
            %注意到，时间线推进过程中，可能开始时间位于t和t+2p之间的作业个数不大于2mg
            if s(U(i)) >= t && s(U(i)) < t + 2*p
                count = count + 1;
                Stmp = [Stmp i];
                newstarttimes(U(i)) = s(U(i));
            end
        end
        %批调度
        if count >= m*g
            %删除已经调度的作业
            U(Stmp) = [];
            %更新时间
            for i=t:t+3*p
                if ~ismember(i,K)
                    K=[K i];
                end
            end
            t = t + 2*p;
        else
            %检查是否有急需要运行的作业
            flag = 0;
            for i=1:length(U)
                if u(U(i)) == t
                    flag = 1;
                    break;
                end
            end
            %若存在急需要运行的作业
            if flag
                Stmp = [];
                %检查所有未调度作业的开始时间是否在t和t+p之间，若是，则运行
                for i=1:length(U)
                    if s(U(i)) >= t && s(U(i)) < t + p
                        Stmp = [Stmp i];
                        newstarttimes(U(i)) = s(U(i));
                        P = [P U(i)];
                    end
                end
                %删除已经调度的作业
                U(Stmp) = [];
                %更新时间
                 t = t + p;
            else
                %不存在急需运行的作业时，需要将时间轴向前推进
                t = t + 1;
            end
        end
    end
end
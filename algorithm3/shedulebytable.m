function [ m ] = shedulebytable( g,s,p )
%% 通过调度时间表调度间歇作业
%s：开始时间
%p：处理时间
%g：处理器个数
%m：需要的机器台数
    %作业的个数
    num=length(s);
    %机器个数
    m=1;
    %调度表，每g行代表一个
    complete=s+p;
    scheduletable=zeros(num,g,max(complete)-min(s)+1);
    %逐个调度剩余的不等长度的作业，以释放时间为开始时间
    if num>0
        for i=1:num
            %逐个机器检查是否可以调度
            j=1;
            while j<=m
                flag=0;
                for k=1:g
                    %繁忙时间段
                    work=s(i):complete(i)-1;
                    if all(scheduletable(j,k,work)==0)
                        scheduletable(j,k,work)=1;
                        flag=1;
                        break;
                    end
                end
                %若找到一台机器可以调度，则停止寻找
                if flag
                    break;
                else
                    j=j+1;
                end
            end
            %若没有找到一台机器可以调度，则新添加一台机器
            if flag==0
                m=m+1;
                scheduletable(m,1,work)=1;
            end
        end
    end
end


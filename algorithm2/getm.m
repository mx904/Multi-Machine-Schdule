function [ m ] = getm( g,r,u,p )
%% 二分查找确定使用最少的机器个数
    m1=1;
    m2=length(r);
    flag=1;
    while flag
        n=fix((m1+m2)/2);
        [flag,~]=shedule(n * g,r,u,p);
        if flag
            m=n;
        end
        m2=n;
    end
end
function [ m ] = getm( g,r,u,p )
%% 二分查找确定使用最少的机器个数
    m1=1;
    m2=length(r);
    m=m2;
    flag=1;
    while flag
        n=fix((m1+m2)/2);
        [flag,~]=shedule(n * g,r,u,p);
        %存在可行解
        if flag
            m=n;
            m2=n;
        else%不存在可行解
            m1=n;
        end
        if m1==m2
            break;
        end
    end
end
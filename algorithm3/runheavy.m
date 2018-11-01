function [ U,m ] = runheavy( jid,starttimes,r,u,rmin,umax,p,g )
%% 包处理作业
%U：执行过的作业的序号集合
%m：使用的机器数量
    U=[];%要删除的作业集合
    k=0;
    t=0;
    m=0;
    while t < rmin
        k=k+1;
        t=k*p;
    end
    while t >= rmin && t <= umax
        Jt1=[];
        Jt2=[];
        %第一组
        for i=1:length(jid)
            if starttimes(jid(i))==t
                Jt1=[Jt1 jid(i)];%加入作业编号
            end
        end
        k1=floor(length(Jt1)/g);
        if k1>0
            for i=1:k1*g
                no = Jt1(i);
                U=[U no];%记录要删除的作业
                starttimes(Jt1(i))=max(starttimes(no),r(no));%更新开始时间
            end
        end
        
        %第二组
        for i=1:length(jid)
            if starttimes(jid(i)) <= t && t <= u(jid(i))
                Jt2=[Jt2 jid(i)];%加入作业编号
            end
        end
        k2=floor(length(Jt2)/g);
        if k2>0
            for i=1:k2*g
                no = Jt2(i);
                U=[U Jt2(i)];%记录要删除的作业
                starttimes(no)=max(starttimes(no),r(no));%更新开始时间
            end
        end
        k=k+1;
        t=k*p;
        m=m+k1+k2;
    end
end
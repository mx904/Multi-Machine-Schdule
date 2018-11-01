%% 多台多处理器上的作业繁忙时间调度问题
%将一个长度不等的多机调度问题转换为长度相等的多机调度问题
%每台机器上的处理器个数
g = 2;
%作业的释放时间
r = [1 2 2 3 4 5 3 4 6 7 4 5 9 7 3 4];
%作业的最迟开始时间
u = [9 4 7 5 6 8 10 15 12 10 9 7 10 9 5 6];
%作业处理时间
p = [6 2 1 3 4 5 3 4 6 10 4 5 6 4 3 8];
%使用的机器总数
totalm = 0;
%按照作业处理时间将作业打包
tmp=zeros(1,length(p));
for i=1:length(p)
    tmp(i) = getregion(p,i);
end
%待删除作业集合
JD=[];
%剩余作业集合
JR=1:length(r);
%开始时间
starttimes = zeros(1,length(u));
%对每包作业分别处理
for i=1:max(tmp)
    %第i包作业
    bag = find(tmp==i);
    %将一个作业长度不等的多机调度问题转换为长度相等的作业的多机调度问题，生成一个可行调度
    [ tmpstarttime,rn,un ] = change(g,r(bag),u(bag),p(bag));
    %更新开始时间
    for j=1:length(bag)
        starttimes(bag(j))=tmpstarttime(j);
    end
    %执行runheavy方法
    [U,m]=runheavy(bag,starttimes,r,u,min(rn),max(un),max(p(bag)),g);
    %使用的机器数加m
    totalm=totalm+m;
    %执行过的作业
    JD=[JD U];
end
%删除已经调度的作业
JR(JD)=[];
%作业调度顺序
JD=[JD JR];
%需要机器的个数
m=shedulebytable(g,starttimes(JR),p(JR));
%总共使用的机器个数
totalm=totalm+m
%各个作业的开始时间
starttimes
%% 多台多处理器上的作业繁忙时间调度问题
%每台机器上的处理器个数
g = 2;
%作业处理时间
p = 3;
%作业的释放时间
r = [1 2 2 3 4 5 3 4 6 7 4 5 9 7 3 4];
%作业的最迟开始时间
u = [9 2 2 5 6 8 10 15 12 10 9 7 10 9 5 6];
%二分查找确定使用最少的机器个数
m=getm(g,r,u,p)
%生成一个可行调度
[~,starttimes] = shedule(m * g,r,u,p)
%优化调度
newstarttimes = optimalshedule(starttimes,m,g,r,u,p)
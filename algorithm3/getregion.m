function [ id ] = getregion( p,i )
%% 判断处理时间所处的区间编号
%p：处理时间数组
%i：当前元素所在数组的位置
    %打包个数
    q=ceil(log2(max(p)/min(p)));
    m=min(p);
    count=1;
    while count<=q
        if p(i) >= m*power(2,count-1) && p(i) < m*power(2,count)
            break;
        elseif p(i) >= m*power(2,count)
            count = count + 1;
        end
    end
    id = count;
end


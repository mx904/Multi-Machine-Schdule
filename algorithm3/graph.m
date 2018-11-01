function graph(cm)
%% 绘图

    %% 去除图中的权重为inf的边
    for i=1:size(cm,1)
        for j=1:size(cm,2)
            if cm(i,j) == inf
                cm(i,j) = 0;
            end
        end
    end
    
    %% 设置图显示权重并可视化
     bg=biograph(cm);
     bg.showWeights='on';
     view(bg);
end
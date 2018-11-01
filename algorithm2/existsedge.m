function [ M ] = existsedge( M,r,u,p)
%ÅĞ¶ÏÍ¼ÖĞÊÇ·ñ´æÔÚ±ß
    rmin=min(r);
    umax=max(u);
	%% Ô¼Êø1
    for i=1:size(M,1)
        if i >= rmin && i <= umax-p
            M(i+p,i) = 1;
        end
    end
    
	%% Ô¼Êø2
	for i=1:size(M,1)
        if i >= rmin && i < umax
            M(i,i+1) = 1;
        end
    end
    
	%% Ô¼Êø3
    for i=1:length(r)
        for j=1:length(r)           
            if(r(i)<u(j))
                M(r(i),u(j)) = 1;
            end
        end
    end
end

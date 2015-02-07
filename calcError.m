function [ error ] = calcError( func, data, means, actualValue)
    error = 0;
    for j =1:length(actualValue)
        data_class = data{j};
        for i =1:size(data_class,1)
            z = [data_class(i,1) data_class(i,2)];
            if(func(means,z)~=actualValue(j))
                error=error+1;
            end
        end
    end
end


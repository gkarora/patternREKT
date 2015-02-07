function [gridXValues, gridYValues, classifiedValues] = makeGrid2(gridStep, dataA, dataB)

    xMin = min([min(dataA(:,1)) min(dataB(:,1))]);
    xMax = max([max(dataA(:,1)) max(dataB(:,1))]);
    yMin = min([min(dataA(:,2)) min(dataB(:,2))]);
    yMax = max([max(dataA(:,2)) max(dataB(:,2))]);
    
    gridXValues = (xMin):gridStep:(xMax);
    gridYValues = (yMin):gridStep:(yMax);
    
    classifiedValues = zeros(length(gridYValues),length(gridXValues));

end
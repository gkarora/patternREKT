function [gridXValues, gridYValues, classifiedValues] = makeGrid3(gridStep, dataA, dataB, dataC)

    xMin = min([min(dataA(:,1)) min(dataB(:,1)) min(dataC(:,1))]);
    xMax = max([max(dataA(:,1)) max(dataB(:,1)) max(dataC(:,1))]);
    yMin = min([min(dataA(:,2)) min(dataB(:,2)) min(dataC(:,2))]);
    yMax = max([max(dataA(:,2)) max(dataB(:,2)) max(dataC(:,2))]);
    
    gridXValues = (xMin):gridStep:(xMax);
    gridYValues = (yMin):gridStep:(yMax);
    
    classifiedValues = zeros(length(gridYValues),length(gridXValues));

end
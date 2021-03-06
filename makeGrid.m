% makeGrid: create a grid underlying the selected feature space
% 
% INPUTS:
%   gridStep - <double> indicating the stepsize of the grid
%   varargin - 1 to N inputs. each inputs represents a set of training
%   data for a given class, in <M x 2> format where M is the number of 
%   samples.
%
% OUTPUTS:
%   gridXValues - vector of X-values for the grid
%   gridYValues - vector of Y-values for the grid
%   classifiedValues - matrix of zeroes representing the class at the
%   specified "cell" in the grid
% 
% USAGE (Example): [xVals,yVals,class] = makeGrid(step, data_a, data_b)
function [gridXValues, gridYValues, classifiedValues] = makeGrid(gridStep, varargin)
    minX = [];
    minY = [];
    maxX = [];
    maxY = [];
     
    % go over each dataset and find the max & min X & Y values
    for i = 1:length(varargin)
        xVals = varargin{i}(:, 1);
        yVals = varargin{i}(:, 2);
        minX = min([ minX min(xVals) ]);
        minY = min([ minY min(yVals) ]);
        maxX = max([ maxX max(xVals) ]);
        maxY = max([ maxY max(yVals) ]);
    end
    
    % add a margin of size 0.5 to upper and lower bounds of x & y
    gridXValues = min(xVals):gridStep:max(xVals);
    gridYValues = min(yVals):gridStep:max(yVals);
    
    % matlab (row,col) notation is (Y,X)
    classifiedValues = zeros(length(gridYValues),length(gridXValues));
end
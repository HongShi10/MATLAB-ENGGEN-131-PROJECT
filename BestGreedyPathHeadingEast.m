%This function BestGreedyPathHeadingEast.m finds the best greedy path
%that heads in the east direction. This is done by both calling the
%GreedyWalk.m and FindPathElevationsAndCost.m function and runs a loop that
%searches through the first column for the best greedy path and then
%compares the cost of each to find the lowest costing path
%Inputs = E (The surface matrix)
%Outputs = pathRows (the row number for each path)
%          pathCols (the column number for each path)
%          elev (the elevations for each path)
%Author = Hong Shi

function [pathRows,pathCols,pathElev] = BestGreedyPathHeadingEast(E)

direction = 1;%Makes it so that it goes in the easterly direction
[r,~] = size(E);%Assigns the rows to the variable 'r' for the loop below
cost = zeros(1,r);%Preallocates the array for speed

%This loop cycles through each rows first columns position and calls the
%GreedyWalk.m and FindPathElevationsAndCost.m and then stores each cost
%in a array
for i = 1:r
    currentpos = [i,1];%cycles through starting positions in first column
    %calls GreedyWalk.m
    [pathRows,pathCols] = GreedyWalk(currentpos,direction,E);
    %calls FindPathElevationsAndCost.m
    [~,cost(i)] = FindPathElevationsAndCost(pathRows,pathCols,E);
end
%This loop finds the position in which the minimum cost is by finding the
%lowest number in the cost array and then using a if loop to find which
%where it is equal to and is assigned a variable positionOfLowestCost
counter = 1;%adds a counter for the the positioOflowestCost array
for i = 1:r
    if min(cost) == cost(i) %checks if it is the smallest cost
        positionOfLowestCost(counter) = i;%stores the row in this array
        counter = counter+1;%adds 1 to the counter
    end
end
%Assigns the variable currentpos the position of the start where the total
%lowest cost is found and uses the first one found
currentpos = [positionOfLowestCost(1),1];
%Calls the GreedyWalk.m function again and gives 2 outputs of pathRows
%and pathCols
[pathRows,pathCols] = GreedyWalk(currentpos,direction,E);
%Calls the FindPathElevationsAndCost.m function again and gives 1 output
%of pathElev
[pathElev,~] = FindPathElevationsAndCost(pathRows,pathCols,E);
end


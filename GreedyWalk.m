%The function GreedyWalk.m shows the rows and columns that are used to
%cross the path by calling the GreedyPick.m function as a helper
%Inputs = pick (the next path to take)
%         direction (1 for east direction -1 for west)
%         E (the 2D array surface)
%Outputs = pathRows (the rows which are used)
%          pathCols (the columns that are used)
%Author = Hong Shi
function [pathRows,pathCols] = GreedyWalk(currentpos,direction,E)

[~,c] = size(E);%Assigns variable c to the number of columns in the array
pathRows = currentpos(1); %Initialises the first space in the array
pathCols = currentpos(2); %for both pathRows and pathCols

%This loop creates an array by calling the GreedyPick.m function
%and storing each value in a seperate slot in the array for
%both pathRows and pathCols
if direction == 1 %for direction of +1 which is heading east
    %finds the difference in the columns to see how many loops it runs
    for i = 2:c-currentpos(2)+1
        %calls GreedyPick.m function
        [currentpos] = GreedyPick(currentpos,direction,E);
        %stores the number in a array called pathRows
        pathRows(i) = currentpos(1);
        %stores the number in a array called pathCols
        pathCols(i) = currentpos(2);
    end
end

if direction == -1 %for direction of -1 which is heading west
    %finds how many loops it needs to run by finding the column start point
    for i = 2:(currentpos(2))
        %calls GreedyPick.m
        [currentpos] = GreedyPick(currentpos,direction,E);
        %stores the number in a array called pathRows
        pathRows(i) = currentpos(1);
        %stores the number in a array called pathCols
        pathCols(i) = currentpos(2);
    end
end

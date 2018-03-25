%This function FindPathElevationsAndCost.m shows the total cost of the path
%as well as the single elevations for each path taken
%Inputs = pathRows (the row number for each path)
%         pathCols (the column number for each path)
%         E (The surface matrix)
%Outputs = elev (the elevations for each path)
%          cost (the total cost of the path)
%Author = Hong Shi
function [elev,cost] = FindPathElevationsAndCost(pathRows,pathCols,E)

elev = zeros(1,length(pathCols));%Preallocates the array with zeros

%For loop in which the path elevations get stored in a array
for i = 1:length(pathCols)
    elev(i) = E(pathRows(i),pathCols(i));
end

costOfEach = zeros(1,length(elev)-1);%Preallocates the array for speed

%For loop which stores the cost between each path into a array costOfEach
for j = 1:length(elev)-1
    %calculates the cost by taking the elevations next to each other and
    %finding the difference
    costOfEach(j) = abs(elev(j)-elev(j+1));
end
%finds the total cost by adding the number in each array element
cost = sum(costOfEach);
end

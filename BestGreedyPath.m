%This script BestGreedyPath.m finds the best path by looking at each
%element in the array. It calculats the cost starting from each elevation
%point and goes towards the west and east adding the cost together if it
%started somewhere in the middle. It produces a new matrix cost matrix and
%finds the first position where the lowest cost is and stores that position
%and then calls the GreedyWalk.m function again to find the final output of
%pathRows and pathcols and calls FindPathElevationAndCost to find the elev
%Inputs = E (the 2D array surface)
%Outputs = pathRows (the rows which are used)
%          pathCols (the columns that are used)
%          elev (the elevations for each path)
%Author = Hong Shi
function [pathRows,pathCols,pathElev] = BestGreedyPath(E)

%Assigns the variables r and c to the respective rows and columns
[r,c] = size(E);
costs = zeros(r,c);%Preallocates space for the array 'costs' for speed

%This nested loop runs through the 2D array(E) and goes through each
%element and calls the GreedyWalk.m and FindPathElevationsAndCost.m
%functions to find the pathRows and pathCols as well as creating a matrix
%that has the costs starting from each element
for i = 1:r
    for j = 1:c
        %creates the current position by using the nested loop
        currentpos = [i,j];
        if j == 1 %For first column it can only go in the east direction
            direction = 1;%direction has +1 meaning it travels east
            %calls GreedyWalk function to output pathRows and pathCols
            [pathRows,pathCols] = GreedyWalk(currentpos,direction,E);
            %calls FindPathElevationsAndCost to output cost into a array
            [~,costs(i,j)] =FindPathElevationsAndCost(pathRows,pathCols,E);
        elseif j == c %for last column can only go in the west direction
            direction = -1;%direction of -1 means it travels west
            [pathRows,pathCols] = GreedyWalk(currentpos,direction,E);
            [~,costs(i,j)]=FindPathElevationsAndCost(pathRows,pathCols,E);
            %if the starting element is in the middle it can travel both
            %east and west this creates 2 arrays for each of pathRows and
            %pathCols and calculates the 2 different costs for each
            %direction and then adds them together to form the cost array
            %of that element
            %for everything in the middle it has to call both east and west
            %directions so it creates new arrays called costEast and costWest
            %and combines to find the total cost from that element and stores it
            %in the costs array
        else
            direction = 1;%travels east
            %calls GreedyWalk.m
            [pathRows,pathCols] = GreedyWalk(currentpos,direction,E);
            [~,costWest] = FindPathElevationsAndCost(pathRows,pathCols,E);
            direction = -1;%travels west
            [pathRows,pathCols] = GreedyWalk(currentpos,direction,E);
            [~,costEast] = FindPathElevationsAndCost(pathRows,pathCols,E);
            %adds the cost of west direction and east direction together
            costs(i,j) = costWest + costEast;
        end
    end
end
%reapplies the variables c and r to columns and rows respectively
[r,c] = size(E);
SmallestPathRowCost = zeros(length(r)); %preallocates array for speed

for i = 1:r
    %finds the lowest number in the 2D array
    [SmallestPathRowCost(i)] = min(costs(i,:));
    
end
%searches within the array and assigns the rows as rowsmall
rowsmall = find(min(SmallestPathRowCost)==SmallestPathRowCost);
%Assigns the the lowest cost in the array to the variable lowestcost
lowestcost = min(costs(:));
%finds the column that currentposition starts in by checking the smallest
%cost in the first row that was found in the cost array
[~,columnsmall] = find(costs(rowsmall(1),:)==lowestcost);
%Assigns the variable currentpos to the position where it starts calling
%from
currentpos = [rowsmall(1),columnsmall(1)];
if columnsmall(1) == 1
    direction = 1;%calls GreedyWalk in the east direction
    [pathRows,pathCols] = GreedyWalk(currentpos,direction,E);
    [pathElev,~] = FindPathElevationsAndCost(pathRows,pathCols,E);
    
    %condition if column starts at the end column then it has to go west and
    %reverse the pathRows and pathCols to find the elevation
elseif columnsmall(1) == c
    direction = -1;% calls GreedyWalk in the west direction
    [pathRows,~] = GreedyWalk(currentpos,direction,E);
    pathRows = Reverse(pathRows);%calls the Reverse.m function
    pathCols = Reverse(pathCols);%calls Reverse.m function again
    %calls the FindPathElevationsAndCost function to calculate the
    %elevations
    [pathElev,~] = FindPathElevationsAndCost(pathRows,pathCols,E);
    
    %condition if anywhere in the middle it calls the functions in both
    %directions and concatenates the 2 arrays pathRowswest and pathRowseast
    %into one array pathRows.
else
    direction = 1;%calls in the east direction
    [pathRowseast,~] = GreedyWalk(currentpos,direction,E);%calls Greedywalk
    direction = -1;%calls in the west direction
    [pathRowswest,~] = GreedyWalk(currentpos,direction,E);
    %creates pathRowswest but doesnt take the first value due to
    %concantenating so it doesnt overlap the same values
    pathRowswest = pathRowswest(2:columnsmall(1));
    %calls the Reverse.m function to reverse the pathRowswest
    pathRowswestreversed = Reverse(pathRowswest);
    %concatenates the 2 arrays into one called pathRows
    pathRows = [pathRowswestreversed pathRowseast];
    %creates pathCols with length of the columns
    pathCols = 1:c;
    %calls the FindPathElevationsAndCost.m function to find pathElev as the
    %output
    [pathElev,~] = FindPathElevationsAndCost(pathRows,pathCols,E);
    
end
end
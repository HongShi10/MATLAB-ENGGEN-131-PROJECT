%This function BestPath.m finds the best path with the smallest elevation
%cost from one side of the array to the other. It is done by using the
%Dijkstra's algorithm method to solve the best path. This is done by making
%the starting position equal to 0 and other positions equal to infinity and
%then making a cost matrix where the lower cost is replaced by the previous
%and then at the end row the smallest cost is where the path ends. It then
%goes through a path matrix which contains the previous ROW number in the
%element so it can backtrack to the starting position and give the outputs
%Reference for Dijkstra's algorithim from computerphiles youtube video
% https://www.youtube.com/watch?v=GazC3A4OQTE
%Inputs = E(2D Surface matrix)
%Outputs = pathRows (the rows which are used)
%          pathCols (the columns that are used)
%          pathElev (the elevations that are in the bestpath)
%Author = Hong Shi
function [pathRows,pathCols,pathElev] = BestPath(E)

%Assigns the variable rows and columns to r & c respectively
[r,c] = size(E);
%Creates a costMatrix that calculates cost and a RowMatrix that has the row
%of the previous element in it
%Assigns non starting positions to be infinity due to Dijkstra's algorithm
costMatrix = inf(r,c);
costMatrix(:,1) = 0;%Assigns starting position to be 0s due to algorithm
RowMatrix = inf(r,c);%Preallocates the RowMatrix for speed
%A nested loop that loops through each element like a book to replace each
%number in the costMatrix and also stores
for j = 2:c %runs through columns
    for i = 1:r %runs through rows
        
        %For first row it can only move down or stay in the same row for
        %the next element
        if i == 1
            
            %conditional to see if the cost will be replaced by seeing if
            %its a lower cost then the previous for the element next to
            %each other
            
            if  costMatrix(i,j) > costMatrix(i,j-1)+abs(E(i,j-1)-E(i,j))
                %finds cost by adding previous cost and the difference
                costMatrix(i,j) = costMatrix(i,j-1)+abs(E(i,j-1)-E(i,j));
                %stores the row number in the RowMatrix array
                RowMatrix(i,j) = i;
            end
            %this finds the costMatrix of the same column but row below
            if costMatrix(i+1,j) > costMatrix(i,j-1)+abs(E(i,j-1)-E(i+1,j))
                costMatrix(i+1,j)=costMatrix(i,j-1)+abs(E(i,j-1)-E(i+1,j));
                RowMatrix(i+1,j) = i;
            end
            
            %for last row can go up a row or same row for the next element
        elseif i == r
            %same conditional as previous
            if costMatrix(i,j) > costMatrix(i,j-1)+abs(E(i,j-1)-E(i,j))
                costMatrix(i,j)=costMatrix(i,j-1)+abs(E(i,j-1)-E(i,j));
                RowMatrix(i,j) = i;
            end
            %this finds the costMatrix of the same column but row above
            if costMatrix(i-1,j )> costMatrix(i,j-1)+abs(E(i,j-1)-E(i-1,j))
                costMatrix(i-1,j)=costMatrix(i,j-1)+abs(E(i,j-1)-E(i-1,j));
                RowMatrix(i-1,j) = i;
            end
            
        else %for all the other elements where it can go to the next row,
            %the row before and the same row
            %finds cost for diagonal element above
            if costMatrix(i-1,j) > costMatrix(i,j-1)+abs(E(i,j-1)-E(i-1,j))
                costMatrix(i-1,j)=costMatrix(i,j-1)+abs(E(i,j-1)-E(i-1,j));
                RowMatrix(i-1,j) = i;
            end
            %finds cost for side by side element
            if costMatrix(i,j) > costMatrix(i,j-1)+abs(E(i,j-1)-E(i,j))
                costMatrix(i,j) =costMatrix(i,j-1)+abs(E(i,j-1)-E(i,j));
                RowMatrix(i,j) = i;
                
            end
            %finds cost for diagonal element below
            if costMatrix(i+1,j) > costMatrix(i,j-1)+abs(E(i,j-1)-E(i+1,j))
                costMatrix(i+1,j)=costMatrix(i,j- 1)+abs(E(i,j-1)-E(i+1,j));
                RowMatrix(i+1,j) = i;
            end
        end
    end
end

%this section backtracks and creates the outputs for this function
%since columns have to start from 1 and end at last column so 1:c cycles
%each column
pathCols = 1:c;
%finds the minimum number in the last column of costMatrix matrix
MatrixEndPoint = min(costMatrix(:,c));
%finds the position where the minimum number is in the last column
r = find(MatrixEndPoint == costMatrix(:,c));
%Assigns the first element in the pathRows array to that row number
pathRows = r(1);

%this loop runs and sets up the pathRows array by backtracking. This is
%done by searching through the RowMatrix as it contains the previous row
%and stores it in the array pathRows
for i = 2:c
    pathRows(i) = RowMatrix(r(1),c);%stores the row in the pathRows array
    %searches for the number which is the Row number for the previous
    %element
    r = RowMatrix(RowMatrix(r(1),c),c);
    c = c-1;%c is columns so it goes to the previous column
end
%calls the Reverse.m function to reverse the pathRows to make it aligned
%with pathCols
pathRows = Reverse(pathRows);
%calls the FindPathElevationsAndCost.m function to output a array with the
%elevations called pathElev
[pathElev,~] = FindPathElevationsAndCost(pathRows,pathCols,E);
end

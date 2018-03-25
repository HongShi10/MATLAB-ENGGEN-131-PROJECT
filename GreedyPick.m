%This function GreedyPick.m picks the next greediest path from one point
%to the next by comparing elevation differences and calling the
%FindTheSmallestElevationChange.m function as a helper function
%Inputs = currentpos (current position [a,b] form)
%         direction (1 for east direction -1 for west)
%         E (The 2D array surface)
%Outputs= pick (picks the path that has the smallest change in elevation)
%Author : Hong Shi
function [pick] = GreedyPick(currentpos,direction,E)

[r,~] = size(E);%finds how many rows there are in the E matrix
yPos = currentpos(1,1);% changes square brackets to circular
xPos = currentpos(1,2);
y = E(yPos,xPos);%y equals the current elevation(yPos rows, xPos columns)
%these if statements creates an array for the next possible elevations
%For first row you only take the bottom and same row in the next column
if  yPos == 1
    z = [E((yPos),(xPos+direction)),E((yPos+1),(xPos+direction))];
    
    % if at bottom row you can only take the top and same row values in the
    % next column
elseif yPos == r
    z = [E((yPos-1),(xPos+direction)),E((yPos),(xPos+direction))];
    
else  % anywhere else you can take top same and bottom row in next column
    z = [E((yPos-1),(xPos+direction)),E((yPos),(xPos+direction))...
        ,E((yPos+1),(xPos+direction))];
end

%calls the function FindTheSmallestElevationChange.m to find in which
%position it is the smallest change in elevation
smallestposition = FindSmallestElevationChange(y,z);

%This loop uses 2 conditionals if the row does not equal to 1 then it uses
%the smallestposition to calculate if it should move up a row it always
%uses the northern element as if there were 2 smallestpositions it will
%always use the first one if yPos is equal to 1 it can not move up a row so
%the first element in the smallesposition will have to be in the next
%column on the same row therefore a -1 is used instead of -2
if yPos ~= 1
    pick  = [(yPos)+smallestposition(1)-2,xPos+direction];
else
    pick = [(yPos)+smallestposition(1)-1,xPos+direction];
    
end
end


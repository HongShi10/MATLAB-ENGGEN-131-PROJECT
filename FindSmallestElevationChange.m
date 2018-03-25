%This function FindTheSmallestElevationChange finds the position
%in the array in which the smallest step size is
%Inputs = y (A number in which the current elevation is at)
%         z (Array of numbers indicating elevation)
%Outputs = smallestposition (an array containing the positions of the
%smallest elevation change)
%Author: Hong Shi

function [smallestposition] = FindSmallestElevationChange(y,z)

Difference = zeros(1,length(z));%Preallocating for speed
%Creates a for loop that calculates the change in elevation by using
%absolute values to make it positive
for i = 1:length(z)
    Difference(i) = abs(y-z(i));
end

%finds the smallest elevation and compares it using the find function and
%gives it back in a array with position
[smallestposition] = find(Difference==min(Difference));
end

function miles = calories2Miles(n,mileCalories)
%function miles = calories2Miles(n)
%tells you how many miles you need to run to burn off a certain number of
%donuts
%inputs: n, the number of donuts desired, and mileCalories, the vector
%containing how many calories burned each mile
donutCalories = 303;
totalCal = n*donutCalories;
avCal = mean(mileCalories); %the average calories burned per mile

miles = totalCal/avCal;



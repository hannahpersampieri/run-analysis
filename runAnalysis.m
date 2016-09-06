%Hannah Voelker, Lab J 4/26/15
%Final Project: Run Analysis Program
%The goal of my project is to utilize csv data from my garmin watch and use
%it to calculate various statistics in a user-friendly interface
%% loading/organizing the data
data = loadXlsxFile; %prompt the user to select a data file
mileSplit = 1440*(data(:,3)); 
%the mile split is given in a "fraction of a day" so when multiplied by
%1440, it gives minutes-- had to do some by hand math to figure that out
mileCalories = data(:,8);
distance = data(:,4);
totalDistance = sum(data(:,4));
donutCalories = 303; %this will be used later :-)
pizzaCalories = 285;
%other portions of the data are redundant, so we only need these columns
%% now, calculations for these values
averagePace = mean(mileSplit); 
%average pace per mile
totalCalsBurned = sum(mileCalories); 
%how many pizza slices
fastestMile = min(mileSplit); 
%the fastest mile time of the run
acceleration = gradient(mileSplit)/120 ;
%this gives it in miles/(hour squared), I thought that was the more
%appropriate units for acceleration
for count = 1:length(distance)
    mileNumber(count) = sum(distance(1:count));
end
%for loop to give the current mile number, as we need this for plotting
%% Did we run any records today?
%ask the user what their previous records are
currentLongestRun = inputdlg('What is the farthest you have ever run? (miles)');
currentLongestRun = str2double(currentLongestRun{1});
currentMile = inputdlg('What is the fastest mile you have ever run? (minutes)');
currentMile = str2double(currentMile{1});
%note that these are assigned to cell arrays and are strings, so I converted them 

%now I'll use an if loop to say whether or not any records were acheived
if totalDistance> currentLongestRun && fastestMile < currentMile,
    string = sprintf('Congrats! You have two new records today. Your new longest run is %2.2f miles and your new fastest mile is %2.2f minutes',totalDistance, fastestMile);
    msgbox(string)
elseif totalDistance> currentLongestRun && fastestMile > currentMile,
    string = sprintf('Congrats! You have one new record today. Your new longest run is %2.2f miles', totalDistance);
    msgbox(string)
elseif totalDistance < currentLongestRun && fastestMile < currentMile,
    string = sprintf('Congrats! You have one new record today. Your new fastest mile is %2.2f minutes', fastestMile);
    msgbox(string)
else
    string = ('No new records today. keep on working hard!');
    msgbox(string)
end
pause(5) %i added in pauses because the dialog boxes were coming up to quickly

%% Making a run summary
% I want to plot the pace vs split and also tell the user how many calories
% they burned
figure
plot(mileNumber,mileSplit)
xlabel('Mile number')
ylabel('Mile time (minutes)')
title('Pace per mile')
saveas(gcf,'pacepermile.jpg')


% what if the user wanted to know the pace at a certain point?
% use ginput to get  value at a point, and then display the result
[x,y]=ginput(1);
msgOut = sprintf('Pace at %2.2f miles is %2.2f minutes',x,y);
msgbox(msgOut)
pause(5) %another pause, again because I didn't want dialog boxes on top of each other

figure
plot(mileNumber, acceleration)
xlabel('Mile Number')
ylabel('Acceleration (Miles/hour^2)')
title('Average Acceleration')
saveas(gcf,'averageaccel.jpg')
pause(5)

%fastest 5k split
fastest5k = findfastest5k(mileSplit);
msg = sprintf('Your fastest 5k for today was %2.2f minutes', fastest5k);
msgbox(msg)
pause(5)

%now for the number of donuts or pizza slices burned 
numberofDonuts = totalCalsBurned/donutCalories; 
%how many donuts
pizzaSlices = totalCalsBurned/pizzaCalories; 
%how many pizza slices

[cdata, map] = imread('donut.jpeg'); %read in the donut image
msg = sprintf('During todays run, you burned the same number of calories as %2.2f donuts. Yum!', numberofDonuts);
msgbox(msg,'Donuts Eaten','custom',cdata,map)
pause(5)

[bdata,map2] = imread('pizza.jpg'); %read in the pizza image
msg =sprintf('During todays run, you burned the same number of calories as %2.2f slices of pizza. Yum!', pizzaSlices);
msgbox(msg,'Slices of Pizza Eaten','custom',bdata,map2) %put the picture on the message box
pause(5)

%What if the user wanted to know how many miles they needed to run in order
%to eat x amount of donuts?
howMany = inputdlg('How many donuts do you want to eat after your next run?');
howMany = str2double(howMany{1}); %have to convert again!
miles = calories2Miles(howMany,mileCalories);
msg = sprintf('You would need to run %2.2f miles to eat that many donuts (and not feel guilty)', miles);
msgbox(msg,'How many miles?','custom',cdata,map) %again a message box with a picture
 
%automatically save my results
save('runAnalysisResults.mat')
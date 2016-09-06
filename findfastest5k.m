function time = findfastest5k(mileSplit)
%function time = findfastest5k(mileSplit)
%looks at all your mile splits and finds the fastest 5k out of them
startingMile = 1;
sumMile = 500; 
%set this to a super high value that wouldnt be a 5k time
for count = 1:(length(mileSplit)-2),
    z = mileSplit(count) + mileSplit(count+1) + mileSplit(count+2);
    if z < sumMile
        sumMile = z;
    end
end
time = z;

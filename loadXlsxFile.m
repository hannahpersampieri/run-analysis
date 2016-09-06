function data = loadXlsxFile
% function data = loadFile

[filename,pathname]=uigetfile('*.xlsx','pick a file');  
% we want .xlsx files only to prevent confusion

% now, read it in
fullname = fullfile(pathname,filename); % stick path and name together
data=xlsread(fullname);

return
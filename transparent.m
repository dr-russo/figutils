function img = transparent(file,bg)
%===============================================================================
% TRANSPARENT	
% Makes a png image transparent by setting background color transparency.
%
% OUTPUTS: 
%	img		Image (matrix).  Also saves a new image with '_t' appended to 
%			original filename.
% INPUTS:
%	file    Image file to convert (.png), or list of files as cell array.
%   bg		Background color (color to become transparent).
%
% MJRusso 4/2014
%===============================================================================

%Convert single filename to cell array for consistent cell indexing
if ~iscell(file)
    file = {file};  
end

for m = 1:length(file)
    %Load image data
    [img,~,~] = imread(file{m},'png');
    
    %Create filename for transparent image ('_t' appended).
    [~,fn,ext] = fileparts(file{m});
    if isempty(ext), ext = '.png'; end
    newfilename = [fn '_t' ext];
    
    %Write new image file and set bg color to transparent.
    imwrite(img,newfilename,'png','Transparency',bg);
end

end

function savefigure(varargin)
%===============================================================================
% SAVEFIGURE    Save figure in multiple formats for presentation/publication.
%
% savefigure(filename)          Saves current figure.
% savefigure(filename,hfig)     Saves figure with figure handle hfig.
% savefigure(filename,'Parameter',value)    Adds optional style parameters.
%
% Note: saves all figures to a new folder within current directory, e.g.
%       currentdirectory/filename/filename.png
% 
% INPUTS:
%   hfig        Figure handle.  Uses current figure if no handle provided.
%   filename    Save filename.
%         
% OPTIONS:
% 'Size'        Specify figure size in pixels [width height]
% 'Style'       'transparent' Save png file as transparent.
%               'black'       Save png file with black background.
%               'white'       Save png file with white background.
%               'all'         Save all of the above formats.
%                             (Also saves transparent forms of png for 
%                              black and white backgrounds). 
% DEPENDENCIES
%
% savefigure.m : figurecolor.m
%===============================================================================

%-------------------------- Argument handling ----------------------------------
defaultfig = gcf;
defaultsize = 0;
defaultstyle = 'transparent';

args = inputparser;
args.FunctionName = 'savefigure';
args.addRequired('filename',@ischar);
args.addOptional('hfig',defaultfig,@ishandle);
args.addParameter('Size',defaultsize,@(x) isvector(x) && length(x) == 2);
args.addParameter('Style',defaultstyle,...
                 @(x) any(strcmpi(x,{'transparent','black','white','all'})));
             
%Parse inputs
args.parse(varargin);

%-------------------------------------------------------------------------------

%Set basic figure formatting options
set(hfig,'WindowStyle','normal');   %undock figure
set(hfig,'PaperPositionMode', 'auto');
set(hfig,'InvertHardCopy','off');

%Set figure size
if args.Results.Size
   pos = get(hfig,'Position');
   pos(3) = size(1);
   pos(4) = size(2);
   set(hfig,'Position',pos);
else
   pos = get(hfig,'Position');
   set(hfig,'Position',pos);
end

status = mkdir('.',args.Results.filename);
if status
    fn = fullfile(args.Results.filename,args.Results.filename);
end
print('-dpng','-r300',fn); %Save original figure before altering
saveas(hfig, fn,'fig');

bg = get(args.Results.hfig,'Color');

switch args.Results.Style
    
    case {'Transparent','transparent'} %Save transparent background
        savetransparent(fn,bg);
        
    case {'Black','black'}  %Save for black background
        filename_blk = [fn '_blk'];
        figurecolor(args.Results.hfig,'k');
        print('-dpng','-r300',filename_blk);
   

    case {'White','white'} %Save for white background
        filename_wht = [fn '_wht'];
        figurecolor(hfig,'w');
        print('-dpng','-r300',filename_wht);
        
    case {'All','all'}
        %Save transparent
        savetransparent(fn,bg);
        
        %Save black background
        filename_blk = [fn '_blk'];
        figurecolor(args.Results.hfig,'k');
        print('-dpng','-r300',filename_blk);
        savetransparent(filename_blk,[0 0 0]); %Transparent
        
        %Save white background
        filename_wht = [fn '_wht'];
        figurecolor(hfig,'w');
        print('-dpng','-r300',filename_wht);
        savetransparent(filename_wht,[1 1 1]); %Transparent

    
end %switch style

%---- Subfunction to save transparent png --------------------------------------
function savetransparent(filename,bgcolor)
    %Load image data
    [img,~,~] = imread(filename,'png');  
    %Create filename for transparent image ('_t' appended).
    newfilename = [filename '_t'];
    %Write new image file and set bg color to transparent.
    imwrite(img,newfilename,'png','Transparency',bgcolor);
end


end %fcn



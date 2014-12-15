function hs = drawstimulus(haxis,onset,varargin)
%===============================================================================
% DRAWSTIMULUS	Draw line/arrow markers to indicate temporal position of 
%				photo- or electrical stimulus. Draws either single bar/arrow or 
%				series of ticks for stimulus trains.
% RETURNS:
% hs		Stimulus object handle.
% 
% INPUTS:
%  haxis    Axis handle
%  onset		Onset of stimulus/train (ms).
%
% OPTIONS:
% 'Type'    'bar'   single bar indicating stimulus duration
%           'train' train of ticks/bars indicating stimulus times
%           'step'  step from baseline to indicate 
%
% 'Length'  Duration of stimulus (ms)
%
% 'Number'  Number of pulses (for stimulus train)
%
% 'ISI'		Inter-stimulus interval in ms (for stimulus train).
%
% 'Style'   'tick'  single tick mark at each stimulus time
%           'arrow' arrow at each stimulus time
%
% MJRusso 12/2014
%===============================================================================

%Argument handling

%Set defaults
typ = 'train';
num = 1;
stimcolor = [0 102 255]/255;
duration = 0.001; %1ms

for n=1:(nargin-2)
    switch varargin{n}
        case {'Type','type'}
           tp = varargin{n+1};
        case {'Num','num','number','Number'}
           num = varargin{n+1};
        case {'ISI','isi','Isi'}
           isi = varargin{n+1}/1000;
        case {'Color','color'}
           stimcolor = varargin{n+1};
        case {'Duration','duration'};
           duration = varargin{n+1}/1000;
        case {'Style','style'}
           style = varargin{n+1};
    end
end

onset = onset/1000;

hs = zeros(num,1);


if num == 1

    xPoints = [onset,onset+duration];
    yLims = get(haxis,'YLim');
    yDist = yLims(2)-yLims(1);
    y0 = yLims(2)+0.02*yDist;
    yPoints = [y0,y0];
    
    hs = line(xPoints,yPoints,...
            'Parent',haxis,...
            'Color',stimcolor,...
            'LineWidth',5,...
            'Tag','stimulus','Clipping','off');
else
    
    xPoints = [onset:isi:(onset + (num-1)*isi)];
    yLims = get(haxis,'YLim');
    yDist = yLims(2)-yLims(1);
    y0 = yLims(2)+0.02*yDist;
    y1 = y0 + 0.02*yDist;

    for n=1:num
        hs(n) = line([xPoints(n) xPoints(n)],[y0 y1],...
                'Parent',haxis,...
                'Color',stimcolor,...
                'LineWidth',1.5,...
                'Tag','stimulus',...
                'Clipping','off');
    end
	
end

end
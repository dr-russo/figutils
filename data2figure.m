function figcoord = data2figure( haxis,data )
%===============================================================================
% DATA2FIGURE   
% Converts a data point to figure coordinates.
%     
% 
% OUTPUTS
%   figcoord    Figure coordinate of data point.
% 
% INPUTS
%   haxis       Handle to axis.
%   data        Data point to be converted to global figure coordinates.
%
% MJRusso 10/2013
%===============================================================================
    
    %Get data limits
	dataX = get(haxis,'XLim');
	dataY = get(haxis,'YLim');
    
    %Get axis limits
    axisPos = get(haxis,'Position');
    
    %Get figure limits
    figPos = get(get(haxis,'Parent'),'Position');

    %Convert data coordinates first to axis coordinates
    axisX = map(data(1),dataX(1),dataX(2),axisPos(1),axisPos(1)+axisPos(3));
    axisY = map(data(2),dataY(1),dataY(2),axisPos(2),axisPos(2)+axisPos(4));
    
    %Convert axis coordinates to figure coordinates
    
    figX = map(axisX,axisPos(1),axisPos(1)+axisPos(3),...
                     figPos(1),figPos(1)+figPos(3));
    figY = map(axisY,axisPos(2),axisPos(2)+axisPos(4),...
                     figPos(2),figPos(2)+figPos(4));
      
    figcoord = [figX,figY];             
    
    
%---------------------------- Subfunctions -------------------------------------	
    %MAP: linearly map a value onto a new linear coordinate space.
	function y = map(x,xmin,xmax,ymin,ymax)
		y = (x - xmin)*((ymax-ymin)/(xmax-xmin))+ymin;
	end

end


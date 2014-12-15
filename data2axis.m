function axiscoord = data2axis(haxis,data)
% ==============================================================================
% DATA2AXIS	Convert data coordinate to axis coordinate.
%
%
% RETURNS:
%	axiscoord   Coordinate in axis reference frame.
%
% OUTPUTS:
%	haxis		Axis handle.
%   data        Coordinate to be transformed to axis coordinates [x,y].
%
% MJRusso 10/2013
% ==============================================================================
	

	xdata = get(haxis,'XLim');				%Get X axis limits
	ydata = get(haxis,'YLim');              %Get Y axis limits
	axispos = get(haxis,'Position');		%Get current axis position
	dx = axispos(3);                        %Width
	dy = axispos(4);                        %Height
	
	axiscoord(1) = map(data(1),xdata(1),xdata(2),axispos(1),axispos(1)+dx);
	axiscoord(2) = map(data(2),ydata(1),ydata(2),axispos(2),axispos(2)+dy);

%---------------------------- Subfunctions -------------------------------------	
    %MAP: linearly map a value onto a new linear coordinate space.
	function y = map(x,xmin,xmax,ymin,ymax)
		y = (x - xmin)*((ymax-ymin)/(xmax-xmin))+ymin;
	end

end


function hstep = drawstep(haxis,onset,duration,)
%===============================================================================
% DRAWSTEP      Draw a square step pulse to indicate stimulus timing.
% 
% RETURNS:
% hstep         Step object handle.
% 
% PARAMETERS:
% haxis         Axis handle
% onset         Onset of step (ms).
% duration      Duration of step pulse (ms).
%
% OPTIONAL (precede each parameter with descriptor in parentheses)
%
% 'Color'       Color of stimulus indicator (default: blue)
%===============================================================================

%Defaults

hstep = zeros(5,1);

xLims = get(haxis,'XLim');
yLims = get(haxis,'YLim');

x1 = xLims(1);
x2 = onset;
x3 = 
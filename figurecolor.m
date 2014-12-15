function figurecolor(hfig,bg)
%===============================================================================
% FIGURECOLOR 
% Color figure according to background color (bg). Adjusts colors of 
% foreground objects to white for black background, and black for white 
% background.
%  
% figurecolor(bg)       Change figure color of current figure.
% figurecolor(hfig,bg)  Change figure color of figure with handle hfig.
%
% INPUTS:
%
%	hfig		Figure handle. Uses current figure if none specified.
%   bg          Background color (Black: 'k','black',0,[0 0 0])
%								 (White: 'w','white',1,[1 1 1])
%
% MJRusso 10/2014
%===============================================================================


%-------------------------- Argument handling ----------------------------------

%Check that single argument is not handle, assign to bg color.
if ~ishandle(hfig) && nargin < 2
    bg = hfig; %swap args
    hfig = gcf;
elseif nargin < 2
	bg = [0 0 0];
end

if ischar(bg)
	switch bg
		case {'w','W','white','White'}
			bg = [1 1 1];
			fg = [0 0 0];
		case {'k','K','black','Black'};
			bg = [0 0 0];
			fg = [1 1 1];
	end
elseif bg == 1
	bg = [1 1 1];
	fg = [0 0 0];
elseif bg == 0
	bg = [0 0 0];
	fg = [1 1 1];
end

%-------------------------------------------------------------------------------

%Set figure background color
set(hfig,'Color',bg);

hc = findall(hfig); %Get all children of hfig

%Adjust all axes
haxis = findobj(hc,'Type','axes','-depth',inf);
set(haxis,'Color',bg);
set(haxis,'XColor',fg);
set(haxis,'YColor',fg);


%Adjust text colors
htext = findobj(hc,'Type','text','-and','-property','Color','-depth',inf);
for n=1:length(htext)
	if isbw(htext(n),'Color') 
		set(htext(n),'Color',fg);
	end
end

%Adjust line colors
hline = findobj(hc,'Type','line','-and','-property','Color','-depth',inf);
for m =1:length(hline)
	if isbw(hline(m),'Color')
		set(hline(m),'Color',fg);
	end
end

%Adjust markers
hmarker = findobj(hc,'-property','Marker','-depth',inf);
for p = 1:length(hmarker)
    if isbw(hmarker(p),'MarkerEdgeColor')
        set(hmarker(p),'MarkerEdgeColor',fg);
    end
    if isbw(hmarker(p),'MarkerFaceColor')
        set(hmarker(p),'MarkerFaceColor',fg);
    end
end

%Other, objects with property 'TextColor'
hobj = findobj(hc,'-property','TextColor','-depth',inf);
for q = 1:length(hobj)
    if isbw(hobj(q),'TextColor')
        set(hobj(q),'TextColor',fg);
    end
end

%Legends
hlegend = findobj(hc,'Type','legend','-depth',inf);
for r=1:length(hlegend)
    set(hlegend(r),'EdgeColor',fg);
    set(hlegend(r),'Color',bg);
    if isbw(hlegend(r),'TextColor')
        set(hlegend(r),'TextColor',fg);
    end
end

%============================ SUBFUNCTION ======================================

function bw = isbw(hobj,property)
   if all(get(hobj,property) == 0) || all(get(hobj,property) == 1)
       bw = 1;
   else
       bw = 0;
   end
end
        
        
end
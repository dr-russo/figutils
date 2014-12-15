function [hScale,hLabel] = cappedscalebar(hAxis,dist,units,axis,pos)


hFig = get(hAxis,'Parent');

%Remember original figure and axis units
initAxisUnits = get(hAxis,'Units');
initFigUnits = get(hFig,'Units');

%Set units for figure and axis to normalized
set(hFig,'Units','normalized');
set(hAxis,'Units','normalized');

fontsettings = {'FontName','Arial','FontSize',16,'FontWeight','normal'};

color = [1 1 1];
hlen = 0.5;
hwid = 12;

%Argument handling
if nargin < 5
	XPos = 0.1;
	YPos = 0.1;
else
	XPos = pos(1);
	YPos = pos(2);
end

%Initialize handles for total number of axes
hScale = zeros(length(dist),1);
hLabel = zeros(length(dist),1);


%Draw X scalebar ---------------------------------------------------------------
if (axis == 0 || axis == 2)
	if length(dist) > 1
		xDist = dist(1);
		xUnits = units{1};
	else
		xDist = dist;
		xUnits = units;
	end
	xLabelStr = [num2str(xDist) ' ' xUnits];
	if strcmp(xUnits,'ms') || strcmp(xUnits,'um')
		xDist = xDist/1000;
	end
	
	xWidth = axisPos(3);
	xData = get(hAxis,'XLim');
	xScale = xDist*abs(xWidth/(xData(2)-xData(1)));

   if caps == 1
      
      APos = data2axis(hAxis,pos);
	  XPos = APos(1);
	  YPos = APos(2);
      
      hSx = annotation(		'doublearrow','Units','normalized',...
							'Position',[XPos,YPos,xscale,0],...
							'LineWidth',1,'Color',color,...
							'Head1Style','rectangle',...
							'Head2Style','rectangle',...
							'Head1Length',capLength,...
							'Head2Length',capLength,...
							'Head1Width',capWidth,...
							'Head2Width',capWidth);
   else
   
      hSx = annotation(		'line','Units','normalized',...
							'Position',[XPos,YPos,xscale,0],...
							'LineWidth',2.5,'Color',color);
   end       
              
				  
% 	xlabelxpos = map(XPos+xscale-(xscale/50),axispos(1),axispos(1)+axispos(3),0,1);
% 	xlabelypos = map(YPos-0.015,axispos(2),axispos(2)+axispos(4),0,1);
   if XPos > 0.5
      xlabeloffset = XPos+0.02;
   elseif XPos <= 0.5
      xlabeloffset = XPos+0.02;
   end

   hLx = annotation('textbox','Units','normalized',...
                    'String',xlabelstr,...
                    'Position',[xlabeloffset,YPos-0.04,0.07,0.03],...
                    'FontName',fname,'FontSize',fsize,'FontWeight',fweight,...
                    'HorizontalAlignment','right',...
                    'LineStyle','none',...
                    'FitBoxToText','on',...
                    'Color',color,...
                    'Margin',0.1);
   
   % 	hLx = text('Units','normalized',...
% 				 'String',xlabelstr,...
% 				 'Position',[xlabelxpos,xlabelypos,0],...
% 				 'FontName',fname,'FontSize',fsize,'FontWeight',fweight,...
% 				 'HorizontalAlignment','right',...
% 				 'Margin',0.1,'Color',color);
	if length(dist) > 1
		hScale(1) = hSx;
		hLabel(1) = hLx;
	else
		hScale = hSx;
		hLabel = hLx;
   end
   assignin('base','hSx',hSx);
   assignin('base','hLx',hLx);
   
end

%Draw Y scale bar---------------------------------------------------------------
if (axis == 1 || axis == 2);
	if length(dist) > 1
		ydist = dist(2);
		yunits = units{2};
	else
		ydist = dist;
		yunits = units;
	end
	
	ylabelstr = [num2str(ydist) ' ' yunits];
	
	if strcmpi(yunits,'nA')
		ydist = ydist*1000;
	end
	
	yheight = axispos(4);
	ydata = get(hAxisxis,'YLim');
	yscale = ydist*abs(yheight/(ydata(2)-ydata(1)));
	
	if (XPos > 0.5 && axis == 2)
		XPos = XPos + xscale;
		ylabeloffset = xlabeloffset;
	else 
      ylabeloffset = XPos+0.02;
	end
	
	hSy = annotation('line','Units','normalized',...
						'Position',[XPos,YPos,0,yscale],...
						'LineWidth',2.5,'Color',color);

   hLy = annotation('textbox','Units','normalized',...
                    'String',ylabelstr,...
                    'Position',[ylabeloffset,YPos+yscale/2,0.07,0.03],...
                    'FontName',fname,'FontSize',fsize,'FontWeight',fweight,...
                    'HorizontalAlignment','right',...
                    'LineStyle','none',...
                    'FitBoxToText','on',...
                    'Color',color,...
                    'Margin',0.1);
               
% 	ylabelxpos = map(XPos-labeloffset,axispos(1),axispos(1)+axispos(3),0,1);
% 	ylabelypos = map(YPos+(yscale/5),axispos(2),axispos(2)+axispos(4),0,1);
% 	hLy = text('Units','normalized',...
% 				  'String',ylabelstr,...
% 				  'Position',[ylabelxpos,ylabelypos,0],...
% 				  'Rotation',90,...
% 				  'FontName',fname,'FontSize',fsize,'FontWeight',fweight,...
% 				  'Margin',0.1,'Color',color);
	
	if length(dist) > 1
		hScale(2) = hSy;
		hLabel(2) = hLy;
	else
		hScale = hSy;
		hLabel = hLy;
   end		  
   assignin('base','hSy',hSy);
   assignin('base','hLy',hLy);
			  
end





set(hScale,'Units','normalized');
set(hLabel,'Units','normalized');


end
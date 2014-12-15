function hL = customxlabels(hA,labels,rotation)

if nargin < 3
	rotation = 0;
end

xticks = get(hA,'XTick');
ticklength = get(hA,'TickLength');
ylims = get(hA,'YLim');
set(hA,'XTickLabel',[]);
fname = get(hA,'FontName');
fsize = get(hA,'FontSize');
fweight = get(hA,'FontWeight');

hL = zeros(length(xticks),1);

for n = 1:length(xticks)
	X = xticks(n);
	Y = ylims(1);
	hL(n) = text(xticks(n),ylims(1),labels{n});
	set(hL(n),'LineStyle','none',...
			  'FontName',fname,...
			  'FontSize',fsize,...
			  'FontWeight',fweight);
	Pos = get(hL(n),'Position');
	if rotation ~= 0
		set(hL(n),'Rotation',rotation);
		Ext = get(hL(n),'Extent');
		Pos(1) = X - Ext(3)/2;
		Pos(2) = Y - Ext(4)*0.7;
	else
		Ext = get(hL(n),'Extent');
		Pos(1) = Pos(1) - Ext(3)/2;
		Pos(2) = Pos(2) - Ext(4);
	end
	
	set(hL(n),'Position',Pos);
end
	

end
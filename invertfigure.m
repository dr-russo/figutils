function invertfigure(hfig)
%===============================================================================
% INVERTFIGURE 
% Inverts black and white in a plot.  Preserves non-black/white colors
% 
% INPUTS
%   hfig    Handle of figure to invert.
%===============================================================================

if nargin == 0
    hfig = gcf;
end

%Invert background color of figure
bg = get(hfig,'Color');
if all(bg == 1) || all(bg == 0)
    set(hfig,'Color',~bg)
end

%Common color properties
cProps = {'Color',...
          'XColor',...
          'YColor',...
          'LineColor',...
          'MarkerFaceColor',...
          'MarkerEdgeColor',...
          'TextColor'};
      
%Get all children of current figure
hall = findall(hfig);

%Iterate through color props and invert values
for n=1:length(cProps)
    %Find all objects with color setting set to b/w
    hobj = findobj(hall,cProps{n},[0 0 0],'-or',cProps{n},[1 1 1]);
    if length(hobj) > 1
        for m=1:length(hobj)
            set(hobj(m),cProps{n},~get(hobj(m),cProps{n}));
        end
    else
        set(hobj,cProps{n},~get(hobj,cProps{n}));
    end
end


end
function flipped = bwflip(img)
%===============================================================================
% BWFLIP    
% Inverts/swaps black and white in a greyscale image.
%
% Outputs:
% flippedimg   Black-white inverted image.
%
% Inputs:
% img          Image to be inverted.
%
% MJRusso 10/2014
%===============================================================================

%Set color constants
wht = uint8(255);
blk = uint8(0);

[A,~,~] = imread(img,'png');

dim = [size(A,1),size(A,2)];


blkMask = ind2sub(dim,A(:,:,:) == blk);
whtMask = ind2sub(dim,A(:,:,:) == wht);

A(whtMask) = blk;
A(blkMask) = wht;

flipped = imadd(A,COLORS);

end
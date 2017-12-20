function samples = sampleImg(img,initstate,inrad_ratio,outrad_ratio,maxnum)
% $Description:
%    -Compute the coordinate of sample image templates
% $Agruments
% Input;
%    -img: inpute image
%    -initistate: [x y width height] object position 
%    -inrad: outside radius of region
%    -outrad: inside radius of region
%    -maxnum: maximal number of samples
% Output:
%    -samples.sx: x coordinate vector,[x1 x2 ...xn]
%    -samples.sy: y ...
%    -samples.sw: width ...
%    -samples.sh: height...
% $ History $
%   - Created by Kaihua Zhang, on April 22th, 2011
%   - Revised by Kaihua Zhang, on May 25th, 2011

% rand('state',0);%important

% inrad = ceil(inrad);
% outrad= ceil(outrad);

[row,col] = size(img);
x = initstate(1);
y = initstate(2);
w = initstate(3);
h = initstate(4);

x_inrad = int32(w * inrad_ratio);
y_inrad = int32(h * inrad_ratio);

x_outrad = int32(w * outrad_ratio);
y_outrad = int32(h * outrad_ratio);

rowsz = row - h - 1;
colsz = col - w - 1;

minrow = max(1, y - y_inrad+1);

maxrow = min(rowsz - 1, y + y_inrad);
maxrow = max(1, maxrow);

mincol = max(1, x - x_inrad + 1);

maxcol = min(colsz - 1, x + x_inrad);
maxcol = max(1, maxcol);

if mincol > maxcol || minrow > maxrow
    maxnum = 0;
end
samples = [];
for i = 1:maxnum
    samples.sx(i) = randi([mincol, maxcol]);
    samples.sy(i) = randi([minrow, maxrow]);
    samples.sw(i) = w;
    samples.sh(i) = h;
end


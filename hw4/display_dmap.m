function [d_color] = display_dmap(d)
% 1. Map disparity into the range [0,1]
% max_d = the maximum calculated value of disparity;
% min_d = the minimum calculated value of disparity;
% scale the disparity values by subtracting the minimum
% value min_d and dividing by the difference beween max_d
% and min_d
[y,x] = size(d);
disparity = d./255;
max_d = max(disparity);
min_d = min(disparity);
temp = zeros(y,x);


% 2. Colorize occluded pixels to be red
% dColor = color image where each RGB layer is equal to the
% scaled disparity matrix (values between 0 and 1)
% find the positions/indices where each of the 3 values of
% dColor is equal to NaN, and store them in a variable
% replace the values of these positions with:
% dColor(at position in R layer) = 1; 
% dColor(at position in G layer) = 0;
% dColor(at position in B layer) = 0;
% 3. Display dColor image using imshow

end


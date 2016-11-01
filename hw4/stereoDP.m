function [disparity] = stereoDP(e1,e2,occ)

%%%%% Calculate the disparity, it is just the index difference between i
%%%%% and j.!!!!!!!!!!!!!!!!!
%%%So from the directionTable you get the from either right, it's
%%%occluded,if it's from the (i-1,j), you got a skipped pixels in Ir()a
%%%unit in disparity, selecting(i,j-1) is a uit decrease in disparity.


%%%%%%Part A
[~,x] = size(e1);
[~,~] = size(e2);
%%%e1 and e2 are epipolar scanline of the two image
disparity = zeros(1,x);
directionTable = zeros(x,x);
%%For directionTable, define North as 1
%%%%% West as 2, Northwest as 3
costTable = zeros(x,x);
for i = 1:x %Left epipolar line
    for j = 1:x %Right epipolar line
        if i == 1
            costTable(i,j) = j*occ;
        elseif j == 1
            costTable(i,j) = i*occ;
        elseif i == j
            dij = (e1(i) - e2(j))^2;
        else
            D1 = costTable(i,j-1) + occ;
            D2 = costTable(i-1,j) + occ;
            D3 = costTable(i-1,j-1) + dij;
            A = [D1,D2,D3];
            [~,direction] = min(A);
            directionTable(i,j) = direction;
            %%%%%Since matlab start with index 1,for my funtion
            %%%Go to index 3
            %1 for Northwest, 2 for West and 3 for North
        end
    end
end

%%%%%%%%%%%%%%Part B
%%%%%%%%%%%%Backtracking
row = x;
col = x;
    for k = x:-1:2
        while (row && col) > 1
            if directionTable(row,col) == 1
                col = col - 1;
                %%%Corresponds to skipping a pixel in Il(a unit decrease in disparity)
                disparity(1,k) = abs(i - j) - 1;
            elseif directionTable(row,col) == 2
                row = row - 1;
                %%%%Corresponds to skipping a pixel in Ir(a unit decrease in disparity)
                disparity(1,k) = abs(i - j) + 1;
            else
                %%%%%%%Matches pixels, leave the disparity unchanged
                row = row - 1;
                col = col - 1;
                disparity(1,k) = abs(i - j);
            end
        end
    end
end

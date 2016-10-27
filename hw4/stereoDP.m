function [Disparity] = stereoDP(e1,e2,occ)
%%%%%%Part A
[y,x] = size(e1);
[y1,x1] = size(e2);
%%%e1 and e2 are epipolar scanline of the two image
Nl = x+1;
Nr = x+1;
directionTable = zeros(Nl,Nr);
%%For directionTable, define North as 1
%%%%% West as 2, Northwest as 3
DPTable = zeros(Nl,Nr);
Disparity = zeros(Nl,Nr);
for i = 1:Nl %Left epipolar line
    for j = 1:Nr %Right epipolar line
        if i == 1
            DPTable(i,j) = i*occ;
        elseif j == 1
            DPTable(i,j) = j*occ;
        elseif i == j
            dij = ((i) - e2(j))^2;
        else
            D1 = DPTable(i-1,j-1) + dij;
            D2 = DPTable(i-1,j) + occ;
            D3 = DPTable(i,j-1) + occ;
            A = [D1,D2,D3];
            [D,direction] = min(A);
            DPTable(i,j) = D;
            directionTable(i,j) = direction;
            %%%%%Since matlab start with index 1,for my fuciont
            %%%Go to index 3
            %1 for Northwest, 2 for West and 3 for North
        end
    end
end

%%%%%%%%----------------Part B Backtracking-------------
%%%%%Finding the optimal alignment (The disparity) by
%%backtracking
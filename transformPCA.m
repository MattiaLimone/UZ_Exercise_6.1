function [projected, reprojected] = transformPCA(E, mu, input, eraseComponents)
% E - matrix of eigen vectors MxN
% mu - mean value 1xN
% input - vector(s) to be transformed KxN
% noComponents - number of eigen vectrors to represent reprojected points

if nargin < 4 || any(eraseComponents < 1)
    % By default takes all eigen vectors
    eraseComponents = [];
end

xd = input - mu;
projected = E * xd.';
tran = projected; % Use different variable to rememeber projected vector
tran(eraseComponents) = 0;
reprojected = E.' * tran + mu.';

end
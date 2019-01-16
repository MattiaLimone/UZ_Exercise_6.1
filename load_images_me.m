function [database, M, N, Mold, Nold] = load_images_me(scale, noImages)
if nargin < 2
    % Default number of images to load
    noImages = 38;
end

if nargin < 1
    scale = 0.5;
end

% Read one image to find out its dimensions
filename = fullfile('Mira', sprintf('%02d.png', 1));
img = imread(filename);
[Mold, Nold, ~] = size(img);
img = imresize(img, scale);
[M, N, ~] = size(img);
% if(G > 1)
%     img = rgb2gray(img);
% end

database = zeros(noImages, M*N);
database(1, :) = reshape(img, 1, []);
for i = 2:noImages
filename = fullfile('Mira', sprintf('%02d.png', i));
    img = imread(filename);
%     if(G > 1)
%         img = rgb2gray(img);
%     end
    img = imresize(img, scale);
    database(i, :) = reshape(img, 1, []);
end
end
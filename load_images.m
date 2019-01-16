function [database, M, N] = load_images(noSerie, noImages)
if nargin < 2
    % Default number of images to load
    noImages = 64;
end

% Read one image to find out its dimensions
filename = fullfile('faces', num2str(noSerie), sprintf('%03d.png', 1));
img = imread(filename);
[M, N, G] = size(img);
if(G > 1)
    img = rgb2gray(img);
end

database = zeros(noImages, M*N);
database(1, :) = reshape(img, 1, []);
for i = 2:noImages
    filename = fullfile('faces', num2str(noSerie), sprintf('%03d.png', i));
    img = imread(filename);
    if(G > 1)
        img = rgb2gray(img);
    end
    database(i, :) = reshape(img, 1, []);
end
end
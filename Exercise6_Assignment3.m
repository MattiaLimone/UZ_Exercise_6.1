%% MP, Exercise 6, Assignment 3
% Image decomposition
clc; close all; clear;

%% 3a - Data preparation
clc; close all; clear;
[database, M, N] = load_images(1);
% D = prepare_data('1');
% D = double(D.');

%% 3b - Using dual PCA
close all; clc;
[E, mu] = dualPCA(database);
e = zeros(5, M, N);
figure('name', '3b - First 5 eigen vectors');
for i = 1:5
    img = reshape(E(i, :), [M N]);
    e(i, :, :) = img;
    subplot(2, 3, i);
    imagesc(img); colormap gray;
    title(['Eignen vector number\_', num2str(i)]);
end

x = database(1, :);
eraseComponent = 3;

[~, reprojected] = transformPCA(E, mu, x);
[~, oneMissing] = transformPCA(E, mu, x, eraseComponent);
original = reshape(x, [M N]);
reprojected = reshape(reprojected, [M N]);
oneMissing = reshape(oneMissing, [M N]);
difference = (original - reprojected);
diff = sum(sum(abs(original - reprojected)))

figure('name', '3b - Projection and reprojection');
subplot(2, 2, 1);
imagesc(original); colormap gray;
title('Original image');
subplot(2, 2, 2);
imagesc(reprojected); colormap gray;
title('Reprojected image');
subplot(2, 2, 3);
imagesc(difference); colormap gray;
title('Difference');
subplot(2, 2, 4);
imagesc(oneMissing); colormap gray;
title(['Component\_',num2str(eraseComponent), '\_missing']);

%% 3c - Effect of number of components
clc; close all;
x = database(24, :);
% xd = x - mu;
% Tran = E * xd.';
original = reshape(x, [M N]);

noEigs = [-1 33 17 9 5 3 2];

figure('name', '3c');
subplot(2, 4, 1);
imagesc(original); colormap gray;
title('Original');
for i = 1:7
%     t = zeros(64, 1);
%     t(1:noEigs(i)) = Tran(1:noEigs(i));
%     reTran = (E \ t).' + mu;
    [~, reTran] = transformPCA(E, mu, x, noEigs(i):64);
    reprojected = reshape(reTran, [M N]);
    subplot(2, 4, i+1);
    imagesc(reprojected); colormap gray;
    title(num2str(noEigs(i)-1));
end


%% 3d - Informativness of each component, optional (5)
clc; close all; clear;

[database, M, N] = load_images(2);

[E, mu] = dualPCA(database);
[~, reprojected] = transformPCA(E, mu, mu, [2 3]);

figure('name', '3d');
subplot(1, 3, 1);
imagesc(reshape(mu, [M N])); colormap gray;
title('Original average image');
subplot(1, 3, 2);
imagesc(reshape(reprojected, [M N])); colormap gray;
title('Reprojected average image');

for x = linspace(-200, 200, 50)
    % TODO: compute the projection, reshape it to image and store it to the variable image
    
    xd = mu - mu;
    projected = E * xd.';
    projected(2) = x * sin(x);
    projected(3) = x * cos(x);
    reprojected = E.' * projected + mu.';
    image = reshape(reprojected, [M N]);
    
    subplot(1, 3, 3); imshow(uint8(image)) ;
    pause(0.2);
end
%% 3e - Recontruction of foreign image, optonal (5)
clc; close all; clear;

[database, M, N] = load_images(1);
[E, mu] = dualPCA(database);

elephant = double(rgb2gray(imread('elephant.jpg')));
[~, reprojected] = transformPCA(E, mu, elephant(:).');
reprojected = reshape(reprojected, [M N]);

figure('name', '3e');
subplot(1, 2, 1);
imshow(uint8(elephant)); title('Original image');
subplot(1, 2, 2);
imshow(uint8(reprojected)); title('Reprojected image');

%% 3f - Recognition with subspace, optional (15)
clc; close all; clear;
scale = 1;
[database, M, N, X, Y] = load_images_me(scale);
[E, mu] = dualPCA(database);

% Connect to webcam
c = webcam(1);
% Setup preview window
fig = figure('NumberTitle', 'off', 'MenuBar', 'none');
fig.Name = 'My Camera';
ax = axes(fig);
frame = snapshot(c);
im = image(ax, zeros(size(frame), 'uint8'));
axis(ax, 'image');

% Start preview
preview(c, im)
setappdata(fig, 'cam', c);
fig.CloseRequestFcn = @closePreviewWindow_Callback;

% Draw rectangle as image selection of appropriate size
hold on;
rectangle('Position', [(1280-Y)/2 (720-X)/2 Y X], 'EdgeColor', 'r', 'LineWidth', 3);

while(true)
    w = waitforbuttonpress;
    imgFull = snapshot(c);
    imgFull = rgb2gray(imgFull);
    img2D = imgFull((720-X)/2:(720+X)/2-1, (1280-Y)/2:(1280+Y)/2-1);
    img2D = imresize(img2D, scale);
    img = double(reshape(img2D, 1, []));
    [~, reprojected] = transformPCA(E, mu, img);
    reprojected = reprojected.'; % Dimension agrees with img
    
    distance = pdist2(img, reprojected);
    if distance < 1.5e4
        fprintf("YES (face detected)\n");
    else
       fprintf("NO (no face detected)\n");
    end
    % Cityblock yes cca 3.5e6, no 6e6
    % Euclidean yes cca 1e4, no 2e4
end

%% 3g - Linear discriminant analysis, optional (10)
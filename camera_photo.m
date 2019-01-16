function img = camera_photo(M, N)
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
rectangle('Position', [(1280-N)/2 (720-M)/2 N M], 'EdgeColor', 'r', 'LineWidth', 3);

% Make button to take photos
button = uicontrol();
button.String = 'Take photo!';
button.Callback = @pushButton_Callback;

w = waitforbuttonpress;

img = snapshot(c);
end
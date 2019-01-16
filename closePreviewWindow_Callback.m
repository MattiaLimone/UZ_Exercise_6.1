function closePreviewWindow_Callback(obj, ~)
c = getappdata(obj, 'cam');
closePreview(c)
delete(obj)
end
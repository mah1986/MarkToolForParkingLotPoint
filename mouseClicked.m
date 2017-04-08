function mouseClicked( hObject, ~ )

handles = guidata(hObject);
if ~handles.readSuccess
    return;
end
cursorPoint = get(handles.AxesImage, 'CurrentPoint');
curX = cursorPoint(1,1);
curY = cursorPoint(1,2);

xLimits = get(handles.AxesImage, 'xlim');
yLimits = get(handles.AxesImage, 'ylim');

if (curX > min(xLimits) && curX < max(xLimits) && curY > min(yLimits) && curY < max(yLimits))
    if strcmp(get(handles.figure1,'selectionType'), 'normal')
        handles.marks = [handles.marks; [curX, curY]];
        handles = plotMarks(handles, size(handles.marks,1));
    elseif strcmp(get(handles.figure1,'selectionType'), 'alt')
        for i = 1:size(handles.marks, 1)
            if norm(handles.marks(i, :) - [curX, curY]) < 10
                handles.marks(i, :) = [];
                delete(handles.markPlots(i, :));
                handles.markPlots(i, :) = [];
                for j = i:size(handles.marks, 1)
                    delete(handles.markPlots(j, 1));
                    handles.markPlots(j, 1) = text(handles.marks(j, 1)+10, handles.marks(j, 2)+10, ...
                        num2str(j),'Color','blue');
                end
                break;
            end
        end
    end
    guidata(hObject, handles);
end

end
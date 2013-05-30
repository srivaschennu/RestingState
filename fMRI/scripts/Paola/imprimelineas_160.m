function imprimelineas(cc,color)
h = findobj(cc,'type','image');
xdata = get(h, 'XData');
ydata = get(h, 'YData');
M = size(get(h,'CData'), 1);
N = size(get(h,'CData'), 2);
%%
if M > 1
    pixel_height = diff(ydata) / (M-1);
else
    % Special case. Assume unit height.
    pixel_height = 1;
end

if N > 1
    pixel_width = diff(xdata) / (N-1);
else
    % Special case. Assume unit width.
    pixel_width = 1;
end

y_top = ydata(1) - (pixel_height/2);
y_bottom = ydata(2) + (pixel_height/2);
y = linspace(y_top, y_bottom, M+1);
x_left = xdata(1) - (pixel_width/2);
x_right = xdata(2) + (pixel_width/2);
x = linspace(x_left, x_right, N+1);
%%
%  32    21    34    33   21  40

TA=2;
hold on
plot([x(33) x(33)], [y(1) y(end)], 'Color',color, 'LineWidth', TA);
plot([x(33+21) x(33+21)], [y(1) y(end)],'Color', color, 'LineWidth', TA);
plot([x(33+21+34) x(33+21+34)], [y(1) y(end)],'Color', color, 'LineWidth', TA);
plot([x(33+21+34+33) x(33+21+34+33)], [y(1) y(end)],'Color', color, 'LineWidth', TA);
plot([x(33+21+34+33+21) x(33+21+34+33+21)], [y(1) y(end)],'Color', color, 'LineWidth', TA);

plot([x(1) x(end)], [y(33) y(33)], 'Color',color, 'LineWidth', TA);
plot([x(1) x(end)], [y(33+21) y(33+21)],'Color', color, 'LineWidth', TA);
plot([x(1) x(end)], [y(33+21+34) y(33+21+34)],'Color', color, 'LineWidth', TA);
plot([x(1) x(end)], [y(33+21+34+33) y(33+21+34+33)],'Color', color, 'LineWidth', TA);
plot([x(1) x(end)], [y(33+21+34+33+21) y(33+21+34+33+21)],'Color', color, 'LineWidth', TA);

plot([x(1) x(1)], [y(1) y(end)],'Color', color, 'LineWidth', TA);
plot([x(end+1) x(end+1)], [y(1) y(end)],'Color', color, 'LineWidth', TA);
plot([x(1) x(end)], [y(1) y(1)], 'Color',color, 'LineWidth', TA);
plot([x(1) x(end)], [y(161) y(161)],'Color', color, 'LineWidth', TA);



hold off
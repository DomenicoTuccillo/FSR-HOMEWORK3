function h = personal_plot(x, y, x_label_latex, y_label_latex, pdf_name,plot_title)

set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')
lw = 2;

h = figure('Renderer', 'painters', 'Position', [10 10 900 300]);
removeToolbarExplorationButtons(h)

plot(x, y, 'b-', 'Linewidth', lw ,'Color', [0, 0, 1]);
xlim([x(1) x(end)])

xlabel(x_label_latex)
ylabel(y_label_latex)
title(plot_title)
set(gca, 'FontSize',18);
grid on
box on
set(gcf,'color','w');
exportgraphics(h, pdf_name);

end

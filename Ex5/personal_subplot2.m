function h = personal_subplot2(x, y, x_label_latex, y_label_latex, pdf_name, n_rows, n_cols, subplot_titles)
    % Configurazioni iniziali per interpretazione LaTeX
    set(0, 'DefaultTextInterpreter', 'latex')
    set(0, 'DefaultLegendInterpreter', 'latex')
    set(0, 'DefaultAxesTickLabelInterpreter', 'latex')
    lw = 2;  % Line width

    % Crea la figura
    h = figure('Renderer', 'painters', 'Position', [10 10 3000 500]);
    removeToolbarExplorationButtons(h)
    num_subplot=n_rows*n_cols;
    % Ciclo per creare ogni subplot
    for i = 1:num_subplot
        subplot(n_rows, n_cols, i);
        plot(x{i}, y{i}, 'b-', 'Linewidth', lw, 'Color', [0, 0, 1]);
        xlim([x{i}(1) x{i}(end)]);
        xlabel(x_label_latex{i});
        ylabel(y_label_latex{i});
        title(subplot_titles{i});
        set(gca, 'FontSize', 18);
        grid on;
        box on;
    end

    % Imposta il colore di sfondo della figura
    set(gcf,'color','w');

    % Salva la figura in un file PDF
    exportgraphics(h, pdf_name);
end

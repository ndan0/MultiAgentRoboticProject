function updatePlot(ax, A, nodes)
numNodes = length(nodes);
% Clear axes
cla(ax);
hold(ax, 'on');

% Draw all edges
for i = 1:numNodes
    for j = i+1:numNodes
        if A(i,j) == 1
            ni = nodes{i};
            nj = nodes{j};

            plot(ax, ...
                [ni.x, nj.x], ...
                [ni.y, nj.y], ...
                'k-', 'LineWidth', 1.5);
        end
    end
end

% Draw all nodes as objects
for i = 1:numNodes
    node = nodes{i};

    h = plot(ax, ...
        node.x, node.y, ...
        node.shape, ...
        'MarkerSize', 10, ...
        'MarkerFaceColor', node.color, ...
        'MarkerEdgeColor', 'k');

    h.ButtonDownFcn = @(src, event) onNodeClick(node.id);
end

axis(ax, 'equal');
axis(ax, 'off');
drawnow;
end
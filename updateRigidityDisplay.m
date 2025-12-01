function updateRigidityDisplay(rigidityText, A, numNodes)
    % Extract the active portion of the adjacency matrix
    Aactive = A(1:numNodes, 1:numNodes);

    % Count undirected edges
    edges = nnz(Aactive) / 2;

    % Laman condition in 2D: 2n - 3 edges
    lamanRequired = 2*numNodes - 3;

    % Edge density
    maxEdges = numNodes*(numNodes-1)/2;

    % Build display text
    info = sprintf([ ...
        'Graph Rigidity Summary\n\n' ...
        'Nodes           : %d\n' ...
        'Edges           : %d\n\n' ...
        'Laman Required  : %d\n' ...
        'Laman Status    : %s\n' ...
        ], ...
        numNodes, edges, lamanRequired, ...
        statusString(edges, lamanRequired));

    % Update GUI text box
    rigidityText.String = info;
end

% Helper that returns YES/NO text
function s = statusString(edges, lamanRequired)
    if edges == lamanRequired
        s = "Exactly meets (Laman rigid)";
    elseif edges < lamanRequired
        s = sprintf("Missing %d edges", lamanRequired - edges);
    else
        s = sprintf("Has %d extra edges", edges - lamanRequired);
    end
end
function [A, nodes] = applyRule1(A, nodes)
    N = size(A,1);

    % Find all unused node (circle node)
    newNodeIndex = -1;
    for i = 1:N
        if isequal(nodes{i}.shape, 'o')
            newNodeIndex = i;
            break;
        end
    end

    if newNodeIndex == -1
        return; % No available nodes
    end

    % Find all edge of A in from of (nodea, nodeb)
    edges = []; % Initialize empty list

    for i = 1:N
        for j = i+1:N  % check only upper triangle
            if A(i,j) ~= 0
                edges = [edges; i, j];
            end
        end
    end

    % Chose a random edge
    randomEdgeIndex = randi(size(edges, 1)); % Select a random edge index
    selectedEdge = edges(randomEdgeIndex, :); % Get the corresponding edge

    A(newNodeIndex, selectedEdge(1)) = 1;
    A(newNodeIndex, selectedEdge(2)) = 1;

    A(selectedEdge(1), newNodeIndex) = 1;
    A(selectedEdge(2), newNodeIndex) = 1;

    nodes{newNodeIndex}.shape = 's'; % Update the shape of the new node
          

end

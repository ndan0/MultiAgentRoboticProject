function [A, nodes] = applyRule1(A, nodes)
    N = size(A,1);

    % Find all unused node (circle node)
    circleNodeIndexes = [];
    for i = 1:N
        if isequal(nodes{i}.shape, 'o')
            circleNodeIndexes = [circleNodeIndexes; i];
        end
    end
    
    % Chose random node
    if length(circleNodeIndexes) <=0
        return; % Exit if no circle nodes are found
    end
    newNodeIndex = circleNodeIndexes(randi(length(circleNodeIndexes)));

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
    idx = randi(size(edges,1));
    e = edges(idx, :);
    a = e(1);
    b = e(2);

    A(newNodeIndex, a) = 1;
    A(newNodeIndex, b) = 1;

    A(a, newNodeIndex) = 1;
    A(b, newNodeIndex) = 1;

    nodes{newNodeIndex}.shape = 's'; % Update the shape of the new node
          

end

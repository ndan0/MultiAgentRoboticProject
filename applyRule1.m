function [A, nodes] = applyRule1(A, nodes)
    N = size(A,1);

    % Find all unused node (circle node)
    newNode = -1;
    for i = 1:N
        if isequal(nodes{i}.shape, 'o')
            newNode = i;
            break;
        end
    end

    if newNode == -1
        return; % No available nodes
    end

    % Find an active nodes to connect to
    active = [];
    for i = 1:N
        if ~isequal(nodes{i}.shape, 's')
            active(end+1) = i;
        end
    end

    if numel(active) < 2
        return; % Not enough active nodes
    end
end

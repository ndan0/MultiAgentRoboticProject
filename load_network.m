function [X, n, N, A] = load_network(A, nodes)
% Load network from hennesburg_gui generated graph
% Input:
%   A     : adjacency matrix (NxN)
%   nodes : cell array of NodeObj with fields .x, .y
% Output:
%   X     : position matrix (2xN) where X(:,i) = [x_i; y_i]
%   n     : dimension (always 2 for 2D)
%   N     : number of nodes
%   A     : adjacency matrix (returned unchanged)

n = 2;  % 2D space
N = size(A, 1);

% Extract positions from nodes into position matrix X (2xN)
X = zeros(2, N);

for i = 1:N
    X(1, i) = nodes{i}.x;
    X(2, i) = nodes{i}.y;
end

end

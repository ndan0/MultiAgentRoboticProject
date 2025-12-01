function [A, nodes] = applyRule0(start_node_index, A, nodes)
% Reset adjacency matrix
A(:,:) = 0;

% Reset all nodes to isolated, default shape 'o' and blue color
N = size(A,1);
for i = 1:N
    node = nodes{i};
    node.shape = 'o';
    node.color = [0 0 1];
end

% Set the seed node to red
nodes{start_node_index}.color = [1 0 0];

%Choose a random node in A that is not the start node
random_node_index = randi(N);
while random_node_index == start_node_index
    random_node_index = randi(N);
end

%Make an edge between that and node A
A(start_node_index, random_node_index) = 1;  % Create an edge from start_node to randomNode
A(random_node_index, start_node_index) = 1;  % Create a bidirectional edge

%Set both node to a square
nodes{start_node_index}.shape = 's';
nodes{random_node_index}.shape = 's';
end

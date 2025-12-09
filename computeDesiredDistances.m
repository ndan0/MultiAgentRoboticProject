%Compute all current distances between neighbors

function D = computeDesiredDistances(A, nodes)
N = size(A,1);
D = zeros(N);

for i = 1:N
    for j = i+1:N
        if A(i,j) == 1
            dx = nodes{i}.x - nodes{j}.x;
            dy = nodes{i}.y - nodes{j}.y;
            D(i,j) = sqrt(dx^2 + dy^2);
            D(j,i) = D(i,j);
        end
    end
end
end
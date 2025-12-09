function[]=plotsol(X,N,A,Delta);

%figure(1);
hold off;

%{
for i=1:N;
  plot(X(1,i),X(2,i),'o');
  hold on;
  for j=1:N;
    if (A(i,j)==1);
      plot([X(1,i),X(1,j)],[X(2,i),X(2,j)]);
      grid on
end; end; end;

axis([-2*Delta,2*Delta,-2*Delta,2*Delta]);
drawnow;
%}

for i = 1:N
    plot(X(1,i), X(2,i), 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'blue');
    hold on;
    for j = 1:N
        if A(i,j) == 1 && i < j  % plot each edge only once
            plot([X(1,i), X(1,j)], [X(2,i), X(2,j)], 'k-', 'LineWidth', 1.5);
        end
    end
end

grid on;
axis equal;
axis([-2*Delta, 2*Delta, -2*Delta, 2*Delta]);
xlabel('X');
ylabel('Y');
title('Graph Visualization');
drawnow;

end

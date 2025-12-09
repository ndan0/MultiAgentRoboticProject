clear;
clc;

figure

%% Proximity disk
Delta=0.5; % interaction distance

%Load Networks
network_no=1; % 1 or 2 or 3
[X,n,N]=load_network(network_no,Delta);
% n = dimension of each robot (n>1)
% N = total number of robots
% X = n x N vector containing the initial robot positions


%% Some numerical integration parameters
dt=0.003; % numerical steplength
Tf=5; % final time

t=0; 
iter=1;

d0 = .2;
p = 3;
b = -tan(-pi/2 + pi/p);
%weightfcn = @(d) tan(-pi/2 + pi * d/Delta) + b;

%eps_reg   = 0.01;                         % small regularization to avoid blow-up
%weightfcn = @(d) 1 ./ (Delta - d + eps_reg);

eps_reg = .05;
weightfcn = @(d) (.5 .* (2 .* Delta - d) ./ (Delta - d + eps_reg).^2) * (d - d0);

dist = @(xi, xj) sqrt( (xi - xj)' * (xi - xj));
%weight   = @(xi,xj) 1;
weight = @(xi, xj) weightfcn(dist(xi, xj)); 

% H for hysterisys
epsilon = .05;
H = zeros(size(disk(X,N,Delta)));
dmin = inf;
dmax = 0;

R = zeros(n, N);

R0    = 0.4;                          % circle radius
theta = linspace(0, 2*pi, N+1);       % N angles around the circle
theta(end) = [];                      % drop duplicate 2π

for i = 1:N
    R(1,i) = R0 * cos(theta(i));      % x-coordinate
    R(2,i) = R0 * sin(theta(i));      % y-coordinate

    % if n > 2, keep extra dimensions at 0:
    % R(3:end,i) = 0;   % optional
end

while (t<=Tf)

%% A is the adjacency matrix associated with the system
%% using a disk graph. 
  A=disk(X,N,Delta);

  DX=zeros(n,N); %% Here is where we store the derivatives
  for i=1:N
    for j=1:N
      if (A(i,j)==1)

%% ?????????????????????????????????
dmin = min(dist(X(:,j),X(:,i)), dmin);
dmax = max(dist(X(:,j),X(:,i)), dmax);

if H(i, j) == 0     % this is a new edge
    if dist(X(:,j),X(:,i)) < Delta-epsilon  % don't head towards
        H(i, j) = 1;
    end
end

w = weight(X(:,i), X(:,j));
r_ij = R(:,i) - R(:,j);
e_ij = (X(:,i) - X(:,j)) - r_ij;

DX(:,i) = DX(:,i) - w * e_ij;
%DX(:,i)=DX(:,i)+ w .* (X(:,j)-X(:,i));   % The consensus equation
%% ?????????????????????????????????
%% Note, here I've given the consensus equation.
%% Your job is to change this by selecting appropriate weight "w" in order to make the robots
%% satisfy the three (not all at once, mind you) questions
%% that I want you to think about...

      end; end; end

%% Update the states using an Euler approximation
  for i=1:N
    X(:,i)=X(:,i)+dt.*DX(:,i);
  end

%% Update time
  t=t+dt;


%% Plot the solution every 10 iterations
  if (mod(iter,10)==0)
    plotsol(X,N,A,Delta);
  end

  iter=iter+1;
end
 
[dmin dmax]




function hennesburg_gui()
% Destroy all figure
close all;

% USER INPUT
Nmax = inputdlg("Enter the number of nodes:", ...
    "Number of Nodes", 1, {"8"});
Nmax = str2double(Nmax{1});

if Nmax < 0
    error("Number need to be greater than 0");
end

% INITIALIZE GRAPHS
A = zeros(Nmax); % Adjacency matrix for the graph

coords = zeros(Nmax, 2); % Coordinates for each node

% Generate circular coordinates for the nodes
theta = linspace(0, 2*pi, Nmax + 1)';
coords(:, 1) = cos(theta(1:end-1)); % X-coordinates
coords(:, 2) = sin(theta(1:end-1)); % Y-coordinates

%Initialize nodes array size Nmax of NodeObj
nodes = cell(Nmax, 1); % Initialize nodes array to hold NodeObj

for i = 1:Nmax
    nodes{i} = NodeObj(i,coords(i,1),coords(i,2),'o',[0 0 1]);
end

% BUILD GUI
fig = figure('Name','Hennesburg Grammar GUI',...
    'Position',[200 100 900 600]);
ax = axes('Parent',fig,'Position',[0.05 0.1 0.6 0.85]);
hold(ax,'on');

% Buttons
uicontrol(fig,'Style','pushbutton','String','Rule 0 (Start)', ...
    'Units','normalized','Position',[0.7 0.85 0.25 0.08], ...
    'Callback', @(~,~)cb_rule0());

uicontrol(fig,'Style','pushbutton','String','Rule 1 (Addition)',...
    'Units','normalized','Position',[0.7 0.75 0.25 0.08],...
    'Callback',@(~,~)cb_rule1());

uicontrol(fig,'Style','pushbutton','String','Rule 2 (Edge Splitting)',...
    'Units','normalized','Position',[0.7 0.65 0.25 0.08],...
    'Callback',@(~,~)cb_rule2());

uicontrol(fig,'Style','pushbutton','String','Auto Run',...
    'Units','normalized','Position',[0.7 0.55 0.25 0.08],...
    'Callback',@(~,~)cb_auto());

rigidityText = uicontrol(fig,'Style','text',...
    'Units','normalized','Position',[0.7 0.05 0.25 0.4],...
    'FontSize',12,'HorizontalAlignment','left');

% Initial plot and rigidity
updatePlot(ax, A, nodes);
updateRigidityDisplay(rigidityText, A, Nmax);

% GUI CALLBACKS
function cb_rule0()
    % Ask user to pick a node ID
    choice = inputdlg("Enter the start node ID (1 to " + Nmax + "):", ...
        "Choose Start Node", 1, {"1"});
    if isempty(choice)
        return;
    end

    start_node = str2double(choice{1});
    if isnan(start_node) || start_node < 1 || start_node > Nmax
        errordlg("Invalid node ID selected.");
        return;
    end

    % Apply Rule 0
    [A, nodes] = applyRule0(start_node, A, nodes);

    % Update UI
    updatePlot(ax, A, nodes);
    updateRigidityDisplay(rigidityText, A, Nmax);
end

function cb_rule1()
    [A, nodes] = applyRule1(A, nodes);
    updatePlot(ax, A, nodes);
    updateRigidityDisplay(rigidityText, A, Nmax);
end

function cb_rule2()
    [A, nodes] = applyRule2(A, nodes);
    updatePlot(ax, A, nodes);
    updateRigidityDisplay(rigidityText, A, Nmax);
end

function cb_auto()
    % Extract the active portion of the adjacency matrix
    Aactive = A(1:Nmax, 1:Nmax);

    % Count undirected edges
    edges = nnz(Aactive) / 2;

    % Laman condition in 2D: 2n - 3 edges
    lamanRequired = 2*Nmax - 3;
    
    while edges < lamanRequired
        if rand() < 0.5
            cb_rule1();
        else
            cb_rule2();
        end
        pause(0.5);
    end
end

end %hennesburg_gui

function onNodeClick(nodeID)
    msg = sprintf('Node ID: %d', nodeID);
    disp(msg);
    warndlg(msg, 'Node Selected');
end

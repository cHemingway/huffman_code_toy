function [map,t] = huffman_map(pmap)
%HUFFMAN_MAP generates a map of symbol,huffman from symbol,probability
% Optionally outputs binary tree t used to generate the map.
%

% Create the tree
t = tree_from_pmap(pmap);

% Sort and Merge probabilities until only 2 left
while (length(t.getchildren(1)) > 2)
    
    t = sort_prob_tree(t); % Sort tree
    [idx1, idx2] = find_lowest_two(t); % Get indicies of lowest two
    
    % Get the values of the lowest two, and find the merged values
    lowest = t.get(idx1);
    second = t.get(idx2);
    new_prob = lowest.p + second.p;
    new_val = [lowest.s second.s]; % Concat letters together
    
    % Create a new branch to attach to the root
    branch = tree(node_struct(new_val, new_prob));
    
    % Attach the lowest two to the new tree
    branch = branch.graft(1, t.subtree(idx1));
    branch = branch.graft(1, t.subtree(idx2));
    
    % Attach this tree to the root
    t = t.graft(1, branch);
    
    % Remove the previously merged values
    t = t.chop(idx1); t = t.chop(idx2);
end



% Create empty map for output
S = keys(pmap);
map = containers.Map(S, cell(1, length(S)));

% Now descend depth first, assigning bits to each layer
% TODO: do this by splitting graph instead
for idx=t.breadthfirstiterator
    % Get parent bits
    parent = t.getparent(idx);
    if parent == 0 % Skip root, which has no parents
       continue;
    end
    % Choose bit based on if we are bigger or smaller
    current_level = t.getchildren(parent);
    other = current_level(current_level ~= idx);
    if t.get(idx).p > t.get(other).p
        bit = 0;
    elseif t.get(idx).p == t.get(other).p % Handle equals, special case
        bit = ~bit; % Ensure it is not the same as the sibling
    else 
        bit = 1;
    end
    % Add bit on end of parent bits
    parent_bits = t.get(parent).bits;
    new_bits = [parent_bits bit];
    % Update node with new bits
    new_struct = t.get(idx);
    new_struct.bits = new_bits;
    t = t.set(idx, new_struct);
    % If its a leaf (e.g. a symbol), add it to the map
    if t.isleaf(idx)
       map(new_struct.s) = new_bits; 
    end
end

end


function [lowest, second] = find_lowest_two(t)
    % Find lowest and second lowest
    idx = t.getchildren(1);
    lowest = idx(end);
    second = idx(end-1);
end
   

function t = tree_from_pmap(pmap)
    % Add root node, this will be at index 1
    root = node_struct('',1.0); % Has probability of 1
    t = tree(root);
    % Attach all symbols to root node
    % Will preserve order, as this is already sorted
    for s = cell2mat(keys(pmap))
       p = pmap(s);
       t = t.addnode(1, node_struct(s, p)); 
    end
end
function new_tree = sort_prob_tree(t)
    %SORT_PROB_TREE sort top level of probability tree
    
    % Get the addresses of the top level
    top_idx = t.getchildren(1);
    
    % Get list of probabilities in top level
    probs = zeros(length(top_idx),1);
    j = 1;
    for i=top_idx
       probs(j)= t.get(i).p;
       j = j + 1;
    end
    
    % Sort and get indicies
    [~, sorted_idx] = sort(probs,'descend');
    % Rearrange top_idx by this
    top_idx = top_idx(sorted_idx);
    
    % Create new tree based on these indicies
    new_tree = tree(node_struct('',1.0));
    for i=top_idx
       branch = t.subtree(i);
       %[~, head] = new_tree.addnode(1, t.get(i));
       new_tree = new_tree.graft(1,branch);
    end
end


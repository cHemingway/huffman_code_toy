% Chris Hemingway 2019

function p_map = probability_map(data)
    %PROBABILITY_MAP generate map of probabilites of each symbol in data
    
    % Convert string to char
    if isa(data,'string')
        data = char(data);
    end
    
    % Quick 2 liner to get both unique and counts
    % https://uk.mathworks.com/help/matlab/ref/unique.html#mw_42eea7c7-dde5-45e9-8434-133a1dfe4b6a
    [S,~,ic] = unique(data);
    counts = accumarray(ic,1);
    
    % Add null terminator to table if not present
    if isa(data, 'char') && ~ismember('$',S)
       S = [S, '$'];
       counts = [counts;1]; 
       total_count = length(data) + 1;
    else
       total_count = length(data);
    end
    
    probs = counts / total_count; % Divide by total to get probabilites
    
    % Quick fix, if we were given chars, convert to cells
    if isa(S, 'char')
       S = cellstr(S');
    end
    % Add the missing space back as cellstr deletes it
    if any(cellfun(@isempty,S))
        S{cellfun(@isempty,S)}=' ';
    end
    
    % Return a map
    p_map = containers.Map(S, probs);
end
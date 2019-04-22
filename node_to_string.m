function str = node_to_string(content)
    % Function to turn our nodes into string representation
    bitstr = num2str(content.bits);
    bitstr = bitstr(~isspace(bitstr));
    
    if length(content.s) == 1 %Final row
        str = [content.s ' ' num2str(content.p) ' ' bitstr];
    else
        str = [num2str(content.p) ' ' bitstr];
    end
    
    
end
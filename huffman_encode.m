function bits = huffman_encode(data, map)
    if isa(data, 'string')
       data = char(data); 
    end
    bits = [];
    for d=data
        bits = [bits map(d)];
    end
end
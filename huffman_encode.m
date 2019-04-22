function bits = huffman_encode(data, map)
    bits = [];
    for d=data
        bits = [bits map(d)];
    end
end
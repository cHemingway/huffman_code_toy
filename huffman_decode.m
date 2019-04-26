function data = huffman_decode(bits, map)
%HUFFMAN_DECODE convert a sequence of bits back to the message

symbols = keys(map);
symbols_bits = values(map);

%Simplest implementation, consume bits 1 at a time
data = [];
symbol_bits = [];
for i=1:length(bits)
    % Build up bits until we get a symbol
    symbol_bits = [symbol_bits bits(i)];
    
    % Search all values in map for the symbol, slow but simple
    for k = 1:length(symbols_bits)
        possible_bits = cell2mat(symbols_bits(k));
        if isequal(possible_bits,symbol_bits)
           symbol = cell2mat(symbols(k));
           data = [data symbol];
           symbol_bits = []; %Clear the bits
        end
    end
end

end
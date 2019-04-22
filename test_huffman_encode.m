% Arbitrary message encode, shows performance results
message = fileread('sample_text.txt');
pmap = probability_map(message);

[map,~] = huffman_map(pmap);

compressed = huffman_encode(message, map);

n1 = length(message)*8; %Assume ASCII, 8 bits per letter
n2 = length(compressed);
Cr = n1 / n2; % Compression ratio

h = pmap_entropy(pmap); % Entropy, theoretical average bits needed per letter
Cr_max = 8/h; % Max possible Cr

fprintf("Bits before = %d, after = %d \n",n1,n2);
fprintf("Message Entropy = %.3f \n",h);
fprintf("Achieved Cr = %.3f, %02.2f%% of Theoretical Cr = %.3f \n",... 
        Cr, (Cr/Cr_max)*100, Cr_max);

function h = pmap_entropy(pmap)
    pk = cell2mat(values(pmap));
    h = - sum(pk .* log2(pk));
end
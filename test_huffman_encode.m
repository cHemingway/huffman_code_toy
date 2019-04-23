% Demo showing encoding of a long string and performance results

% TODO use better import method
addpath('./tinevez-matlab-tree-3d13d15');

% Arbitrary message encode, shows performance results
text_file = 'sample_text.txt';

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
fprintf("Huffman achieved Cr = %.3f, %02.2f%% of Theoretical Cr = %.3f \n",... 
        Cr, (Cr/Cr_max)*100, Cr_max);

% Compare against zip
zipfile_name = [text_file '.zip'];
zip(zipfile_name,text_file);
zipped_stats = dir(zipfile_name);
zipped_bits = zipped_stats.bytes * 8;

fprintf("Zipped file is %d bits, Cr = %.3f \n",...
    zipped_bits,n1/zipped_bits); 

delete(zipfile_name); % Clean up
    
function h = pmap_entropy(pmap)
    pk = cell2mat(values(pmap));
    h = - sum(pk .* log2(pk));
end
% Demo showing encoding and decoding of a message
clc; clear;

% TODO use better import method
addpath('./tinevez-matlab-tree-3d13d15');

message = "An example message to compress";
pmap = probability_map(message);

[map,~] = huffman_map(pmap);

disp("Map");
print_huffman_map(map);

compressed = huffman_encode(message, map);

disp(compressed);

decoded = huffman_decode(compressed, map);
disp(decoded);

assert(decoded == message);
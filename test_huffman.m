clc; clear;

% TODO use better import method
addpath('./tinevez-matlab-tree-3d13d15');

%% LECTURE EXAMPLE
S = { 'a' , 'b' , 'c' , 'd' , 'e' };
probs = {0.25, 0.25, 0.2, 0.15, 0.15};
pmap = containers.Map(S, probs);

% Generate the map
[map, t] = huffman_map(pmap);

% Show the map
print_huffman_map(map);

%% TUTORIAL EXAMPLE
% Define the mapping of probability to symbols
S = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i'};
probs = [.36 .15 .13 .11 .09 .07 .05 .03 .01];
pmap = containers.Map(S, probs);

% Generate the map
[map, t] = huffman_map(pmap);

% Show the map
print_huffman_map(map);



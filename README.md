## huffman_toy
A toy huffman code implementation in MATLAB

Not fast or tested properly, but somewhat simple to understand code.
Do not use this for anything, no gaurantee it works.

### Files
- `test_huffman.m` Shows generation of huffman tables with "tree" view
- `test_huffman_encode_decode.m` Compresses/decompresses a sample message
- `test_huffman_encode.m` Compresses a long string of text, and gives compression ratio vs theoretical.

### Credits
Uses [matlab-tree](https://github.com/tinevez/matlab-tree). 

MODIFIED tostring.m to add custom node contents printing function support.

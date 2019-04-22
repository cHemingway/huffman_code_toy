function print_huffman_map(map)
S = keys(map);
for s=cell2mat(S)
   bitstr = num2str(map(s));
   bitstr = bitstr(~isspace(bitstr));
   fprintf(' ''%s'' \t: %s\n',s, bitstr);
end

end
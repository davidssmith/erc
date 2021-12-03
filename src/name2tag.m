function idx = name2tag (data, name)
%%NAME2TAG  Convert English name of nuclide to numerical database tag.
for idx = 1:numel(data)
  if strcmp(data{idx}.name, name), break; end
end
if idx == numel(data)
  idx = 0;
end

idx = uint16(idx);
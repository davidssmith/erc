function p = dig (data, nuclides, weights)
%%DIG  Traverse decay chains to find all products

if nargin < 3, weights = 1; end
p = {};
p.daughter = [];
p.branch_ratio = [];
for k = 1:numel(nuclides)
  n              = nuclides(k);
  %e              = emit(data, n);
  %if sum(e.Y) >= 1e-3
  for j = 1:numel(data{n}.daughter)
    d = data{n}.daughter(j);
    if d ~= 0 && data{d}.half_life <= 0.0*data{n}.half_life
       br = weights(k) * data{n}.branch_ratio(j);
       p.daughter     = [p.daughter d];
       p.branch_ratio = [p.branch_ratio br];
       q              = dig(data,d,br);
       p.daughter     = [p.daughter q.daughter];
       p.branch_ratio = [p.branch_ratio q.branch_ratio];
    end
  end
  %end
end
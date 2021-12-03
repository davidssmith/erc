function e = emit (data, nuclides, weights, codes)
%%EMIT Total emissions from group of nuclides
%
%  E = emit(DATA, NUCLIDES, WEIGHTS, CODES) returns a cell array of all
%  emissions from NUCLIDES given in DATA subject to the per-nuclide WEIGHTS
%  and restricted to emissions with type CODES.
%

u = units;

e = {};
e.Y = [];
e.E = [];
if nargin < 3
  weights = ones(numel(nuclides),1);
end
if nargin < 4    % default is G,PG,DG,X,AQ
  codes = 1:5;
end
for j = 1:numel(nuclides)
  n = nuclides(j);
  for c = codes
    if ~isempty(data{n}.emissions{c})
      e.Y = [e.Y weights(j)*data{n}.emissions{c}.Y];
      e.E = [e.E data{n}.emissions{c}.E];
    end
  end
end
e.E = e.E * u.MeV;
e.Y = e.Y / u.decay;
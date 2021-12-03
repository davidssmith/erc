function e = decay (data, nuclide)
%%DECAY  Traverse decay chain downard.
%
%  E = DECAY(DATA,NUCLIDE) produces emmissions E in MeV from NUCLIDE in
%  the decay DATA.
d = dig(data, nuclide);
e = emit(data, [nuclide d.daughter], [1 d.branch_ratio]);
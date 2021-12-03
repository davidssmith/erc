function a = atten (E, S)
%%ATTEN  Attenuation of photon of energy E [MeV] safter thickness S [mm].
%
%  This is a helper function used in solving for the HVL, TVL, etc.s

if E < 0.015
  a = 0.0;
elseif S <= 0
  a = 1.0;
elseif S / mfp_in_mm(E) > 10
  a = 0;
elseif E > 0.15
  a =  shimatten(E, S ./ mfp_in_mm(E));
elseif E >= 0.03
  a = 0.5*(kakatten(E,S) + shimatten(E, S ./ mfp_in_mm(E)));
elseif E >= 0.015
  a = kakatten(E,S);
else
  a = 0;
end
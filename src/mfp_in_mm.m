function m = mfp_in_mm (E)
%%MFP_IN_MM   Return mfp in Pb in mm as a function of energy in MeV.
persistent lastE lastm
if E == lastE
  m = lastm;
  return;
end
rho = 11.35;
m = 10.0 ./ mac(E,'lead') / rho;
lastm = m;
lastE = E;
function vl = kakvl (T, E)
%%KAKVL returns Tth-VL in mm Pb in units of mfp

if E < 0.015 || E > 0.15, error('E (%g) out of range in KAKVL.', E); end
if T < 0 || T > 1, error('T (%g) out of range in KAKVL.', T); end

kak_data= [ ...
  0.015, 1.17633E+01, -1.34217E-01, 8.85677E-01, 0.0000, 1.12853E+01, -5.03702E-01, 2.06684E+00, 0.0001; ...
  0.020, 9.50995E+00, -4.14115E-01, 6.19699E-01, 0.0090, 9.50995E+00, -4.14115E-01, 6.19699E-01, 0.0004; ...
  0.025, 5.34729E+00, -2.38246E-01, 8.36810E-01, 0.0002, 5.32116E+00, -1.73564E+00, 1.50332E+00, 0.0171; ...
  0.030, 3.30614E+00, -1.15885E-01, 7.36948E-01, 0.0059, 3.29709E+00, -1.42671E+00, 2.77163E+00, 0.0549; ...
  0.035, 2.17631E+00, -1.03827E-01, 3.20243E+00, 0.7036, 2.18041E+00, -1.21294E+00, 5.05980E+00, 0.0670; ...
  0.040, 1.52945E+00, -1.20160E-01, 3.09791E+00, 0.4352, 1.53013E+00, -5.07678E-01, 2.66323E+00, 0.1129; ...
  0.045, 1.12015E+00, -4.47244E-02, 7.46156E-01, 0.0775, 1.11324E+00, -4.65410E-01, 4.35891E+00, 0.8723; ...
  0.050, 8.49098E-01, -3.50687E-02, 4.70320E-01, 0.0131, 8.43768E-01, -2.08544E-01, 2.13787E+00, 0.0131; ...
  0.055, 6.57869E-01, -2.90042E-02, 4.52193E-01, 0.0502, 6.51233E-01, -1.80282E-01, 3.02043E+00, 1.6612; ...
  0.060, 5.16212E-01, -3.29972E-02, 1.67289E+00, 6.0382, 5.18569E-01, -1.00439E-01, 1.74804E+00, 0.2146; ...
  0.065, 4.18642E-01, -2.47927E-02, 8.47181E-01, 0.0000, 4.18992E-01, -6.24265E-02, 1.30914E+00, 0.2838; ...
  0.070, 3.47857E-01, -2.07794E-02, 3.53976E-01, 0.0015, 3.44520E-01, -4.29512E-02, 1.01129E+00, 0.2614; ...
  0.075, 2.89845E-01, -1.85416E-02, 3.65112E-01, 0.0015, 2.85896E-01, -3.54312E-02, 1.16484E+00, 0.1981; ...
  0.080, 2.44457E-01, -1.64625E-02, 3.78717E-01, 0.0021, 2.41339E-01, -2.74606E-02, 1.02199E+00, 0.2000; ...
  0.085, 2.08271E-01, -1.47266E-02, 3.89255E-01, 0.0030, 2.05821E-01, -2.16135E-02, 8.94837E-01, 0.1795; ...
  0.088, 1.89776E-01, -1.36119E-02, 4.22896E-01, 0.0161, 1.87505E-01, -1.95533E-02, 9.53233E-01, 0.1445; ...
  0.089, 2.14779E-01, 3.62803E-01, 2.81168E-01, 2.1291, 1.84312E-01, 3.56167E-01, 2.13962E-01, 3.0177; ...
  0.090, 2.10965E-01, 3.50870E-01, 2.58134E-01, 1.7524, 1.74093E-01, 3.51449E-01, 1.89643E-01, 2.7438; ...
  0.095, 1.66768E-01, 3.37581E-01, 1.62861E-01, 0.3171, 6.92092E-02, 4.08605E-01, 9.85324E-02, 2.2170; ...
  0.100, -5.70467E-04, 4.55381E-01, 6.91824E-02, 0.2501, -5.51428E+00, 5.94959E+00, 3.78136E-03, 2.7667; ...
  0.105, -4.71772E+00, 5.12602E+00, 3.04741E-03, 0.3405, -8.59998E+00, 9.00411E+00, 1.74954E-03, 6.5412; ...
  0.110, 1.41321E-02, 3.62338E-01, 2.94277E-02, 2.7160, 4.85351E-02, 3.12290E-01, 1.37629E-02, 3.3735; ...
  0.115, 8.11678E-03, 3.37934E-01, 1.68197E-02, 6.5023, 3.37038E-01, -1.56541E-01, 1.28629E+01, 0.4278; ...
  0.120, 3.16214E-01, -3.61610E-02, 3.05401E+00, 0.6196, 3.16073E-01, -1.01480E-01, 6.17966E+00, 1.9958; ...
  0.125, 2.98654E-01, -4.16152E-02, 1.76970E+00, 0.7246, 2.98059E-01, -7.81643E-02, 3.21266E+00, 2.9783; ...
  0.130, 2.81700E-01, -4.38207E-02, 1.24173E+00, 0.5589, 2.82326E-01, -6.05881E-02, 1.53607E+00, 0.6197; ...
  0.135, 2.66031E-01, -4.24681E-02, 8.25482E-01, 0.0340, 2.66010E-01, -5.30182E-02, 1.03209E+00, 0.1146; ...
  0.140, 2.48957E-01, -4.10319E-02, 7.25170E-01, 0.0266, 2.48499E-01, -4.86340E-02, 9.03917E-01, 0.1281; ...
  0.145, 2.31350E-01, -3.87409E-02, 7.31147E-01, 0.0274, 2.30970E-01, -4.47229E-02, 8.83316E-01, 0.1838; ...
  0.150, 2.14147E-01, -3.58901E-02, 7.95851E-01, 0.0226, 2.12649E-01, -4.18441E-02, 1.09587E+00, 0.0984; ...
  ];


logenergies = log(kak_data(:,1));
data = kak_data(:,2:end);
a = data(:,5);
b = data(:,6);
g = data(:,7);
loghvls = log(log((T.^-g + b./a) ./ (1 + b./a)) ./ a ./ g);
logvl = interp1q(logenergies, loghvls, log(E));
vl = 0.1 * exp(logvl);
end

function [g,E,Y,G] = erc (data, nuclide_str, cutoff)
%%ERC   Exposure rate constant.
%
%  Workhorse routine to produce the constants in a range of units, and if
%  required the energies and yields of the products.
%
%  
 
% constants
%IP = 33.97;  % J/C, or eV per ion pair in air
% 
% K_SI = 1.60217646e-13 * 1e6 / IP;   % SI units
% % convert MeV m2 / kg nt -> C m2 / kg MBq s
% % 1.60217646e-13  J/MeV   (J / kg nt)
% % 1/33.97 C/J             (C / kg nt)
% % 1e6 nt / MBq s
% 
% K_R = K_SI * 37 * 3600 * 1e4 / 2.58e-4;   % traditional units
% % convert MeV m2 / kg nt -> C m2 / kg MBq s -> R cm2 / mCi hr
% % 1/2.58e-4 kg R / C     (R m2 / MBq s)
% % 3600 s / hr            (R m2 / MBq hr)
% % 37 MBq / mCi           (R m2 / mCi hr)
% % 1e4 cm2 / m2           (R cm2 / mCi hr)
% 
% K_ICRP = K_SI * IP * 1e-6 * 1e18;   % ICRP units
% % convert MeV / kg nt -> C m2 / kg MBq s -> aGy m2 / Bq s
% % 33.97 J/C   (J m2 / kg MBq s)
% % 1 Gy kg / J (Gy m2 / MBq s)
% % 1e-6 MBq / Bq   (Gy m2 / Bq s)
% % 1e18 aGy /Gy
% 
% K_UT = K_SI * IP * 3600 * 1e3;  % Unger-Trubey units
% % convert MeV / kg nt -> C m2 / kg MBq s -> mSv m2 / MBq hr
% % 33.97 J/C               (J m2 / kg MBq s)
% % 3600 s / hr             (J m2 / kg MBq hr)
% % 1 Gy kg / J             (Gy m2 / MBq hr)
% % 1e3 mSv / Gy            (mSv m2 / MBq hr) 

u = units;

K_SI   = u.kg * u.MBq * u.s / (u.coul * u.m^2 * u.coul2Jair);
K_R    = u.mCi * u.hr       / (u.R * u.cm^2 * u.coul2Jair);
K_ICRP = u.Bq * u.s         / (1e18 * u.Gy * u.m^2);
K_UT   = u.MBq * u.hr       / (u.mSv * u.m^2);

if nargin < 3
  cutoff = 0.015 * u.MeV; % 15 keV cutoff by default
else
  cutoff = cutoff * u.MeV;
end

if cutoff < 0.010 * u.MeV
  error('Cutoff (%g keV) too low to give reliable results.', cutoff/u.keV);
end

if ischar(nuclide_str)
  nuclide = name2tag(data,nuclide_str);
  if ~nuclide
    error('Could not find %s.', nuclide_str);
  end
end

e = decay(data,nuclide);
valid = e.E >= cutoff & e.Y >= 1e-6/u.decay;
e.E = e.E(valid);
e.Y = e.Y(valid);

muen_over_rho = meac(e.E,'air');
fluence = e.Y .* e.E;  % units: MeV / nt

if isempty(fluence)
  g = 0;
else
  g = sum(fluence .* muen_over_rho) / 4 / pi;  % units: MeV m2 / kg nt (at 1 m)
end

G{1} = g * K_SI;
G{2} = g * K_R;
G{3} = g * K_UT;
G{4} = g * K_ICRP;
E = e.E;
Y = e.Y;



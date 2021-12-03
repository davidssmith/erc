function [Dfull,Dsimple] = dose_constant (data, nuclide)
%%DOSE_CONSTANT  Integrated dose constant in (mSv m2 / MBq h).
%
%  D = DOSE_CONSTANT(E,Y) returns the dose constant for energies E [MeV] and yields Y.
%

u = units;

% constants
%IP = 33.97 * u.J / u.coul;  % J/C, or eV per ion pair in air

% K_UT = K_SI * IP * 3600 * 1e3;  % Unger-Trubey units
% % convert MeV / kg nt -> C m2 / kg MBq s -> mSv m2 / MBq hr
% % 33.97 J/C               (J m2 / kg MBq s)
% % 3600 s / hr             (J m2 / kg MBq hr)
% % 1 Gy kg / J             (Gy m2 / MBq hr)
% % 1e3 mSv / Gy            (mSv m2 / MBq hr) 


[g, E, Y] = erc(data,nuclide);
fluence = Y .* E;  % units: MeV / nuclear transition

% calculate dose constant
cGytoRinAir = u.coul2Jair * u.R / u.cGy;
if ~isempty(E)
 %D = cGytoRinAir * sum(Y .* (fluence .* m /4/pi) .* meac(E,'tissue') ./ meac(E,'air')) / sum(Y);
 D = cGytoRinAir * sum(fluence .* meac(E,'tissue')) / 4 / pi;
else
  D = 0 * cGytoRinAir;
end

K_UT = (u.MBq * u.hr) / (u.mSv * u.m^2);
Dsimple = K_UT * g * ffactor(E,Y);
Dfull = K_UT * D;


%      C m2     3876 R   f-fac cGy   10 mSv   3600 s   mSv m2
%    -------- x ------ x --------- x ------ x ------ = ------
%    kg MBq s   C / kg      1 R       1 cGy    1 hr    MBq hr
% C m2 / kg MBq s  = mSv m2 / MBq hr
K = 3876*ffactor(E,Y)*10*3600;
5.94e-13*K



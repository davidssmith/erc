function f = ffactor (E, Y)
%%FFACTOR Mayneord f-factor
%
%  F = FFACTOR(E,Y) returns the Mayneord f-factor for energy E [MeV] and yield Y.
%
u = units;
cGytoRinAir = u.coul2Jair * u.R / u.cGy;
if ~isempty(E)
  f = cGytoRinAir * sum(Y .* meac(E,'tissue') ./ meac(E,'air')) / sum(Y);
else
  f = 0 * cGytoRinAir;
end
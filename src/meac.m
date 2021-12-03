function c = meac (energy, material)
%%MEAC  NIST mass-energy absorption coefficient for ICRU-44 dry air
%
%  C=MEAC(ENERGY,MATERIAL) returns mass-energy absorption coefficient C
%  given an ENERGY and MATERIAL.  Units are expected to be ???
%
%  20121024 :: dss :: persistent variables commented out because were
%  causing incorrect calculation of f-factor.

%persistent energies meacs lastMaterial lastEnergy lastc

if nargin < 2, material = 'air'; end

%if isempty(energies) || ~strcmp(material,lastMaterial)
%  fprintf('switching material to %s\n', material);
  switch material
    case 'air'
      load meac_data_air meacs energies;
    case 'water'
      load meac_data_water meacs energies;
    case 'tissue'
      load meac_data_tissue meacs energies;
    otherwise
      error('Unknown material %s', material);
  end
  energies = log(energies);
  %lastMaterial = material;
%end

%if all(size(energy) == size(lastEnergy)) && all(energy == lastEnergy)
%  c = lastc;
%  return;
%end
if nargin < 1
  c = [exp(energies) meacs];
  return;
end

u = units;
energy = energy / u.MeV;

if size(energy,1) == 1  % ensure we have a col vect for interp1q
  energy = energy';
  transposed = true;
else
  transposed = false;
end;

le = log(energy);

if any(le < energies(1)) || any(le > energies(end))
  error('MEAC> energy out of bounds: %g\n', exp(le));
end

c = interp1q(energies, meacs, le);

if transposed, c = c'; end  % return same as we received

c = c * u.cm^2/u.gm;
%c = c * 0.1;  % 1 cm2/g -> 1e-4 m2/ 1e-3 kg

%lastc = c;
%lastEnergy = energy;

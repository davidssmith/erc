function c = mac(energy, material)
%%MEAC NIST mass-energy absorption coefficient for ICRU-44 dry air
persistent energies macs lastMaterial

if nargin < 2, material = 'air'; end

if isempty(energies) || ~strcmp(material,lastMaterial)
  switch material
    case 'lead'
      load mac_data_pb energies macs;
    otherwise
      error('Unknown material %s', material);
  end
  energies = log(energies);
  lastMaterial = material;
end

if nargin < 1
  c = [exp(energies) macs];
  return;
end


if size(energy,1) == 1  % ensure we have a col vect for interp1q
  energy = energy';
  transposed = true;
else
  transposed = false;
end;

le = log(energy);

if any(le < energies(1)) || any(le > energies(end))
  error('MAC> energy out of bounds: %g', exp(le));
end

c = interp1q(energies, macs, le);

if transposed, c = c'; end  % return same as we received

%c = c * 0.1;  % 1 cm2/g -> 1e-4 m2/ 1e-3 kg
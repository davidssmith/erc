function v = vl (T, E, Y)
%%VL T-th value layer. 
%
%  V = VL (T,E,Y) returns the lead thickness required to attenuate photons
%  of energy E and yield Y by a factor T.
%

if numel(E) == 1 && numel(T) == 1  % monoenergetic is easy to solve
  
  if E < 0.015
    v = 0;
  elseif E > 0.15
    v = shimvl(T,E) * mfp_in_mm(E);
  elseif E >= 0.030
    v = 0.5*(kakvl(T,E) + shimvl(T,E) * mfp_in_mm(E));
  elseif E >= 0.015
    v = kakvl(T,E);
  else
    v = 0;
  end
  
else
  
  % a spectrum requires a numerical solver to find it
  X0 = 0;
  meacs = meac(E,'air');
  for k = 1:numel(E)
    X0 = X0 + Y(k) * E(k) * meacs(k);
  end
  YEM = Y .* E .* meacs;

  Emax = max(E);
  roughMFP = mfp_in_mm(Emax);
  v = zeros(1,numel(T));
  
  for t = 1:numel(T)
    S0 = -log(T(t)) * roughMFP;
    v(t) = fzero(@(s) miniexposure(E,s,YEM)/X0 - T(t), S0);
  end
  
end

function X = miniexposure(E,S,YEM)
X = 0;
for k = 1:numel(E)
  X = X + YEM(k) * atten(E(k), S);
end


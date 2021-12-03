%  Main example file of how to use these functions.  It will create a CSV
%  file that has the same data as Table 1 in Smith and Stabin, 2012, Health
%  Physics.
%
%  To verify that your system is working correctly, you can compare your
%  table1.csv to table1_reference.csv.

load icrp107;
cutoff = 15;  % keV
tableattens = [0.5 0.25 0.1 0.01 0.001];
f = fopen('table1.csv','w');
tic;
fprintf(f,'nuclide,gammaSI,gammaR,f,HVL,QVL,TVL,CVL,MVL\n');
for n = 1:1251
  nuclide = data{n}.name;
  fprintf('%d %s\n', n, nuclide);
  [g E Y] = erc(data,nuclide,cutoff);
  if numel(E) > 0
  v = vl(tableattens, E, Y);
  ff = ffactor(E,Y);
  else
    v = [0 0 0 0 0];
    ff = 0;
  end
  fprintf(f,'%s,%.2e,%.3g,%.3f,%.3g,%.3g,%.3g,%.3g,%.3g\n', nuclide, ...
    g(1), g(2), ff, v(1),v(2),v(3),v(4),v(5));
end
toc;
fclose(f);

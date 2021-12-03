
This code calculated exposure rate constants, Mayneord f-factors, and shielding thicknesses for
over 1100 nuclides in the ICRP-107 data.  This code was used to generate Table 1 in Smith and
Stabin 2012, 'Exposure Rate Constants and Lead Shielding Values for Over 1,100 Radionuclides',
Health Physics, 102(3): 271-291.

All of the ICRP-107 data has been recompiled into a MAT file called 'icrp107.mat' and included
with this source code.  

This code was written by David Smith <david.smith@vanderbilt.edu> with collaboration from Mike
Stabin <michael.g.stabin@vanderbilt.edu>.

To get a feel for how to use the code, start with 'create_table1.m'.  That script will use the
main subroutines to generate a CSV file called 'table1.csv' that contains the same data as Table 1
in Smith and Stabin 2012.  On my fastest machine, 'create_table1.m' takes the better part of an
hour, so be prepared to wait.  When you finish, the script 'check_results.m' will bring up a
Matlab diff viewer to see if you have any discrepancies in the output on your machine with our
reference table.

Thanks for downloading!



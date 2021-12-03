# Exposure Rate Constant and Lead Shielding Data

Welcome to the repo for the paper Exposure Rate Constants and Lead
Shielding Values for over 1100 Radionuclides by David Smith and Michael
Stabin, 2012, Health Phys., 102(3): 271-291. This site is intended to
provide a version-controlled repository for the data and codes used
to generate it, as well as to provide updates to the code, bug fixes,
and errata.

The Matlab source code used to generate the published and corrected
data is in `src/`.

The reference (correct) version of Table 1 is located in
`results/table1.csv`.

*Errata*: A few of the Mayneord f-factors in the published version of
Table 1 are incorrect. Due to a bug in the Matlab code, a few values
were incorrectly output as 0.876 instead of the correct value. If you
are interested in a nuclide and the f-factor is listed as 0.876, please
consult either
- `results/table1.csv`, or
- the corrected ArXiv version of the manuscript: [LINK]

*Note*: Our published exposure rate constants have been challenged
through private correspondence many times since publication, and to
date no errors have been found in our exposure rate constants, so we
believe these to be the best available values, within the limits of
the ICRP107 decay data.


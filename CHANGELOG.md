## v.0.2.4 Release notes

The following substances are added

- Hydrogen sulfide (H2S);
- n-Alkanes: C9 and from C11 to C20.

The physical properties of new components are stored `Data.martinez()`, but not all of them are actually from I.Martinez database (for new source see `data/src/polymer.sut.ac.ir.pdf`).

The EoS-related properties of new components are added for Brusilovsky' EoS. The pure components' parameters are added directly to `Data.brusilovsky_comp()`. Binary interaction parameters not found in literature are set to zero (this should be fixed later). As these zero parameters are not true, they are kept in a new database `Data.brusilovsky_mix_adjusted()`.

### Added

- `Data.brusilovsky_mix_adjusted()`.

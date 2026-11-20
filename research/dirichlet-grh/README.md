# Conditional polylogarithmic minor arcs

The current release theorem at X^(2/15+epsilon) is unchanged.

**Paper-level result.** [CONDITIONAL_PROOF.md](CONDITIONAL_PROOF.md) derives the all-center bound at H >= (log X)^J from standard Dirichlet GRH. J can depend on the requested logarithmic saving. This is asymptotic. The further claimed averaged consequences in that note are not fixed-shift results.

**Kernel-checked components of this draft.**
- [GRHZeroMass.lean](GRHZeroMass.lean) uses the explicit Mathlib Dirichlet right-half-plane premise to bound a finite weighted zero sum by the total multiplicity times X^(-1). This is the GRH weight step in the short-interval AP argument. It does not supply the analytic zero count/truncation.
- [PolylogConnector.lean](PolylogConnector.lean) states the literal polylogarithmic target in the public definitions, checks the near/far geometry and invokes the positive-integral restriction. Its analytic near/far premise remains an explicit premise. It also checks an exact GRH critical-strip zero-weight factorization. It **does not** prove the full analytic estimate in Lean.

No unverified prover axioms, foreign proof code, or release changes. The existing release targets remain untouched. The draft files are opt-in and can be checked at the root of this repo:

```sh
export MATHLIB_CACHE_DIR="$PWD/.cache/mathlib"
sh research/dirichlet-grh/check.sh --cache
```

Remove the flag for a replay using already materialized Mathlib dependencies. Axiom reporting for all audited declarations must contain only the three standard axioms listed in the original release's verification record. [LOCAL_CHECK.txt](LOCAL_CHECK.txt) records the precise local replay.

## The external import is not yet authorized as mathematical evidence

The 20 November [Alpöge release](https://alpo.ge/remark.pdf) exposes right-half-plane Dirichlet nonvanishing and full-strip Dirichlet GRH over Mathlib definitions, in addition to ordinary RH. It pins Lean v4.33.1 and a different Mathlib revision; this repo pins v4.35.0-rc2. Its compiled objects are not a drop-in import. The [independent verification status](https://github.com/Deicyde/riemann-hypothesis/blob/main/verification/NOTES.md#results) reported the full Comparator run in progress at review. That mirror notes the source is published without a reuse license. This branch does not redistribute it.

A later import requires a pinned independent kernel verification and allowed-axiom closure on the original statement, source reuse permission if the source is to be incorporated, and a single compatible Lean/Mathlib environment whose Mathlib-only challenge checks the exact same proposition. The candidate adapter must consume the exported theorem, not declare a new axiom. Independently, the AP explicit formula/truncation and far-window sharp Perron/MRT application still need formal Lean proofs before a full logarithmic-scale theorem can be certified by this repo.

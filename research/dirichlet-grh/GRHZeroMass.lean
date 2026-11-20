import Mathlib.NumberTheory.LSeries.DirichletContinuation
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.Linarith

/-!
The Dirichlet theorem discussed in the Alpöge release appears here only as a
canonical hypothesis. This module proves the finite equation-(2.7) weight
step, before supplying any analytic zero count or verifying the external
proof. The hypothesis is not an axiom.
-/

namespace MAPGRHResearch

open scoped BigOperators

/-- Canonical right-half-plane form over this repository's Mathlib. -/
def DirichletRightNonvanishing : Prop :=
  ∀ (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (s : ℂ),
    1 / 2 < s.re → (χ ≠ 1 ∨ s ≠ 1) → DirichletCharacter.LFunction χ s ≠ 0

/-- Each actual zero other than the pole point has real part at most one half. -/
theorem re_le_half_of_zero
    (grh : DirichletRightNonvanishing) {N : ℕ} [NeZero N]
    (χ : DirichletCharacter ℂ N) {s : ℂ} (hs : s ≠ 1)
    (hz : DirichletCharacter.LFunction χ s = 0) : s.re ≤ 1 / 2 :=
  le_of_not_gt (fun h => grh N χ s h (Or.inr hs) hz)

/-- Finite zero mass, allowing repeated zeros through their multiplicities.
This is the actual X^{-1} saving used in the conditional prime-in-AP step.
The caller must prove the support comes from the indicated L-function. -/
theorem weightedZeroMass_le
    (grh : DirichletRightNonvanishing) {N : ℕ} [NeZero N]
    (χ : DirichletCharacter ℂ N) {X : ℝ} (hX : 1 ≤ X)
    (zeros : Finset ℂ) (m : ℂ → ℕ)
    (hSupport : ∀ ρ ∈ zeros, ρ ≠ 1 ∧ DirichletCharacter.LFunction χ ρ = 0) :
    (∑ ρ ∈ zeros, (m ρ : ℝ) * X ^ (2 * (ρ.re - 1))) ≤
      (∑ ρ ∈ zeros, (m ρ : ℝ)) * X⁻¹ := by
  rw [Finset.sum_mul]
  apply Finset.sum_le_sum
  intro ρ hρ
  obtain ⟨hρ1, hρz⟩ := hSupport ρ hρ
  have hβ := re_le_half_of_zero grh χ hρ1 hρz
  have he : 2 * (ρ.re - 1) ≤ -1 := by linarith
  apply mul_le_mul_of_nonneg_left _ (Nat.cast_nonneg _)
  rw [← Real.rpow_neg_one]
  exact Real.rpow_le_rpow_of_exponent_le hX he

end MAPGRHResearch

#print axioms MAPGRHResearch.weightedZeroMass_le

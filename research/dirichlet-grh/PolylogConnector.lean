import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.NumberTheory.ArithmeticFunction.VonMangoldt
import Mathlib.NumberTheory.LSeries.DirichletContinuation
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace MinorArcsGRHStandalone

open MeasureTheory Metric Set
open scoped BigOperators ArithmeticFunction

noncomputable section

def primeExponentialSum (X : ℝ) (alpha : UnitAddCircle) : ℂ :=
  ∑ n ∈ Finset.Ioc ⌊X⌋₊ ⌊2 * X⌋₊,
    (ArithmeticFunction.vonMangoldt n : ℂ) * fourier (n : ℤ) alpha

def majorArcs (X : ℝ) (B D : ℕ) : Set UnitAddCircle :=
  {alpha | ∃ q a : ℕ,
    1 ≤ q ∧
    (q : ℝ) ≤ (Real.log X) ^ B ∧
    a < q ∧
    a.Coprime q ∧
    dist alpha ((↑((a : ℝ) / (q : ℝ)) : UnitAddCircle)) ≤
      (Real.log X) ^ D / X}

def minorArcs (X : ℝ) (B D : ℕ) : Set UnitAddCircle :=
  (majorArcs X B D)ᶜ

def centeredArc (H : ℝ) (center : UnitAddCircle) : Set UnitAddCircle :=
  closedBall center ((2 * H)⁻¹)

theorem primeExponentialSum_continuous (X : ℝ) :
    Continuous (primeExponentialSum X) := by
  unfold primeExponentialSum
  fun_prop

theorem normSq_primeExponentialSum_integrable (X : ℝ) :
    Integrable (fun a : UnitAddCircle ↦ ‖primeExponentialSum X a‖ ^ 2)
        (@AddCircle.haarAddCircle 1 ⟨Real.zero_lt_one⟩) :=
  ((primeExponentialSum_continuous X).norm.pow 2).integrable_of_hasCompactSupport
    (HasCompactSupport.of_support_subset_isCompact isCompact_univ
      (Set.subset_univ _))

def collar (X H k : ℝ) (B K : ℕ) : Set UnitAddCircle :=
  {alpha | ∃ q a : ℕ,
    1 ≤ q ∧ (q : ℝ) ≤ (Real.log X) ^ B ∧ a < q ∧ a.Coprime q ∧
    dist alpha ((↑((a : ℝ) / (q : ℝ)) : UnitAddCircle)) ≤
      k * (Real.log X) ^ K / H}

/-- Increasing the aperture parameter shrinks the centered closed arc. -/
theorem centeredArc_anti_aperture
    {H₀ H : ℝ} (hH₀ : 0 < H₀) (hH : H₀ ≤ H)
    (center : UnitAddCircle) :
    centeredArc H center ⊆ centeredArc H₀ center := by
  have hHpos : 0 < H := hH₀.trans_le hH
  have hrad : (2 * H)⁻¹ ≤ (2 * H₀)⁻¹ := by
    exact (inv_le_inv₀ (mul_pos (by norm_num) hHpos)
      (mul_pos (by norm_num) hH₀)).2 (by nlinarith)
  intro a ha
  rw [centeredArc, Metric.mem_closedBall] at ha ⊢
  exact ha.trans hrad

theorem canonicalArc_subset_outer
    {X H : ℝ} {B K : ℕ} (hH : 0 < H) (hlog : 1 ≤ Real.log X)
    {center : UnitAddCircle} (hcenter : center ∈ collar X H 2 B K) :
    centeredArc H center ⊆ collar X H 4 B K := by
  rintro alpha halpha
  rcases hcenter with ⟨q, a, hq, hqcap, ha, hacop, hdistCenter⟩
  refine ⟨q, a, hq, hqcap, ha, hacop, ?_⟩
  have hR : 1 ≤ (Real.log X) ^ K := one_le_pow₀ hlog
  have halphaDist : dist alpha center ≤ (2 * H)⁻¹ := by
    simpa [centeredArc] using halpha
  have hhalf : (2 * H)⁻¹ ≤ 2 * (Real.log X) ^ K / H := by
    have hinv : 0 < H⁻¹ := inv_pos.mpr hH
    rw [mul_inv_rev]
    norm_num
    have h : (1 / 2 : ℝ) ≤ 2 * (Real.log X) ^ K := by linarith
    simpa [div_eq_mul_inv, mul_comm, mul_left_comm, mul_assoc] using
      (mul_le_mul_of_nonneg_right h hinv.le)
  calc
    dist alpha ((↑((a : ℝ) / (q : ℝ)) : UnitAddCircle)) ≤
        dist alpha center +
          dist center ((↑((a : ℝ) / (q : ℝ)) : UnitAddCircle)) :=
      dist_triangle _ _ _
    _ ≤ (2 * H)⁻¹ + 2 * (Real.log X) ^ K / H :=
      add_le_add halphaDist hdistCenter
    _ ≤ 2 * (Real.log X) ^ K / H + 2 * (Real.log X) ^ K / H :=
      add_le_add hhalf le_rfl
    _ = 4 * (Real.log X) ^ K / H := by ring

/-- Genuine polylogarithmic aperture. Its exponent J is fixed before X, H
and the center, and may depend on the requested saving A. -/
def PolylogPublicMAP : Prop :=
  ∀ A : ℝ, 0 < A →
    ∃ B D J : ℕ, 1 ≤ B ∧ 1 ≤ D ∧ 1 ≤ J ∧
      ∃ C X₀ : ℝ, 0 < C ∧ 2 ≤ X₀ ∧
        ∀ X H : ℝ, X₀ ≤ X → (Real.log X) ^ J ≤ H →
          ∀ center : UnitAddCircle,
            (∫ alpha in centeredArc H center ∩
                minorArcs X B D,
              ‖primeExponentialSum X alpha‖ ^ 2
                ∂(@AddCircle.haarAddCircle 1 ⟨Real.zero_lt_one⟩)) ≤
              C * X * Real.rpow (Real.log X) (-A)

/-- Exact remaining analytic source at the polylogarithmic aperture:
global collar bound, and local full-arc bound outside the inner collar.
In particular the far inequality is not claimed here on GRH alone. -/
def PolylogAnalyticNearFar : Prop :=
  ∀ A : ℝ, 0 < A →
    ∃ B D J K : ℕ, 1 ≤ B ∧ 1 ≤ D ∧ 1 ≤ J ∧
      ∃ C X₀ : ℝ, 0 < C ∧ 2 ≤ X₀ ∧
        ∀ X : ℝ, X₀ ≤ X →
          1 ≤ Real.log X ∧
          (∫ alpha in collar X ((Real.log X) ^ J) 4 B K ∩
              minorArcs X B D,
            ‖primeExponentialSum X alpha‖ ^ 2
              ∂(@AddCircle.haarAddCircle 1 ⟨Real.zero_lt_one⟩)) ≤
            C * X * Real.rpow (Real.log X) (-A) ∧
          ∀ center : UnitAddCircle,
            center ∉ collar X ((Real.log X) ^ J) 2 B K →
            (∫ alpha in centeredArc ((Real.log X) ^ J) center,
              ‖primeExponentialSum X alpha‖ ^ 2
                ∂(@AddCircle.haarAddCircle 1 ⟨Real.zero_lt_one⟩)) ≤
              C * X * Real.rpow (Real.log X) (-A)

theorem polylogPublicMAP_of_nearFar (hNF : PolylogAnalyticNearFar) :
    PolylogPublicMAP := by
  intro A hA
  obtain ⟨B, D, J, K, hB, hD, hJ, C, X₀, hC, hX₀, hest⟩ := hNF A hA
  refine ⟨B, D, J, hB, hD, hJ, C, X₀, hC, hX₀, ?_⟩
  intro X H hXX₀ hH center
  obtain ⟨hlog, hnear, hfar⟩ := hest X hXX₀
  have hH₀ : 0 < (Real.log X) ^ J := pow_pos (zero_lt_one.trans_le hlog) _
  have hsmall : centeredArc H center ⊆
      centeredArc ((Real.log X) ^ J) center :=
    centeredArc_anti_aperture hH₀ hH center
  let f : UnitAddCircle → ℝ := fun alpha ↦ ‖primeExponentialSum X alpha‖ ^ 2
  have hf : Integrable f (@AddCircle.haarAddCircle 1 ⟨Real.zero_lt_one⟩) :=
    normSq_primeExponentialSum_integrable X
  by_cases hcenter : center ∈ collar X ((Real.log X) ^ J) 2 B K
  · have hsubset : centeredArc H center ∩ minorArcs X B D ⊆
        collar X ((Real.log X) ^ J) 4 B K ∩ minorArcs X B D :=
      Set.inter_subset_inter (hsmall.trans (canonicalArc_subset_outer hH₀ hlog hcenter))
        Set.Subset.rfl
    exact (MeasureTheory.setIntegral_mono_set hf.integrableOn
      (Filter.Eventually.of_forall (fun _ ↦ sq_nonneg _))
      (Filter.Eventually.of_forall hsubset)).trans hnear
  · have hsubset : centeredArc H center ∩ minorArcs X B D ⊆
        centeredArc ((Real.log X) ^ J) center :=
      Set.inter_subset_left.trans hsmall
    exact (MeasureTheory.setIntegral_mono_set hf.integrableOn
      (Filter.Eventually.of_forall (fun _ ↦ sq_nonneg _))
      (Filter.Eventually.of_forall hsubset)).trans (hfar center hcenter)

/-- GRH stated just for primitive Dirichlet L-functions (including zeta at
conductor one) on the nontrivial open strip. -/
def PrimitiveDirichletGRH : Prop :=
  ∀ (q : ℕ) [NeZero q] (chi : DirichletCharacter ℂ q),
    chi.IsPrimitive → ∀ z : ℂ, 0 < z.re → z.re < 1 →
      DirichletCharacter.LFunction chi z = 0 → z.re = 1 / 2

/-- No GRH-to-branch estimate is asserted: the second hypothesis is the exact
analytic work needed to make the conditional quantitative conclusion. -/
theorem polylogPublicMAP_of_GRH_source
    (hGRH : PrimitiveDirichletGRH) (hsource : PrimitiveDirichletGRH → PolylogAnalyticNearFar) :
    PolylogPublicMAP :=
  polylogPublicMAP_of_nearFar (hsource hGRH)

end
end MinorArcsGRHStandalone

#print axioms MinorArcsGRHStandalone.polylogPublicMAP_of_nearFar

namespace MinorArcsGRHStandalone

open scoped BigOperators
noncomputable section

/-- GRH removes the real-part growth from any finite weighted collection of
primitive critical-strip zeros. It does not bound the sum of the weights. -/
theorem GRH_square_weight_factor
    (hGRH : PrimitiveDirichletGRH)
    {q : ℕ} [NeZero q] (chi : DirichletCharacter ℂ q) (hprim : chi.IsPrimitive)
    (Z : Finset ℂ) (X : ℝ) (weight : ℂ → ℝ)
    (hz : ∀ z ∈ Z,
      0 < z.re ∧ z.re < 1 ∧ DirichletCharacter.LFunction chi z = 0) :
    (∑ z ∈ Z, weight z * Real.rpow X (2 * z.re)) =
      X * ∑ z ∈ Z, weight z := by
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro z hzZ
  obtain ⟨hpos, hlt, hzero⟩ := hz z hzZ
  rw [hGRH q chi hprim z hpos hlt hzero]
  norm_num [mul_comm]

end
end MinorArcsGRHStandalone

#print axioms MinorArcsGRHStandalone.GRH_square_weight_factor

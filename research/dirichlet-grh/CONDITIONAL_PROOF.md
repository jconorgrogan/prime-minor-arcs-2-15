# Dirichlet GRH gives a polylogarithmic all-center minor-arc scale

This conditional supplement uses GRH for primitive Dirichlet L-functions (including the Riemann zeta function) and two ingredients used in [Prime Pairs at the Prime Number Theorem Threshold](https://github.com/jconorgrogan/prime-minor-arcs-2-15/blob/main/paper/prime-pairs-pnt-threshold.tex): its signed-measure Gallagher bound and [MRT Corollary 5.3](https://www.math.mcgill.ca/radziwill/correlations.pdf). No hypothesis on nonabelian number fields is used. This supplement is not machine-verified and leaves the repository’s unconditional result unchanged. The far case uses GRH directly rather than a Heath–Brown decomposition.

**Theorem (conditional all-center minor-arc bound).** Assume Dirichlet GRH. Write $L=\log X$, $e(v)=\exp(2\pi i v)$, and $S_X(\alpha)=\sum_{X<n\le 2X}\Lambda(n)e(n\alpha)$. For each $A>0$ there are positive integers $B,D,J$ and constants $C,X_0$ such that, for $X\ge X_0$, $Q=L^B$, $P=L^D$ and every real $H\ge L^J$,
$$
\sup_{|I|=1/H}\int_{I\setminus\mathfrak M(P,Q)} |S_X(\alpha)|^2\,d\alpha \le CXL^{-A}.
$$
The supremum is over arcs of the unit circle, and $\mathfrak M(P,Q)$ consists of the arcs of radius $P/X$ about reduced $a/q$ with $q\le Q$. All parameters are chosen before $X,H$ or the center of $I$.

## Near rational centers

Write L=log X, Q=L^B. For the manuscript's simultaneous short-interval progression mean square, choose T=X/L^C0, C0>A_AP+2B+3. All nontrivial zeros have β=1/2, so
```
Z = sum_{q≤Q,χ mod q, |γ|≤T} X^(2(β−1)) ≪ L^(2B+1−C0).
```
For each primitive inducing character, use a height in [T,T+1] separated from its zero ordinates by a constant times 1/L, or the standard all-T symmetric truncated explicit formula. The elementary sharp-endpoint term bounded by O(L) is smaller than the O(XL²/T) truncation error. Thus dividing differences of the explicit formula by lengths Y≥L^J0 costs O(L^(C0+2−J0)), including induced-character corrections O(log(q) log X) before division. The half-value convention at integer endpoints changes these differences by at most O(L). For clarity, set Fχ(u) equal to the sum of u^(ρ−1) over the retained zeros on [X/4,6X], and zero outside. Direct integration of two terms is bounded by X^(β+β′−1)/(1+|γ−γ′|). The unit-interval zero count O(L), then a harmonic sum in ordinate differences and 2ab≤a²+b², yield Σχ ||Fχ||₂² ≪ XL²Z, where the character sum includes q≤Q. A difference of the two explicit formulas divided by Y is bounded by the one-sided maximal average of |Fχ| plus the stated truncation error, uniformly for x in [X/2,4X] and Y in [L^J0,X]. Expand the reduced residue indicator in characters and apply Cauchy before taking the supremum over Y and a. Sum over moduli to majorize the maximum over q; each modulus costs just one copy of the squared explicit-formula error. The L² maximal inequality now yields the simultaneous mean square
```
≪ X L^(2B+3−C0) + X L^(B+2C0+4−2J0).
```
Choose 2J0 > A_AP+B+2C0+4, to obtain any prescribed saving A_AP at every y≥L^J0. A classical comparison for one-point variance is [Goldston–Yıldırım, *Primes in Short Segments of Arithmetic Progressions*](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/2A642B29431D84EB19FB1FD635998E51/S0008414X00019465a.pdf/primes-in-short-segments-of-arithmetic-progressions.pdf).

Let H*=L^J, R=L^C1 where C1>A+10, y=H*/(32R), and choose J>C1+J0 so that y≥L^J0 eventually. For each reduced a/q, apply the signed-measure Gallagher inequality to the exponential-weighted prime measure on (X,2X] minus μ(q)/φ(q) times Lebesgue measure on the same interval. The inequality follows from Plancherel for the measure convolved with an interval indicator of length y, whose Fourier multiplier has magnitude ≫y for frequencies |β|≤1/(8y). In the interior, split into at most q reduced residue classes and apply Cauchy, using Σ_(a,q)=1 e(a/q)=μ(q). Squared interior errors divided by y² therefore cost at most q² times the progression variance, with a bound uniform in the reduced numerator. Endpoints have measure O(y) and normalized error O(L); prime powers on primes dividing q contribute at most O(L²) in every window, and their squared counting function has integral O(y L⁴) by nonnegativity and Fubini. Sum over all reduced rationals. The continuous main term outside the deleted radius P/X contributes at most O(X/P) per rational, by integration of |β|⁻². This gives the four terms of (3.2) of the original manuscript: ```
X Q^4 L^(−A_AP),  Q² y L²,  Q² L^4/y,  X Q²/L^D.
```
Take A_AP>A+4B, D>A+2B, and J>C1+J0. The two non-X terms are fixed powers of L or reciprocals of them, hence negligible compared with XL^(−A). This uniformly covers neighborhoods |α−a/q|≤4R/H* for coprime a,q with q≤Q.

## Far case: short proof directly from Dirichlet GRH

We need the GRH bound, for q≤Q and |t|≤X²/2,
```
|Σ_{X<n≤2X} Λ(n) χ(n) n^(−1/2−it)|
 ≪ L³ + 1_{χ principal} √X/(1+|t|).
```
For a primitive inducing character, use truncated Perron for F(s)=−L'/L(1/2+it+s,χ), with c=1 initially, height X², and each sharp endpoint replaced by floor(endpoint)+1/2. This gives identical integer supports. For a half-integer endpoint u≈X and height V=X², the truncated-Perron kernel error at n is bounded by (u/n) min(1,1/[V|log(u/n)|]). Multiply by Λ(n)n^(−1/2). For n outside [u/2,2u] sum by absolute convergence of ΣΛ(n)n^(−3/2); for n within [u/2,2u], use |log(u/n)|≫|u−n|/X and the harmonic sum over half-integer distances. The resulting error is O(X/V + √X L²/V), uniformly in t and in the character. Shift the line to ε=1/log X. No zero is crossed, because zeros have real part 1/2 in the L variable. Only the principal pole at s=1/2−it contributes, combining the two endpoint residues to ≪√X/(1+|t|). On the new vertical line the standard local log-derivative formula and elementary unit-interval zero count give F(s)≪L²: zeros are at least ε distant horizontally, and the pole is bounded away from this line. On horizontal sides the same estimate holds, since their L-variable height is ≫X² and the same horizontal zero margin applies. The horizontal integrals are O(XL²/X²), and integrating 1/|ε+iu| along the vertical line costs O(L). For an imprimitive character, only prime powers based on primes dividing q are corrected, with a negligible contribution at n≈X. The local log-derivative estimate follows by summing over the O(L) zeros within distance one in ordinate and bounding the analytic remainder by O(L), with the principal pole kept separately near height zero. The strip used is 1/2+1/log X ≤ Re ≤ 3/2. For this estimate, the zero count and the truncated explicit formula, see [Koukoulopoulos, *The Distribution of Prime Numbers*, Chapter 11](https://dms.umontreal.ca/~koukoulo/documents/publications/primes.pdf), especially Theorem 11.3 and Lemma 11.4. The conductor-one pole is dealt with explicitly above.

Use rational approximation to the interval center γ=a/q+λ with q≤Q and |λ|≤1/(qQ). If |λ|≤2R/H*, the arc lies in the near region already treated. Otherwise U=|λ|H*>2R and apply MRT Corollary 5.3 to the local integral, using η=Q^(−1/2). Its t-range has size O(Q^(1/2)|λ|X); every t in that range, even after perturbation by at most U, has |t|≫X/L^O(1)≫√X, since H* and Q are fixed powers of L. The upper t bound is O(X) by rational approximation, well inside the Perron range. The hypotheses 1≤H*≤X and |λ|≪η≪1 hold; |λ|≤1/(qQ)≤η². Thus each shifted Dirichlet polynomial is O(L³). The q0>1 pieces in the same corollary are negligible: q0n can only be a power of a prime dividing q0, giving at most two terms in a dyadic range, each at most sqrt(q0/X) log(2X).

MRT’s Dirichlet polynomial is Σₙ f(q₀n)χ(n)n^(−s). The square of the character sum (at most q characters), with integration over an interval of length 2U, is O(q²U²L⁶). By (68) of MRT, the outer region has length at most 2Q^(1/2)|λ|X. The coefficient multiplying this integral in Corollary 5.3 is exactly d₂(q)^4/(qU²), not d₂(q)^4/U². Its main estimate is therefore
```
≪ d_2(q)^4/(q U²) · (Q^(1/2)|λ| X) · q² U² L^6
≪ X Q^(−1/2) d_2(q)^4 L^6.
```
For q≤Q and any fixed δ1>0, d_2(q)^4≪_δ1 q^δ1; choose δ1=1/8, so taking B sufficiently large saves L^A. The error term uses trivial |Λ|≤O(L), giving ≪XL²(Q^(−1/2)+U^(−1))², also adequate. This closes the far case, without factoring the polynomial into convolution types. For all H≥H*, containment in an arc of length at most a fixed multiple of 1/H* completes the claim, after harmless constants in the near parameters.

## Scope

This is a conditional strengthening of the existing all-center estimate. It does not assert a new best conditional result in the literature. In particular, the discussion of GRH in MRT already anticipates a stronger range. The argument concerns windows growing with X; it gives no fixed-shift result and does not settle the twin-prime or pointwise binary Goldbach conjectures.

## Downstream at logarithmic widths: avoid the divisor-moment trap

The manuscript's generic uniform short-interval mean-value bound for powers of the divisor function does not automatically extend to polylogarithmic block lengths. In the major-arc calculation, use the exact singular-series coefficients instead.

For a nonzero integer n, write the absolute coefficient A_q(n) = μ²(q)|c_q(n)|/φ(q)². On a squarefree q, split q=de with d|n and e coprime to n, by assigning each prime factor to the appropriate block. The absolute Ramanujan coefficient is exactly
```
A_q(n) = 1/φ(d) · 1/φ(e)^2.
```
Consequently the total absolute sum of all coefficients is at most a universal constant times |n|/φ(|n|) ≪ log log(3+|n|). The tail q>Q is bounded by the part with e>sqrt(Q) and the part with d>sqrt(Q). The first part is uniformly O(Q^(−1/4) log log X) for |n|≤4X: use φ(e)≫e^(3/4) and sum e^(−3/2). For the second part, normalize the weights 1/φ(d) over squarefree d|n. Such random d selects each prime p|n independently with probability 1/p. The chance it selects any p>sqrt(Q) is ≪ log X/sqrt(Q), since there are at most O(log X) distinct prime factors. If d>sqrt(Q) and all selected primes are ≤sqrt(Q), greedily multiply selected primes until crossing sqrt(Q); one obtains b|d with sqrt(Q)<b≤Q. By a union bound, the chance of this case is at most
```
Σ_{sqrt(Q)<b≤Q} (1/b) 1_{b|n}.
```
On any integer interval of length H≥Q the average of 1_{b|n} is at most 2/b, so this chance averages O(Q^(−1/2)). Removing n=0 if relevant does not worsen the bound (zero shifts are already excluded from the prime-pair theorem). Thus for |n|≤4X the average absolute tail is O(Q^(−1/4) log log X + Q^(−1/2) log X log log X), with absolute implied constants. Since the absolute series itself is bounded pointwise by O(log log X), the average squared tail also has any requested log saving when B is large. H≥Q can be enforced by enlarging J.

Use the effective GRH AP estimate and partial summation for the local rational major-arc approximation. For q≤Q and |β|≤(log X)^D/X it gives error O(sqrt(X) times a fixed log power), including the discrepancy at prime powers with prime dividing q. Across all arcs this is negligible relative to X log^(−A) X in the correlation coefficient. Extending the β integral to the line costs O(X/(log X)^D) times the full bounded absolute series because each continuous exponential integral is O(min(X,1/|β|)). Replacing the truncated series by the full one now uses the preceding block-mean-square tail, not a divisor moment. For completeness, for any frequency block of O(H) consecutive integers the Fejér kernel bounds the sum of squares of Fourier coefficients of a complex measure ν by O(H) times its total mass in variation times the largest mass in variation of an arc of length 1/H. For translated prime pairs and balanced Goldbach, use ν=1_minor |S_X|² dα or ν=1_minor S_X² dα, respectively. The total mass is O(XL) by Parseval and the largest local mass is O(XL^(−K)) by the theorem with saving K. The minor-arc square error is O(HX²L^(1−K)). The continuous overlaps are X−|h| and min(N−2X,4X−N), respectively. For shifts |h|=O(X^(1−ε)), the pointwise endpoint error for the unrestricted shifted sum is O((|h|+1)L²), negligible in the variance.

For ordinary Goldbach write N=X+h, with 0≤h≤H≤X^(1−ε). Up to O((h+1)L²), its weighted count is twice the asymmetric convolution of Λ on (X/2,X] and on [1,X). The error counts terms with both summands above X/2 or a summand at least X. The continuous overlap for this asymmetric convolution is exactly X/2. Apply the local theorem at scale X/2 to the first Fourier factor and use Parseval globally for the second; enlarge the common deleted arcs if needed to contain those from scale X/2. Cauchy gives O(XL^((1−K)/2)) for the local mass of the product; the Fejér square error is O(HX²L^((3−K)/2)). Combined with the major-arc block mean square just proved and Chebyshev, these give the original manuscript’s translated prime-pair variance and almost-all Goldbach conclusions with lower cutoff H≥L^J and the same upper cutoff H≤X^(1−ε). The replacement X by N in the Goldbach main term costs O(H log log X); discarding proper prime powers costs O(√X L³), uniformly. No step gives a fixed shift or a pointwise singular-series estimate.


## Attribution and publication checks

- K. Matomäki, M. Radziwiłł and T. Tao, *Correlations of the von Mangoldt and higher divisor functions I: Long shift ranges*, [author-hosted manuscript](https://www.math.mcgill.ca/radziwill/correlations.pdf), equation (68) and Corollary 5.3. These are mathematical inputs, not bundled material.
- D. Koukoulopoulos, *The Distribution of Prime Numbers*, [author-hosted book](https://dms.umontreal.ca/~koukoulo/documents/publications/primes.pdf), Chapter 11, especially Theorem 11.3 and Lemma 11.4; see also the explicit-formula discussion in Chapter 12.
- The source manuscript in this repository supplies the transfer to correlations. This supplement is newly written prose and mathematics, without vendored source, code, theorem prover artifacts, or copied figures. No license for third-party software or mathematical text is asserted or needed to reproduce this supplement. Keep the repository’s existing licensing unchanged. Cite the mathematical inputs rather than importing upstream files.

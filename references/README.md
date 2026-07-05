# Annotated Bibliography

This reference library supports the SymbolicLongMemorySequences.jl paper and package documentation. The
BibTeX database is `s5_references.bib`. Downloaded PDFs are not stored in this
public repository; their private locations and match status are recorded in
`../DOWNLOAD.mn`.

An online PaperFetch check was run in check-only mode, without downloading
references. Clear DOI/title/author matches were used to correct stale metadata
in `s5_references.bib`, including the Li--Marr--Kaneko, Lowen--Teich,
Carpio--Daley, Montemurro--Pury, Provata--Beck, Buldyrev chapter, Thurner et
al., and Sorbye--Myrvoll-Nilsen--Rue entries. Low-confidence provider failures
for books, older proceedings, or local alternative versions are retained as
audit items rather than silently rewritten.

## Long-Range Dependence And Self-Similarity

Samorodnitsky's survey `samorodnitsky2006_long`, Pipiras and Taqqu's book
`pipiras2017_long`, Beran's monograph `beran1994_statistics`, and the empirical
estimator study of Taqqu, Teverovsky, and Willinger `taqqu1995_estimators`
provide the general definitions used by SymbolicLongMemorySequences.jl. They separate covariance decay,
spectral behavior, self-similarity, heavy tails, and finite-sample estimation
risk. The package follows this distinction by describing generator claims as
exact, asymptotic, latent, nominal, or empirical rather than treating a finite
simulation as proof of LRD.

Leland et al. `leland1994_on` and Willinger, Paxson, and Taqqu
`willinger1998_self` are the core network-traffic references that made
self-similar traffic a practical modeling problem. They motivate the package's
emphasis on synthetic sequences that preserve large-scale structure, not merely
short-range counts or Markov transitions.

Witt and Malamud `witt2013_quantification` and Malamud and Turcotte
`malamud1999_self` are useful cautionary surveys. They emphasize finite records,
trends, nonstationarity, and diagnostic choices. Their role in SymbolicLongMemorySequences.jl is
methodological: validation plots are evidence about finite generators, not
claims that an estimator has recovered a true asymptotic parameter.

## Numerical LRD Synthesis

Paxson `paxson1997_fast` is the direct source for the approximate spectral fGn
idea used in PB1 and in the default latent source for PB2 and PB3. Dieker
`dieker2004_simulation`, Coeurjolly `coeurjolly2000_simulation`, Wood and Chan
`wood1994_simulation`, Dietrich and Newsam `dietrich1997_fast`, and Craigmile
`craigmile2000_simulating` document exact and approximate Gaussian simulation
alternatives. In SymbolicLongMemorySequences.jl these remain upgrade paths: the current design favors
fast reproducible synthesis, while the API keeps the numerical latent source
separate from the symbolic transformation.

Sorbye, Myrvoll-Nilsen, and Rue `sorbye2017_an` show how sums of short-memory
components can approximate fGn at linear cost. This is not yet a generator in
SymbolicLongMemorySequences.jl, but it is relevant to future scalable latent sources and to interpreting
finite-range approximations.

Roughan, Veitch, and Abry `roughan2000_real` provide the wavelet/multiscale
background behind PB3. SymbolicLongMemorySequences.jl modifies the idea by using a latent multiscale
driver to select Markov regimes, so short-range structure is carried by
transition matrices while long-range persistence is inherited from the driver.

## Point-Process And Heavy-Tailed Generators

Garrett and Willinger `garrett1994_analysis`, Lowen and Teich
`lowen1995_estimation`, Thurner et al. `thurner1997_analysis`, and Ryu and
Lowen `ryu1998_point` motivate heavy-tailed on/off and fractal point-process
mechanisms. SymbolicLongMemorySequences.jl adapts this line in two ways: MB2 uses heavy-tailed regime
sojourns to drive a Markov chain, and MB3 assigns each symbol a heavy-tailed
renewal-like stream before merging events into a single symbolic sequence.

Roughan, Yates, and Veitch `roughan1999_the` is the warning reference for these
methods. It shows that naive fractal renewal simulation can lose the expected
scale range. SymbolicLongMemorySequences.jl therefore treats the FSS and on/off diagnostics as empirical
finite-sample evidence and marks scale limits in validation plots.

## Symbolic, Text, And DNA Applications

Voss `voss1992_evolution` is especially important because it avoids arbitrary
numeric DNA encodings by decomposing each base into a binary indicator sequence.
SymbolicLongMemorySequences.jl's centered one-hot diagnostics follow the same philosophy: transform a
symbol sequence into symbol-level indicator processes before computing
autocorrelation and spectral summaries.

Peng et al. `peng1992_long`, Li and Kaneko `li1992_long`, Li, Marr, and Kaneko
`li1994_understanding`, Buldyrev et al. `buldyrev1998_analysis`, and Buldyrev
`buldyrev2006_power` document long-correlation questions in nucleotide
sequences. They motivate DNA-like use cases and the copy/mutation family, while
also showing how sensitive conclusions can be to preprocessing and region
selection.

Schenkel, Zhang, and Zhang `schenkel1993_long`, Ebeling and Poschel
`ebeling1994_entropy`, Montemurro and Pury `montemurro2002_long`,
Alvarez-Lacalle et al. `alvarez2006_hierarchical`, Altmann et al.
`altmann2009_beyond`, Altmann, Cristadoro, and Degli Esposti
`altmann2012_on`, Tanaka-Ishii and Bunde `tanaka2016_long`, Debowski
`debowski2015_hilberg`, and Wieczynski and Debowski `wieczynski2025_long`
provide the text-side context. They suggest that symbolic LRD can arise from
hierarchy, rare-word clustering, topic persistence, and semantic similarity.
SymbolicLongMemorySequences.jl does not fit text models, but it provides controlled synthetic sequences
for testing estimators and learning systems against these kinds of large-scale
effects.

Belletti et al. `belletti2018_factorized` and Belletti, Chen, and Chi
`belletti2019_quantifying` motivate machine-learning stress tests for long-range
dependence. Tay et al. `tay2021_long` is a benchmark reference for long-context
sequence modeling, though SymbolicLongMemorySequences.jl focuses on scientific synthetic data rather than
neural architecture benchmarking alone.

## SymbolicLongMemorySequences.jl Generator Models

PB1, PB2, PB3, and PB4 share a property-based pattern: generate one or more
numerical LRD or multiscale latent series, then transform them into symbols.
PB1 uses Paxson-style fGn plus rank quantization. PB2 uses independent fGn
streams and an argmax transform adapted from latent Gaussian categorical models
`gal2015_latent`. PB3 uses the same split, but the latent driver selects among
Markov regimes. PB4 uses an intermittent-map driver motivated by Provata and
Beck `provata2012_coupled`, then quantizes the trajectory.

MB1a and MB1b are based on LAMP `kumar2017_linear`, with SymbolicLongMemorySequences.jl adding explicit
finite-history and dyadic-bucket implementations for long symbolic sequences.
MB1c follows additive Markov-chain memory-function work by Melnyk et al.
`melnyk2006_memory`, Mayzelis et al. `mayzelis2006_additive`, and Melnik and
Usatenko `melnik2014_entropy`; SymbolicLongMemorySequences.jl implements a centered finite-state memory
function rather than a full inverse-correlation calibration pipeline.

MB2 adapts heavy-tailed source and on/off traffic models
`garrett1994_analysis`, `ryu1998_point` to finite alphabets by using
Pareto-like regime durations with ordinary Markov transitions inside regimes.
MB3 adapts fractal point processes by treating symbols as competing renewal
streams. MB4 is motivated by text Hawkes-process work `ogura2022_modeling`, but
implemented as a discrete-time finite-history symbolic process. MB5 is a
copy/mutation growth model motivated by DNA duplication-mutation literature
`koroteev2015_duplication`, `salgado2012_exact`; SymbolicLongMemorySequences.jl uses a power-law lag
copy kernel because validation showed that earlier block-copy variants produced
weak large-scale diagnostics.

## Open Reference Gaps

The private download audit records a few references that are not available
locally as complete PDFs, including the full Lowen and Teich 1995 article and
some entropy-rate references. The paper appendix also cites classical
Hermite-rank and nonlinear Gaussian-transformation results by Dobrushin and
Major, Taqqu, Breuer and Major, and Arcones; these have been added to the
still-to-find list because they support the mathematical discussion of how
quantization and other nonlinear transformations can preserve or weaken LRD.
These are retained in the BibTeX file when they are methodologically important,
with uncertainty noted in `../DOWNLOAD.mn`.

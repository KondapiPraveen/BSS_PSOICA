# BSS_PSOICA
This repository contains code, test files and results for Blind Source Separation using ICA with PSO, NMF and Harmonic Model.

Blind Source Separation (BSS) is class of techniques used to separate different sources from the observed source mixture. In BSS, the mixing scheme and information related to sources are unknown. This make BSS a difficult problem to solve. There are two type of channel separation, which are Multi Channel Source Separation and Single Channel Source Separation.

In Multi Channel Source Separation, several observerations of sources are gathered through different channels/paths, this results in a observation having high component of a specific source than others. In Single Channel Source Separation, single observation for all source is collected, this makes single channel separation much harder than multi channel separation. In Multi Channel Separation, there is a lot of data (observations) and less parameters to optimize (Demixing Matrix). In Single Channel Separation, one source may overshadow other sources or its harmonic partials.

Some Techniques in Multi Channel Source Separation: Principle Component Analysis (PCA), Independent Component Analysis (ICA), Sparse Component Analysis.
Techiques used in Single Channel Source Separation: Non-Negative Matrix Factorization (NMF), Sinusoidal/Harmonic Modelling.

In this Project, ICA algorithm is implemented with PSO Optimization for Demixing Matrix. Harmonic Modelling is used to estimate sources for Single Channel Source Mixing using mtg-sms tools. Some Proof of Concepts models for NMF are introduced to separated complex speech signals.

ICA algorithm try to find the independent sources from mixture by optimizing for demixing matrix (W). In this work, PSO algorithm is utilized for optimization of W. Individual sources are collected and mixed using random matrix (A) to get mixed observation signals. Non-gaussianity is used to check independence.

NMF takes a Non-negative input matrix and factorized into 2 Matrices of Basis (W) and Activations (H). NMF by itself converges to local optimum, an exhaustive search with large population will be able to achieve global optimum. Finding appropriate Number of Basis (K) is important to get better separation. A coarse plot with several options of K and taking best 'n' candidates will give a better idea/knowlege at choosing right 'K'. If first run of NMF gives a good result, futher NMF (Stage 2) with obtained outputs can be used to separate the former even further. This Stage 2 NMF is used to separate audio source signals in this work. There are also works suggesting supervised learning of 'W' with available individual sources and using this W to learn 'H' from Single Channel mixed observation.

In this work, only separation of Two sources are considered. But, ICA can be extended to any number of sources provided atleast the observations are in same number as that of sources. Single Channel Source Techinques may behave poorly for large number of sources as they have to optimize for many parameters with small data.

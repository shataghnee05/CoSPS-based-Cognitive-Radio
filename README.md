# CoSPS-Based Cooperative Cognitive Radio for Wideband Spectrum Sensing

<p align="center">
<img src="images/banner.png" width="900">
</p>

<p align="center">

![MATLAB](https://img.shields.io/badge/MATLAB-R2022b+-orange)
![Platform](https://img.shields.io/badge/Platform-MATLAB-blue)
![Signal Processing](https://img.shields.io/badge/Domain-Signal%20Processing-success)
![Cognitive Radio](https://img.shields.io/badge/Application-Cognitive%20Radio-red)
![License](https://img.shields.io/badge/License-MIT-green)

</p>

A MATLAB implementation of a **Cooperative Cognitive Radio Network** using the **CoSPS 
(Compressed Spectrum Sensing)** algorithm for wideband spectrum sensing at 
**sub-Nyquist sampling rates**.

Multiple **Secondary Users (SUs)** collaboratively sense the radio spectrum, identify 
temporarily unused frequency bands (spectrum holes), and dynamically allocate them — 
all while ensuring minimal interference with licensed **Primary Users (PUs)**.

---

## 📑 Table of Contents

* [Overview](#-overview)
* [Theory](#-theory)
* [Algorithms Used](#-algorithms-used)
* [MATLAB Toolboxes Required](#-matlab-toolboxes-required)
* [Installation & Setup](#-installation--setup)
* [Repository Structure](#-repository-structure)
* [Performance Evaluation](#-performance-evaluation)
* [Experimental Results](#-experimental-results)
* [Future Improvements](#-future-improvements)
* [Contributing](#-contributing)
* [Authors](#-authors)
* [License](#-license)

---

## 🌐 Overview

Fixed spectrum allocation leaves large portions of licensed bands underutilized. 
**Cognitive Radio (CR)** addresses this by letting SUs opportunistically access idle 
spectrum without interfering with PUs.

This project implements the full CR sensing pipeline in MATLAB:

1. **Multi-Coset Sampling** — compressed wideband data acquisition at sub-Nyquist rates
2. **Invertible Modulo Permutation (IMP)** — randomizes sample positions for better 
   reconstruction
3. **Dolph-Chebyshev Windowing** — reduces spectral leakage
4. **Sparse FFT** — efficient frequency estimation from compressed measurements
5. **Peak Detection** — identifies active bands via adaptive thresholding
6. **Majority Voting (Fusion Center)** — combines decisions from all SUs to improve 
   reliability
7. **Spectrum Hole Detection** — locates vacant bands
8. **Demand-Aware Allocation** — assigns holes to SUs with configurable guard bands

---

## 🧠 Theory

Wideband radio signals are **sparse in the frequency domain** — only a small fraction 
of available spectrum is occupied at any instant. Classical sensing requires sampling 
at the full Nyquist rate, which is computationally expensive at wide bandwidths.

**CoSPS** exploits this sparsity: Multi-Coset Sampling acquires a carefully chosen 
subset of samples sufficient to reconstruct the occupied frequencies, dramatically 
reducing sampling overhead without sacrificing detection accuracy.

Sensing reliability is further improved by having multiple SUs independently sense 
the spectrum and report to a **centralized Fusion Center**, which applies majority 
voting to suppress the effects of noise, fading, and individual sensing errors.

---

## ⚙️ Algorithms Used

| Algorithm | Purpose |
|---|---|
| **Multi-Coset Sampling** | Sub-Nyquist compressed acquisition of wideband signals |
| **Invertible Modulo Permutation (IMP)** | Randomizes samples to improve sparse reconstruction |
| **Dolph-Chebyshev Window** | Suppresses spectral leakage before frequency analysis |
| **Sparse FFT** | Estimates occupied frequency bins from compressed measurements |
| **Peak Detection** | Identifies active components via adaptive thresholding |
| **Majority Voting** | Fuses local sensing decisions at the Fusion Center |
| **Spectrum Hole Detection** | Finds vacant bands available for secondary access |
| **Demand-Aware Allocation** | Assigns spectrum to SUs with configurable guard bands |

Each module can be independently modified or replaced, making the framework suitable 
for experimenting with alternative sensing and allocation strategies.

---

## 🛠 MATLAB Toolboxes Required

| Toolbox | Purpose |
|---|---|
| MATLAB (R2022b+) | Core environment |
| Signal Processing Toolbox | FFT, windowing, spectral analysis (**required**) |
| Communications Toolbox | Signal generation, channel modeling (optional, for future extensions) |

---

##  Installation & Setup

In MATLAB:

```matlab
addpath(genpath(pwd));
savepath;
```

Then run:

```matlab
main.m
```

---

## 📁 Repository Structure

```text
CoSPS-Based-Cognitive-Radio/
│
├── README.md
├── LICENSE
├── main.m                         # Simulation entry point
│
├── src/
│   ├── preprocessing.m            # Signal generation & Multi-Coset Sampling
│   ├── cosps_main_algorithm.m     # IMP + Windowing + Sparse FFT + Peak Detection
│   ├── nc_fusion_center.m         # Cooperative sensing & majority voting
│   ├── free_band_detector.m       # Spectrum hole detection
│   └── demand_aware_allocation.m  # Dynamic spectrum allocation
│
├── images/
├── docs/
│   ├── Project_Report.pdf
│   └── Presentation.pdf
└── results/
    ├── snr_analysis/
    ├── runtime_analysis/
    ├── detection_probability/
    └── spectrum_utilization/
```

---

## 📊 Performance Evaluation

| Metric | Description |
|---|---|
| Detection Probability (Pd) | Correctly detected occupied bands |
| False Alarm Probability (Pfa) | Idle bands incorrectly flagged as occupied |
| Missed Detection Rate | Occupied bands that went undetected |
| Runtime | End-to-end sensing pipeline execution time |
| Spectrum Utilization | Percentage of available spectrum successfully allocated |
| Allocation Efficiency | Ratio of allocated to total available bandwidth |

---


## 🚀 Future Improvements

* Realistic channel models (AWGN, Rayleigh, Rician fading)
* CFAR-based adaptive thresholding
* Benchmarking against Energy Detection baselines
* Real-time spectrum monitoring dashboard
* ML/DL-based occupancy prediction
* SDR hardware integration (USRP, HackRF)
* Distributed multi-cell Fusion Centers
* RL-based spectrum allocation

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Keep commits focused and documented
4. Update docs if new functionality is added
5. Submit a Pull Request

---

## 👥 Authors

* **[Shataghnee Chatterjee](https://github.com/shataghnee05)**
* **Saunak Ray**

---

## 📜 License

Licensed under the **MIT License** — free to use, modify, and distribute for 
educational and research purposes with attribution. See `LICENSE` for details.
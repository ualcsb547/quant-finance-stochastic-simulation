# Quantitative Finance & Stochastic Simulation 📈

This repository contains advanced numerical simulation models developed entirely in **MATLAB** for financial asset modeling, quantitative risk management, and insurance ruin theory. It explores the implementation of stochastic calculus and Monte Carlo methods to analyze capital volatility and corporate solvency constraints.

---

## 🔬 Core Implementations

### 1. Standard Arithmetic Brownian Motion (Ruin Theory Foundations)
*   **SDE Architecture:** Simulates baseline capital paths driven purely by stochastic shocks with zero drift (μ = 0):
    \[dU_t = \sigma dW_t\]
*   **Absorbing Barrier Logic:** Implements custom event loops that immediately halt the trajectory (\(U_t = 0\)) upon hitting the zero-capital threshold, avoiding artificial financial recoveries.

### 2. General Arithmetic Brownian Motion (Linear Solvency Risk)
*   **SDE Architecture:** Models a continuous linear risk process where the capital surplus balances a constant drift (premium income net of claims) and a massive claims volatility parameter:
    \[dU_t = \mu dt + \sigma dW_t\]
*   **Dynamic Ruin Analysis:** Designed to capture structural tail-risk under large-scale volatility constraints (σ = 5000).

### 3. Geometric Brownian Motion & Itô Calculus (Non-Linear Solvency)
*   **SDE Architecture:** Implements the classic multiplicative asset price model by applying **Itô's Lemma** to solve the non-linear SDE framework used in derivative pricing and Solvency II validation:
    \[dU_t = \mu U_t dt + \sigma U_t dW_t \implies U_t = U_0 \exp\left(\left(\mu - \frac{1}{2}\sigma^2\right)t + \sigma W_t\right)\]
*   **Regulatory Threshold Constraints:** Integrates an early-warning solvency barrier (\(U_t \le 200\)) to simulate compliance breaches before complete depletion.

---

## 📊 Empirical Results & Quantitative Analysis

Leveraging a large-scale **Monte Carlo Framework** (10⁴ simulations per model) under a seed-controlled environment (`rng(1234)`), the empirical execution yielded the following data architecture:

| Model Strategy / Risk Profile | Ruin Probability (\(P_{\text{ruin}}\)) | Mean Final Capital (\(\mathbb{E}[U_T]\)) | 95% Confidence Interval (\(\text{VaR}_{97.5\%}\)) |
| :--- | :---: | :---: | :---: |
| **Pure Arithmetic BM** (μ=0, T=100) | *[.3074]* | *[10.0619]* | *[[0,	295549]]* |
| **General Arithmetic BM** (μ=-50, σ=5000, T=1) | *[0.0414]* | *[9951.9]* | *[0, 19655]* |
| **Geometric BM (Itô)** (μ=-0.05, σ=1.20, T=1) | *[0.0071]* | *[9710.3]* | *[431, 48474]* |

### 📈 Core Risk Insights:
*   **Discrete Sampling Bias:** The models account for discrete daily steps (dt = 1/365), establishing a robust baseline for stress-testing financial reserves.
*   **Tail-Risk Distribution:** The empirical probability density function (PDF) generated via final-step histograms reveals highly skewed distributions under non-linear geometric assumptions, proving the impact of volatility drag (\(-\frac{1}{2}\sigma^2\)) on capital survival.

---

## 🛠️ Repository Structure
```text
└── matlab/
    ├── arithmetic_bm_pure.m       # Baseline Brownian Motion with zero drift
    ├── arithmetic_bm_general.m    # Linear drift & volatility risk model
    └── geometric_bm_ito.m         # Multiplicative Itô calculus & Solvency II barrier
```

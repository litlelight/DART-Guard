Evidence-Gated Deployment of Cross-Farm Wind Power Forecasts under Negative Transfer and Sensor Uncertainty

DART-Guard is a reproducible research repository for studying when cross-farm wind-power model updates should be released, withheld, or replaced by a conservative fallback under limited target evidence and sensor uncertainty.

The project does not present DART-Guard as a new forecasting architecture or as a distribution-free safety guarantee. Instead, DART-Guard is evaluated as an empirical, reference-conditional deployment policy built around strong structured forecasters, chronological evidence separation, delayed expert aggregation, and explicit fault-aware fallback.

Overview

Cross-farm transfer can be useful when target-site labels are scarce, but limited adaptation data can also produce negative transfer. This repository evaluates that problem through a frozen chronological deployment protocol:

Prepare the forecasting models, expert set, reference policy, evidence rules, switching cost, and fault fallback before deployment.

Proposal interval (15 days): generate candidate forecasts and select one candidate using proposal-period performance only.

Freeze: lock the selected candidate and the fixed reference.

Confirmation interval (15 days): aggregate field-day evidence without using locked-query outcomes.

Evidence gate: release the candidate only when the predeclared evidence rule and switching-cost condition are both satisfied.

Locked query (30 days): evaluate once without retuning.

Fault audit: evaluate current-power loss, communication outage, missingness, and other sensor failures separately from Guard calibration.

The central question is therefore not only how to adapt a forecast model, but also whether the available evidence is strong enough to justify deploying the update.

Main findings reproduced by this repository

The retained manuscript evidence supports the following conclusions:

Direct and persistence-residual target formulations show route- and loss-dependent behavior. The MAE ranking reverses across the two internal transfer routes, while the MAE-favored residual formulation can substantially reduce ramp-event F1.

Under paired same-window evaluation, short target adaptation is frequently harmful. The 7- and 14-day adaptation results are consistently negative across the evaluated internal starts, while 30-day outcomes are weaker and more start-dependent.

Delayed EWA and Hedge aggregation provide small positive internal rolling gains.

The representative evidence Guard rejected all three observed harmful internal candidates, but also withheld some beneficial updates, exposing a measurable downside–opportunity trade-off.

Confirmation evidence is directionally informative but does not transport perfectly to the subsequent locked query.

Current-power loss and row-level communication outage are the dominant operational fault modes in the evaluated tests. The predefined lag anchors are conservative emergency baselines and do not restore normal forecast performance.

Cross-manufacturer results on Altahullion reproduce short-budget negative transfer. Longer-budget gains are strongly start-dependent, and in three of four external rolling windows no evaluated candidate outperformed the fixed reference even under a post-hoc oracle.

All gain and release claims are conditional on the predeclared equal pooled-source/persistence reference.

Repository contents

The repository contains the research compendium used to generate the retained manuscript evidence, including:

preprocessing and harmonization code;

forecasting and adaptation configurations;

source-model and pooled-source experiments;

delayed EWA and Hedge aggregation;

evidence-gating and switching-cost analysis;

fault and missingness stress tests;

cross-manufacturer confirmation experiments;

frozen-output decision audits;

confirmation-to-query diagnostics;

candidate-selection oracle diagnostics;

start-sensitivity analyses;

experiment manifests and summary tables;

figure-generation assets and scripts.

Only completed experiment families are used to support the primary manuscript claims.

Datasets

The study uses three public 10-minute SCADA datasets.

Kelmarsh Wind Farm

Senvion MM92 turbines

Internal source/target evaluation

Zenodo: https://doi.org/10.5281/zenodo.16807551

Penmanshiel Wind Farm

Senvion MM82 turbines

Internal source/target evaluation

Zenodo: https://doi.org/10.5281/zenodo.16807304

Altahullion Wind Farm

Siemens SWT-1.3-CS-62 turbines

Cross-manufacturer confirmation

Zenodo: https://doi.org/10.5281/zenodo.19948235

The original Zenodo archives remain the authoritative sources for the raw datasets and their licensing conditions. This repository contains harmonized/derived analysis assets where redistribution is permitted.

Experimental design

Forecast horizons

30 min

60 min

120 min

Internal adaptation budgets

7 days

14 days

30 days

Candidate adaptation strategies

No adaptation

AffineHead

RidgeAdapter

TargetLGBM

WeightedTransfer

Rolling expert policies

single-source experts;

pooled-source expert;

persistence;

static selection rules;

static EWA;

delayed online EWA;

Hedge;

global gate;

ridge stacking.

Guard evaluation

Each rolling deployment uses:

15-day proposal interval;

15-day confirmation interval;

30-day locked query interval.

The selected candidate and reference are frozen before confirmation. Query outcomes are not used for candidate retuning or release authorization.

Reference policy

The manuscript uses a fixed equal blend of the pooled-source forecast and persistence:

reference = 0.5 × pooled_source + 0.5 × persistence

Query gain is defined as:

gain = MAE(reference) - MAE(candidate)

Positive gain therefore favors the candidate.

The equal 0.5/0.5 blend is a predeclared operating reference, not a claim that this weighting is universally optimal.

Evidence gate

The representative Guard uses field-day confirmation gains and releases a candidate only when:

the predeclared one-sided evidence screen is positive; and

the mean confirmation gain exceeds the chosen switching cost.

If either condition fails, the locked-query forecast returns exactly to the fixed reference.

The implemented screens are empirical engineering rules under temporal dependence and candidate selection. They are not interpreted as finite-sample or distribution-free certification guarantees.

Fault-aware evaluation

The fault layer is evaluated separately from Guard calibration.

The stress tests include:

random 20% missingness;

random 40% missingness;

complete wind loss;

complete pitch loss;

3-hour multi-sensor outage;

6-hour multi-sensor outage;

current-power failure;

row-level communication outage.

Current-power and communication failures remain severe in the evaluated experiments. Lagged-power anchors are therefore treated as conservative fallback baselines rather than as evidence that normal performance has been recovered.

Reproducibility

The retained manuscript evidence is based on completed experiment families:

full LightGBM direct/residual experiments;

completed mask-aware Patch confirmation;

paired adaptation experiments;

proper missingness/fault experiments;

external paired adaptation;

source/fusion/Guard rolling-window evaluations.

The repository includes experiment manifests and configuration files so that reported outputs can be traced back to the corresponding runs.

Environment

The repository includes an environment.yml file.

A typical setup is:

conda env create -f environment.yml
conda activate dart-guard

If your local environment name differs, use the name declared in environment.yml.

Reproducing the study

The exact execution entry points may depend on the released snapshot. Before running large experiments, inspect:

README.md
FILE_INVENTORY.txt
environment.yml
Makefile

and the experiment/configuration directories included in the repository.

For reproducibility checks, prefer the frozen experiment manifests and released summary outputs rather than modifying configurations and comparing the resulting numbers directly with the manuscript.

Scope and limitations

The repository and manuscript intentionally retain several important limitations:

the downstream direct/residual route assignment is a retrospective frozen analysis configuration, not a validated prospective mode selector;

the internal adaptation study contains three independent starts;

the external Altahullion adaptation study contains two starts;

Altahullion is treated as a frozen cross-manufacturer confirmation set rather than a pristine unseen benchmark;

adjacent rolling deployment windows overlap, so confirmation-to-query correlations are descriptive rather than independent-sample significance tests;

evidence-gating results are conditional on the declared fixed reference;

the completed mask-aware Patch experiment is a domain-matched deep baseline, not an exhaustive deep-learning benchmark;

fault fallback does not eliminate the performance degradation caused by severe information loss.

These limitations are part of the intended interpretation of the study rather than hidden implementation details.

Manuscript

Evidence-Gated Deployment of Cross-Farm Wind Power Forecasts under Negative Transfer and Sensor Uncertainty

Authors:

Yuchen Zhang — INTI International University, Malaysia

Liangzheng Li — Nanchang Institute of Science & Technology, China

The repository is maintained as the reproducibility companion to the manuscript. Please cite the archived release once a versioned DOI is available.

Citation

Until a versioned archival DOI for this repository is issued, please cite the manuscript and the original datasets.

A CITATION.cff file is included and should be updated together with the manuscript metadata before the final archived release.

Data availability

The original SCADA datasets are publicly available through the Zenodo records listed above.

Harmonized analysis data, derived experiment tables, result files, configurations, and reproducibility assets used by the manuscript are released in this repository:

https://github.com/litlelight/DART-Guard

Code availability

The DART-Guard research compendium is available at:

https://github.com/litlelight/DART-Guard

Code is released under the repository's MIT License unless otherwise indicated.

Funding

This research received no external funding.

License

Code in this repository is released under the MIT License unless otherwise stated.

The original SCADA datasets retain their own licenses and must be cited through their authoritative Zenodo records.

Contact

Yuchen ZhangINTI International University, MalaysiaEmail: i24026647@student.newinti.edu.my

For reproducibility questions, please open a GitHub issue or contact the corresponding author.

Disclaimer

This repository is intended for research and reproducibility. DART-Guard is evaluated as an empirical deployment-governance framework. The reported evidence screens and fallback rules should not be interpreted as certified operational safety mechanisms or as guarantees of improved forecast accuracy.

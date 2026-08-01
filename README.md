# Reference-conditional screening for cross-farm adaptation

Complete lightweight companion repository for:

> **When Should Cross-Farm Adaptation Be Deployed? Reference-Conditional Screening for Wind Power Forecasting**

**Author:** Yuchen Zhang, INTI International University, Malaysia  
**Contact:** i24026647@student.newinti.edu.my

This repository is ready to upload to GitHub as provided. It deliberately does not redistribute the public SCADA archives. Instead, it contains the complete materials for its declared lightweight scope:

- official dataset record pages and exact file-level download links;
- publisher-provided MD5 checksums and a verified downloader;
- the predeclared protocol and model settings reported in the manuscript;
- a tested implementation of proposal, activation-strength selection, field-day screening, and exact fallback;
- a CSV command-line workflow with deterministic example input and expected outputs;
- all manuscript tables exported as small CSV files;
- citation, software-archive, licence, testing, and GitHub Actions metadata.

## Scientific scope

CertRIFT is an empirical **model-update governance mechanism**, not a new forecasting backbone and not a formal statistical certification procedure. A contextual learner proposes a source weight, one activation strength is selected chronologically, and a held-out field-day screen either releases the partial update or returns exactly to the predeclared source–persistence reference.

The repository implements this governance layer from precomputed predictions and contextual weights. It does not claim to recreate private working scripts that were not supplied with the manuscript. The reported numerical tables are included verbatim as CSV exports so that reviewers can inspect the paper's evidence without downloading large data.

## Repository map

```text
configs/                  public-data manifest and protocol settings
data/                     local raw/processed data locations; ignored by Git
docs/                     method, data, scope, results, and reproducibility notes
examples/                 runnable synthetic CSV example and expected outputs
paper/                    manuscript metadata and reported tables as CSV
scripts/                  data download, integrity, smoke-test, and release validation
src/certrift/             tested reference implementation and CLI
tests/                    unit and command-line tests
```

## Installation

Python 3.11 or newer is supported.

```bash
python -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -e .[test]
```

## Run the example

```bash
certrift-screen examples/synthetic_protocol.csv --output-dir outputs/example
```

The input CSV contains `selection` and `confirmation` rows and these columns:

```text
partition, field_date, y_true, source_prediction,
persistence_prediction, contextual_source_weight
```

The command writes:

- `decision.json`;
- `gamma_selection.csv`;
- `confirmation_predictions.csv`.

A deterministic integrity check is also available:

```bash
python scripts/run_smoke_test.py
python -m pytest -q
python scripts/validate_repository.py
```

## Public data

The package selects only the files used for the manuscript periods. The raw downloads total approximately 1 GB; they remain hosted by the data publishers.

| Farm | Official record | Selected content |
|---|---|---|
| Kelmarsh | https://zenodo.org/records/8252025 | 2016–2018 SCADA, signal mapping, static metadata |
| Penmanshiel | https://zenodo.org/records/8253010 | 2016–2018 WT11–WT15 SCADA, signal mapping, static metadata |
| Altahullion | https://zenodo.org/records/19948235 | turbine data and turbine metadata; LiDAR excluded |

List or download the exact files:

```bash
python scripts/download_data.py --list
python scripts/download_data.py --dataset all
python scripts/check_data_layout.py
```

See [`docs/DATA.md`](docs/DATA.md) for direct links, citations, checksums, and storage layout.

## Reported results

All 22 numbered manuscript tables are available under [`paper/reported_tables/`](paper/reported_tables/). The index file preserves each original caption. These files are a transparent export of the v15 manuscript, not newly recomputed values.

## Configuration

[`configs/protocol.yaml`](configs/protocol.yaml) records the declared reference weight, chronological split, gamma grid, minimum field-date evidence, empirical critical value, model settings, missingness design, repetitions, and bootstrap settings.

## Citation

Citation metadata are provided in [`CITATION.cff`](CITATION.cff) and [`.zenodo.json`](.zenodo.json). The software is released under the MIT License. Public datasets remain under their publishers' licences and are not relicensed by this repository.

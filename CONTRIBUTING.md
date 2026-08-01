# Contributing

Issues and pull requests are welcome for reproducible bug reports, documentation corrections, and well-tested extensions of the governance layer.

1. Create a branch.
2. Install with `python -m pip install -e .[test]`.
3. Add or update tests.
4. Run `python -m pytest -q` and `python scripts/validate_repository.py`.
5. Describe whether a change affects the scientific protocol or only the software interface.

Do not commit public SCADA archives, extracted raw files, fitted models, or large processed matrices.

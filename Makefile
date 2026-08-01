.PHONY: install test smoke validate data-list data-check example

install:
	python -m pip install -e .[test]

test:
	python -m pytest -q

smoke:
	python scripts/run_smoke_test.py

validate:
	python scripts/validate_repository.py

data-list:
	python scripts/download_data.py --list

data-check:
	python scripts/check_data_layout.py

example:
	certrift-screen examples/synthetic_protocol.csv --output-dir outputs/example

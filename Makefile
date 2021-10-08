run:
	opa eval -f pretty -i examples/slsa_1.yaml -d lib 'data.main'

.PHONY: run

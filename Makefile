.PHONY: install
install:
	./install.sh

.PHONY: merge
merge:
	./scripts/merge_configs.sh

.PHONY: atom
atom:
	./scripts/atom/atom.sh

.PHONY: aws
aws:
	./scripts/aws/aws.sh


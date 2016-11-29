.PHONY: help
help:    ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/:.*##/;/' | column -t -s ";"

.PHONY: update
update: ## Update dotfiles
	./update.sh

.PHONY: install
install: ## Install dependencies
	./install.sh

.PHONY: download
download: ## Fetch the latest
	git pull

.PHONY: merge
merge:   ## Merge config files from ./mergeables
	./scripts/merge_configs.sh

.PHONY: atom
atom:    ## Install atom plugins
	./scripts/atom/atom.sh

.PHONY: aws
aws:     ## Install AWS specifics
	./scripts/aws/aws.sh

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

.PHONY: atom
atom:    ## Install atom plugins
	./scripts/atom/atom.sh

.PHONY: code
code:    ## Install VS Code settings
	./bootstrap_code.sh

.PHONY: link
link:     ## Link the /castle
	./bootstrap_castle.sh

.PHONY: aws
aws:     ## Install AWS specifics
	./scripts/aws/aws.sh

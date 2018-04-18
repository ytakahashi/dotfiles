SHELL := /bin/bash

DOT_FILES := \
.vimrc \
.vim/colors/kafka.vim \
.zshrc \
.zshenv \
.tmux.conf \
.gitignore_global

PUGIN_MANAGER := \
neobundle \
zplug

.DEFAULT_GOAL := dotfiles

.PHONY: dotfiles
dotfiles: setup deploy ## do setup and deploy

.PHONY: setup
setup: ## setup plugin managers
	@$(SHELL) lib/setup.sh $(PUGIN_MANAGER)

.PHONY: deploy
deploy: ## create symbolic links
	@$(SHELL) lib/deploy.sh $(DOT_FILES)

.PHONY: clean
clean: ## delete existing symlinks and backup existing files
	@$(SHELL) lib/clean.sh $(DOT_FILES)

.PHONY: list
list: ## show dotfiles to be deployed
	@echo "------------- Dotfiles -------------"
	@$(foreach val, $(DOT_FILES), echo $(val);)
	@echo "------------------------------------"

.PHONY: help
help:
	@echo $(DOT_FILES)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36;1m%-30s\033[0m %s\n", $$1, $$2}'

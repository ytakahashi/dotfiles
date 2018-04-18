SHELL := /bin/bash
LIGHT_CYAN := \e[96;1m
COLOR_OFF := \e[m

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

.DEFAULT_GOAL := help

.PHONY: dotfiles
dotfiles: setup deploy ## do setup and deploy

.PHONY: setup
setup: ## set up plugin managers listed by "make list"
	@$(SHELL) lib/setup.sh $(PUGIN_MANAGER)

.PHONY: deploy
deploy: ## create symbolic links listed by "make list"
	@$(SHELL) lib/deploy.sh $(DOT_FILES)

.PHONY: clean
clean: ## delete existing symbolic links and backup existing files to "~/.tmp/" directory
	@$(SHELL) lib/clean.sh $(DOT_FILES)

.PHONY: list
list: ## show dotfiles and plugin managers to be deployed/installed
	@echo ""
	@echo -e "$(LIGHT_CYAN)------------- Dotfiles -------------$(COLOR_OFF)"
	@$(foreach val, $(DOT_FILES), echo $(val);)
	@echo -e "$(LIGHT_CYAN)------------------------------------$(COLOR_OFF)"
	@echo ""
	@echo -e "$(LIGHT_CYAN)---------- Plugin Manager ----------$(COLOR_OFF)"
	@$(foreach val, $(PUGIN_MANAGER), echo $(val);)
	@echo -e "$(LIGHT_CYAN)------------------------------------$(COLOR_OFF)"

.PHONY: help
help: ## show how to use
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36;1m%-30s\033[0m %s\n", $$1, $$2}'


SHELL := /bin/bash
LIGHT_CYAN := \033[96;1m
LIGHT_MAGENDA := \033[95;1m
COLOR_OFF := \033[m

DOT_FILES := \
.vimrc \
.vim/colors/kafka.vim \
.zshrc \
.zshenv \
.bashrc \
.bash_profile \
.tmux.conf \
.gitignore_global \
.hyper.js

PUGIN_MANAGER := \
neobundle \
zplug

.DEFAULT_GOAL := help

.PHONY: dotfiles
dotfiles: setup deploy ## do setup and deploy

.PHONY: setup
setup: ## set up plugin managers listed by "make list"
	@$(SHELL) $(CURDIR)/lib/setup.sh $(PUGIN_MANAGER)

.PHONY: deploy
deploy: ## create symbolic links of dotfiles listed by "make list"
	@$(SHELL) $(CURDIR)/lib/deploy.sh $(DOT_FILES)

.PHONY: clean
clean: ## delete existing symbolic links and backup existing files to "~/tmp" directory
	@$(SHELL) $(CURDIR)/lib/clean.sh $(DOT_FILES)

.PHONY: list
list: ## show dotfiles and plugin managers to be deployed/installed
	@echo ""
	@echo -e "$(LIGHT_MAGENDA)------------- Dotfiles -------------$(COLOR_OFF)"
	@$(foreach val, $(DOT_FILES), echo $(val);)
	@echo -e "$(LIGHT_MAGENDA)------------------------------------$(COLOR_OFF)"
	@echo ""
	@echo -e "$(LIGHT_MAGENDA)---------- Plugin Manager ----------$(COLOR_OFF)"
	@$(foreach val, $(PUGIN_MANAGER), echo $(val);)
	@echo -e "$(LIGHT_MAGENDA)------------------------------------$(COLOR_OFF)"

.PHONY: help
help: ## show how to use
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "$(LIGHT_CYAN)%-9s$(COLOR_OFF):  %s\n", $$1, $$2}'


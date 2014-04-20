# Rsync options.
RSYNC ?= rsync
RSYNC_ARGS ?= --archive --delete --human-readable
ROOT_FILTER = root.lst
HOME_FILTER = home.lst

# Repository paths.
REPO_DIR = $(CURDIR)
REPO_HOME_DIR = $(REPO_DIR)/home
REPO_ROOT_DIR = $(REPO_DIR)/root

# ANSI colors.
ANSI_BOLD = \e[01m
ANSI_RESET = \e[0m

all: home root

install: install_home install_root

install_home:
	@while [ -z "$$USERINPUT" ]; do \
		echo -en "$(ANSI_BOLD)Are you sure you want to overwrite your home directory?$(ANSI_RESET) (y/N) "; \
		read USERINPUT; \
	done && \
		[[ "$$USERINPUT" =~ ^[yY] ]] || exit 1
	$(RSYNC) --archive --human-readable "$(REPO_HOME_DIR)/" "$(HOME)/test"

install_root:
	@echo "install_root: Not yet implemented."

root:
	@mkdir -p $(REPO_ROOT_DIR)
	$(RSYNC) $(RSYNC_ARGS) --filter=". $(ROOT_FILTER)" --exclude "*" / "$(REPO_ROOT_DIR)"

home:
	@mkdir -p $(REPO_HOME_DIR)
	$(RSYNC) $(RSYNC_ARGS) --filter=". $(HOME_FILTER)" --exclude "*" "$(HOME)/" "$(REPO_HOME_DIR)"

clean:
	rm -rf $(REPO_HOME_DIR) $(REPO_ROOT_DIR)

.PHONY: home root

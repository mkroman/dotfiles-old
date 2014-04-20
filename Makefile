# Rsync options.
RSYNC ?= rsync
RSYNC_ARGS ?= --archive --delete --progress --human-readable
ROOT_FILTER = root.lst
HOME_FILTER = home.lst

# Repository paths.
REPO_DIR = $(CURDIR)
REPO_HOME_DIR = "$(REPO_DIR)/home"
REPO_ROOT_DIR = "$(REPO_DIR)/root"

all: home root

root:
	mkdir -p $(REPO_ROOT_DIR)
	$(RSYNC) $(RSYNC_ARGS) --filter=". $(ROOT_FILTER)" --exclude "*" / $(REPO_ROOT_DIR)

home:
	mkdir -p $(REPO_HOME_DIR)
	$(RSYNC) $(RSYNC_ARGS) --filter=". $(HOME_FILTER)" --exclude "*" "$(HOME)/" $(REPO_HOME_DIR)

clean:
	rm -rf $(REPO_HOME_DIR) $(REPO_ROOT_DIR)

.PHONY: home root

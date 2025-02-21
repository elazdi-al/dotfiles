# Define the directories to be stowed
DIRS = README.md ghostty latexmk nvim tmux aerospace home-manager nix raycast zathura

# Default target
all: stow

# Stow all directories
stow:
	@for dir in $(DIRS); do \
		if [ -d $$dir ]; then \
			echo "Stowing $$dir..."; \
			if [ "$$dir" = "nvim" ]; then \
				mkdir -p ~/.config/nvim; \
				stow -v -R -t ~/.config $$dir; \
			else \
				stow -v -R -t ~ $$dir; \
			fi \
		else \
			echo "$$dir is not a directory, skipping..."; \
		fi \
	done

# Unstow all directories
unstow:
	@for dir in $(DIRS); do \
		if [ -d $$dir ]; then \
			echo "Unstowing $$dir..."; \
			if [ "$$dir" = "nvim" ]; then \
				stow -v -D -t ~/.config $$dir; \
			else \
				stow -v -D -t ~ $$dir; \
			fi \
		else \
			echo "$$dir is not a directory, skipping..."; \
		fi \
	done

# Clean up (unstow all directories)
clean: unstow

.PHONY: all stow unstow clean

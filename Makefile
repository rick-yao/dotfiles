# I don't need this , but I keep it just in case network connection is not stable
darwin-set-proxy:
	sudo python3 machines/scripts/darwin_set_proxy.py

# alias all necceary config file
set-up-config:
	python3 machines/scripts/set_up_config.py

deploy-linux: set-up-config
	home-manager switch --flake ~/dotfiles/
	
# deploy-mac: set-up-config
# 	# NOTE: update hostname here!
# 	nix build .#darwinConfigurations.Ricks-MacBook-Air.system \
# 		--extra-experimental-features 'nix-command flakes'

# 	sudo ./result/sw/bin/darwin-rebuild switch --flake .#Ricks-MacBook-Air
	
# 	rm ./result

# darwin-debug: set-up-config
# 	# NOTE: update hostname here!
# 	nix build .#darwinConfigurations.Ricks-MacBook-Air.system --show-trace --verbose \
# 		--extra-experimental-features 'nix-command flakes'

# 	./result/sw/bin/darwin-rebuild switch --flake .#Ricks-MacBook-Air --show-trace --verbose

############################################################################
#
#  nix related commands
#
############################################################################

# Hostname and User detection
HOST ?= $(shell hostname -s)
USER ?= $(shell whoami)

# Export as env vars for NIX
export NIX_HOSTNAME = $(HOST)
export NIX_USERNAME = $(USER)

deploy-mac: set-up-config
	@echo "Deploying for $(USER) @ $(HOST)"
	# Build the system configuration
	nix build .#darwinConfigurations."$(HOST)".system \
		--extra-experimental-features 'nix-command flakes' \
		--impure

	# Apply the configuration
	sudo ./result/sw/bin/darwin-rebuild switch --flake .#"$(HOST)" --impure
	
	rm ./result

darwin-debug: set-up-config
	@echo "Debugging for $(USER) @ $(HOST)"
	nix build .#darwinConfigurations."$(HOST)".system --show-trace --verbose \
		--extra-experimental-features 'nix-command flakes' \
		--impure

	./result/sw/bin/darwin-rebuild switch --flake .#"$(HOST)" --show-trace --verbose --impure

update:
	nix flake update
	
update-mac: update
	make deploy-mac
	
update-linux: update
	make deploy-linux

deploy-linux: set-up-config
	home-manager switch --flake ~/dotfiles/ --impure

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc-mac:
	# remove all generations older than 1 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

	# garbage collect all unused nix store entries
	sudo nix store gc --debug
	nix-collect-garbage -d
	nix-store --gc --option keep-outputs false --option keep-derivations false
	nix-store --optimise

gc-linux:
	# remove all generations
	home-manager expire-generations -d
	# garbage collect all unused nix store entries
	nix store gc --debug
	nix-collect-garbage -d
	nix-store --optimise
	nix-store --gc --option keep-outputs false --option keep-derivations false

fmt:
	nix fmt .

.PHONY: clean  
clean:  
	rm -rf result

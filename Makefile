# I don't need this , but I keep it just in case network connection is not stable
darwin-set-proxy:
	sudo python3 machines/scripts/darwin_set_proxy.py

# alias all necceary config file
set-up-config:
	python3 machines/scripts/set_up_config.py

deploy-linux: set-up-config
	home-manager switch --flake ~/dotfiles/
	
deploy-mac: set-up-config
	# NOTE: update hostname here!
	nix build .#darwinConfigurations.Ricks-MacBook-Air.system \
		--extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#Ricks-MacBook-Air
	
	rm ./result

darwin-debug: set-up-config
	# NOTE: update hostname here!
	nix build .#darwinConfigurations.Ricks-MacBook-Air.system --show-trace --verbose \
		--extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#Ricks-MacBook-Air --show-trace --verbose

############################################################################
#
#  nix related commands
#
############################################################################


update:
	nix flake update
	
update-mac: update
	make deploy-mac
	
update-linux: update
	make deploy-linux

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc-mac:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug

gc-linux:
	# remove all generations
	home-manager expire-generations -d
	# garbage collect all unused nix store entries
	nix store gc --debug

fmt:
	nix fmt

.PHONY: clean  
clean:  
	rm -rf result

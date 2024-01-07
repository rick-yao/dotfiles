#
#  NOTE: Makefile's target name should not be the same as one of the file or directory in the current directory, 
#    otherwise the target will not be executed!
#


############################################################################
#
#  Darwin related commands
#
############################################################################

#  NOTE: don't need this , but I keep it just in case
darwin-set-proxy:
	sudo python3 scripts/darwin_set_proxy.py

set-up-config:
	sh scripts/set_up_config.sh

deploy: set-up-config
	# NOTE: update hostname here!
	nix build .#darwinConfigurations.Ricks-MacBook-Air.system \
		--extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#Ricks-MacBook-Air

darwin-debug: darwin-set-proxy
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

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug


fmt:
	# format the nix files in this repo
	nix fmt

.PHONY: clean  
clean:  
	rm -rf result

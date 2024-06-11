darwin-set-proxy:
	sudo python3 scripts/darwin-set-proxy.py

darwin: darwin-set-proxy
	darwin-rebuild switch --flake .#charles

darwin-debug: darwin-set-proxy
	darwin-rebuild switch --flake .#charles --show-trace --verbose
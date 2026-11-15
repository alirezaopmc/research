.PHONY: proposal proposal-single proposal-signed setup-proposal-signed

proposal:
	$(MAKE) -C proposal proposal

proposal-single:
	$(MAKE) -C proposal proposal-single

proposal-signed:
	$(MAKE) -C proposal proposal-signed

setup-proposal-signed:
	$(MAKE) -C proposal setup-proposal-signed

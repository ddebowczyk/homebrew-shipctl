# Homebrew tap for Shipctl

Install the Shipctl release as one Homebrew cask. The cask installs
the macOS app and exposes its bundled small `shipctl` command.

```bash
brew tap ddebowczyk/shipctl
brew trust ddebowczyk/shipctl
brew install --cask shipctl
shipctl version
```

This initial private release is ad-hoc signed but not notarized. On first
launch, macOS will block the app. Open System Settings > Privacy & Security,
then select Open Anyway for Shipctl. Later updates use normal Homebrew cask
upgrades:

```bash
brew upgrade --cask shipctl
```

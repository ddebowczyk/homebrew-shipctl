cask "shipctl" do
  version "0.8.2"
  sha256 "e919d9185b9f9cfe12fe96333655f50a6e0b4026c350cf4710209e0275582837"

  url "https://github.com/ddebowczyk/shipctl/releases/download/v#{version}/shipctl_#{version}_aarch64.dmg"
  name "Shipctl"
  desc "Desktop and command-line control for Shipctl"
  homepage "https://github.com/ddebowczyk/shipctl"

  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "shipctl.app"
  binary "#{appdir}/shipctl.app/Contents/MacOS/shipctl"

  # Shipctl is ad-hoc signed and unnotarized. The ad-hoc signature satisfies the
  # Apple Silicon execution gate; notarization is only consulted for artifacts
  # carrying com.apple.quarantine. Homebrew's cask installer propagates that
  # attribute from the downloaded DMG onto the installed bundle, so Gatekeeper
  # evaluates the app on first launch and rejects it.
  #
  # Removing the attribute before first launch restores the same condition
  # formula-installed tools get for free: their curl download never carries it.
  # `xattr -dr` exits 0 when the attribute is absent, so this is safe to run
  # unconditionally.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/shipctl.app"]
  end
end

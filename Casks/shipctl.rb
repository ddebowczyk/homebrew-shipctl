cask "shipctl" do
  version "0.9.3"
  sha256 "297263154d34d54cf45d541565f90c42c5ccf251c197a0b9485c7f99274f831a"

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

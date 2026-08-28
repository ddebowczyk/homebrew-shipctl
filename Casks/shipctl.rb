cask "shipctl" do
  version "0.9.5"
  sha256 "13f975f3565996acfe6dc5b2d8c8f1f56307d580e0895e2f4210301597b39534"

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

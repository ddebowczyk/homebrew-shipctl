cask "shipctl" do
  version "0.7.2"
  sha256 "d8e13e17f216737ad84382ffb8218f224cec02bc1925f8fae26f53880a58d78a"

  url "https://github.com/ddebowczyk/shipctl/releases/download/v#{version}/shipctl_#{version}_aarch64.dmg"
  name "Shipctl"
  desc "Desktop and command-line control for Shipctl"
  homepage "https://github.com/ddebowczyk/shipctl"

  depends_on arch: :arm64

  app "shipctl.app"
  binary "#{appdir}/shipctl.app/Contents/MacOS/shipctl"

  caveats <<~EOS
    Shipctl is ad-hoc signed but not notarized. On first launch, approve it in
    System Settings > Privacy & Security, then select Open Anyway.
  EOS
end

cask "shipctl" do
  version "0.7.0"
  sha256 "c09a7add7789ea4bc93b7c4a41fac8aaccc3b4aee0367665eeb146e5c92830a4"

  url "https://github.com/ddebowczyk/shipctl/releases/download/v#{version}/shipctl_#{version}_aarch64.dmg"
  name "Shipctl"
  desc "Desktop and command-line control for Shipctl"
  homepage "https://github.com/ddebowczyk/shipctl"

  depends_on arch: :arm64

  app "shipctl.app"
  binary "#{appdir}/shipctl.app/Contents/MacOS/shipctl"

  caveats <<~EOS
    Shipctl is unsigned. On first launch, approve it in System Settings >
    Privacy & Security, then select Open Anyway.
  EOS
end

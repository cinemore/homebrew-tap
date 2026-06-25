cask "cineplayer" do
  version "1.0.1"
  sha256 "1d1b9cde87e321da2c2de9914d279b591111d6b64bbd69ddcf04189febcb8c3f"

  url "https://github.com/cinemore/CinePlayer/releases/download/v#{version}/CinePlayer-macOS-v#{version}.zip"
  name "CinePlayer"
  desc "Video player"
  homepage "https://github.com/cinemore/CinePlayer"

  app "CinePlayer.app"

  caveats <<~EOS
    This build is currently unsigned and not notarized. On first launch,
    macOS Gatekeeper may show a warning. If you trust this release, open
    it from Finder by Control-clicking the app and choosing Open.
  EOS
end

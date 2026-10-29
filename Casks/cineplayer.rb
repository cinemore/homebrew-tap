cask "cineplayer" do
  version "2.0.0"
  sha256 "d9b8eb5eb0e5b3f5e1e0fe2036daebe733d18fd3268f5c5f66edac05821908c1"

  url "https://github.com/cinemore/CinePlayer/releases/download/v#{version}/CinePlayer-macOS-v#{version}.zip"
  name "CinePlayer"
  desc "Video player"
  homepage "https://github.com/cinemore/CinePlayer"

  depends_on macos: ">= :sonoma"

  app "CinePlayer.app"
end

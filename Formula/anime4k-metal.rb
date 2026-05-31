class Anime4kMetal < Formula
  desc "Native macOS Anime4K image enhancement CLI"
  homepage "https://github.com/cinemore/anime4k-metal"
  version "0.1.1"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.1/anime4k-metal-macos-arm64.tar.gz"
    sha256 "b5269f4416559e9a0cdb2340f9f43a6301dd162ef3a2b742debac060c47edb31"
  else
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.1/anime4k-metal-macos-x86_64.tar.gz"
    sha256 "646aa805906e9ce8172667ee05c4fbde0e22129595daff514bfed0ac30390b1c"
  end

  def install
    libexec.install "bin/anime4k-metal"
    libexec.install "bin/Anime4KMetal_Anime4KMetalCore.bundle"

    (bin/"anime4k-metal").write <<~SH
      #!/bin/sh
      exec "#{libexec}/anime4k-metal" "$@"
    SH
  end

  test do
    assert_match "Native Apple Metal Anime4K-style image enhancement", shell_output("#{bin}/anime4k-metal --help")
  end
end

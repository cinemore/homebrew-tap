class Anime4kMetal < Formula
  desc "Native macOS Anime4K image enhancement CLI"
  homepage "https://github.com/cinemore/anime4k-metal"
  version "0.1.4"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.4/anime4k-metal-macos-arm64.tar.gz"
    sha256 "cd2d353bd86bce3d3b14a04a811baed265d02cb4d09dc69e4e7ba78393898365"
  else
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.4/anime4k-metal-macos-x86_64.tar.gz"
    sha256 "e329e6ab7ae308659d6c8c32abc60bb4e3da7ccc0b0564667b04b8f4d4af02b8"
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

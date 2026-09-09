class Anime4kMetal < Formula
  desc "Native macOS Anime4K image enhancement CLI"
  homepage "https://github.com/cinemore/anime4k-metal"
  version "0.1.3"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.3/anime4k-metal-macos-arm64.tar.gz"
    sha256 "81d30e886a04d2bdb6d58ddf8bb8273bf38b29aec1a877faf53d738bafeb724b"
  else
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.3/anime4k-metal-macos-x86_64.tar.gz"
    sha256 "41d45b5b042ede60c0d7d9ad64aedd127be9c97bd9e1c35ad0ace0dea4287154"
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

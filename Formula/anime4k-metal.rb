class Anime4kMetal < Formula
  desc "Native macOS Anime4K image enhancement CLI"
  homepage "https://github.com/cinemore/anime4k-metal"
  version "0.1.2"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.2/anime4k-metal-macos-arm64.tar.gz"
    sha256 "ab9cefa2920663adbcee0804cc42ed0325888d12a7a9b35ae59b508bd0f91929"
  else
    url "https://github.com/cinemore/anime4k-metal/releases/download/v0.1.2/anime4k-metal-macos-x86_64.tar.gz"
    sha256 "3cb0a475bc0282d0611d8620b805bce3dda2f0f9e12db57623212b1fa38abd57"
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

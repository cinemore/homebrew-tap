class FsrMetal < Formula
  desc "Native Apple Metal FSR 1 image upscaling CLI"
  homepage "https://github.com/cinemore/fsr-metal"
  version "0.1.0"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/fsr-metal/releases/download/v0.1.0/fsr-metal-macos-arm64.tar.gz"
    sha256 "cddab7600a7643f2a5c67eb1835c92adf042fe2bf1f1e59767846d2bc18780c2"
  else
    url "https://github.com/cinemore/fsr-metal/releases/download/v0.1.0/fsr-metal-macos-x86_64.tar.gz"
    sha256 "0337d57215b7c7c55bdc7a2a84b67c4df3ed478d2536c543f2bae2c4f0f8dd60"
  end

  def install
    libexec.install "bin/fsr-metal"
    libexec.install "bin/FSRMetal_FSRMetal.bundle"
    (bin/"fsr-metal").write <<~SH
      #!/bin/sh
      exec "#{libexec}/fsr-metal" "$@"
    SH
  end

  test do
    assert_match "FSRMetal self-test", shell_output("#{bin}/fsr-metal --self-test")
  end
end

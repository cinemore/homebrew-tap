class FsrMetal < Formula
  desc "Native Apple Metal FSR 1 image upscaling CLI"
  homepage "https://github.com/cinemore/fsr-metal"
  version "0.1.0"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/fsr-metal/releases/download/v0.1.0/fsr-metal-macos-arm64.tar.gz"
    sha256 "df90f05cc4189d4f3ed05d234f336e0d0381b47c334d75f9f21215caf966dd47"
  else
    url "https://github.com/cinemore/fsr-metal/releases/download/v0.1.0/fsr-metal-macos-x86_64.tar.gz"
    sha256 "e60eff51285a8b97da7919c164914d7956868886b9de6d13e704493dffbb3c34"
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

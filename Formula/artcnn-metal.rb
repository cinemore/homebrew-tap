class ArtcnnMetal < Formula
  desc "Native Apple Metal ArtCNN C4F16 image upscaling CLI"
  homepage "https://github.com/cinemore/artcnn-metal"
  version "0.1.0"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/artcnn-metal/releases/download/v0.1.0/artcnn-metal-macos-arm64.tar.gz"
    sha256 "d74f0f12e73c29b3fd7adbceb7ddbc268b6a4ea88bc66d7ca1a862b265bba7e5"
  else
    url "https://github.com/cinemore/artcnn-metal/releases/download/v0.1.0/artcnn-metal-macos-x86_64.tar.gz"
    sha256 "e8e3de706de8559cb0550d8228bdf773afcebebc9c6c976763cf94d85a6120a7"
  end

  def install
    libexec.install "bin/artcnn-metal"
    libexec.install "bin/ArtCNNMetal_ArtCNNMetal.bundle"
    (bin/"artcnn-metal").write <<~SH
      #!/bin/sh
      exec "#{libexec}/artcnn-metal" "$@"
    SH
  end

  test do
    assert_match "ArtCNNMetal self-test", shell_output("#{bin}/artcnn-metal --self-test")
  end
end

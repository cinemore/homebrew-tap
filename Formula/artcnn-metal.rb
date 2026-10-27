class ArtcnnMetal < Formula
  desc "Native Apple Metal ArtCNN C4F16 image upscaling CLI"
  homepage "https://github.com/cinemore/artcnn-metal"
  version "0.1.0"
  license "MIT"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/artcnn-metal/releases/download/v0.1.0/artcnn-metal-macos-arm64.tar.gz"
    sha256 "3e13b4186b6cf3aa3429fb5723bb036b544c0cbd9b5e49bacd10009f09e7864a"
  else
    url "https://github.com/cinemore/artcnn-metal/releases/download/v0.1.0/artcnn-metal-macos-x86_64.tar.gz"
    sha256 "4a6b3353ffd76da046a75934bfb1e967d88ca3fbba3000705f01e60e99da16e1"
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

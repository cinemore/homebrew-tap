class RifeMetal < Formula
  desc "Native macOS RIFE frame interpolation CLI"
  homepage "https://github.com/cinemore/rife-metal"
  version "0.1.8"
  license "Apache-2.0"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.8/rife-metal-macos-arm64.tar.gz"
    sha256 "ebd4edc1a406b7a0e7118c57b12ed5e798667cc8ac66c236ea578c3f87045dad"
  else
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.8/rife-metal-macos-x86_64.tar.gz"
    sha256 "e28352d2a1c0063dec0dd27d17883421fd64d0118ff3ff4335df710b58a3f82a"
  end

  def install
    libexec.install "bin/rife-metal"
    libexec.install "bin/RifeMetal_RifeMetalCore.bundle"
    pkgshare.install "share/rife-metal/rife-v4.25.rmw"

    (bin/"rife-metal").write <<~SH
      #!/bin/sh
      if [ "$#" -eq 0 ]; then
        exec "#{libexec}/rife-metal"
      fi

      has_model=0
      for arg in "$@"; do
        case "$arg" in
          -m|--model|--model=*)
            has_model=1
            ;;
        esac
      done

      if [ "$has_model" -eq 1 ]; then
        exec "#{libexec}/rife-metal" "$@"
      else
        exec "#{libexec}/rife-metal" "$@" --model "#{pkgshare}/rife-v4.25.rmw"
      fi
    SH
  end

  test do
    assert_match "Native Apple Silicon RIFE frame interpolation", shell_output("#{bin}/rife-metal --help")
  end
end

class RifeMetal < Formula
  desc "Native macOS RIFE frame interpolation CLI"
  homepage "https://github.com/cinemore/rife-metal"
  version "0.1.7"
  license "Apache-2.0"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.7/rife-metal-macos-arm64.tar.gz"
    sha256 "2340d5353afec68fd3c5ab4138a36d139aadd99b862842abee3b3db2ca864690"
  else
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.7/rife-metal-macos-x86_64.tar.gz"
    sha256 "2f5625ec0ce8e3cdddcfb0ed6d0f589d5ff9f522dadb6be9baf1c665028be135"
  end

  def install
    libexec.install "bin/rife-metal"
    libexec.install "bin/RifeMetal_RifeMetalCore.bundle"
    pkgshare.install "share/rife-metal/rife-v4.26.rmw"

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
        exec "#{libexec}/rife-metal" "$@" --model "#{pkgshare}/rife-v4.26.rmw"
      fi
    SH
  end

  test do
    assert_match "Native Apple Silicon RIFE frame interpolation", shell_output("#{bin}/rife-metal --help")
  end
end

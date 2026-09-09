class RifeMetal < Formula
  desc "Native macOS RIFE frame interpolation CLI"
  homepage "https://github.com/cinemore/rife-metal"
  version "0.1.6"
  license "Apache-2.0"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.6/rife-metal-macos-arm64.tar.gz"
    sha256 "5543d97c51d28ad8012ae5d149ac3a55259ea69e0cd14c929041187eb972c59d"
  else
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.6/rife-metal-macos-x86_64.tar.gz"
    sha256 "0af50f7d110dfdccc1931bd6cdeb6f520df3efed431dd7737334a16b64eabc7f"
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

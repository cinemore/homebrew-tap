class RifeMetal < Formula
  desc "Native macOS RIFE frame interpolation CLI"
  homepage "https://github.com/cinemore/rife-metal"
  version "0.1.4"
  license "Apache-2.0"

  depends_on macos: :ventura

  if Hardware::CPU.arm?
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.4/rife-metal-macos-arm64.tar.gz"
    sha256 "958795e47edacb1c2ed01cb7c414094c4fc97d5d1e7646a658986da52b3e79ce"
  else
    url "https://github.com/cinemore/rife-metal/releases/download/v0.1.4/rife-metal-macos-x86_64.tar.gz"
    sha256 "382b5d65624c05ff7deff2d3870a72b45a50a344655260c200b4bec67cd35b7c"
  end

  def install
    libexec.install "bin/rife-metal"
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

# Tessel: a small, compiled language for native apps. This formula installs
# the release package (signed and notarized) from GitHub. The Release
# workflow of alexiusacademia/tessel updates it with each release.
class Tessel < Formula
  desc "Small compiled language for native apps, with the UI written in it"
  homepage "https://tessel-lang.syncster.dev"
  url "https://github.com/alexiusacademia/tessel/releases/download/v0.16.3/tessel-v0.16.3-macos-arm64.tar.gz"
  sha256 "6d2d58f1f73f921b05d0439f003926b84231e109ec515b6ec5903df97587bd79"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    # tessel finds its runtime library and sdk/ next to itself.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"tessel"
  end

  test do
    (testpath/"hello.tsl").write "fn main() {\n    print(\"hello\")\n}\n"
    assert_equal "hello", shell_output("#{bin}/tessel run #{testpath}/hello.tsl").strip
  end
end

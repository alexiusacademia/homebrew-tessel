# Tessel: a small, compiled language for native apps. This formula installs
# the release package (signed and notarized) from GitHub. The Release
# workflow of alexiusacademia/tessel updates it with each release.
class Tessel < Formula
  desc "Small compiled language for native apps, with the UI written in it"
  homepage "https://tessel-lang.syncster.dev"
  url "https://github.com/alexiusacademia/tessel/releases/download/v0.18.0/tessel-v0.18.0-macos-arm64.tar.gz"
  sha256 "954c1141e9d851c57e8dc1e5dd323028294b0bd48a34ab2b81e2345c1c035ab1"
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

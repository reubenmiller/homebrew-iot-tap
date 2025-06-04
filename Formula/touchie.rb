class Touchie < Formula
  desc "TouchID access to Mac Keychain via CLI"
  homepage "https://github.com/reubenmiller/touchie"
  url "https://github.com/reubenmiller/touchie/archive/refs/tags/0.0.3.tar.gz"
  sha256 "b6753bfd098598d2a6784d95e15b80509ad644191d6c50e5712dc5d373559dd5"
  license "MIT"
  depends_on :macos
  uses_from_macos "swift" => :build, since: :sonoma # swift 5.10+

  def install
    system "swiftc", "touchie.swift", "-o", "touchie"
    bin.install "touchie"
  end

  test do
    assert_match "no Github token found", shell_output("#{bin}/touchie --help", 255)
  end
end

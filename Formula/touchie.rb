class Touchie < Formula
  desc "TouchID access to Mac Keychain via CLI"
  homepage "https://github.com/reubenmiller/touchie"
  url "https://github.com/reubenmiller/touchie/archive/refs/tags/0.0.3.tar.gz"
  sha256 "b6753bfd098598d2a6784d95e15b80509ad644191d6c50e5712dc5d373559dd5"
  license "MIT"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/touchie-0.0.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "83c4675c91d9ad0d853ceb33ddb087f62200663fa75247a39f8a7dd61465ce06"
    sha256 cellar: :any_skip_relocation, ventura:       "89bf991024e76f7126b73e220d736c61521fcbdef89577941d31ba49f96bdc26"
  end
  depends_on :macos
  uses_from_macos "swift" => :build, since: :sonoma # swift 5.10+

  def install
    system "swiftc", "touchie.swift", "-o", "touchie"
    bin.install "touchie"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/touchie --help")
  end
end

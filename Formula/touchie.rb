class Touchie < Formula
  desc "TouchID access to Mac Keychain via CLI"
  homepage "https://github.com/reubenmiller/touchie"
  url "https://github.com/reubenmiller/touchie/archive/refs/tags/0.0.5.tar.gz"
  sha256 "1a97435ab64beffa0b9ad75be5ba88a1304c3b66850657f699e303fef15ab323"
  license "MIT"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/touchie-0.0.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "686e36c5d7d2a7a3a54c97f0b356906dc7b33a8fb298126295adaf8cc4920c4c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5f319d9c20966da3d76e8ff664e771cb19172734866b651ec8fe1c8878fe1839"
    sha256 cellar: :any_skip_relocation, ventura:       "fc221b70cd9989bddd8d66d84b47f901e5cd92b6b8e06cd6cd0caa602bb2264c"
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

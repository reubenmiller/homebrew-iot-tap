class Touchie < Formula
  desc "TouchID access to Mac Keychain via CLI"
  homepage "https://github.com/reubenmiller/touchie"
  url "https://github.com/reubenmiller/touchie/archive/refs/tags/0.0.5.tar.gz"
  sha256 "1a97435ab64beffa0b9ad75be5ba88a1304c3b66850657f699e303fef15ab323"
  license "MIT"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/touchie-0.0.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "acb953cf6b9de3cea5bdef9eb958d67fcfdfda8b39cba41469caf7d2d995c398"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3ff1edd8908e55974cc9688ffd7d8cb50409effc3b4de40c757a5de16b6f2d5d"
    sha256 cellar: :any_skip_relocation, ventura:       "0618b8e8cde96930fd2370e839c8b222473484e86fe55df62a22e51e50692356"
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

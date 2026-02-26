class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.11.4.tar.gz"
  sha256 "ee825dc50a0212af2a9dc765b1d6ebdb45703bf37dd411c358b47daa84b1412f"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.11.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1eb999c165401f9e99c775b2a435cb663fcbe39421b48e4b30036bb86d2d3fbf"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ac5fb93b6780e063ebc048937650bca40393ecc22c17638bc4f5904c6b788949"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "546a1abc6a0e4ae6728dcb929689f01d3e887ee32e9c5191dc89cc8a6e29a34a"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = OS.mac? ? "1" : "0"
    ldflags = %W[
      -s -w
      -X main.version=v#{version}
      -X main.commit=#{tap.user}
      -X main.date=#{time.iso8601}
      -X main.builtBy=homebrew
    ]
    system "go", "build", *std_go_args(ldflags:), "main.go"
    generate_completions_from_executable(bin/"tedge-oscar", "completion", shells: [:zsh])
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/tedge-oscar --help")
  end
end

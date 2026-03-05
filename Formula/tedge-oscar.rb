class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "798e76591af7fdb6fe24a276ad06d88781878e4b0a45b926bad147a75d40c5b1"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.12.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "458d768cf67315963d97e76044a9a9689d050c02d10aa1fdd1db2982464caa77"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bed97f8a8c25ac7f73f86a50b86ede1bc95b07915f48897e1b5d514faf5a7714"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "956df911f568e3df0265cba6ac9b1338fee1a0d6f4563cdf9d116304d936b68a"
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

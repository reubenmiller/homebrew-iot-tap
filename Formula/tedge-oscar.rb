class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.11.4.tar.gz"
  sha256 "ee825dc50a0212af2a9dc765b1d6ebdb45703bf37dd411c358b47daa84b1412f"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.11.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3bfaf01a722a02f94442be68c92ce3c3974cad1c8ccd44b1099c5d7d20b79281"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d587771cc12bcef17c06832898dc4cf171a9eadc308642c8206623db9ce9a3e9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "616e44ed3c20db41019bcf5addf10680110dd09a477aff0a247c8ee77f729c1d"
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

class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "e70a438530c40fd395fd1484256fe6c97c8061d62771b46375419d9d5d462e81"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3fcda28102dca288b18566d247294d24203e7c07f135920cd199258ffc7f37f0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7f2adf6b02ddddc8bb8232cc87b3c99be21dd46402168f4f471388e528ac3711"
    sha256 cellar: :any_skip_relocation, ventura:       "d39aee6b9648a4206bcf298693903aa49d11e74bb7e560101275c7f477f4ce14"
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

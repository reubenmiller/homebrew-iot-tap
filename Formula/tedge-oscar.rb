class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "cc6f4eec5f81ce8ae10766796f5514a28e42ce4de2a9f4e7c7e323414cbef6e5"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.0.6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "769ca1b795eb38396ac7cb699d9c6df758df8112f7581be384519fa62c6a85d7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "af43f9896f201a7a109e1701e3dce8fc252cd3b9312b56d07bef45f3294e7d9f"
    sha256 cellar: :any_skip_relocation, ventura:       "3dbe43e6bfcc8f610208c178984214b9570b595022169062aee7500dc32ee2de"
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

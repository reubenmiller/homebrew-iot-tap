class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "cc6f4eec5f81ce8ae10766796f5514a28e42ce4de2a9f4e7c7e323414cbef6e5"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "32295cd09d83d06d6b0e84a15f3bd06123de7bff86e1803b782e578a0650f92c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fea546a16957f1dd0229f5ffecddf6530bbee3a9892ec9f7a63b2e6c8f3780fe"
    sha256 cellar: :any_skip_relocation, ventura:       "658dbed52cda794a59b55adbf5a44a92a105d1acc967c51da88dcfa7406d3815"
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

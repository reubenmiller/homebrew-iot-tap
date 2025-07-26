class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "eae0aa816c2bdbb166151e18d59ea9c35344a42ddf035c9bbe4682d7be457902"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.0.5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b30912831cd0c0e9188d00d09e4b23c729220d15a84bb622af1c8e35fb85fd7c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bc6e06a52c8ecd9f6a874feda4f9b4fe1948bfa9a76928a23ab6c752b80636e4"
    sha256 cellar: :any_skip_relocation, ventura:       "de284c3a7b1b27f5a8710413058b97c52a703e6d05ea0dddc1a5b2265ece18aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "884d28eab0dbfa73616f0341950e25e5291b05514c1f3e4f6d612466d8b957fb"
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

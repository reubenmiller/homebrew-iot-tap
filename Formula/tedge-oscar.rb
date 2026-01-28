class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.11.1.tar.gz"
  sha256 "75ea37c9ce48521d65ed67958c229acb88bb808940d059f3f13b43ddb7e43afc"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.11.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "37d14ff0fa03221d00418dda11687d1b416a912e3de411c9d244a2a7f812baa1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6929a77f121ea205a2c70fc74124bd7bbab328a579fff9c9be327ffe85d903be"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "917d8e922b8c1850cf73fb20754dcbfe8c0b0100d6421d4f81e70436ae777f0a"
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

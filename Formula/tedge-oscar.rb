class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "95e6154c7cf724a991cc491ee6e92cf166ed1677f1abc5ca13e7efae2af1a8f8"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ea9a964eceddc46f6c1bd59c2eccf33e4726535eef8ae307763f42f4ad78fba6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a7ee15cec93b8c9462852f4a75b0ce56ed27d02723729b29eb85b5626ee47c9c"
    sha256 cellar: :any_skip_relocation, ventura:       "d6ba09974ac70a98b4d6b79b6a880a539b807e172af79c1083f112eedc3e755e"
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

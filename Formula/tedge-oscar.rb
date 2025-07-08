class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "a9edb0211d1bf2fe54eb95dea0ef8723ce7838a48e3c5020558954107b143a35"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.0.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "107f2b182b02cfe63fc6cf9c7f668145f21632446de2150245d03522955f4cac"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "138717e87a7ce2a8d1ef14dc9108e482a929ace5f6da8a617d526c494c36f254"
    sha256 cellar: :any_skip_relocation, ventura:       "67f290cbba760faefba918d8a78abdd7f40dbe3186d8c5b531a95f8d3f7b9101"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63075bf7b98e798212eacc10411921967b5363c010811768296ecc76cb7ab377"
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

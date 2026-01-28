class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.11.1.tar.gz"
  sha256 "75ea37c9ce48521d65ed67958c229acb88bb808940d059f3f13b43ddb7e43afc"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.11.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a03d2a92c722905cf00419c5d614af5d5d0c733126b456a5619d280e44d3ae65"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f0307112c7f8291f86c688aa8f13f9dd9895928cb634312d520ada9766f2c8d2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "99c60150e7af531384884e14566fa034c5ed122d27ae9679caa1fb643ce714ab"
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

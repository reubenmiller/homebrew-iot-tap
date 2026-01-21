class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "99eadbdfef4b1818a673f4ba0c06bacf88d47221d71a349d54c2f29cf5c35771"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "634b74c07d28fba99c25f059023a35f1a52b3dca773368a489b734b5d9c0745f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8f96ce62f7417acd4e1294fbe9301e916bdd900ec43c8af69738c1e890922f8a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ff43e7aec4b544a74f04ebfca0bf7d8c0dee43ebba1abdfb8321203d42b0a204"
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

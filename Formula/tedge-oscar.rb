class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/touchie/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "a9edb0211d1bf2fe54eb95dea0ef8723ce7838a48e3c5020558954107b143a35"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"
  license "MIT"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.0.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "43baf54c8e7c3553c8159ba4002945263162cb0111e911da24e053c7d659e45f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6a5756305fe31e5d659e6aa843c9bd98586f9b39ab5b75ba4abf9a17ae2720de"
    sha256 cellar: :any_skip_relocation, ventura:       "f4210aebb941b7c115dc47858bd3f87d807c4479b96ea95010de6b9d1a5fc1aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6e131cf8c60ec7dfe68baae567d7a877d3047a8c40b954a53d986877fdbb9e5"
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

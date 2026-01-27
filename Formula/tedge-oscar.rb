class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "5860b54e8cbd54866350dc85c97ff9f21345d8df2aafa5d2613748267bc50667"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.10.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "052ce80972d893d2c5bdc99f120e7e489eb5ff2ff5dec53f1438ff1eae92fe77"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fe87e96a41d82c4572f47afce4131fb78f07013e97afa77e6127d0cab403a900"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c9eb1fe991bb3c793a9942c0d7bb1028e5870f3643cf20fe3faf61cef66c2617"
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

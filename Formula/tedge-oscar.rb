class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "528ae82a8efc8e0f952c54de984b5749977104a0e092afb2ed5bf5470c9ef6d9"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.0.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e8cbe45f61ac81850d743d3f6be5358164b7ad36cc5355edf3c8e5f30647a678"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fa7802a474c47784e9cf5321f9959aad27eca6f22984fe4cbcde34f054db4e8d"
    sha256 cellar: :any_skip_relocation, ventura:       "050c1a1cb338861f97f8fe22c3bfc7c9e545735cd7054bb5e272c7ab09a11fa7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b7f11f9f3003b79d0ddff26470a725e1879b943252430fb5415bce1e0856a53"
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

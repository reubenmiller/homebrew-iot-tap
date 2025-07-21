class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "627b8c522aba5660aac8a5a199e02b475064e0cdcb392c38def13b8d5205e61c"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.0.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c85293f9dec8601849202c9f7e40a463af244a65eb30a0e13241deb6e1f9ed57"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a9e4395da7b44cfe206c5feb505dd1e3a9bd6a5b080a491c2e92b5c5a32ead86"
    sha256 cellar: :any_skip_relocation, ventura:       "f0c2b00606b8eacae7493682b62bc16c80b5a919e1419753cf672ff7048b87d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21fbb4b67a4d7901e060565b68a2f305967f7b26c7c9c04d375bbdcbf953a659"
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

class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "e70a438530c40fd395fd1484256fe6c97c8061d62771b46375419d9d5d462e81"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60492cc341ad735e6b1cc5ec99db25c8ab18e29aa3d06bc644af2a96666376e6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "798220aed9c07243d3516375dcc0b7e1e751ecbf63c23a87a5f8f5404b763deb"
    sha256 cellar: :any_skip_relocation, ventura:       "f49eec724bb791998e27ffc613f81cee1294294c0aee10236b47a337382022d1"
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

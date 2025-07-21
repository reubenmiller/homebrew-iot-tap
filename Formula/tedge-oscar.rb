class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "627b8c522aba5660aac8a5a199e02b475064e0cdcb392c38def13b8d5205e61c"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.0.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "db378f6c6084ad8c31c429eba8c128b7205898ddcda78825421c9790885f0c9e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a20d68324954cf10e160ddddf128c7016f0e28caa6f23b6a748157d1f56deab0"
    sha256 cellar: :any_skip_relocation, ventura:       "45651c15e1d35dc0a763e04f5eab59d44c0139387202c003ef2a384ce56e0f3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ed97d08594691a8de051d976488cbb51b71fcbeb6063b2d0d7e8f1ddd16724e"
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

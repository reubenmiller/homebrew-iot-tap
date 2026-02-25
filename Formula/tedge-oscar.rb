class TedgeOscar < Formula
  desc "Experiment in using OCI artifacts for managing some thin-edge.io artifacts"
  homepage "https://github.com/reubenmiller/tedge-oscar"
  url "https://github.com/reubenmiller/tedge-oscar/archive/refs/tags/v0.11.3.tar.gz"
  sha256 "5c5ea6b8ae2528e65ee5b3570566e5a35b4e8104c16a41b825f1257deccbb290"
  license "MIT"
  head "https://github.com/reubenmiller/tedge-oscar.git", branch: "main"

  bottle do
    root_url "https://github.com/reubenmiller/homebrew-iot-tap/releases/download/tedge-oscar-0.11.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e162b24ea4ef079763b5334f88f6b528ff5b3d61193a3f506a13f4bab8cd13b4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "66c5a01788df11a3458c7687eb916e73b9ef0999b71e86fb84ee8ae5ef00196f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "754007eaf7bbce70bee9996d48286bdac58ef66dec5b3807e0394a9a44354a9a"
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

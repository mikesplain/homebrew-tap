class Kops < Formula
  desc "Production Grade K8s Installation, Upgrades, and Management"
  homepage "https://kops.sigs.k8s.io/"
  url "https://github.com/kubernetes/kops/archive/v1.24.1.tar.gz"
  sha256 "011c01528e5906e6d4ffa4371f9f855b8fe8c635f67a056eaeda0b02f8050e92"
  license "Apache-2.0"
  revision 1
  head "https://github.com/kubernetes/kops.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/mikesplain/tap"
    sha256 cellar: :any_skip_relocation, monterey:     "7b5b70321bb85308b31b2b106b333ed9a27b391b64f7783643aeae92f67a9f55"
    sha256 cellar: :any_skip_relocation, big_sur:      "de7514f36017c0064a8f6a92d7f2eb7a8602e8719c5f24962bc66a41859fabcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5fe2d9ca7e4ddfde32a1a11eed4da1ed0761cb9b30aac7173ffac4ba2a3db425"
  end

  depends_on "go" => :build
  depends_on "kubernetes-cli"

  def install
    ldflags = "-s -w -X k8s.io/kops.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "k8s.io/kops/cmd/kops"

    bash_output = Utils.safe_popen_read(bin/"kops", "completion", "bash")
    (bash_completion/"kops").write bash_output
    zsh_output = Utils.safe_popen_read(bin/"kops", "completion", "zsh")
    (zsh_completion/"_kops").write zsh_output
    fish_output = Utils.safe_popen_read(bin/"kops", "completion", "fish")
    (fish_completion/"kops.fish").write fish_output
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kops version")
    assert_match "no context set in kubecfg", shell_output("#{bin}/kops validate cluster 2>&1", 1)
  end
end

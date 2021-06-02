class Kops < Formula
  desc "Production Grade K8s Installation, Upgrades, and Management"
  homepage "https://github.com/kubernetes/kops"
  url "https://github.com/kubernetes/kops/archive/v1.20.1.tar.gz"
  sha256 "ac046373ff44269d2a5a0bdf4a0c646484e2ce8d451c9066a9155503e595bea8"
  license "Apache-2.0"
  head "https://github.com/kubernetes/kops.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/mikesplain/homebrew-tap/releases/download/kops-1.20.1"
    sha256 cellar: :any_skip_relocation, catalina:     "5649a9807d6eaa88a81e09d1c2aa482f223366aaf7d541d75478f46b99a9ff0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ff45026a3c33591587ddf7443390d11d940083bf6bf0bbc8e8b8d66ddbfeb065"
  end

  depends_on "go" => :build
  depends_on "kubernetes-cli"

  def install
    ENV["VERSION"] = version unless build.head?
    ENV["GOPATH"] = buildpath
    kopspath = buildpath/"src/k8s.io/kops"
    kopspath.install Dir["*"]
    system "make", "-C", kopspath
    bin.install("bin/kops")

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/kops", "completion", "bash")
    (bash_completion/"kops").write output

    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/kops", "completion", "zsh")
    (zsh_completion/"_kops").write output
  end

  test do
    system "#{bin}/kops", "version"
  end
end

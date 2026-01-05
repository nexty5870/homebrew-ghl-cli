# Homebrew formula for ghl-cli
class GhlCli < Formula
  desc "GoHighLevel CLI - Manage your GHL account from the terminal"
  homepage "https://github.com/nexty5870/ghl-cli"
  url "https://github.com/nexty5870/ghl-cli/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bdbf241677bd2b30b5fcdaee64385fd6b4876ef5b4dde193df149108d1e4c144"
  license "ISC"

  depends_on "node"

  def install
    system "npm", "install"
    system "npm", "run", "build"
    # Remove devDependencies after build
    system "npm", "prune", "--production"
    libexec.install Dir["*"]
    (bin/"ghl").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    EOS
    chmod 0755, bin/"ghl"
  end

  test do
    system bin/"ghl", "--version"
  end
end

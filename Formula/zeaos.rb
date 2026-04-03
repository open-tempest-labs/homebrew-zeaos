class Zeaos < Formula
  desc "Arrow-native interactive data REPL powered by DuckDB"
  homepage "https://github.com/open-tempest-labs/zeaos"
  url "https://github.com/open-tempest-labs/zeaos/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "af0534bb1e8c8b29c83e2528fefb6d43fd128dfcbb956546fbece48140704cfc"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",
      "-ldflags", "-s -w -X main.version=#{version}",
      "-o", bin/"zeaos",
      "./cmd/zeaos"
  end

  test do
    assert_match "ZeaOS", shell_output("#{bin}/zeaos --help 2>&1")
    assert_match version.to_s, shell_output("#{bin}/zeaos --version 2>&1")
  end
end

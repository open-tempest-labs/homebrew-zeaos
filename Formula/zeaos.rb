class Zeaos < Formula
  desc "Arrow-native interactive data REPL powered by DuckDB"
  homepage "https://github.com/open-tempest-labs/zeaos"
  url "https://github.com/open-tempest-labs/zeaos/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d393d3111d70d9b9c0d6e6a6c791d91ab31b226093faa4130ff7ace600658261"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",
      "-ldflags", "-s -w -X main.version=#{version}",
      "-o", bin/"zeaos",
      "./cmd/zeaos"
  end

  test do
    assert_match "ZeaOS", shell_output("#{bin}/zeaos --version 2>&1", 1)
  end
end

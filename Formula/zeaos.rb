class Zeaos < Formula
  desc "Interactive data shell: load, explore, and publish as Apache Iceberg"
  homepage "https://github.com/open-tempest-labs/zeaos"
  url "https://github.com/open-tempest-labs/zeaos/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0b2710eb3cd496552f5b25bdf043bb39f1949edc02ee9cd29f34b3f0f9d0766a"
  license "Apache-2.0"

  depends_on "go" => :build

  def caveats
    <<~EOS
      ZeaDrive (the zea:// volume mount) requires macFUSE:
        brew install --cask macfuse

      After installing macFUSE you must:
        1. Open System Settings → Privacy & Security
        2. Allow the macFUSE system extension
        3. Reboot your Mac

      Apple Silicon users may also need to reduce the startup security
      policy in Recovery Mode to permit third-party kernel extensions.

      Full instructions: https://github.com/open-tempest-labs/zeaos/blob/main/docs/installation.md
    EOS
  end

  def install
    system "go", "build",
      "-tags", "duckdb_arrow",
      "-ldflags", "-s -w -X main.version=#{version}",
      "-o", bin/"zeaos",
      "./cmd/zeaos"
  end

  test do
    assert_match "ZeaOS", shell_output("#{bin}/zeaos --help 2>&1")
    assert_match version.to_s, shell_output("#{bin}/zeaos --version 2>&1")
  end
end

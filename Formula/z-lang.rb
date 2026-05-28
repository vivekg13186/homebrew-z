class ZLang < Formula
  desc "Mini Lisp-flavoured language and interpreter (z + zide REPL)"
  homepage "https://github.com/vivekg13186/z_lang"
  url "https://github.com/vivekg13186/z_lang/releases/download/0.0.1/z-macos-arm64.tar.gz"
  sha256 "f6156e7e0a5072d2158c76078c7ad28eff32e835feebac3a0fb3bab7044e0a4d"
  license "MIT"
  head "https://github.com/vivekg13186/z_lang.git", branch: "main"

  def install
    system "make"
    # The Makefile drops binaries in dist/<os>_<arch>/ and creates `./z` /
    # `./zide` symlinks at the project root. Install via the real files.
    bin.install Dir["dist/*/z"][0]    => "z"
    bin.install Dir["dist/*/zide"][0] => "zide"
    pkgshare.install "examples"
    pkgshare.install "CHEATSHEET.md"
    doc.install "README.md"
  end

  test do
    (testpath/"hello.z").write '(print "hello from z")'
    assert_match "hello from z", shell_output("#{bin}/z #{testpath}/hello.z")
  end
end

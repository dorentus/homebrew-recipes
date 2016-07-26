class Xcbuild < Formula
  desc "Xcode-compatible build tool."
  homepage "https://github.com/facebook/xcbuild/"
  url "https://github.com/facebook/xcbuild.git", :tag => "0.1.0",
                                                  :shallow => false
  head 'https://github.com/facebook/xcbuild.git'

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
    bin.install_symlink "#{prefix}/usr/bin/xcbuild"
    bin.install_symlink "#{prefix}/usr/bin/builtin-copy"
    bin.install_symlink "#{prefix}/usr/bin/builtin-copyPlist"
    bin.install_symlink "#{prefix}/usr/bin/builtin-copyStrings"
    bin.install_symlink "#{prefix}/usr/bin/builtin-copyTiff"
    bin.install_symlink "#{prefix}/usr/bin/builtin-embeddedBinaryValidationUtility"
    bin.install_symlink "#{prefix}/usr/bin/builtin-infoPlistUtility"
    bin.install_symlink "#{prefix}/usr/bin/builtin-lsRegisterURL"
    bin.install_symlink "#{prefix}/usr/bin/builtin-productPackagingUtility"
    bin.install_symlink "#{prefix}/usr/bin/builtin-validationUtility"
    bin.install_symlink "#{prefix}/usr/bin/dependency-info-tool"
  end

  test do
    system "#{bin}/xcbuild", "-showsdks"
  end
end

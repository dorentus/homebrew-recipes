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
  end

  test do
    system "#{bin}/xcbuild", "-showsdks"
  end
end

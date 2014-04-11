require 'formula'

class LolcatMruby < Formula
  homepage 'https://github.com/dorentus/mruby-lolcat-bin'

  url 'https://github.com/dorentus/mruby-lolcat-bin.git', :tag => 'v0.42.1'
  version '0.42.1'

  head 'https://github.com/dorentus/mruby-lolcat-bin.git'

  def install
    syetem "make install PREFIX=#{prefix}"
  end

  def test
    system "brew list | lolcat_m"
  end
end

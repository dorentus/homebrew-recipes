require 'formula'

class LolcatMruby < Formula
  homepage 'https://github.com/dorentus/mruby-lolcat-bin'

  url 'https://github.com/dorentus/mruby-lolcat-bin.git', :tag => 'v0.42.2'
  version '0.42.2'

  head 'https://github.com/dorentus/mruby-lolcat-bin.git'

  def install
    system "make install PREFIX=#{prefix}"
  end

  def test
    system "brew list | lolcat_m"
  end
end

require 'formula'

class LolcatMruby < Formula
  homepage 'https://github.com/dorentus/mruby-lolcat-bin'

  url 'https://github.com/dorentus/mruby-lolcat-bin.git', :tag => 'v0.42.4'

  head 'https://github.com/dorentus/mruby-lolcat-bin.git'

  def install
    system "make install PREFIX=#{prefix}"
  end

  def caveats
    %x(lolcat -h)
  end

  def test
    system "lolcat -v"
  end
end

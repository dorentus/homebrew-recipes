require 'formula'

class LolcatMruby < Formula
  homepage 'https://github.com/dorentus/mruby-lolcat-bin'

  url 'https://github.com/dorentus/mruby-lolcat-bin.git', :tag => 'v0.42.6'

  head 'https://github.com/dorentus/mruby-lolcat-bin.git'

  def install
    system "make install PREFIX=#{prefix}"
  end

  def caveats
    %x(echo "Installation complete, type lolcat -h for usage instructions" | #{prefix}/bin/lolcat -f)
  end

  def test
    system "lolcat -v"
  end
end

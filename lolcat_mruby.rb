require 'formula'

class LolcatMruby < Formula
  homepage 'https://github.com/dorentus/mruby-lolcat'

  url 'https://github.com/dorentus/mruby-lolcat.git', :tag => 'v0.42.15'

  head 'https://github.com/dorentus/mruby-lolcat.git'

  def install
    system "make -C binutils install PREFIX=#{prefix}"
  end

  def caveats
    %x(echo "Type lolcat -h for usage instructions" | #{prefix}/bin/lolcat -f)
  end

  def test
    system "lolcat -v"
  end
end

require 'formula'

class Tsocks < Formula
  homepage 'https://github.com/pc/tsocks'

  head 'https://github.com/pc/tsocks.git'

  depends_on 'autoconf' => :build if MacOS.xcode_version.to_f >= 4.3

  def install
    inreplace 'tsocks', 'LIBDIR="/lib"', "LIBDIR=\"#{lib}\""

    system "autoconf", "-v"
    system "./configure", "--with-conf=#{config_file}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    man1.install 'tsocks.1'
    man8.install 'tsocks.8'
    man5.install 'tsocks.conf.5'

    etc.install 'tsocks.conf.simple.example' => 'tsocks.conf' unless config_file.exist?
  end

  def patches
    DATA
  end

  def caveats; <<-EOS.undent
    The configuration file is: #{config_file}.
    Please edit it first.
    `man 5 tsocks.conf` for more details.
    EOS
  end

  def test
    puts 'Your current public ip is:'
    ohai `curl -sS ifconfig.me 2>&1`.chomp
    puts "If your correctly configured #{config_file}, this should show the ip you have trough the proxy"
    puts 'Your ip through the proxy is:'
    ohai `tsocks curl -sS ifconfig.me 2>&1`.chomp
  end

  def config_file
    etc / 'tsocks.conf'
  end

end

__END__
--- /dev/null
+++ b/tsocks.conf
@@ -0,0 +1,6 @@
+local = 192.168.0.0/255.255.255.0
+local = 10.0.0.0/255.0.0.0
+
+server = localhost
+server_type = 5
+server_port = 1080

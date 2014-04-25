require 'formula'

class ShadowsocksLibev < Formula
  homepage 'https://github.com/madeye/shadowsocks-libev'

  url 'https://github.com/madeye/shadowsocks-libev.git', :tag => 'v1.4.4'

  head 'https://github.com/madeye/shadowsocks-libev.git'

  option "with-polarssl", "Use PolarSSL instead of OpenSSL"

  depends_on 'libev'
  if build.with? "polarssl"
    depends_on "polarssl"
  else
    depends_on "openssl"
  end

  def install
    inreplace 'shadowsocks.8', '/etc/shadowsocks/config.json', "#{etc}/shadowsocks-client.json"

    args = ["--prefix=#{prefix}"]

    if build.with? "polarssl"
      polarssl = Formula["polarssl"]

      args << '--with-crypto-library=polarssl'
      args << "--with-polarssl=#{polarssl.prefix}"
    end

    system './configure', *args
    system 'make'
    system 'make install'
    man8.install 'shadowsocks.8'
    etc.install 'shadowsocks-client.json' unless (etc/'shadowsocks-client.json').exist?
  end

  def patches
    DATA
  end

  def caveats
    "Edit #{etc}/shadowsocks-client.json to configure Shadowsocks-libev client"
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/opt/shadowsocks-libev/bin/ss-local -c #{HOMEBREW_PREFIX}/etc/shadowsocks-client.json"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/ss-local</string>
          <string>-c</string>
          <string>#{etc}/shadowsocks-client.json</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
      </dict>
    </plist>
    EOS
  end
end

__END__
--- /dev/null
+++ b/shadowsocks-client.json
@@ -0,0 +1,8 @@
+{
+    "server":"localhost",
+    "server_port":8388,
+    "local_port":1080,
+    "password":"barfoo!",
+    "timeout":600,
+    "method":null
+}

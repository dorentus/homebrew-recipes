require 'formula'

class ShadowsocksLibev < Formula
  homepage 'https://github.com/madeye/shadowsocks-libev'

  url 'https://github.com/madeye/shadowsocks-libev.git', :tag => 'v1.3.2'
  version '1.3.2'

  head 'https://github.com/madeye/shadowsocks-libev.git'

  depends_on 'libev'

  def install
    inreplace 'shadowsocks.8', '/etc/shadowsocks/config.json', "#{etc}/ss-config.json"

    args = ["--prefix=#{prefix}"]
    system './configure', *args
    system 'make'
    system 'make install'
    man8.install 'shadowsocks.8'
    etc.install 'ss-config.json' unless (etc/'ss-config.json').exist?
  end

  def patches
    DATA
  end

  def caveats; <<-EOS.undent
    The configuration file is: #{etc}/ss-config.json.
    You should edit it first.
    EOS
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_prefix}/bin/ss-local</string>
          <string>-c</string>
          <string>#{etc}/ss-config.json</string>
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
+++ b/ss-config.json
@@ -0,0 +1,8 @@
+{
+    "server":"localhost",
+    "server_port":8388,
+    "local_port":1080,
+    "password":"barfoo!",
+    "timeout":600,
+    "method":null
+}

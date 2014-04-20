require 'formula'

class ShadowspdyClient < Formula
  homepage 'https://github.com/clowwindy/ShadowSPDY'

  head 'https://github.com/clowwindy/ShadowSPDY.git'

  depends_on 'node'

  def config_file
    "sspdy-config.json"
  end

  def patches
    DATA
  end

  def install
    system "#{HOMEBREW_PREFIX}/bin/npm install"
    etc.install 'config.json' => config_file unless (etc/config_file).exist?
    prefix.install Dir["*"]
  end

  def caveats; <<-EOS.undent
    The configuration file is: #{etc}/#{config_file}.
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
          <string>#{opt_prefix}/bin/splocal</string>
          <string>-c</string>
          <string>#{etc}/#{config_file}</string>
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
--- a/bin/splocal
+++ b/bin/splocal
@@ -1,4 +1,4 @@
-#!/usr/bin/env node
+#!/usr/local/bin/node

 var path = require('path');
 var fs = require('fs');


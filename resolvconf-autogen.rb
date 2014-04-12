require 'formula'

class ResolvconfAutogen < Formula
  homepage 'https://github.com/dorentus/resolvconf-autogen'

  url 'https://github.com/dorentus/resolvconf-autogen.git', :tag => '0.1.2'

  head 'https://github.com/dorentus/resolvconf-autogen.git'

  def install
    rake "install", "prefix=#{prefix}"
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
          <string>#{opt_prefix}/bin/resolvconf-autogen</string>
          <string>#{etc}/resolv.conf</string>
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

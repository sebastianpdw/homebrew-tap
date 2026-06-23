class PowerspacesApp < Formula
  desc "Per-Space dock and smart-launch for macOS Spaces (menu-bar app)"
  homepage "https://github.com/sebastianpdw/powerspaces"
  url "https://github.com/sebastianpdw/powerspaces/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4ddce3ceaa06bdf5aea6dd4766d1e3d6a9f6ef341193821dd4f1a2ca33e06282"
  license "GPL-3.0-only"
  head "https://github.com/sebastianpdw/powerspaces.git", branch: "main"

  depends_on macos: :sonoma # Package.swift requires macOS 14+

  def install
    # Same steps as scripts/make-app.sh. The only delta is --disable-sandbox:
    # SwiftPM's build sandbox collides with Homebrew's, and the package has no
    # external dependencies, so there is no network access during the build.
    system "swift", "build", "-c", "release", "--disable-sandbox", "--product", "PowerspacesApp"
    system "swift", "build", "-c", "release", "--disable-sandbox", "--product", "powerspaces"

    iconset = buildpath/"AppIcon.iconset"
    system ".build/release/PowerspacesApp", "--export-iconset", iconset

    app = prefix/"Powerspaces.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath
    cp ".build/release/PowerspacesApp", app/"Contents/MacOS/Powerspaces"
    system "iconutil", "-c", "icns", iconset, "-o", app/"Contents/Resources/AppIcon.icns"

    # The powerspaces helper ships inside the .app (used by "Set Up Raycast..."),
    # not installed on PATH.
    cp ".build/release/powerspaces", app/"Contents/Resources/powerspaces"
    cp_r "raycast-extension", app/"Contents/Resources/raycast-extension"

    (app/"Contents/Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleName</key>               <string>Powerspaces</string>
        <key>CFBundleDisplayName</key>        <string>Powerspaces</string>
        <key>CFBundleExecutable</key>         <string>Powerspaces</string>
        <key>CFBundleIdentifier</key>         <string>nl.sebastianpdw.powerspaces</string>
        <key>CFBundleIconFile</key>           <string>AppIcon</string>
        <key>CFBundlePackageType</key>        <string>APPL</string>
        <key>CFBundleShortVersionString</key> <string>#{version}</string>
        <key>CFBundleVersion</key>            <string>1</string>
        <key>LSMinimumSystemVersion</key>     <string>14.0</string>
        <key>LSUIElement</key>                <true/>
        <key>NSHighResolutionCapable</key>    <true/>
        <key>NSPrincipalClass</key>           <string>NSApplication</string>
        <key>NSAppleEventsUsageDescription</key>
        <string>Powerspaces controls apps like Finder, Safari, and Terminal to open a new window on your current desktop.</string>
      </dict>
      </plist>
    PLIST
  end

  def caveats
    <<~EOS
      Link Powerspaces.app into an Applications folder so Spotlight/Launchpad find it:
        ln -sf "#{opt_prefix}/Powerspaces.app" ~/Applications/      # no sudo (recommended)
      Then launch it and grant Accessibility when prompted:
        open "#{opt_prefix}/Powerspaces.app"
    EOS
  end

  test do
    assert_predicate prefix/"Powerspaces.app/Contents/MacOS/Powerspaces", :executable?
  end
end

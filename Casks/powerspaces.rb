cask "powerspaces" do
  version "1.1.0"
  sha256 "9d6e3b1f744a975e93906aa59635fa0ac32f1e18f325c35d1cfc79b6262e42c3"

  url "https://github.com/sebastianpdw/powerspaces/releases/download/v#{version}/Powerspaces.app.zip"
  name "Powerspaces"
  desc "Per-Space dock and smart-launch for macOS Spaces"
  homepage "https://github.com/sebastianpdw/powerspaces"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Powerspaces.app"

  caveats <<~EOS
    Powerspaces is unsigned, so macOS blocks the first launch. Clear it with one command:

      xattr -dr com.apple.quarantine /Applications/Powerspaces.app

    then open Powerspaces and grant Accessibility when prompted.

    No Terminal? Open Powerspaces (it gets blocked), then go to System Settings >
    Privacy & Security > Security and click "Open Anyway".
  EOS

  zap trash: "~/.config/powerspaces"
end

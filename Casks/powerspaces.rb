cask "powerspaces" do
  version "1.2.0"
  sha256 "93df62e78bb6d9fa47a29687a564f49e8469abf3a93bd623ca94c5b97b9fa93e"

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

  zap trash: "~/.config/powerspaces"
end

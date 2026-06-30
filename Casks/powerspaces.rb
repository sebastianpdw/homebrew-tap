cask "powerspaces" do
  version "1.2.0"
  sha256 "1213ae34b5e6ad2c0b7a5ca016d2b59e38aa2b61d31ab2118c6b7aa83cc1364e"

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

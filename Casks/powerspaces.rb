cask "powerspaces" do
  version "1.2.1"
  sha256 "4e266faff6d17a4b16cd9221abc923bd48d9a2e085c2c653b4a9f552c30130ac"

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

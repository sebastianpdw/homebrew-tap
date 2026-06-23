cask "powerspaces" do
  version "1.0.0"
  sha256 "57d3009a6e0b2bba4d3630b3d185f7fa759ba84373e06a21d9276f26a3545324"

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

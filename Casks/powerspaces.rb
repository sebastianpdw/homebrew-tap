cask "powerspaces" do
  version "1.1.0"
  sha256 "d2ef44556247f39948fb71a9eb1dd6d192be9714cd4966d58f55aef0e450b5b7"

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

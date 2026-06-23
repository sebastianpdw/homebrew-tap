cask "powerspaces" do
  version "1.0.0"
  sha256 "7ce21c4c7ebe93110badcf18bfccb9f2ca35ddfdf28c4917e3a73e0d32c0571b"

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
    Powerspaces is ad-hoc signed but not notarized, so macOS blocks it on first launch.
    To allow it: open System Settings -> Privacy & Security, scroll to the Security
    section, and click "Open Anyway" next to Powerspaces, then open the app again.
    Grant Accessibility when prompted.
  EOS

  zap trash: "~/.config/powerspaces"
end

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
    Powerspaces is not notarized, so macOS blocks the first launch. Allow it either way:

      Quickest (Terminal):
        xattr -dr com.apple.quarantine "/Applications/Powerspaces.app"
      then open Powerspaces.

      System Settings:
        Try to open Powerspaces, then open System Settings > Privacy & Security,
        scroll to Security, and click "Open Anyway" next to Powerspaces.

    Then grant Accessibility when prompted.
  EOS

  zap trash: "~/.config/powerspaces"
end

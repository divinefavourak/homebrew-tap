cask "jesutobits" do
  arch arm: "arm64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "6a3630d9d43b2149acf7259cada3691597b14ae091f9e4a96910713aa304a4c2",
         intel: "6b8272340b0494d87ba414db3b3ab5fcfea1332e1f56c8eb12ec87b89c887a8b"

  url "https://github.com/divinefavourak/jesutobits-ide/releases/download/v#{version}/Jesutobits-#{version}-macos-#{arch}.dmg"
  name "Jesutobits"
  desc "AI agent that builds in front of you, on VS Code"
  homepage "https://github.com/divinefavourak/jesutobits"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Jesutobits.app"
  binary "#{appdir}/Jesutobits.app/Contents/Resources/app/bin/jesutobits"

  zap trash: [
    "~/.jesutobits",
    "~/Library/Application Support/Jesutobits",
    "~/Library/Caches/dev.jesutobits.app",
    "~/Library/Preferences/dev.jesutobits.app.plist",
    "~/Library/Saved Application State/dev.jesutobits.app.savedState",
  ]

  caveats <<~EOS
    Jesutobits is not yet signed with an Apple Developer ID. The first time you open it,
    macOS blocks it: open System Settings > Privacy & Security and choose Open Anyway.
  EOS
end

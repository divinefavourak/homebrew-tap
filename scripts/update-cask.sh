#!/usr/bin/env bash
# Writes Casks/jesutobits.rb for the latest Jesutobits release, with the checksums from its
# SHA256SUMS.txt. Run by .github/workflows/update.yml; prints whether the cask changed.
set -euo pipefail

SOURCE=divinefavourak/jesutobits-ide
TAG=$(gh release view --repo "$SOURCE" --json tagName -q .tagName)
VERSION=${TAG#v}
SUMS=$(gh release download "$TAG" --repo "$SOURCE" --pattern SHA256SUMS.txt --output -)

sum() {
	local file="Jesutobits-${VERSION}-macos-$1.dmg"
	local value
	value=$(awk -v f="$file" '$2 == f || $2 == "*"f {print $1}' <<< "$SUMS")
	[ -n "$value" ] || { echo "No checksum for $file in $TAG" >&2; exit 1; }
	echo "$value"
}
ARM=$(sum arm64)
INTEL=$(sum x64)

mkdir -p Casks

cat > Casks/jesutobits.rb <<EOF
cask "jesutobits" do
  arch arm: "arm64", intel: "x64"

  version "${VERSION}"
  sha256 arm:   "${ARM}",
         intel: "${INTEL}"

  url "https://github.com/${SOURCE}/releases/download/v#{version}/Jesutobits-#{version}-macos-#{arch}.dmg"
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
EOF
echo "Cask for ${TAG}: arm64 ${ARM}, x64 ${INTEL}"

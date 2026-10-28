# Jesutobits for Homebrew

Install [Jesutobits](https://github.com/divinefavourak/jesutobits), an AI agent that builds in front of you, on macOS (Apple Silicon or Intel):

```bash
brew install --cask divinefavourak/tap/jesutobits
```

Update it with `brew upgrade --cask jesutobits`, remove it with `brew uninstall --cask jesutobits` (add `--zap` to remove its settings and data too).

**The first open:** Jesutobits is not yet signed with an Apple Developer ID, so macOS blocks it the first time. Open **System Settings > Privacy & Security** and choose **Open Anyway** for Jesutobits.

The cask follows the latest [Jesutobits release](https://github.com/divinefavourak/jesutobits-ide/releases/latest): `.github/workflows/update.yml` checks once a day (or by hand) and updates `Casks/jesutobits.rb` with the release's checksums.

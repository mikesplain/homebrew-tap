cask "jordanbaird-ice" do
  version "0.10.0-beta.6"
  sha256 "d07d498c2dbe8b5de952677e70ac1acf7a74dfa823a06c7b941012cca76ed4c1"

  url "https://github.com/jordanbaird/Ice/releases/download/#{version}/Ice.zip"
  name "Ice"
  desc "Menu bar manager"
  homepage "https://github.com/jordanbaird/Ice"

  auto_updates true
  depends_on macos: ">= :sonoma"

  app "Ice.app"

  uninstall quit: "com.jordanbaird.Ice"

  zap trash: "~/Library/Preferences/com.jordanbaird.Ice.plist"
end

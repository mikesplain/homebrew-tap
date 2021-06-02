cask "splashy" do
  version "1.0.0"
  sha256 :no_check

  url "https://splashy.art/downloads/Splashy.dmg"
  name "Splashy"
  desc "Breathtaking, auto changing wallpaper app for all devices"
  homepage "https://splashy.art/"

  depends_on macos: ">= :catalina"

  app "Splashy #{version.major}.app"
end

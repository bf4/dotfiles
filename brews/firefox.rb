# For selenium compatibility
# brew cask install ~/dotextras/firefox.rb --appdir="/Applications"
class Firefox < Cask
  version '29.0'
  #  cat ~/Downloads/Firefox\ 29.0.dmg | openssl dgst -sha256
  sha256 "b2606d2e7deb983d60db089f0c0af9f4a7f00547c29b25fbce464b477018e0af"

  url 'https://download.mozilla.org/?product=firefox-29.0-SSL&os=osx&lang=en-US'
  homepage 'https://www.mozilla.org/en-US/firefox/'

  link 'Firefox.app'

  after_install do

    # Turn off auto-updates
    puts `cp local-settings.js /opt/homebrew-cask/Caskroom/firefox/29.0/Firefox.app/Contents/MacOS/defaults/pref`
    puts `cp ff_config.cfg /opt/homebrew-cask/Caskroom/firefox/29.0/Firefox.app/Contents/MacOS/ff_config.cfg`
  end
end

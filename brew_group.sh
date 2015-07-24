whoami=`whoami`
for lib in "/Library/Caches/Homebrew/" "/opt/homebrew-cask/" "/usr/local/"; do
  sudo chown -R $whoami:brew $lib
  sudo chmod -R 775 $lib
done

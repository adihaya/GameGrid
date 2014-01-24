# First we install 'wget', a tool needed to load files
echo "Downloading updates for GG Downloader..."
curl -O http://ftp.gnu.org/gnu/wget/wget-1.13.4.tar.gz -d ~/
echo "Unpacking update for GG Downloader..."
tar -xzf ~/wget-1.13.4.tar.gz
echo "Configuring GG Downloader's updates..."
cd ~/wget-1.13.4
sh ./configure --with-ssl=openssl
echo "Installing updates for GG Downloader..."
make; sudo make install
cd ~/

echo "Moving files..."
cd  /Applications
echo "Downloading GameGrid, Game Update Files..."
wget http://github.com/adihaya/GameGrid/zipball/master -O GameGridUpdate.zip
echo "Unpacking GameGrid Update..."
unzip GameGridUpdate.zip -f -d GameGridUpdate
echo "Installing updates for GameGrid...."
cd GameGridUpdate
echo "Re-Installing updates for GameGrid...."
ruby install.rb
echo "Installing updates for GameGrid's RubyGem...."
gem install GameGrid
echo "All done! GameGrid is up-to-date, with the latest version!   GameGrid Updater succeeded with no errors! You're update is ready."

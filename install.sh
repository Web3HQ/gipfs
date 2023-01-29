#!/bin/sh

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

unameOutM="$(uname -m)"
case "${unameOutM}" in
    i286)   flofarch="286";;
    i386)   flofarch="386";;
    i686)   flofarch="386";;
    x86_64) flofarch="amd64";;
    arm)    dpkg --print-flofarch | grep -q "arm64" && flofarch="arm64" || flofarch="arm";;
    riscv64) flofarch="riscv64"
esac

echo "Initializing..."
sh ./init.sh

# Install IPFS:

      if [ "$flofarch" = "386" ]; then
         echo "Installing IPFS..."
         tar -xzf include/IPFS/kubo_v0.18.0_linux-386.tar.gz
         sudo mv kubo/ipfs /usr/bin
         sudo rm -r kubo
         chmod +x /usr/bin/ipfs
         echo "Testing if IPFS works:"
         ipfs
fi
      if [ "$flofarch" = "amd64" ]; then
         echo "Installing IPFS..."
         tar -xzf include/IPFS/kubo_v0.18.0_linux-amd64.tar.gz
         sudo mv kubo/ipfs /usr/bin
         sudo rm -r kubo
         chmod +x /usr/bin/ipfs
         echo "Testing if IPFS works:"
         ipfs
fi
# <---- future task: check against .cid file; floflis icons: icon for .cid files and file handler for comparing

#- This will add about 46 MB of files:
#- If your device have enough space and you want to update it using Web3Updater, it'll need IPFS.
#- Large files like IPFS aren't suitable to an core device such as a router.
#- Want to install IPFS, an P2P decentralized file network (evolution of Torrent)?
#- task: if Floflis ISO/Cubic, automatically install IPFS

sudo cat > /usr/bin/ipfsdaemon << ENDOFFILE
#!/bin/bash

(ipfs daemon &)
ENDOFFILE
sudo chmod +x /usr/bin/ipfsdaemon

# Install ipget:
   echo "Installing ipget..."
      if [ "$flofarch" = "386" ]; then
         tar -xzf include/ipget/ipget_v0.9.1_linux-386.tar.gz
         sudo mv ipget/ipget /usr/bin
         sudo rm -rf ipget
         chmod +x /usr/bin/ipget
         echo "Testing if ipget works:"
         ipget
fi
      if [ "$flofarch" = "amd64" ]; then
         tar -xzf include/ipget/ipget_v0.9.1_linux-amd64.tar.gz
         sudo mv ipget/ipget /usr/bin
         sudo rm -rf ipget
         chmod +x /usr/bin/ipget
         echo "Testing if ipget works:"
         ipget
fi

# Install elcid:
echo "Installing elcid..."
sudo cp -f include/elcid /usr/bin
echo "- Turning elcid into an executable..."
sudo chmod 755 /usr/bin/elcid && sudo chmod +x /usr/bin/elcid

echo "Installing gipfs..." && echo "- Installing gipfs command in /usr/bin..."
sudo cp -f gipfs /usr/bin
echo "- Turning gipfs into an executable..."
sudo chmod +x /usr/bin/gipfs

if [ -f /usr/bin/ipfsoriginal ]; then
sudo cp -f ipfs /usr/bin
fi
#programming tip from an inspired aspirant newbie: if you expect a condition to happen/be used more frequently than others, put it on front/prioritize it!
if [ ! -f /usr/bin/ipfsoriginal ]; then
echo "Do you want to install our ipfs replacement? 🧚‍♀️ [Y/n]"
read wrapipfs
case $wrapipfs in
   [nN])
      echo "Ok."
      break ;;
   [yY])
      sudo cp -rf /usr/bin/ipfs /usr/bin/ipfsoriginal && sudo chmod +x /usr/bin/ipfsoriginal
      echo "Done."
      echo "- Installing ipfs wrapper in /usr/bin..."
      sudo cp -f ipfs /usr/bin
      echo "- Turning ipfs wrapper into an executable..."
      sudo chmod 755 /usr/bin/ipfs && sudo chmod +x /usr/bin/ipfs
      break ;;
   *)
      echo "${invalid}" ;;
esac
fi

echo "Done! Run 'gipfs' command to use it." && exit

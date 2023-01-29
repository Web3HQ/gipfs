unameOutM="$(uname -m)"
case "${unameOutM}" in
    i286)   flofarch="286";;
    i386)   flofarch="386";;
    i686)   flofarch="386";;
    x86_64) flofarch="amd64";;
    arm)    dpkg --print-flofarch | grep -q "arm64" && flofarch="arm64" || flofarch="arm";;
    riscv64) flofarch="riscv64"
esac

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

if echo $1 | elcid d >/dev/null 2>&1; then
   echo "✅ Valid CID"
   else
      echo "❌ Invalid CID"
fi
# from https://discuss.ipfs.tech/t/is-there-a-way-to-determine-if-a-string-is-a-valid-ipfs-multihash/1248/7?u=daniellmesquita

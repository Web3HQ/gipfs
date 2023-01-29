valid_cid() {
  echo $1 | ./elcid d
}
# from https://discuss.ipfs.tech/t/is-there-a-way-to-determine-if-a-string-is-a-valid-ipfs-multihash/1248/7?u=daniellmesquita

if valid_cid -s; then
   echo "✅ Valid CID"
   else
      echo "❌ Invalid CID"
fi

valid_cid() {
  echo $1 | ./elcid d QmbiwLD2cgLk763DSaTMWvw4ZfhVr5PKb8Ht5FNLWQnPmu >/dev/null 2>&1
  return $?
}
# from https://discuss.ipfs.tech/t/is-there-a-way-to-determine-if-a-string-is-a-valid-ipfs-multihash/1248/7?u=daniellmesquita

valid_cid

if valid_cid -s; then
   echo "✅ Its online"
   else
      echo "❌ Its offline"
fi
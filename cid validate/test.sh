valid_cid() {
  echo $1 | ./elcid d QBU3 >/dev/null 2>&1
  return $?
}

valid_cid

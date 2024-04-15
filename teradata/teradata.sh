set -e
db-health() {
  # validate the db is up
  message=$(pdestate -a)
  # case when "DBS state: Unable to get the state.". `exit 1` will be triggered
  if ! echo $message | grep "PDE state is RUN/STARTED."; then
    return 1
  fi
  if ! echo $message | grep "Logons are enabled"; then
      return 1
  fi
}
wait-until-health() {
  counter=0
  set +e
  while true; do
    if db-health; then
      break
    else
      ((counter++))
      sleep 1
      echo Wait until DB become healthy ... ${counter} times retry
    fi
    
  done
  set -e
}
$@

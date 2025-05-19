"$@" &
pid=$!

swaymsg -t subscribe -m '[ "window" ]' \
  | jq --unbuffered --argjson pid "$pid" '.container | select(.pid == $pid) | .id' \
  | xargs -I '@' -- swaymsg '[ con_id=@ ] floating enable, resize set 1000 600, move position center' &

subscription=$!

echo Going into wait state

# Wait for our process to close
tail --pid=$pid -f /dev/null

echo Killing subscription
kill $subscription

# stolen from here: https://github.com/Synthetica9/sway-floating/blob/master/floating
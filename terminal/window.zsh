
export DEFAULT_TERMINAL_COLOR=000000
export DEFAULT_TERMINAL_OPACITY=0.2

set_title () {
  echo -ne "\033]0;$@\007"
}

set_window_title () {
  echo -ne "\033]2;$@\007"
}

set_tab_title () {
  echo -ne "\033]1;$@\007"
}

set_window_color() {
  local HEX_BG=$1
  local OPACITY=$2
 
  local BG_R=`echo $HEX_BG | sed 's/../0x&,/g' | awk -F "," '{printf("%d",$1 * 257)}'`
  local BG_G=`echo $HEX_BG | sed 's/../0x&,/g' | awk -F "," '{printf("%d",$2 * 257)}'`
  local BG_B=`echo $HEX_BG | sed 's/../0x&,/g' | awk -F "," '{printf("%d",$3 * 257)}'`
 
  [ -f "/Applications/iTerm.app" ] || return 1

  /usr/bin/osascript <<EOF
tell application "iTerm"
   tell current session of current terminal
      set background color to {$BG_R, $BG_G, $BG_B} 
      set transparency to "$OPACITY" 
   end tell
end tell
EOF
}
 
set_window_color $DEFAULT_TERMINAL_COLOR $DEFAULT_TERMINAL_OPACITY

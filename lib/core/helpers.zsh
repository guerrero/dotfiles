#!/usr/bin/env bash

dot_check_system() {

}

dot_check_installed() {

}

dot_close_app() {
  if ps ax | grep -v grep | grep "$1" > /dev/null; then
    the_app="$1"
    osascript -e 'on run {theApp}' -e 'tell application theApp to quit'  -e 'end run' $the_app
    echo "Exit $1 app"
  else
    echo "Process $1 isn't running"
  fi
}
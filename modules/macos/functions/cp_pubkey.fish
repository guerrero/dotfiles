function pubkey --description "Pipe my public key to my clipboard"
  cat ~/.ssh/id_rsa.pub | pbcopy
  echo '=> Public key copied to pasteboard.'
end
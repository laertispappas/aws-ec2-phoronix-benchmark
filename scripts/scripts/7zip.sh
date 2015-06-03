#!/usr/bin/expect

set i 0;
while { $i < 10 } {
  spawn phoronix-test-suite benchmark compress-7zip
  set prompt ":|#|\\\$"
  interact -o -nobuffer -re $prompt return
  send "y\r"
  interact -o -nobuffer -re $prompt return
  send "7zip\r"
  interact -o -nobuffer -re $prompt return
  send "7zip-run-$i\r"
  interact -o -nobuffer -re $prompt return
  send "7zip run - $i cloud lab exercise mpsp unipi.gr\r"
  interact -o -nobuffer -re $prompt return
  send "n\r"
  interact
  set i [ expr $i+1 ]
}

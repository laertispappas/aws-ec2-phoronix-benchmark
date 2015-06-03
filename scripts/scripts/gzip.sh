#!/usr/bin/expect

set i 0;
while { $i < 10 } {
  spawn phoronix-test-suite benchmark compress-gzip
  set prompt ":|#|\\\$"
  interact -o -nobuffer -re $prompt return
  send "y\r"
  interact -o -nobuffer -re $prompt return
  send "gzip\r"
  interact -o -nobuffer -re $prompt return
  send "gzip-run-$i\r"
  interact -o -nobuffer -re $prompt return
  send "gzip run - $i cloud lab exercise - gzip - mpsp - unipi.gr\r"
  interact -o -nobuffer -re $prompt return
  send "n\r"
  interact
  set i [ expr $i+1 ]
}

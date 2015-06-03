#!/usr/bin/expect

set i 0;
while { $i < 10 } {
  spawn phoronix-test-suite benchmark stream
  set prompt ":|#|\\\$"
  interact -o -nobuffer -re $prompt return
  send "5\r"  
  interact -o -nobuffer -re $prompt return
  send "y\r"
  interact -o -nobuffer -re $prompt return
  send "stream-bench\r"
  interact -o -nobuffer -re $prompt return
  send "stream-run-$i\r"
  interact -o -nobuffer -re $prompt return
  send "\r"
  interact -o -nobuffer -re $prompt return
  send "n\r"
  interact
  set i [ expr $i+1 ]
}

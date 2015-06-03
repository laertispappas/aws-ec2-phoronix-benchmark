#!/usr/bin/expect -f

set i 0;
while { $i < 10 } {
  spawn phoronix-test-suite benchmark apache
  set prompt ":|#|\\\$"
  interact -o -nobuffer -re $prompt return
  send "y\r"
  interact -o -nobuffer -re $prompt return
  send "apache-bench\r"
  interact -o -nobuffer -re $prompt return
  send "apache-run-$i\r"
  interact -o -nobuffer -re $prompt return
  send "\r"
  interact -o -nobuffer -re $prompt return
  send "n\r"
  interact
  set i [ expr $i+1 ]
}

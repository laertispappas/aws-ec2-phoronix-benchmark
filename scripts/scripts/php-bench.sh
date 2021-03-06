#!/usr/bin/expect

set i 0;
while { $i < 10 } {
  spawn phoronix-test-suite benchmark phpbench
  set prompt ":|#|\\\$"
  interact -o -nobuffer -re $prompt return
  send "y\r"
  interact -o -nobuffer -re $prompt return
  send "php-benchmark\r"
  interact -o -nobuffer -re $prompt return
  send "phpbench-run-$i\r"
  interact -o -nobuffer -re $prompt return
  send "\r"
  interact -o -nobuffer -re $prompt return
  send "n\r"
  interact
  set i [ expr $i+1 ]
}

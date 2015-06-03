#!/bin/bash

./scripts/7zip.sh
./scripts/gzip.sh
./scripts/apache.sh
./scripts/stream.sh
./scripts/php-bench.sh
./scripts/threaded.sh
./scripts/iozone.sh


sudo shutdown -h now


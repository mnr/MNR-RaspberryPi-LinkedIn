#! /bin/bash

while [ 1 ]
do
  cat gpiostatus_open.txt > gpiostatus.html
  date >> gpiostatus.html
  gpio readall >> gpiostatus.html
  cat gpiostatus_final.txt >> gpiostatus.html
  sleep 1s
done

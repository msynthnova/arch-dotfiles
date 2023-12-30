#!/bin/bash

pacman -Syu
pacman -Rscn $(pacman -Qtdq)
pacman -Sc
pacman-optimize && sync
updatedb

exit 0

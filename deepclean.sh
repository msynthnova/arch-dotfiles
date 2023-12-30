#!/bin/bash

pacman -Syu
pacman -Rscn $(pacman -Qtdq)
pacman -Sc

exit 0

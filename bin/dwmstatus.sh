#! /bin/bash

conky -x 0 -y 0 | while read -r; do xsetroot -name "$REPLY"; done

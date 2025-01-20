#!/bin/bash
npm install -g typescript
git clone https://github.com/pop-os/shell.git
cd shell
# change to correct version of ubuntu
git checkout master_noble
make local-install
echo "installation probably failed, relog and then run make local-install again"

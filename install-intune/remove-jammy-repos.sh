#!/bin/bash

echo "making a backup of modified sources..."
cp -f /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.withjammy.bak
echo "restoring old sources..."
cp -f /etc/apt/sources.list.d/ubuntu.sources.bak /etc/apt/sources.list.d/ubuntu.sources
apt update

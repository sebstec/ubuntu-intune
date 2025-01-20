#!/bin/bash
echo "testing mde real time protection, first checking if it is enabled:"
mdatp health --field real_time_protection_enabled
read -p 'if the output says its disabled, you should enable this and then rerun this test. press a key to continue...'
curl -o ~/Downloads/eicar.com.txt https://www.eicar.org/download/eicar.com.txt
echo "downloaded a test file, check md portal in a few minutes for an alert"

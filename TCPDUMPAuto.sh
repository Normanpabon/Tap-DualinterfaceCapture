!usr/bin/bash
echo "This script will capture data for port Eth1 and Eth2"
echo "It outputs 3 files, each if .cap and a merged one"
echo "Use Ctrl-c to stop capturing"
sudo tcpdump -v -i eth1 -XX -w eth1Capture.pcap &
sudo tcpdump -v -i eth2 -XX -w eth2Capture.pcap &
wait
sudo mergecap -w mergedCapture.pcap eth*.pcap



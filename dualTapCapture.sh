!/bin/bash

if [ $(whoami) != "root" ]; then
    echo "This script must be ran as root"
    exit 1
else
    echo "root user detected"
fi

echo "This script will capture data for selected interfaces"
echo "It outputs 3 files, each if .cap and a merged one"
echo "Use Ctrl-c to stop capturing"


PS3='Please select a option for the interfaces to being capture: '
options=("Eth0 and Eth1" "Eth1 and Eth2" "Custom interfaces" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Eth0 and Eth1")
            echo "Starting capture on Eth0 and Eth1 ports"
            sudo tcpdump -v -i eth0 -XX -w eth0Capture.pcap &
            sudo tcpdump -v -i eth1 -XX -w eth1Capture.pcap &
            wait
            sudo mergecap -w mergedCapture.pcap eth*.pcap
            break
            ;;
        "Eth1 and Eth2")
            echo "Starting capture on Eth1 and Eth2 ports"
            sudo tcpdump -v -i eth0 -XX -w eth0Capture.pcap &
            sudo tcpdump -v -i eth1 -XX -w eth1Capture.pcap &
            wait
            sudo mergecap -w mergedCapture.pcap eth*.pcap
            break
            ;;
        "Custom interfaces")
            echo "Type interface n°1"
            read if1 
            echo "Type interface n°2"
            read if2 
            sudo tcpdump -v -i $if1 -XX -w $if1-capture.pcap &
            sudo tcpdump -v -i $if2 -XX -w $if2-capture.pcap &
            sudo mergecap -w mergedCapture.pcap *capture.pcap
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done




echo
echo Copy the diagnostic sript to target hosts
echo

SSH_USER=sam22
IP_LIST=data-local/stec23-ip-latest
SSH_KEY_SAM22=/var/lib/centreon-engine/.ssh/sam22_key
RAY_SCRIPT_1=monitor-scripts/ray.sh
RAY_SCRIPT_2=monitor-scripts/ray2.sh

echo First script: $RAY_SCRIPT_1
echo
for ip in `cat $IP_LIST`; do echo $ip; sudo timeout 2 scp -i $SSH_KEY_SAM22 $RAY_SCRIPT_1 $SSH_USER@$ip:. ; done
echo
echo 2nd script: $RAY_SCRIPT_2
echo
for ip in `cat $IP_LIST`; do echo $ip; sudo timeout 2 scp -i $SSH_KEY_SAM22 $RAY_SCRIPT_2 $SSH_USER@$ip:. ; done


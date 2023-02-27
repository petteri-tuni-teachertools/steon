echo
echo Copy the diagnostic sript to target hosts
echo ray.sh
echo
for ip in `cat data-local/stec-ip-latest`; do echo $ip; sudo timeout 2 scp -i /var/lib/centreon-engine/.ssh/sam22_key monitor-scripts/ray.sh sam22@$ip:. ; done
echo
echo ray2.sh
echo
for ip in `cat data-local/stec-ip-latest`; do echo $ip; sudo timeout 2 scp -i /var/lib/centreon-engine/.ssh/sam22_key monitor-scripts/ray2.sh sam22@$ip:. ; done

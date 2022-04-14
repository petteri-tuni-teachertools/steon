echo
echo Copy the diagnostic sript to target hosts
echo
for ip in `cat data-local/stec-ip-30.3`; do echo $ip; sudo timeout 2 scp -i /var/lib/centreon-engine/.ssh/sam22_key /opt/stec22/html/ray.sh sam22@$ip:. ; done

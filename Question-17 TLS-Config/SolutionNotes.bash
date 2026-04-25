# Step one
# We want to edit the config map to remove all references to tls v1.2
k edit cm -n nginx-static nginx-config # remove TLSv1.2 from SSL protocols (remove from last applied configuration for safety)

# Step 2
# We need to get the IP of the service
k get svc -n nginx-static
# We need to add this IP with the host name to /etc/hosts
IP=$(k get svc -n nginx-static nginx-static -o jsonpath='{.spec.clusterIP}')
echo "$IP ckaquestion.k8s.local" | sudo tee -a /etc/hosts
# Check the hosts file has been updated the IP and host should be added to the bottom of the file
sudo cat /etc/hosts

# Step 3
# If we run the check commands now we see v1.2 is still working, this is because we need to restart the deployment to use the new CM config
k rollout restart -n nginx-static deployment nginx-static
# Test the commands again and the v1.2 should no longer work

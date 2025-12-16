# Step 1: pause workload
kubectl scale deployment wordpress --replicas 0

# Step 2: edit deployment (set same resources on all init + main containers)
kubectl edit deployment wordpress
# In spec.template.spec.containers[] and spec.template.spec.initContainers[] set:
# resources:
#   requests:
#     cpu: "300m"
#     memory: "600Mi"
#   limits:
#     cpu: "400m"
#     memory: "700Mi"
# (Values are just an example of dividing the node evenly and keeping some headroom;
# ensure every container—init and main—uses the exact same requests/limits.)

# Step 3: resume replicas
kubectl scale deployment wordpress --replicas 3
kubectl rollout status deployment wordpress
kubectl get pods -l app=wordpress

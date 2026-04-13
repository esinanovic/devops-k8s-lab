#!/bin/bash
# On démarre les conteneurs
docker start k8s-lab-control-plane k8s-lab-worker

# On attend 2 secondes pour laisser le temps au moteur de souffler
sleep 2

# On affiche l'état des nœuds pour confirmer
kubectl get nodes
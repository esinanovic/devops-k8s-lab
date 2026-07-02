#!/bin/bash

echo "🔌 Coupure des tunnels (Port-Forward)..."
# On tue tous les processus qui contiennent 'port-forward'
pkill -f "port-forward"

echo "💤 Arrêt des nodes Kubernetes (Docker)..."
# On stoppe les conteneurs qui font tourner le cluster Kind
docker stop k8s-lab-control-plane k8s-lab-worker
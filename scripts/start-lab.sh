#!/bin/bash

echo "🚀 Réveil des nodes Docker..."
docker start k8s-lab-control-plane k8s-lab-worker

echo "⏳ Attente de la disponibilité de l'API Kubernetes (environ 15s)..."
# On attend que les nodes soient "Ready" au lieu d'un sleep fixe
kubectl wait --for=condition=ready node --all --timeout=60s

echo "🔌 Lancement des tunnels (Port-Forward)..."

pkill -f "port-forward"
# On lance le frontend sur le port 8080 en arrière-plan (&)
# On redirige les logs vers /dev/null pour ne pas polluer ton terminal
kubectl port-forward svc/frontend-service 8080:80 -n devops-lab > /dev/null 2>&1 &

# On fait pareil pour le backend sur le port 3001
kubectl port-forward svc/backend-service 3001:3001 -n devops-lab > /dev/null 2>&1 &

echo "✅ Lab prêt !"
echo "🌐 Frontend : http://localhost:8080"
echo "⚙️  Backend  : http://localhost:3001/health"
kubectl get pods -n devops-lab
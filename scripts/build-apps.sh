#!/bin/bash

# 1. On définit les noms d'images (pour être sûr qu'ils correspondent à tes YAML)
BACKEND_IMAGE="backend-app:latest"
FRONTEND_IMAGE="frontend-app:latest"
CLUSTER_NAME="k8s-lab"

echo "🚀 Début du build des applications..."

# 2. Build du Backend
echo "📦 Build du Backend..."
cd backend && docker build -t $BACKEND_IMAGE .
cd ..

# 3. Build du Frontend
echo "📦 Build du Frontend..."
cd frontend && docker build -t $FRONTEND_IMAGE .
cd ..

# 4. Chargement des images dans Kind (L'étape CRUCIALE)
echo "🚚 Chargement des images dans le cluster Kind..."
kind load docker-image $BACKEND_IMAGE --name $CLUSTER_NAME
kind load docker-image $FRONTEND_IMAGE --name $CLUSTER_NAME

echo "✅ Terminé ! Tes images sont prêtes et chargées dans le cluster."
echo "💡 Tu peux maintenant faire : kubectl apply -k k8s/base/"
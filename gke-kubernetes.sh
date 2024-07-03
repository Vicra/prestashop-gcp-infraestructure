# enable kubernetes
gcloud components install kubectl

# check kubernetes version
kubectl version --client

# create env variable
export PROJECT_ID=prestashop-apps
export REGION=us-central1

# Set your project ID for the Google Cloud CLI
gcloud config set project $PROJECT_ID

# Create the prestashops-repo repository with the following command
gcloud artifacts repositories create prestashops-repo \
   --repository-format=docker \
   --location=us-central1 \
   --description="Prestashops docker repository"

# build docker image
docker build -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/prestashop/prestashop:latest .


references links:
- https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app

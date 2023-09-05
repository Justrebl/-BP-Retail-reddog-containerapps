# *nix only
export RG="reddog-demo-fc2"
export LOCATION="francecentral"
export SUB_ID="<Your Subscription ID>"

# Follow Azure CLI prompts to authenticate to your subscription of choice
# az login --use-device-code
az account set --subscription $SUB_ID

# Create resource group
az group create -n $RG -l $LOCATION

# Deploy all infrastructure and reddog apps
az deployment group create -n reddog-demo -g $RG -f ./deploy/bicep/main.bicep

# Show outputs for bicep deployment
az deployment group show -n reddog-demo -g $RG -o json --query properties.outputs.urls.value
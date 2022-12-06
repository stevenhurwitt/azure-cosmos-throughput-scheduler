FROM mcr.microsoft.com/azure-cli

ARG TOOLS_URL="https://github.com/Azure/azure-functions-core-tools/releases/download/3.0.2798/Azure.Functions.Cli.linux-x64.3.0.2798.zip"

RUN apk update \
  && apk add --no-cache wget

COPY . /tmp
WORKDIR /tmp

# RUN curl --insecure -L -o az-func.zip $TOOLS_URL \
#   && unzip -d /usr/local/bin/func az-func.zip \
#   && rm -rf az-func.zip

# DE_RG_DEV_27403_DERMS

# Function app and storage account names must be unique.

# Variable block
ARG location="eastus"
ARG resourceGroup="DE_RG_DEV_27403_DERMS"
ARG tag="create-function-app-throughput"
ARG storage="azdermsstoragedev"
ARG functionApp="azure-cosmos-throughput-scheduler-dev"
ARG subscription="e7493688-cdc8-4c97-8bdc-71b096102a6b"
ARG skuStorage="Standard_LRS"
ARG functionsVersion="4"

# Create a resource group
# echo "Creating $resourceGroup in "$location"..."
# az group create --name $resourceGroup --location "$location" --tags $tag

# Create an Azure storage account in the resource group.
# echo "Creating $storage"

# RUN subscriptionId="$(az account list --query "[?isDefault].id" -o tsv)"
RUN az login

RUN az account set --subscription "${subscription}"

# RUN az storage account create --name ${storage} --location ${location} --resource-group ${resourceGroup} --sku ${skuStorage}

# Create a serverless function app in the resource group.
# echo "Creating $functionApp"

RUN az functionapp create --name ${functionApp} --storage-account ${storage} --consumption-plan-location ${location} --resource-group ${resourceGroup} --functions-version ${functionsVersion}

# RUN az --version
RUN bash
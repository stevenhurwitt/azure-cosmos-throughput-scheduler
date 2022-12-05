FROM mcr.microsoft.com/azure-cli

ARG TOOLS_URL="https://github.com/Azure/azure-functions-core-tools/releases/download/3.0.2798/Azure.Functions.Cli.linux-x64.3.0.2798.zip"

RUN apk update \
  && apk add --no-cache wget

COPY . /tmp
WORKDIR /tmp

RUN curl --insecure -L -o az-func.zip $TOOLS_URL \
  && unzip -d /usr/local/bin/func az-func.zip \
  && rm -rf az-func.zip

# RUN func/func --version
# RUN az --version
# RUN bash

# DE_RG_DEV_27403_DERMS

# Function app and storage account names must be unique.

# Variable block
ARG location="eastus"
ARG resourceGroup="DE_RG_DEV_27403_DERMS"
ARG tag="create-function-app-throughput"
ARG storage=""
ARG functionApp="azure-cosmos-throughput-scheduler-dev"
ARG skuStorage="Standard_LRS"
ARG functionsVersion="4"

# Create a resource group
# echo "Creating $resourceGroup in "$location"..."
# az group create --name $resourceGroup --location "$location" --tags $tag

# Create an Azure storage account in the resource group.
# echo "Creating $storage"
# az storage account create --name $storage --location "$location" --resource-group $resourceGroup --sku $skuStorage

# Create a serverless function app in the resource group.
# echo "Creating $functionApp"

# --storage-account $storage
RUN az functionapp create --name $functionApp --consumption-plan-location "$location" --resource-group $resourceGroup --functions-version $functionsVersion
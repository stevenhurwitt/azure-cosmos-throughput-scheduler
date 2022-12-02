FROM mcr.microsoft.com/azure-cli

ARG TOOLS_URL="https://github.com/Azure/azure-functions-core-tools/releases/download/3.0.2798/Azure.Functions.Cli.linux-x64.3.0.2798.zip"

RUN apk update \
  && apk add --no-cache wget

COPY . /tmp
WORKDIR /tmp

RUN curl --insecure -L -o az-func.zip $TOOLS_URL \
  && unzip -d /usr/local/bin/func az-func.zip \
  && rm -rf az-func.zip

# RUN func --version
# RUN az --version
RUN bash
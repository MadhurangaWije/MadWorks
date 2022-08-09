# Create the virtual network
az network vnet create --resource-group ohc-stage-aks-rg --name ohc-stage-bastion-vnet --address-prefix 10.0.0.0/16 --subnet-name AzureBastionSubnet --subnet-prefix 10.0.0.0/24 --location eastus2
# Create the public ip
az network public-ip create --resource-group ohc-stage-aks-rg --name ohc-stage-bastion-public-ip --sku Standard --location eastus2
# Create the Bastion service
az network bastion create --name ohc-stage-bastion --public-ip-address ohc-stage-bastion-public-ip --resource-group ohc-stage-aks-rg --vnet-name ohc-stage-virtual-network --location eastus2

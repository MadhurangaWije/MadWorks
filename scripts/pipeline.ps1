New-AzResourceGroup -Name TestRG1 -Location EastUS
$virtualNetwork = New-AzVirtualNetwork `
   -ResourceGroupName TestRG1 `
   -Location EastUS `
   -Name VNet1 `
   -AddressPrefix 10.1.0.0/16
$virtualNetwork | Set-AzVirtualNetwork
$subnetConfig = Add-AzVirtualNetworkSubnetConfig `
   -Name 'FrontEnd' `
   -AddressPrefix 10.1.0.0/24 `
   -VirtualNetwork $virtualNetwork
$virtualNetwork | Set-AzVirtualNetwork

$virtualNetwork = Get-AzVirtualNetwork -Name "VNet1" `
   -ResourceGroupName "TestRG1"
Add-AzVirtualNetworkSubnetConfig -Name "AzureBastionSubnet" `
   -VirtualNetwork $virtualNetwork -AddressPrefix "10.1.1.0/26" `
$virtualNetwork | Set-AzVirtualNetwork
$publicip = New-AzPublicIpAddress -ResourceGroupName "TestRG1" -name "VNet1-ip" -location "EastUS" -AllocationMethod Static -Sku Standard
New-AzBastion -ResourceGroupName "TestRG1" -Name "VNet1-bastion" `
   -PublicIpAddressRgName "TestRG1" -PublicIpAddressName "VNet1-ip" `
   -VirtualNetworkRgName "TestRG1" -VirtualNetworkName "VNet1" `
   -Sku "Standard"
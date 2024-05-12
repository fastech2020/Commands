$privateIP = "YourPrivateIPHere"
$networkInterface = Get-AzNetworkInterface | Where-Object { $_.IpConfigurations.PrivateIpAddress -eq $privateIP }
$vmName = (($networkInterface.VirtualMachine.ID) -split '/') | Select-Object -Last 1
Write-Output "VM Name: $vmName"

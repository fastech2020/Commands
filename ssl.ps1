# Define your DNS_NAME variable
$DNS_NAME = "example.com"

# Generate the self-signed certificate and capture the thumbprint
$cert = New-SelfSignedCertificate -DnsName $DNS_NAME -CertStoreLocation Cert:\LocalMachine\My

# Extract the thumbprint from the generated certificate
$thumbprint = $cert.Thumbprint

# Create the winrm listener configuration
$winrmCommand = "winrm create winrm/config/Listener?Address=*+Transport=HTTPS '@{{Hostname=`"$DNS_NAME`"; CertificateThumbprint=`"$thumbprint`"}}'"
Invoke-Expression $winrmCommand

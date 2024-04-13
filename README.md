# Set Up VM's

1. Installed Windows Server 2022 as virtual machine in VirtualBox.
2. Installed Windows 11 as virtual machine in Virtualbox.
3. Installed VirtualBox Guest Additions in both VM's
4. Created clones for each VM as a template.
5. Created workstation using Windows 11 template for Management Client.
7. Activated PS-Remoting on Server and renamed Server to DC01.
8. Set static IP for Management Client
9. Set static IP for Workstation
10. Set static IP for DC01
11. Set up DC01 as a Trusted Host in Management Client.
12. Installed Chocolatey and Git onto Mangement Client.

# Installing Domain Controller
1. Use 'SConfig' to:
 - Change the hostname
 - Change the IP to static
 - Change the DNS Server to our own IP address

2. Install the Active Directory Windows Feature

```shell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Import-Module ADDSDeployment

Install-ADDSForest
```
3. Set static IP on correct interface

Find the index of the interface hosting the current IP address
```shell
Get-NetIPAddress -IPAddress '192.168.1.38'
```
Ensure DHCP is disabled on this interface.
```shell
Get-NetIPInterface -InterfaceIndex 4 | Set-NetIPInterface -Dhcp Disabled
```
Otherwise, you will get an error message:
New-NetIPAddress : The object already exists.

 Set the interface’s DNS server
```shell
Set-DnsClientServerAddress -InterfaceIndex 4 -ServerAddresses 192.168.1.38
```
# Join Workstation to domain

1. Repeat steps from above to set correct DNS 

2. Join Workstation to domain
```shell
Add-Computer -DomainName xyz.com -Credential xyz\Administrator -Force
```
3. This brings up a GUI login prompt. Enter the domain administrator credentials. The workstation is now joined to the domain.


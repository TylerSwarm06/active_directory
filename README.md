# Set Up VM's

1. Installed Windows Server 2022 as virtual machine in VirtualBox.
2. Installed Windows 11 as virtual machine in Virtualbox.
3. Installed VirtualBox Guest Additions in both VM's
4. Created clones for each VM as a template.
5. Created workstation using Windows 11 template for Management Client.
7. Activated PS-Remoting on Server and renamed Server to DC01.
8. Set static IP for DC01.
9. Set static IP for Management Client
10. Set static IP for Workstation
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
```


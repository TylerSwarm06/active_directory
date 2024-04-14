param([Parameter(Mandatory=$true)] $JSONFile)

function CreateADGroup(){
    param([Parameter(Mandatory=$true)] $groupObject )

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global 
}

function CreateADUser(){
    param([Parameter(Mandatory=$true)] $userObject )
    
    #Pull out the name from the JSON object
    $name = $userObject.name
    $password = $userObject.password
    
    #Generate a "first initial, last name" stucture for username    
    $firstname, $lastname = $name.Split(" ")
    $username = ($firstname[0] + $lastname).ToLower()
    $SamAccountName = $username
    $principalname = $username

    #Actually create the AD user object
    New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@ -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount 

    #Add the user to its appropriate group
    foreach($group_name in $userObject.groups) {
    
        try {
            Get-ADGroup -Identity “$group_name”
            Add-ADGroupMember -Identity $group_name -Members $username
        }
            catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
           {
            Write-Warning “user $name NOT added to group $group_name because it does not exist”
        }
    
    
    }
}


#$json = (Get-Content -Raw -Path $JSONFile | ConvertFrom-Json)
$json = (Get-Content -Raw -Path $JSONFile | ConvertFrom-Json)
$Global:Domain = $json.domain

foreach ( $group in $json.groups ){
    CreateADGroup $group
}
#if($manager -ne $null){
    foreach ( $user in $json.users ){
    CreateADUser $user
}
#foreach ( $user in $json.users ){
 #   CreateADUser $user
#}
#echo $json.groups
#function CreateADGroup(){
 #   param( [Parameter(Mandatory=$true)] $JSONFile )
#  $name = $groups.name
 #   { New-ADGroup -name $groups -GroupScope Global }}    

#echo $name
# function CreateADUser(){
    # param( [Parameter(Mandatory=$true)] $userObject )


    # Write-Output $userObject
    # Pullout the name from the JSON object
    # $name = $userObject.name
    # Write-Output $userObject.name
   # $password = $UserObject.password
    # Generate a "first initial, lastname" structure for username
    #$firstname, $lastname = name.Split(" ")
    #($username = $name[0] + $name.split(" ")[1]).ToLower()
    #$SamAccountName = $username
    #$princiaplname = $username

    # Actually create the AD user object
    #New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@ -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount 
# }
    # Add the user to its appropriate Group
 #   foreach($group_name in $UserObject.group){
        
  #      try {
 #           Get-ADGroup -Identity “$group_name”
  #          Add-ADGroupMember -Identity $group_name -Members $username    
        #}
        #catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
        #    {
         #   Write-Warning “User $name NOT added to group $group_name because it does not exist”
          #  }
    #}
   


#json = ( Get-Content $JSONFile | ConvertFrom-JSON)

#$Global:Domain = $json.domain


#foreach ( $user in $json.users ){
 #   CreateADUser $user
#}
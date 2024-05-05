$group_names = (Get-Content "data/group_names.txt")
$first_names = (Get-Content "data/first_names.txt")
$last_names = (Get-Content "data/last_names.txt")
$passwords - (Get-Content "data/passwords.txt")
$groups = @()

$num_groups = 12

Write-Output Get-Random -InputObject $group_names
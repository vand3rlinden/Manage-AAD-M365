###Import example###
#CSV format#
#Users
#userPrincipalName

### Script
$Members = (Import-Csv -Path "C:\temp\users.csv" -Delimiter “,”).Users
 
foreach ($Member in $Members){
    Add-AzureADGroupMember -RefObjectId (Get-AzureADUser -ObjectId $Member).ObjectID -ObjectId "a947f764-615a-4dda-9e66-6776d117c771"
}

#### Test
$Members = (Import-Csv -Path "C:\temp\users.csv" -Delimiter “,”).Users
 
foreach ($Member in $Members){
    (Get-AzureADUser -ObjectId $Member).ObjectID
}

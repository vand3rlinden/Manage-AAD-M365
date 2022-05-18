$Groups = Get-DistributionGroup -ResultSize Unlimited 
#Scope option examples: 
##Get-DistributionGroup -ResultSize Unlimited -Filter {HiddenFromAddressListsEnabled -eq $false}
##Get-DistributionGroup | Where-Object {$_.DisplayName -like "*DG1*" -or $_.DisplayName -like "*MSG1*" }
$Groups | ForEach-Object {
$group = $_.Displayname
$type = $_.RecipientTypeDetails
$members = ''
Get-DistributionGroupMember $group | ForEach-Object {
        If($members) {
              $members=$members + ";" + $_.Name
           } Else {
              $members=$_.Name
           }
  }
New-Object -TypeName PSObject -Property @{
      GroupName = $group
      GroupType = $type
      Members = $members
     }
} | Export-CSV "C:\temp\yourexport.csv" -NoTypeInformation -Encoding UTF8

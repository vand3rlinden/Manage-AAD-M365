<#
This script will help you to obtain all Azure AD Groups in the tenant and export this into a CSV file. In my scenario I was need to obtain the following
- All dynamic Azure AAD groups with their MembershipRule
- Get all Azure AD GroupMembers
- Get all M365 GroupOwners
#>

#### All dynamic Azure AAD groups with their MembershipRule
Get-AzureADMSGroup -Filter "groupTypes/any(c:c eq 'DynamicMembership')" -All:$true | Select-Object Displayname,MembershipRule | Export-Csv "C:\Temp\dynamic-groups.csv" -NoTypeInformation

#### Get all Azure AD GroupMembers
$GroupData = @()
Get-AzureADMSGroup -All:$true | ForEach-object {
    $GroupName = $_.DisplayName
     
    #Get Members
    $Members = Get-AzureADGroupMember -ObjectId $_.ID | Select-Object UserPrincipalName, DisplayName 
 
        $GroupData += New-Object PSObject -Property ([Ordered]@{ 
        GroupName = $GroupName
        Members = $Members.UserPrincipalName -join "; "
    })
}
 
#Export Group member data to CSV
$GroupData
$GroupData | Export-Csv "C:\Temp\GroupMembers.csv" -NoTypeInformation

### Get all M365 GroupOwners
$GroupData = @()
Get-AzureADMSGroup -Filter "groupTypes/any(c:c eq 'Unified')" -All:$true | ForEach-object {
    $GroupName = $_.DisplayName
     
    #Get Owners
    $GroupOwners = Get-AzureADGroupOwner -ObjectId $_.ID | Select-Object UserPrincipalName, DisplayName 
 
        $GroupData += New-Object PSObject -Property ([Ordered]@{ 
        GroupName = $GroupName
        OwnerID = $GroupOwners.UserPrincipalName -join "; "
        OwnerName = $GroupOwners.DisplayName -join "; "
    })
}
 
#Export Group Owners data to CSV
$GroupData
$GroupData | Export-Csv "C:\Temp\GroupOwners.csv" -NoTypeInformation

<#
In the need to add alternateEmailAddress in bulk in Azure AD? This script will help you out!


CSV format:
userPrincipalName,alternateEmailAddress
user1@domain.com,user1@otherdomain.com
user2@domain.com,user2@otherdomain.com

userPrincipalName = column A in the CSV file
alternateEmailAddress = column B in the CSV file

#>


$Members = Import-Csv -Path "C:\temp\users1.csv" -Delimiter “,”
 
foreach ($Member in $Members){
    Set-AzureADUser -ObjectId $Member.userPrincipalName -OtherMails $Member.alternateEmailAddress
} 

#>
userPrincipalName = column A in the CSV file
alternateEmailAddress = column B in the CSV file
#>

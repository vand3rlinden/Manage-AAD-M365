<# Bulk adding: senders for impersonation protection

Add in bulk CSV like:
Users
Firstname Lastname;user1@domain.com
Firstname Lastname;user2@domain.com

ForEach will not work and is not needed, because the users needs to be set in 1 row. The input is emailaddress based, for internal or external addresses.

#>

#Obtain the addresses in the CSV
$Users = (Import-CSV -Path 'C:\temp\users.csv').Users

#Set the senders for impersonation protection in the AntiPhishPolicy
Set-AntiPhishPolicy -Identity "Office365 AntiPhish Default" -TargetedUsersToProtect $Users

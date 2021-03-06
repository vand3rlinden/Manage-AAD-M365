# Bulk adding: senders for impersonation protection

<##### Option 1:
CSV Like;
Users
Firstname Lastname;user1@domain.com
Firstname Lastname;user2@domain.com

ForEach is not needed for this option, because we OVERWRITE the whole value
#>
$Users = (Import-CSV -Path 'C:\temp\users.csv').Users
Set-AntiPhishPolicy -Identity "Office365 AntiPhish Default" -TargetedUsersToProtect $Users

<##### Option 2:
CSV Like;
Policy,Users
Office365 AntiPhish Default,Firstname Lastname;user1@domain.com
Office365 AntiPhish Default,Firstname Lastname;user2@domain.com

We use ForEach to add the value on each iteration.
#>
$Users = Import-CSV -Path 'C:\temp\users.csv'

ForEach ($User in $Users){
    Try {
        Set-AntiPhishPolicy -Identity $User.Policy -TargetedUsersToProtect @{add=$User.Users} -ErrorAction Stop
        Write-Host -ForegroundColor Green $user.Users "User is added!"
    }
    Catch {
        Write-Error "Something threw an exception '$($user.Users)'.`nError: $($_.Exception.Message)"
    }
}

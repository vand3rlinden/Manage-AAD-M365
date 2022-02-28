<#
1: First install Graph with: Install-Module Microsoft.Graph -Scope AllUsers
2: First time run, you will need to give consent on the Graph PowerShell enterprise application in AAD and on the scope permissions below.
#>
Connect-MgGraph -Scopes 'AuditLog.Read.All','Directory.Read.All'
Select-MgProfile beta 
$Result=@()
$usersUPN = Get-MgUser -All | Select-Object UserPrincipalName,ID
foreach($user in $usersUPN)
{
    $usersignindate = Get-MgUser -UserId $user.ID -Select SignInActivity | Select-Object -ExpandProperty SignInActivity
    $userprops = [ordered]@{
        UserPrincipalName = $user.UserPrincipalName
        LastSignInDateTime = $usersignindate.LastSignInDateTime
    }
    $userObj =  new-object -Type PSObject -Property $userprops
    $Result += $userObj
}
$Result | Export-Csv "C:\Temp\$((Get-Date).ToString("yyyyMMdd"))_aad-stale-users.csv" -NoTypeInformation

Disconnect-Graph

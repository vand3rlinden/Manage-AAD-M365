<#
1: First install Graph with: Install-Module Microsoft.Graph -Scope AllUsers
2: First time run, you will need to give consent on the Graph PowerShell enterprise application in AAD and on the scope permissions below.
#>

Connect-MgGraph -Scopes 'AuditLog.Read.All','Directory.Read.All'
$Result=@()
$Users = Get-MgUser -All | Select-Object UserPrincipalName,ID,DisplayName
foreach($User in $Users)
{
    $LastSignInDateTime = Get-MgUser -UserId $User.ID -Select SignInActivity | Select-Object -ExpandProperty SignInActivity
    $OutputTable = [ordered]@{
        Displayname        =  $User.DisplayName
        UserPrincipalName  =  $User.UserPrincipalName
        LastSignInDateTime =  $LastSignInDateTime.LastSignInDateTime
    }
    $OutputTableObject = New-Object -Type PSObject -Property $OutputTable
    $Result += $OutputTableObject
}
$Result | Export-Csv "C:\Temp\$((Get-Date).ToString("yyyyMMdd"))_aad-stale-users6.csv" -NoTypeInformation

Disconnect-Graph

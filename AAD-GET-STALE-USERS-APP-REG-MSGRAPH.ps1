<#
1: Make an App Registration in Azure AD
2: API permissions -> Add a permission -> Microsoft Graph -> Application permissions
3: Set the following permissions: User.Read.All, Directory.Read.All, Auditlogs.Read.All
4: Certificates & secrets -> New client setcret
5: Note the Value of the secret and App ID
#>

#App Registration and Azure AD information
$clientID     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"    #  <-insert your own app ID here
$clientSecret = Get-Content -Path 'C:\temp\APISecret.txt' #  <-insert your own secret here
$tenantDomain = "xxxxxx.onmicrosoft.com"                  #  <-insert your onmicrosoft.com domain here
 
#Access token:
$loginURL     = "https://login.microsoft.com"
$resource     = "https://graph.microsoft.com"
$body         = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret}
$oauth        = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body
$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
 
#Query:
$userList = @()
$url = 'https://graph.microsoft.com/beta/users?$select=displayname,userprincipalname,signInActivity&$top=999'
 
While ($Null -ne $url) {
    $data = (Invoke-WebRequest -Headers $headerParams -Uri $url) | ConvertFrom-Json
    $userList += $data.Value
    $url = $data.'@Odata.NextLink'
}

#Data:
$userList | Select-Object DisplayName,userPrincipalName,@{n="LastLoginDate";e={$_.signInActivity.lastSignInDateTime}}|
Export-Csv "C:\Temp\$((Get-Date).ToString("yyyyMMdd"))_aad-stale-users2.csv" -NoTypeInformation

# Exchange Mailbox Report #
Get-ExoMailbox -ResultSize Unlimited

# Get Office 365 Mailbox Size #
Get-ExoMailboxStatistics -Identity admin | Select-Object DisplayName,TotalItemSize
#If you want to get all the mailboxes sizes, combine both Get-Mailbox and Get-MailboxStatistics
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select-Object DisplayName,TotalItemSize

# Get Archive Mailbox in Exchange Online #
#To get archive enabled mailboxes
Get-Mailbox –ResultSize Unlimited –Archive
#To view archive mailboxes sizes
Get-Mailbox –ResultSize Unlimited –Archive | Get-MailboxStatistics| Select-Object DisplayName,TotalItemSize

# Get Mailbox Quota Information #
#To view the quota of a specific mailbox
Get-Mailbox -Identity John@contoso.com | Select-Object *quota*

# List Shared Mailboxes #
Get-ExoMailbox –ResultSize Unlimited –RecipientTypeDetails SharedMailbox

# Get Mailbox Permission Report #
#To get users with Full Access permission on mailboxes
Get-Mailbox | foreach-object {
    (Get-MailboxPermission -Identity $_.userprincipalname | Where-Object { ($_.AccessRights -contains "FullAccess") -and ($_.IsInherited -eq $false) -and -not ($_.User -match "NT AUTHORITY") }) | Select-Object Identity,AccessRights,User}
#To get users with Send-as permission
Get-Mailbox | foreach-object {
    (Get-RecipientPermission -Identity $_.userprincipalname | Where-Object { -not (($_.Trustee -match "NT AUTHORITY") -or ($_.Trustee -match "S-1-5-21"))}) | Select-Object Identity,trustee}
#To get mailboxes with Send-on-behalf permission
Get-Mailbox –ResultSize Unlimited | Where-Object {$_.GrantSendOnBehalfTo -ne $null} | Select-Object UserprincipalName,GrantSendOnBehalfTo

# Identify Inactive Mailboxes #
Get-Mailbox -ResultSize Unlimited | foreach-object {
    Get-MailboxStatistics -Identity $_.UserPrincipalName | Select-Object DisplayName,LastLogonTime,LastUserActionTime}

# Get Mailbox Forwarding Using PowerShell #
Get-mailbox -ResultSize Unlimited| Where-Object {$_.ForwardingAddress -ne $Null} | Select-Object DisplayName,ForwardingAddress

# Get Mailbox Folder Permission #
#To view folders available in the mailbox, run the Get-MailboxFolder along with the mailbox’s identity
Get-MailboxFolder -Identity admin@contoso.com -GetChildren
#To view assigned permission on a specific mailbox folder, use the Get-MailboxFolderPermission
Get-MailboxFolderPermission -Identity "admin@contoso.com:\To me"

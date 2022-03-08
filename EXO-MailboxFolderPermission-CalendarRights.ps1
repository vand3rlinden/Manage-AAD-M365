#AccessRights Table: https://docs.microsoft.com/en-us/powershell/module/exchange/add-mailboxfolderpermission?view=exchange-ps#parameters

#-------Add-Remove-Set-MailboxFolderPermission-Calendar------#
#FIRST "Add-MailboxFolderPermission" to set an -AccessRights!!
Add-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User ed@contoso.com -AccessRights Owner

#remove
Remove-MailboxFolderPermission -Identity kim@contoso.com:\Calendar -User john@contoso.com -confirm:$false

#Set AccessRights (change)
Set-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User ed@contoso.com -AccessRights Editor

#Set AccessRights for the default user (open calendar)
Set-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User Default -AccessRights Reviewer

#Set AccessRights AvailabilityOnly: View only availability data
Set-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User Default -AccessRights AvailabilityOnly


#Add Delegate on Calender !!The parameter "SharingPermissionFlags" can be specified only when access rights is Editor.!!
Set-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User ed@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate

#Delete delegate: This example changes an existing user's permissions to Editor and removes their current delegate status.
Set-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User ed@contoso.com -AccessRights Editor -SendNotificationToUser $false
#There is no way to remove an Outlook delegate user by using powershell command. The best way to remove is to open the Outlook profile and remove it in Outlook.
#Go to File > Account Settings > Delegate Access -> Remove User -> Re add editor permissions via PowerShell

#Add Delegate on Calender + CanViewPrivateItems
Set-MailboxFolderPermission -Identity ayla@contoso.com:\Calendar -User ed@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems



#-------Get-MailboxFolderPermission-Calendar------#
#This example returns the current list of user permissions for the Reports subfolder in the Marketing folder in John's mailbox.
#You can also see who is delegate on the mailbox in the "SharingPermissionFlags" section
Get-MailboxFolderPermission -Identity john@contoso.com:\Marketing\Reports

#This example returns the permissions for the same folder in John's mailbox, but only for the user Ayla.
Get-MailboxFolderPermission -Identity john@contoso.com:\Marketing\Reports -User Ayla@contoso.com

#This example returns the permissions for the Calendar folder in John's mailbox, but only for the user Ayla.
Get-MailboxFolderPermission -Identity john@contoso.com:\Calendar -User Ayla@contoso.com

#See all MailboxFolderPermission for the mailbox Calendar.
Get-MailboxFolderPermission -Identity john@contoso.com:\Calendar

#Foreach get MailboxFolderPermission for a list of users
$Rooms = "roo1m@domain.com","room2@domain.com","room3@domain.com"

foreach ($room in $rooms){
    Get-MailboxFolderPermission -Identity $room":\Calendar"
}

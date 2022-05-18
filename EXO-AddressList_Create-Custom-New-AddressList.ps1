#Create an AddressList for some MailContacts, we use CustomAttribute1 to fill up the AddressList, but you may use any other free CustomAttribute
#By default, the Address List role isn't assigned to any role groups in Exchange Online. Add this role to role group: "Organization Management"
New-ManagementRoleAssignment -SecurityGroup "Organization Management" -Role "Address Lists"

#############################  Step 1: Bulk-Import MailContact
#CSV Format Example
##Name,ExternalEmailAddress
##User,user@domain.com

$Contacts = Import-Csv -Path "C:\temp\YOURCSV.csv"
 
foreach ($Contact in $Contacts){
    New-MailContact -Name $Contact.Name -ExternalEmailAddress $Contact.ExternalEmailAddress
} 


#############################  Step 2: Create custom AddressList
New-AddressList -Name 'Custom AddressList1' -RecipientFilter {((RecipientType -eq "MailContact") -and (CustomAttribute1 -eq 'AddressList1'))}

#############################  Step 3: Set CustomAttribute1
#Use the same CSV as in step 1

$Contacts = Import-Csv -Path "C:\temp\YOURCSV.csv"
 
foreach ($Contact in $Contacts){
    Set-MailContact -Identity $Contact.Name -CustomAttribute1 "AddressList1"
} 

#############################  Step 4: If the new AddressLists don't contain all the expected recipients
#bron: https://docs.microsoft.com/en-us/exchange/troubleshoot/administration/new-address-lists-not-contains-all-recipients
#Use the same CSV as in step 1

#1: Set temp value on not in used CustomAttribute
$Contacts = Import-Csv -Path "C:\temp\YOURCSV.csv"
 
foreach ($Contact in $Contacts){
    Set-MailContact -Identity $Contact.Name -CustomAttribute15 "temp value"
} 

#2: Delete the temp value
$Contacts = Import-Csv -Path "C:\temp\YOURCSV.csv"
 
foreach ($Contact in $Contacts){
    Set-MailContact -Identity $Contact.Name -CustomAttribute15 $null
} 

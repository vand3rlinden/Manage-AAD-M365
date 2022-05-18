#Create a AddressList for some MailContacts, we use CustomAttribute1 to fill up the AddressList

#############################  Step 1: Bulk-Import MailContact
#CSV Format Example
##Name,ExternalEmailAddress
##User,user@domain.com

$Contacts = Import-Csv -Path "C:\temp\YOURCSV.csv"
 
foreach ($Contact in $Contacts){
    New-MailContact -Name $Contact.Name -ExternalEmailAddress $Contact.ExternalEmailAddress
} 


#############################  Step 2: Create custom AddressList
New-AddressList -Name 'NL Franchisers' -RecipientFilter {((RecipientType -eq "MailContact") -and (CustomAttribute1 -eq 'NL Franchisers'))}

#############################  Step 3: Set CustomAttribute1
#Use the same CSV as in step 1

$Contacts = Import-Csv -Path "C:\temp\YOURCSV.csv"
 
foreach ($Contact in $Contacts){
    Set-MailContact -Identity $Contact.Name -CustomAttribute1 "NL Franchisers"
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
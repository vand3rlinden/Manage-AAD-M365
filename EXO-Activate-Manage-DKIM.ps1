#Get DKIM CONFIG#
get-DkimSigningConfig
get-DkimSigningConfig -Identity vand3rlinden.nl | Format-List
##

#Enable DKIM#
#Step 1: Enable DKIM for domain
New-DkimSigningConfig -DomainName vand3rlinden.nl -KeySize 2048 -Enabled $True
#This will give you the values of the CNAME records, if the CNAME records are not added in DNS
#This command also turn on DKIM, if below CNAME records where added in DNS.

#CNAME Records:
#Host: selector1._domainkey.sub.domain.com
#Value: selector1-sub-domain-com._domainkey.domain.onmicrosoft.com.
#Host: selector2._domainkey.sub.domain.com
#Value: selector2-sub-domain-com._domainkey.domain.onmicrosoft.com.

#If you want to only create the selector and do not want to turn it on yet run:
New-DkimSigningConfig -DomainName vand3rlinden.nl -KeySize 2048 -Enabled $false

#Get the DNS CNAME records
Get-DkimSigningConfig -Identity vand3rlinden.nl | Format-List Selector1CNAME, Selector2CNAME
#When selectors are added in DNS as CNAME turn on DKIM like in step 2:

#Step 2: Turn DKIM on (after CNAMEs are added in DNS)
Set-DkimSigningConfig -Identity vand3rlinden.nl -Enabled $true

#If you wish to turn it off:
Set-DkimSigningConfig -Identity vand3rlinden.nl -Enabled $false


#Bron: https://docs.microsoft.com/en-us/microsoft-365/security/office-365-security/use-dkim-to-validate-outbound-email?view=o365-worldwide
##

#Upgrade your 1024-bit keys to 2048-bit DKIM encryption keys#
#Check current key size Selector1
get-DkimSigningConfig -Identity sandbox.vand3rlinden.nl | Select-Object Selector1KeySize
#Check current key size Selector2
get-DkimSigningConfig -Identity sandbox.vand3rlinden.nl | Select-Object Selector2KeySize
#Get Selector Rotate Date
get-DkimSigningConfig -Identity sandbox.vand3rlinden.nl | Select-Object SelectorBeforeRotateOnDate,SelectorAfterRotateOnDate
#For full config run:
get-DkimSigningConfig -Identity sandbox.vand3rlinden.nl | Format-List

#Run to rotate the selector from SelectorBeforeRotateOnDate to 2048
Rotate-DkimSigningConfig -KeySize 2048 -Identity sandbox.vand3rlinden.nl

#After 4 days, run to rotate the other selector
Rotate-DkimSigningConfig -KeySize 2048 -Identity sandbox.vand3rlinden.nl

#bron: https://docs.microsoft.com/en-us/microsoft-365/security/office-365-security/use-dkim-to-validate-outbound-email?view=o365-worldwide#steps-to-manually-upgrade-your-1024-bit-keys-to-2048-bit-dkim-encryption-keys
##

#DKIM Hickup troubleshoot#
#First turn off and on
Set-DkimSigningConfig -Identity vand3rlinden.nl -Enabled $false
Set-DkimSigningConfig -Identity vand3rlinden.nl -Enabled $true

#Second if that does not fix it, rotate the keys
Rotate-DkimSigningConfig -KeySize 2048 -Identity sandbox.vand3rlinden.nl
##

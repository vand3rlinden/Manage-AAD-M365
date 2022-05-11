#Activate AAD role: Identity Governance Administrator

#Connect MS Graph
Connect-MgGraph -Scopes "EntitlementManagement.ReadWrite.All","Directory.Read.All"

#Get users TargetID
$UPN = 'firstname.lastname@domain.com'
Get-MgUser | Where-Object {$_.UserPrincipalName -like $UPN} | Select-Object Id

##Load below variables to add or remove a user from an Access Package:
$AccessPackageName = "ACCESS PACKAGE NAME HERE"
$User = "USER ID HERE"

#Add user to Access Package
Select-MgProfile -Name "beta"
$accesspackage = Get-MgEntitlementManagementAccessPackage -DisplayNameEq $AccessPackageName -ExpandProperty "accessPackageAssignmentPolicies"
$policy = $accesspackage.AccessPackageAssignmentPolicies[0]
New-MgEntitlementManagementAccessPackageAssignmentRequest -AccessPackageId $accesspackage.Id -AssignmentPolicyId $policy.Id -TargetId $User


#Remove user from Access Package
Select-MgProfile -Name "beta"
$accesspackage = Get-MgEntitlementManagementAccessPackage -DisplayNameEq $AccessPackageName -ExpandProperty "accessPackageAssignmentPolicies"
$policy = $accesspackage.AccessPackageAssignmentPolicies[0]
New-MgEntitlementManagementAccessPackageAssignmentRequest -AccessPackageId $accesspackage.Id -AssignmentPolicyId $policy.Id -TargetId $User -RequestType "AdminRemove"

#Disconnect MS Graph
Disconnect-Graph
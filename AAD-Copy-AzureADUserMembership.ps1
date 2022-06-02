# Copy group membership from source user to new target user

#ObjectID Source User
$Source = "xxxxxxxxxxxxxxxxxxxxxxx"

#ObjectID Target User
$Target  = "xxxxxxxxxxxxxxxxxxxxxxx"

$Groups = (Get-AzureADUserMembership -ObjectId $Source).ObjectId

Foreach($Group in $Groups){
    Try
    {
        Add-AzureADGroupMember -ObjectId $Group -RefObjectId $Target -ErrorAction Stop
        Write-Host -ForegroundColor Green "$Group is added!"
    }
    Catch
    {
        Write-Warning "$Group is not added, because already exist or is dynamic!"
    }
}

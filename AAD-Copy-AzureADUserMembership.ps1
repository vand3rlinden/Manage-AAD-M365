# Copy group membership from source user to new target user

#ObjectID Source User
$Source = "d77f0d3a-f6c7-4889-8bc1-da8993f3af4a"

#ObjectID Target User
$Target  = "19720dd4-8ef8-4ea2-838e-c40d4085051b"

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

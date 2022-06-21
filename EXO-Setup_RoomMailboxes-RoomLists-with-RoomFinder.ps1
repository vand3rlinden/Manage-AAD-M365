#1: Create RoomMailboxes
New-Mailbox -Name "RoomMailboxName" -DisplayName "RoomMailboxDisplayName" -PrimarySmtpAddress RoomMailbox@domain.com -Room

#2: Create RoomList(s)
New-DistributionGroup -Name "RoomList" -DisplayName "RoomList" -RoomList

#3: Add the RoomMailboxes to a RoomList
Add-DistributionGroupMember -Identity "RoomList" -Member RoomMailbox@domain.com

#4: Set up the metadata
Set-Place -Identity "RoomMailboxName" -City "Delft" -Capacity '4' -Building 'RoomList Displayname'
#Other meta data to add: AudioDeviceName,VideoDeviceName,DisplayDeviceName,IsWheelChairAccessible [$true/$false]

#If Capacity is already set, you can set the City and Building meta data of all RoomMailboxes in a RoomList
$RoomList = (Get-DistributionGroup -Identity "RoomList@domain.com").Displayname
$City = "Delft"
$Rooms = (Get-DistributionGroupMember -Identity "RoomList@domain.com").Displayname
ForEach ($Room in $Rooms){
    Set-Place -Identity $Room -City $City -Building $RoomList
}

<# 
NOTE: The Set-Place cmdlet comes available after replication cycle of the RoomMailbox. 
You can get an error message on new RoomMailboxes when you use the Set-Place cmdlet. The replication cycle is 24 hours in most cases.
#>

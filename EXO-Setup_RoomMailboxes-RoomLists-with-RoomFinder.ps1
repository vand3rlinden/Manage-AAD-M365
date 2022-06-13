#1: Create RoomMailboxes
New-Mailbox -Name "RoomMailboxName" -DisplayName "RoomMailboxDisplayName" -PrimarySmtpAddress RoomMailbox@domain.com -Room

#2: Create RoomList(s)
New-DistributionGroup -Name "RoomList" -DisplayName "RoomList" -RoomList

#3: Add the RoomMailboxes to a RoomList
Add-DistributionGroupMember -Identity "RoomList" -Member RoomMailbox@domain.com

<#
On this point, fill in all your rooms and place the rooms into  a room lists

Setting up the Room Finder can find the RoomMailboxes and RoomLists, we can do this with the Set-Place cmdlet. This cmdlet let you fill in meta data, like capacity, audio devices, video devices, which city or if wheel chair accessible. When you set all the meta data, finding rooms with Outlooks Room Finder is much easier for your end- users. Also the RoomFinder only works when you set the city meta data on your room mailboxes, I also recommend always set a capicity on your rooms. to avoid disappointment of space. 
#>

#4: Set the city and capacity metadata
Set-Place -Identity "RoomMailboxName" -City "Delft" -Capacity '4'

<#
After you setup the city and capacity metadata, your room mailbox and room lists will appear in the room finder. 
It can take up to 24 hours before this is in sync with the room finder in Outlook and Outlook on the web.
#>

<#
Finetuning the room in Room Finder. 
Is always a good idea when the room have devices like audio or video to make this visible in the Room Finder 
and also, when the room is wheelchair accessible or not. 
#>

#5: Finetuning the room in Room Finder
Set-Place -Identity 'RoomMailbox1' -AudioDeviceName 'Sonos' -VideoDeviceName 'Sony Beamer' -DisplayDeviceName 'Samsung TV 55' -IsWheelChairAccessible $true

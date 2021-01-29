# add the required .NET assembly
Add-Type -AssemblyName System.Windows.Forms
#Set Execution Policy for current user to remotely signed. 
Set-ExecutionPolicy -Scope "CurrentUser" -ExecutionPolicy "RemoteSigned"

#Obtain Username and set within username variable. 
#Create variable UserInfo and store net user information within. Include full name and passwordy Expiry within. 
$username = $env:Username
$UserInfo= net user $username /DOMAIN | Select-String "Full Name", "Password expires"

#Extract Full Name String from UserInfo
#Extract Password Expires from UserInfo
$temp_FullName = $UserInfo | Select-String "Full Name"
$temp_Expiry = $userInfo | Select-String "Password expires"

#Removes Spaces from Fullname and removes "full name" pre-text
$tempHold1 = $temp_FullName -replace '(^\s+|\s+$)','' -replace '\s+',' '
$FullName = $tempHold1 -replace '(Full Name)','' -replace '\s+',' '
#Removes Spaces from Expiry date and removes "Password Expires" Pre-text
$tempHold2 = $temp_Expiry -replace '(^\s+|\s+$)','' -replace '\s+',' '
$Expiry = $tempHold2 -replace '(Password expires)','' -replace '\s+',' '

#Set popup box items such as Button Type, Message Icon, Message Body & Message Title. 
$ButtonType = [System.Windows.Forms.MessageBoxButtons]::OK
$MessageIcon = [System.Windows.Forms.MessageBoxIcon]::Information
$MessageBody =""+$FullName + "`n`nYour Domain Password is due to expire on the" + $Expiry + "`n`nPlease reset your password 7 days in advance.  `n`nThank you`nIT"
$MessageTitle = "Password Expiry Tool"

#Popup Box
[System.Windows.Forms.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType)

#This script was created  by Tom Bindloss - 2019
#You're free to use this script however you please.
# You can find more of my scripts here - https://github.com/TomBindloss    

$EXmsg = "External Message goes here"
$INmsg = "Internal Message goes here"
$Users = @(Get-ADGroupMember -Identity "Group Name"| Get-ADUser -Properties mail | Select mail -ExpandProperty Mail )
$NewUser = ForEach ($user in $Users){$user.Trimstart("@{mail=")}

connect-msolservice
$UserCredential = $Creds
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session


ForEach ($User in $Users){
Set-MailboxAutoReplyConfiguration -Identity $user -autoreplystate enabled -ExternalMessage $EXmsg -InternalMessage $INmsg
}
Remove-PSSession *


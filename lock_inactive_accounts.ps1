## Author: Frank Bischof (info@meer-web.nl)
## Version: 1.0

## Disable account if not used for X days
$90Days = (get-date).adddays(-90)
$users = Get-ADUser -properties * -filter {((lastlogondate -notlike "*" -OR lastlogondate -le $90Days) -AND (enabled -eq $True))}  | where CanonicalName -Like "*NamedAccounts*" | select-object SAMaccountname
foreach ($user in $users)
{
    write-host Disabling account $user.SAMaccountname
    Disable-ADAccount -Identity $user.SAMaccountname

}

## Delete account if disabled for X months.
$6Months = (get-date).AddMonths(-6)
$users = Get-ADUser -properties * -filter {((modifyTimeStamp -le $6Months) -AND (enabled -eq $False))}  | where CanonicalName -Like "*NamedAccounts*" | select-object SAMaccountname
foreach ($user in $users)
{
    write-host Deleting account $user.SAMaccountname
    Remove-ADUser -Identity $user.SAMaccountname
}
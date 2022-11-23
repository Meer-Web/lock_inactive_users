# lock_inactive_users
Lock and/or delete AD accounts which are inactive

## Usage
By default users who did not log in for 90 days, their account will be put inactive.
After this, accounts which are inactive for 6 months will be deleted.

This can be customized in the variables:
$90Days = (get-date).adddays(-90)
and
$6Months = (get-date).AddMonths(-6)
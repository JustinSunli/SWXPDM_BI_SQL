/*
All Security Groups
*/

use blount_vault
select g.GroupID, g.Groupname, g.Description
from Groups g
where g.GroupID not in (1,113,79)
and g.groupname not like 'X%'
order by g.Groupname asc
/*
Repository Projects
*/

select p.ProjectID, p.Path, p.Name, p.StartTime
from Projects p

Where p.Path like '\Engineering\CCF\%\%'
or p.Path like '\Engineering\FLAG\%\%'
or p.Path like '\Engineering\FRAG\%\%'

or p.Path like '\ESW\CCF\%\%'
or p.Path like '\ESW\FLAG\%\%'
or p.Path like '\ESW\FRAG\%\%'

or p.Path like '\Development\CCF\%\%'
or p.Path like '\Development\FLAG\%\%'
or p.Path like '\Development\FRAG\%\%'

and p.Path not like '\ESW\PDM Standards\%'

and p.Deleted = 0
order by p.StartTime asc
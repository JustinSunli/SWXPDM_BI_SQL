select  s.StatusID, s.Name
from Status s
where s.Enabled = 1
and s.Name <> ''
and s.Name not like 'X %'
order by s.StatusID asc
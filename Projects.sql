select p.ProjectID, p.Name as Filename, p.Path
from Projects p
where Deleted = 0
and p.ProjectID not in (1,2)

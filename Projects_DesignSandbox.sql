--Design Sandbox

select d.DocumentID, d.Filename, p.ProjectID, p.Path as Project
from Documents d
inner join DocumentsInProjects dp on d.DocumentID = dp.DocumentID
INNER join Projects p on dp.ProjectID = p.ProjectID
where p.path like '\Design Sandbox\%'
and d.Deleted = 0

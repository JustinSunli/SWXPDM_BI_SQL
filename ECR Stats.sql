SELECT Distinct D.Filename 'File Name', S.Name 'Status Name', P.Path 'Project Path',

CONVERT(VarChar, md.MaxDate, 101) "Date Entered State", --https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15
CONVERT(VarChar, GETDATE(), 101) "Current Date",
DATEDIFF (d, md.MaxDate, GETDATE()) "DaysInState",
Datediff (d,md.MaxDate,getdate())/7 "Weeks in State"

FROM Projects P
INNER JOIN DocumentsInProjects DP ON P.ProjectID = DP.ProjectID
INNER JOIN Documents D ON DP.DocumentID = D.DocumentID
INNER JOIN Status S ON D.CurrentStatusID = S.StatusID

Inner join (select DocumentID, MAX(date) as MaxDate
from TransitionHistory
Group by DocumentID) md ON md.documentid=d.documentid

Where D.ObjectTypeID <> 0 
and d.deleted = 0 
and s.name is not null 
and s.name <> 'Obsolete'
and LEN(s.Name)>0 
and Filename like 'ECR-%.xml'
order by d.Filename desc
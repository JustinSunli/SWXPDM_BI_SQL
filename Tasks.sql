--Date Time conversion: https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15

select ti.TaskID,
	   ti.TaskInstanceID,
	   ti.InitUserID as UserID,
	   u.FullName as Initiated,
	   t.TaskName,d.Filename,
	   d.DocumentID,
	   CONVERT(varchar, DATEADD(mi, datediff(mi, getutcdate(), getdate()), ti.endtime),22) as TimeStamp
,CASE
	when ti.TaskStatus = 6 then 'Cancel'
	when ti.TaskStatus = 7 then 'Success'
	when ti.TaskStatus = 8 then 'Terminated'
	when ti.TaskStatus = 9 then 'Complete with Errors'
	when ti.TaskStatus = 5 then 'Suspended by the User'
	Else 'Not Reported'
end as TaskStatus
from TaskInstances ti
inner join tasks t on ti.TaskID = t.TaskID --Get task name
inner join TaskSelection ts on ti.TaskInstanceID = ts.TaskInstanceID --get Docuements processed and version
inner join Documents d on ts.DocumentID = d.DocumentID --Get Document name
inner join Users u on ti.InitUserID = u.UserID --Get user name
order by ti.EndTime desc
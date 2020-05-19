--Sample code for Pivot Operator: https://forum.solidworks.com/thread/199213

select DocumentID, LatestRevisionNo as Ver, Filename, Status, --Status, Author, TimeStamp,
[ECR_CorrectiveAction] as Corrective_Action,
[ECR_Author] as Author,
[ECR_Approver00] as ENG_Appvr,
[ECR_Approver_CAD] as CAD_Appvr

from (
        select d.DocumentID, d.filename, vv.valuetext, v.variablename, s.Name as Status, d.LatestRevisionNo
--         CONVERT(varchar, DATEADD(mi, datediff(mi, getutcdate(), getdate()), ti.StartTime),22) as TaskStap
--             ,CASE
--                 when ti.TaskStatus = 6 then 'Cancel'
--                 when ti.TaskStatus = 7 then 'Success'
--                 when ti.TaskStatus = 8 then 'Terminated'
--                 when ti.TaskStatus = 9 then 'Complete with Errors'
--                 when ti.TaskStatus = 5 then 'Suspended by the User'
--                 Else 'Not Reported'
--             end as TaskStatus
        from TaskInstances ti
            inner join tasks t on ti.TaskID = t.TaskID --Get task name
            inner join TaskSelection ts on ti.TaskInstanceID = ts.TaskInstanceID --get Docuements processed and version
            inner join Documents d on ts.DocumentID = d.DocumentID --Get Document name
            inner join Users u on ti.InitUserID = u.UserID --Get user name
            inner join Status s on d.CurrentStatusID = s.StatusID
            inner join  VariableValue vv on d.DocumentID = vv.DocumentID
            inner join Variable v on vv.VariableID  = v.VariableID
            where Filename LIKE 'ECR-%.xml'

    ) as SourceTable

PIVOT
(
    MAX(ValueText)
    for variablename in (
                            [ECR_Author],
                            [ECR_Approver00],
                            [ECR_Approver_CAD],
                            [ECR_CorrectiveAction]

                        )
)pivot_table
order by filename desc

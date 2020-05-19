--Sample code for Pivot Operator: https://forum.solidworks.com/thread/199213

select DocumentID, LatestRevisionNo as Ver, left(Filename, len(FileName) - charindex('.', reverse([FileName]))), Status, convert(varchar, StartTime, 101) as Start_Date,


    [ECR_CorrectiveAction] as Corrective_Action,
    [ECR_Author] as Author,
    [ECR_Approver00] as ENG_Appvr,
    [ECR_Approver_CAD] as CAD_Appvr,
    [ECR_AppvlDateCAD] as Release_Date


from (
        select d.DocumentID, d.filename, vv.valuetext, v.variablename, s.Name as Status, d.LatestRevisionNo, p.StartTime

        from TaskInstances ti
            inner join tasks t on ti.TaskID = t.TaskID --Get task name
            inner join TaskSelection ts on ti.TaskInstanceID = ts.TaskInstanceID --get Docuements processed and version
            inner join Documents d on ts.DocumentID = d.DocumentID --Get Document name
            inner join Status s on d.CurrentStatusID = s.StatusID
            inner join  VariableValue vv on d.DocumentID = vv.DocumentID
            inner join Variable v on vv.VariableID  = v.VariableID

            inner join DocumentsInProjects dp on d.DocumentID = dp.DocumentID --Get start of ECR
            inner join Projects p on dp.ProjectID = p.ProjectID

            where Filename LIKE 'ECR-%.xml'
    ) as SourceTable

PIVOT
(
    Max(ValueText)
    for variablename in (
                            [ECR_Author],
                            [ECR_Approver00],
                            [ECR_Approver_CAD],
                            [ECR_CorrectiveAction],
                            [ECR_AppvlDateCAD]
                        )
)pivot_table
order by filename desc

select * from Variable v
where v.VariableName like 'ECR_%'
and v.VariableName like '%date%'
--Sample code for Pivot Operator in SWX PDM: https://forum.solidworks.com/thread/199213

select DocumentID, 
	   LatestRevisionNo as Ver,
	   left(Filename, len(FileName) - charindex('.', reverse([FileName]))) as ECRnumber, Status, convert(varchar, StartTime, 101) as Start_Date,
	   [ECR_CorrectiveAction] as Corrective_Action,
       [ECR_Author] as Author,
       [ECR_Approver00] as ENG_Appvr,
       [ECR_Approver_CAD] as CAD_Appvr,
	   [ECR_AppvlDateCAD]as Release_Date,
	   [Division] as divion,
	   [Department] as Department,

		CASE
			WHEN isnull(convert(varchar,[ECR_AppvlDateCAD],101),'') = '' then CONVERT(VarChar, GETDATE(), 101)
		END as CurrentDate

from (select d.DocumentID, 
			 d.filename,
			 vv.valuetext, 
			 v.variablename, 
			 s.Name as Status, 
			 d.LatestRevisionNo, 
			 p.StartTime

        from Documents d
            inner join Status s on d.CurrentStatusID = s.StatusID
            inner join  VariableValue vv on d.DocumentID = vv.DocumentID
            inner join Variable v on vv.VariableID  = v.VariableID
            inner join DocumentsInProjects dp on d.DocumentID = dp.DocumentID --Get ECR start Date
            inner join Projects p on dp.ProjectID = p.ProjectID
            where Filename LIKE 'ECR-%.xml'
			and d.Deleted = 0
    ) as SourceTable

PIVOT
(
    Max(ValueText)
    for variablename in (
                            [ECR_Author],
                            [ECR_Approver00],
                            [ECR_Approver_CAD],
                            [ECR_CorrectiveAction],
                            [ECR_AppvlDateCAD],
							[Division],
							[department]
                        )
)pivot_table
order by filename desc
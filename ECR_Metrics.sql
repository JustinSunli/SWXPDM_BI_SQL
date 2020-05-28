--Sample code for Pivot Operator in SWX PDM: https://forum.solidworks.com/thread/199213

select DocumentID, 
	   LatestRevisionNo as Ver,
	   left(Filename, len(FileName) - charindex('.', reverse([FileName]))) as ECRnumber,
       Status,
	   statusID,
       convert(varchar, StartTime, 101) as Start_date,
	   [Description] as Description,
	   isnull(nullif([ECR_CorrectiveAction],''), 'Not Entered') as Corrective_Action,
       [ECR_Author] as Author,
       [ECR_Approver00] as ENG_Appvr,
       [ECR_Approver_CAD] as CAD_Appvr,
	   [ECR_AppvlDateCAD] as Release_Date,
	   [Division] as Divion,
	   [Department] as Department,
	   len([ECR_RootCause]) +  len([ECR_ProposedChanges]) as ECR_Quality,
       [ECR_RootCause],
       [ECR_ProposedChanges],


		CASE
			WHEN isnull([ECR_AppvlDateCAD],'') = '' then datediff(day, StartTime, getdate())
		    else datediff(day, StartTime, [ECR_AppvlDateCAD])
		END as Durration

from (select d.DocumentID, 
			 d.filename,
			 vv.valuetext, 
			 v.variablename, 
			 s.Name as Status, 
			 s.StatusID,
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
							[Description],
						    [ECR_Author],
                            [ECR_Approver00],
                            [ECR_Approver_CAD],
                            [ECR_CorrectiveAction],
                            [ECR_AppvlDateCAD],
							[Division],
							[department],
							[ECR_RootCause],
							[ECR_ProposedChanges]
                        )
)pivot_table
order by filename desc
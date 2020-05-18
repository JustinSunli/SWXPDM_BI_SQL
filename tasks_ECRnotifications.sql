--Sample code for Pivot Operator: https://forum.solidworks.com/thread/199213

select filename, LatestRevisionNo as Ver, Status,
       [ECR_Approver00] as ENG_Appvr,
       [ECR_Approver_CAD] as CAD_Appvr,
       [ECR_CorrectiveAction] as Corrective_Action
from
    (select filename, v.variablename, vv.valuetext, d.LatestRevisionNo, s.Name as Status
    from
        documents d
        inner join variablevalue vv on vv.DocumentID = d.DocumentID
        inner join Variable v on v.VariableID = vv.VariableID
        inner join  Users u on d.UserID = u.UserID
        inner join Status s on d.CurrentStatusID = s.StatusID
        where Filename LIKE 'ECR-%.xml'
    ) as SourceTable

PIVOT
(
    MAX(ValueText)
    for variablename in (
                            [ECR_Approver00],
                            [ECR_Approver_CAD],
                            [ECR_CorrectiveAction]
                        )
)pivot_table
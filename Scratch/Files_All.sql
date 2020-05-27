
declare @max int
set @max  =   (
                select max(vv2.RevisionNo) as maxver
                from VariableValue vv2
                where vv2.ConfigurationID = 2
                and vv2.DocumentID = 2441
                and vv2.VariableID = 46
                and vv2.ConfigurationID = 2
                )

select *
from Documents d
inner join VariableValue vv on d.DocumentID = vv.DocumentID --and d.LatestRevisionNo = vv.RevisionNo
where vv.RevisionNo = @max
and vv.VariableID = 46
and d.DocumentID = 2441
and vv.ConfigurationID = 2



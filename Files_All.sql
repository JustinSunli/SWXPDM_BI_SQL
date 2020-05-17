select *--d.Filename,d.CurrentStatusID,vv.VariableID,vv.ValueText, vv.ConfigurationID, vv.RevisionNo
from Documents d
         inner join Revisions r on d.DocumentID = r.DocumentID and d.LatestRevisionNo = r.RevNr
         inner join VariableValue vv on r.DocumentID = vv.DocumentID and d.LatestRevisionNo = r.RevNr

--               inner join
--                       (
--                           select  vv2.DocumentID, max(vv2.RevisionNo) as maxVar
--                           from VariableValue vv2
--                           group by vv2.DocumentID
--                       ) vv2
--   on vv.DocumentID = vv2.DocumentID
--                      and vv.RevisionNo = vv2.maxVar

where d.DocumentID = 2441
  and vv.VariableID = 46
  and vv.ConfigurationID = 2
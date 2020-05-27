select d.DocumentID, d.UserID, d.CurrentStatusID, d.Filename, fe.Extension, d.LatestRevisionNo,
case
when d.UserID = 1 then 'Unlocked'
else 'Locked'
end as LockStatus
from Documents d
inner join FileExtension fe on d.ExtensionID = fe.ExtensionID
where d.Deleted = 0
and fe.Extension not like '*'

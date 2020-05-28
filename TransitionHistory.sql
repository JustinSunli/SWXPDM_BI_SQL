select th.TransitionID, d.DocumentID,d.Filename, u.UserID, u.FullName, th.Date
from TransitionHistory th
inner join documents d on th.DocumentID = d.DocumentID
inner join users u on th.UserID = u.UserID
order by th.Date desc


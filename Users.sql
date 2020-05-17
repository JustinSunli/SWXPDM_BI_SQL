/*
All Users
*/

select u.UserID, u.fullname, s.Value as Title, u.UserData as Category, u.Username,
case
	when u.Username like 'uspo%' then '4909 S.E. International Way Portland, OR 97222'
	when u.Username like 'Admin' then '4909 S.E. International Way Portland, OR 97222'
	when u.Username like 'cago%' then '505 Edinburgh Rd., N. Guelph, Ontario N1H 6L4 Canada'
	when u.Username like 'usoi%' then '2606 S. Illinois Route 2, Oregon, Illinois'
	when u.Username like 'brcp%' then 'Rua Emílio Romani, 1630 - CIC, Curitiba, Paraná, Brazil'
	when u.Username like 'cnff%' then 'Gulou Yuan, Fuwan Pian, Fuzhou, Fujian, Jinshan Industrial Zone, China 350008'
	when u.Username like 'cnsj%' then 'Unit 707-708, International Building, No. 2, West Suzhou Avenue, Industrial ParkSuzhou, Suzhou, Jiangsu, 215021  China'
	when u.Username like 'uskw%' then '1962 Queenland Drive, Mosinee, WI 54455'
	when u.Username like 'uskm%' then '10331 NW Transcon Drive, Kansas City, Missouri 64153'
	when u.Username like 'uspa%' then '2281 Crosswind Drive, Prescott, AZ 86301'
	when u.Username like 'bemb%' then 'Rue Emile Francqui, 5 B 1435 Mont-Saint-Guibert, Belgium'
	when u.Username like 'dews%' then 'Lise-Meitner-Straße 4, 70736 Fellbach, Germany'
end as Location
from Users U
INNER JOIN Settings s on u.UserID = s.UserID
where u.Enabled = 1
and s.VarID = 36 --User Presence note (for Member title)
and u.FullName NOT LIKE '!%'
and u.FullName NOT like 'pmfg%'
order by u.FullName ASC
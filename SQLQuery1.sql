--Display a list of all property names and their property id’s for Owner Id: 1426
SELECT 
	p.Name, 
	p.Id
FROM
[Property] as p
left join [OwnerProperty] as o
ON p.Id = o.PropertyId
WHERE o.OwnerId = '1426'



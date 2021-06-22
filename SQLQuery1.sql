--a) Display a list of all property names and their property id’s for Owner Id: 1426
SELECT 
	p.Name, 
	p.Id
FROM
[Property] AS p
LEFT JOIN [OwnerProperty] AS o
ON p.Id = o.PropertyId
WHERE o.OwnerId = '1426'


--b) Display the current home value for each property in question a)
SELECT 
	p.PropertyId, 
	p.Value
FROM
[PropertyHomeValue] AS p
LEFT JOIN [OwnerProperty] AS o
ON p.PropertyId = o.PropertyId
WHERE o.OwnerId = '1426'


--c)For each property in question a), return the following: Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
SELECT 
	p.PropertyId, 
	tp.PaymentAmount AS RentalAmount,
	tpf.name AS Frequency,
	tp.StartDate,
	tp.EndDate,
	SUM(p.Amount) AS Totalrentpaid
FROM
[PropertyRentalPayment] AS p
LEFT JOIN [OwnerProperty] AS o
ON p.PropertyId = o.PropertyId
RIGHT JOIN [TenantProperty] AS tp
ON p.PropertyId = tp.PropertyId
RIGHT JOIN [TenantPaymentFrequencies] AS tpf
ON p.FrequencyType = tpf.Id
WHERE o.OwnerId = '1426'
GROUP BY p.PropertyId





--d)Display all the jobs available
SELECT 
	t.PropertyId,
	t.JobDescription,
	tjs.Name AS Status
FROM
[TenantJobRequest] AS t
LEFT JOIN [TenantJobStatus] AS tjs
ON t.JobStatusId = tjs.Id
WHERE tjs.Id = '1'


--e)Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). 
SELECT 
	p.Name AS PropertyName, 
	pe.FirstName,
	pe.LastName,
	tp.PaymentAmount AS Rent,
	tpf.Name AS Frequency
FROM
[Property] AS p
LEFT JOIN [OwnerProperty] AS o
ON p.Id = o.PropertyId
RIGHT JOIN [TenantProperty] AS tp
ON p.Id = tp.PropertyId
RIGHT JOIN [Tenant] AS te
ON tp.TenantId = te.Id
RIGHT JOIN [Person] AS pe
ON pe.Id = tp.TenantId
RIGHT JOIN [TenantPaymentFrequencies] AS tpf
ON tp.PaymentFrequencyId = tpf.Id
WHERE o.OwnerId = '1426' AND te.IsActive = '1'
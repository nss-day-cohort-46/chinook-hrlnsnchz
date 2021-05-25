-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT FirstName, LastName, CustomerId, Country 
FROM Customer 
WHERE Country IS NOT 'USA';

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer Where Country = 'Brazil';

-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should 
-- show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT C.FirstName, C.LastName, InvoiceID, InvoiceDate, BillingCountry 
FROM Invoice 
JOIN Customer C 
WHERE C.Country = 'Brazil';

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
SELECT * FROM Employee WHERE Title = 'Sales Support Agent';

-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry FROM Invoice;

-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. 
-- The resultant table should include the Sales Agent's full name.
SELECT E.FirstName, E.LastName, I.InvoiceId, I. CustomerId, I.InvoiceDate, I.BillingAddress, 
I.BillingCity, I.BillingState, I.BillingCountry, I.BillingPostalCode, I.Total 
FROM Invoice I 
JOIN Customer C ON I.CustomerId = C.CustomerId 
JOIN Employee E ON C.SupportRepId = E.EmployeeId;

-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, 
-- Country and Sale Agent name for all invoices and customers.
SELECT I.Total, C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName, C.Country, E.FirstName AS AgentFirstName, E.LastName AS AgentLastName
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON C.SupportRepId = E.EmployeeId;
-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) 
-- who are not in the US.
SELECT FirstName, LastName, CustomerId, Country 
FROM Customer 
WHERE Country IS NOT 'USA';

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer Where Country = 'Brazil';

-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. 
-- The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT C.FirstName, C.LastName, InvoiceID, InvoiceDate, BillingCountry 
FROM Invoice 
JOIN Customer C 
WHERE C.Country = 'Brazil';

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
SELECT * FROM Employee WHERE Title = 'Sales Support Agent';

-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing 
-- countries from the Invoice table.
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
SELECT I.Total, C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName, 
C.Country, E.FirstName AS AgentFirstName, E.LastName AS AgentLastName
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON C.SupportRepId = E.EmployeeId;

-- total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?
SELECT SUM(InvoiceId) FROM Invoice
WHERE InvoiceDate >= '2009-01-01 00:00:00'
AND InvoiceDate < '2010-01-01 00:00:00'
OR InvoiceDate >= '2011-01-01 00:00:00'
AND InvoiceDate < '2012-01-01 00:00:00';

-- total_sales_{year}.sql: What are the respective total sales for each of those years?
SELECT SUM(Total) FROM Invoice
WHERE InvoiceDate >= '2009-01-01 00:00:00'
AND InvoiceDate < '2010-01-01 00:00:00'
OR InvoiceDate >= '2011-01-01 00:00:00'
AND InvoiceDate < '2012-01-01 00:00:00';

-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that 
-- COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(InvoiceLineId) FROM InvoiceLine
WHERE InvoiceId = 37;

-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs 
-- the number of line items for each Invoice. HINT: GROUP BY
SELECT InvoiceId, COUNT(InvoiceLineId) FROM InvoiceLine
GROUP BY InvoiceId;

-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.
SELECT T.Name AS TrackName, I.* FROM InvoiceLine I
JOIN Track T ON I.TrackId = T.TrackId;

-- line_item_track_artist.sql: Provide a query that includes the purchased track name 
-- AND artist name with each invoice line item.
SELECT T.Name AS TrackName, Artist.Name AS ArtistName, I.* FROM InvoiceLine I
JOIN Track T ON I.TrackId = T.TrackId
JOIN Album ON T.AlbumId = Album.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId;

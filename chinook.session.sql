-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) 
-- who are not in the US.
SELECT FirstName, LastName, CustomerId, Country 
FROM Customer 
WHERE Country IS NOT 'USA';

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer 
Where Country = 'Brazil';

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
SELECT T.Name AS TrackName, Artist.Name AS ArtistName, I.* 
FROM InvoiceLine I
JOIN Track T ON I.TrackId = T.TrackId
JOIN Album ON T.AlbumId = Album.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId;

-- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT COUNT(InvoiceId), I.* FROM Invoice I
GROUP BY BillingCountry;

-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. 
-- The Playlist name should be include on the resulant table.
SELECT COUNT(PT.TrackId), P.name FROM PlaylistTrack PT
JOIN Playlist P WHERE PT.PlaylistId = P.PlaylistId
GROUP BY P.PlaylistId;

-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. 
-- The result should include the Album name, Media type and Genre.
SELECT T.Name TrackName, A.Title AlbumName, MT.Name MediaType, G.Name Genre 
FROM Track T
JOIN Album A ON A.AlbumId = T.AlbumId
JOIN MediaType MT ON MT.MediaTypeId = T.MediaTypeId
JOIN Genre G ON G.GenreId = T.GenreId;

-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # 
-- of invoice line items.
SELECT I.*, COUNT(IL.InvoiceLineId)
FROM InvoiceLine IL
JOIN Invoice I ON IL.InvoiceId = I.InvoiceId
GROUP BY IL.InvoiceId;

-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
SELECT SUM(I.Total), E.FirstName, E.LastName FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON E.EmployeeId = C.SupportRepId
GROUP BY E.LastName;

-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?
SELECT SUM(I.Total) AS TotalSales, E.FirstName, E.LastName FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON E.EmployeeId = C.SupportRepId
WHERE I.InvoiceDate >= '2009-01-01 00:00:00'
AND I.InvoiceDate < '2010-01-01 00:00:00'
GROUP BY E.LastName
ORDER BY TotalSales DESC;

-- top_agent.sql: Which sales agent made the most in sales over all?
SELECT SUM(I.Total) AS TotalSales, E.FirstName, E.LastName FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
JOIN Employee E ON E.EmployeeId = C.SupportRepId
GROUP BY E.LastName
ORDER BY TotalSales DESC;

-- sales_agent_customer_count.sql: Provide a query that shows the count of 
-- customers assigned to each sales agent.
SELECT COUNT(C.CustomerId), E.FirstName, E.LastName FROM EMPLOYEE E
JOIN Customer C ON E.EmployeeId = C.SupportRepId
GROUP BY E.EmployeeId;

-- sales_per_country.sql: Provide a query that shows the total sales per country.
SELECT BillingCountry, SUM(Total) FROM Invoice
GROUP BY BillingCountry;

-- top_country.sql: Which country's customers spent the most?
SELECT BillingCountry, SUM(Total) FROM Invoice
GROUP BY BillingCountry
ORDER BY SUM(Total) DESC
LIMIT 1;

-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.
SELECT T.Name, SUM(IL.TrackId) TrackSaleCount FROM InvoiceLine IL
JOIN Invoice I ON IL.InvoiceId = I.InvoiceId
JOIN Track T ON T.TrackId = IL.TrackId
WHERE I.InvoiceDate >= '2013-01-01 00:00:00'
AND I.InvoiceDate < '2014-01-01 00:00:00'
GROUP BY IL.TrackId
ORDER BY TrackSaleCount DESC
LIMIT 1;

-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.
SELECT T.Name, SUM(IL.TrackId) TrackSaleCount FROM InvoiceLine IL
JOIN Invoice I ON IL.InvoiceId = I.InvoiceId
JOIN Track T ON T.TrackId = IL.TrackId
GROUP BY IL.TrackId
ORDER BY TrackSaleCount DESC
LIMIT 5;

-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.
SELECT Artist.Name AS ArtistName, COUNT(IL.TrackId) AS TrackSalesCount 
FROM InvoiceLine IL
JOIN Invoice I ON IL.InvoiceId = I.InvoiceId
JOIN Track T ON T.TrackId = IL.TrackId
JOIN Album ON Album.AlbumId = T.AlbumId
JOIN Artist ON Artist.ArtistId = Album.ArtistId
GROUP BY ArtistName
ORDER BY TrackSalesCount DESC
LIMIT 3;

-- top_media_type.sql: Provide a query that shows the most purchased Media Type.
SELECT MT.Name AS MediaType, COUNT(IL.TrackId) AS TrackSalesCount 
FROM InvoiceLine IL
JOIN Invoice I ON IL.InvoiceId = I.InvoiceId
JOIN Track T ON T.TrackId = IL.TrackId
JOIN MediaType MT ON MT.MediaTypeId = T.MediaTypeId
GROUP BY MediaType
ORDER BY TrackSalesCount DESC
LIMIT 1;
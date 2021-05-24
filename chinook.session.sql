-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT FirstName, LastName, CustomerId, Country FROM Customer WHERE Country IS NOT 'USA';

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer Where Country = 'Brazil';
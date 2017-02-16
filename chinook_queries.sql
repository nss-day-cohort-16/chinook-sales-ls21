#show NON USA Customers
SELECT FirstName, LastName, Country, CustomerId FROM Customer
WHERE Country != "USA"

#show only Brazil Customers
SELECT FirstName, LastName, Country, CustomerId FROM Customer
WHERE Country = "Brazil"

#show invoices from customers from Brazil
SELECT c.FirstName, c.LastName, c.Country, i.InvoiceId, i.InvoiceDate 
FROM Customer c, Invoice i
WHERE i.CustomerId = c.CustomerId 
AND c.Country = "Brazil"

#show employees who are sales agents
SELECT DISTINCT e.LastName, e.FirstName 
FROM Employee e, Customer c
WHERE e.EmployeeId = c.SupportRepId

#select distinct countries from list of invoices
SELECT DISTINCT BillingCountry FROM Invoice

#show invoices associated with appropriate sales agent
SELECT i.InvoiceId, e.LastName, e.FirstName, e. EmployeeId
FROM Invoice i, Employee e, Customer c
WHERE i.CustomerId = c.CustomerId
AND c.SupportRepId = e.EmployeeId

# all invoices associated with customers and sales reps
SELECT i.Total, c.FirstName, c.LastName, c.Country, e.LastName, e.FirstName
FROM Invoice i, Customer c, Employee e
WHERE i.customerId = c.customerId 
AND c.SupportRepId = e.EmployeeId 

# number of invoices in 2009
SELECT Count(*) FROM Invoice 
WHERE InvoiceDate 
between '2009-01-01'
AND '2009-12-31'

#number of invoices in 2011
SELECT Count(*) FROM Invoice
WHERE InvoiceDate
between '2011-01-01'
AND '2011-12-31'

#sum of invoices from 2009
SELECT SUM(Total) FROM Invoice
WHERE InvoiceDate
between '2009-01-01'
AND '2009-12-31'

#sum of invoices from 2011
SELECT SUM(Total) FROM Invoice
WHERE InvoiceDate
between '2011-01-01'
AND '2011-12-31'

#invoice line items for Invoice 37
SELECT Count(InvoiceId) FROM InvoiceLine
WHERE InvoiceId = 37

# invoice line items by invoice
SELECT Count(InvoiceId) FROM InvoiceLine
GROUP BY InvoiceId

#purchased track name by invoice line item
SELECT i.InvoiceLineId, t.Name 
FROM InvoiceLine i, Track t
WHERE i.TrackId = t.TrackId

# purchased track and artist name by invoice line item
SELECT i.InvoiceLineId, t.Name, a.Name 
FROM InvoiceLine i, Track t, Album al, Artist a
WHERE i.TrackId = t.TrackId
AND t.AlbumId = al.AlbumId
AND al.ArtistId = a.ArtistId

# number of invoices by billing country
SELECT Count(*), BillingCountry
FROM Invoice
GROUP BY BillingCountry

# total number of tracks in each playlist
SELECT Count(*), Name FROM PlaylistTrack pt, Playlist p
WHERE pt.PlaylistId = p.PlaylistId
GROUP BY Name

#tracks with no ids, but displays album title, media type, and genre
SELECT a.Title, m.Name, g.Name
FROM Album a, MediaType m, Genre g, Track t
WHERE t.AlbumId = a.AlbumId
AND t.MediaTypeId = m.MediaTypeId
AND t.GenreId = g.GenreId

#all invoices with number of invoice line items
SELECT i.InvoiceId, Count(InvoiceLineId)
FROM Invoice i, InvoiceLine il
WHERE i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId

#total of all sales by sales agent
SELECT SUM(Total), e.LastName, e.FirstName
FROM Invoice i, Employee e, Customer c
WHERE i.CustomerId = c.CustomerId
AND c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId

#top sales agent in 2009
SELECT MAX(value), FirstName, LastName FROM
(SELECT SUM(Total) as VALUE, e.FirstName, e.LastName
FROM Invoice i, Customer c, Employee e
WHERE i.customerId = c.customerId
AND c.SupportRepId = e.EmployeeId
AND i.InvoiceDate between '2009-01-01' AND '2009-12-31'
GROUP BY e.EmployeeId)

#top sales agent overall
SELECT MAX(value), FirstName, LastName FROM
(SELECT SUM(Total) as VALUE, e.FirstName, e.LastName
FROM Invoice i, Customer c, Employee e
WHERE i.customerId = c.customerId
AND c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId)

#number of customers by sales agent
SELECT Count(*), e.FirstName, e.LastName
FROM Customer c, Employee e
WHERE e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId

#sales per country
Select Total, BillingCountry FROM Invoice
GROUP BY BillingCountry


#country with most sales
SELECT BillingCountry FROM Invoice
WHERE Total IN (SELECT MAX(Total)
FROM Invoice)

#most purchased track of 2013
SELECT MAX(Total), t.Name
FROM Invoice i, Track t, InvoiceLine il
WHERE InvoiceDate
between '2013-01-01'
AND '2013-12-31'
AND i.InvoiceId = il.InvoiceId
AND il.TrackId = t.TrackId

# top 5 most purchased tracks overall
SELECT Total, t.Name
FROM Invoice i, Track t, InvoiceLine il
WHERE i.InvoiceId = il.InvoiceId
AND il.TrackId = t.TrackId
ORDER BY Total DESC
LIMIT 5

#top 3 selling artists overall
SELECT Total, a.Name
FROM Invoice i, Track t, InvoiceLine il, Album al, Artist a
WHERE i.InvoiceId = il.InvoiceId
AND il.TrackId = t.TrackId
AND t.AlbumId = al.AlbumId
AND al.ArtistId = a.ArtistId
ORDER BY Total DESC
LIMIT 3

#top media type
SELECT SUM(Total), mt.Name
FROM Invoice i, Track t, InvoiceLine il, MediaType mt
WHERE i.InvoiceId = il.InvoiceId
AND il.TrackId = t.TrackId
AND t.MediaTypeId = mt.MediaTypeId
GROUP BY mt.Name 
ORDER BY Total DESC
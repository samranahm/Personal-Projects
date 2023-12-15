--Q1: who is senior most employee based on job title?



SELECT TOP 1 *
FROM PersonalProject..employee
ORDER BY levels DESC



--Q2: Which countries have the most invoices?


SELECT COUNT(*) as total_count, billing_country
FROM PersonalProject..invoice
GROUP BY billing_country
ORDER BY total_count DESC


--Q3: What are top 3 values of invoice?


SELECT TOP 3 total
FROM PersonalProject.. invoice
ORDER BY total DESC


--Q4: Which city has best customers?


SELECT SUM(total) as total_invoice, billing_city
FROM PersonalProject..invoice
GROUP BY billing_city
ORDER BY total_invoice DESC


--Q5: Who is the best customer?



SELECT TOP 1 customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total
FROM PersonalProject..customer
JOIN PersonalProject..invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total DESC



--Q6: Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. 


SELECT DISTINCT email, first_name, last_name
FROM PersonalProject..customer
JOIN PersonalProject..invoice ON invoice.customer_id =customer.customer_id
JOIN PersonalProject..invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
    SELECT track_id FROM PersonalProject..track 
	JOIN PersonalProject..genre ON track.track_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email


--Q7: Write a query that return the artist name and total track count of the top 10 Rock bands


SELECT TOP 10 artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM PersonalProject..track
JOIN PersonalProject..album ON track.album_id = album.album_id
JOIN PersonalProject..artist ON album.artist_id = artist.artist_id
JOIN PersonalProject..genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC



--Q8: Return all the track names that have a song lenght longer than the average song lenght


SELECT name, milliseconds
FROM PersonalProject..track
WHERE milliseconds > (
SELECT AVG(milliseconds) AS ang_track_lenght
FROM PersonalProject..track)
ORDER BY milliseconds DESC


SELECT 'Project completed successfully!' AS 'Status'

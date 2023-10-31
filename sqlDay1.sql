-- Week 5 - Monday Questions

-- 1. How many actors are there with the last name ‘Wahlberg’?

SELECT COUNT(actor_id) 
FROM actor
WHERE last_name = 'Wahlberg';

-- Two actors. Used Count to display the answer when you run the query.


-- 2. How many payments were made between $3.99 and $5.99?

SELECT COUNT(*)
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99;

-- ZERO BABY! I checked it first by changing 3.99 to -50 and 5.99 to 50,
-- So I knew there wouldn't be any after checking manually...


-- 3. What film does the store have the most of? (search in inventory)

SELECT COUNT(film_id) AS Film_Id_Count, film_id
FROM inventory
GROUP BY film_id
ORDER BY Film_Id_Count DESC;

SELECT * FROM inventory ORDER BY film_id;

-- This feels like a trick question. 
-- There are a ton of movies with the same film_id and different inventory_id
-- So I'm assuming those are the same movie but kept track of differently in each store.
-- Also there are multiple stores, so which one is the question asking about? lol
-- I tried to see if store one had more of one movie but top count was 4 for a bunch
-- Same for store two...

-- Is there a way to count the return of my count?
-- Like how many different movies do we have 8 copies of? 7 copies of? etc..


-- 4. How many customers have the last name ‘William’?
SELECT *
FROM customer
WHERE last_name LIKE 'Will%';

-- Zero, but there is one "Williams", one "Willis" and one "Willimson" 
-- Yall trying to stump us with these trick questions. 
-- I used LIKE to make sure I wasn't crazy ;)



-- 5. What store employee (get the id) sold the most rentals?

SELECT COUNT(staff_id) AS count, staff_id
FROM payment
GROUP BY staff_id
ORDER BY SUM(amount)

SELECT count(staff_id) AS count, staff_id, SUM(amount)
FROM payment
WHERE amount > 0
GROUP BY staff_id
ORDER BY SUM(amount)


-- staff_id 2...
-- There are only 2 employees, and the one with staff_id 2 has 7304 transactions
-- I'm not sure what to consider negative payments. If negative payments are fines and not actual rentals,
-- But even if you remove the negative values (second block) employee two has more transactions...



-- 6. How many different district names are there?


SELECT COUNT(DISTINCT district)
FROM address;

-- 378
-- If you don't use distinct it gives you 603 so I figured it was working :)



-- 7. What film has the most actors in it? (use film_actor table and get film_id)


SELECT film_id, count(actor_id) as actor_count
FROM film_actor
GROUP BY film_id
ORDER BY actor_count DESC;

SELECT film_id, count(film_id) as actor_count
FROM film_actor
GROUP BY film_id
ORDER BY actor_count DESC;

SELECT *
FROM film
WHERE film_id = 508;


-- Lambs Cincinatti is the film with the most actors (15)
-- I spent a looooong time deciding what to count on this. I guess you can do it both ways...?
-- Then getting the film title was easy...



-- 8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)

SELECT COUNT(*)
FROM customer
WHERE store_id = 1
AND last_name LIKE '%es';

-- 13
-- I took the count off and checked myself to make sure I had it right




-- 9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 
--250 for customers with ids between 380 and 430? (use group by and having > 250)

SELECT amount, COUNT(rental_id) AS rental_amount
FROM payment
WHERE customer_id BETWEEN 380 AND 430
GROUP BY amount
HAVING COUNT(rental_id) > 250
ORDER BY amount;

-- THREEE! -419.01, -417.01, and 415.01
-- Most of my problems with this was the wording of it. 
-- Number of rentals isn't a given so i found it by using a count of rental_id 
-- which seemed to be unique for each transaction
-- Had to look up the syntax for HAVING, because I kept trying to squish that in the WHERE
-- Originally had WHERE customer_id BETWEEN 380 AND 430 AND rental_amount > 250
-- And one hour later got an answer lol



-- 10. Within the film table, how many rating categories are there? 
-- And what rating has the most movies total?

SELECT COUNT(DISTINCT rating) 
FROM film;

SELECT rating, COUNT(title) AS film_count 
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- Five: NC-17, G, PG-13, PG, R
-- PG-13 has the most films (224). 
-- This is still tricky to me since count usually returns one number.
-- Getting used to using it as a sum function, but also in combo with GROUP BY 
-- Will take some time for me...


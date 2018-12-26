USE sakila;

#1a
SELECT first_name, last_name
FROM actor;

#1b
SELECT CONCAT(first_name,  ' ', last_name) AS ' Actor Name'
FROM actor;

#2a
SELECT * FROM actor
WHERE first_name = "Joe";

#2b
SELECT * FROM actor
WHERE last_name LIKE "%GEN%";

#2c
SELECT last_name, first_name FROM actor
WHERE last_name LIKE "%LI%";

#2d
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE actor
ADD description BLOB;

#3b
ALTER TABLE actor
DROP description;

##spelled description wrong first time, had to delete both columns. 
ALTER TABLE actor
DROP descrption;

#4a
select last_name as 'Last Name', count(last_name) as 'Last Name Count'
from actor
group by last_name
having count(last_name) > 1;

#4b
select last_name as 'Last Name', count(last_name) as 'Last Name Count'
from actor
group by last_name
having count(last_name) > 2;

#4c
UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#4d
UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

#5a
DESCRIBE sakila.address;

#6a
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a
ON (s.address_id = a.address_id);

#6b
SELECT s.first_name, s.last_name, SUM(p.amount)
FROM staff AS s
INNER JOIN payment AS p
ON p.staff_id = s.staff_id
WHERE MONTH(p.payment_date) = 08 AND YEAR(p.payment_date) = 2005
GROUP BY s.staff_id;

#6c
SELECT f.title, COUNT(fa.actor_id) AS 'Actors'
FROM film_actor AS fa
INNER JOIN film as f
ON f.film_id = fa.film_id
GROUP BY f.title
ORDER BY Actors desc;

#6d
SELECT title, COUNT(inventory_id) AS '# of copies'
FROM film
INNER JOIN inventory
USING (film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY title;

#6e
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount Paid'
FROM payment AS p
INNER JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

#7a
SELECT title
FROM film WHERE title 
LIKE 'K%' OR title LIKE 'Q%'
AND title IN 
(
SELECT title 
FROM film 
WHERE language_id = 1
);

#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
Select actor_id
FROM film_actor
WHERE film_id IN 
(
SELECT film_id
FROM film
WHERE title = 'Alone Trip'
));

#7c
SELECT first_name, last_name, email, country
FROM customer cus
INNER JOIN address a
ON (cus.address_id = a.address_id)
INNER JOIN city cit
ON (a.city_id = cit.city_id)
INNER JOIN country ctr
ON (cit.country_id = ctr.country_id)
WHERE ctr.country = 'canada';

#7d
SELECT title, description FROM film 
WHERE film_id IN
(
SELECT film_id FROM film_category
WHERE category_id IN
(
SELECT category_id FROM category
WHERE name = "Family"
));

#7e
SELECT title, COUNT(title) as 'Rentals'
FROM film
INNER JOIN inventory
ON (film.film_id = inventory.film_id)
INNER JOIN rental
ON (inventory.inventory_id = rental.inventory_id)
GROUP by title
ORDER BY rentals desc;

#7f
SELECT s.store_id, SUM(amount) AS Gross
FROM payment p
INNER JOIN rental r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory i
ON (i.inventory_id = r.inventory_id)
INNER JOIN store s
ON (s.store_id = i.store_id)
GROUP BY s.store_id;

#7g
SELECT store_id, city, country
FROM store s
INNER JOIN address a
ON (s.address_id = a.address_id)
INNER JOIN city cit
ON (cit.city_id = a.city_id)
INNER JOIN country ctr
ON(cit.country_id = ctr.country_id);

#7h
SELECT SUM(amount) AS 'Total Sales', c.name AS 'Genre'
FROM payment p
INNER JOIN rental r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory i
ON (r.inventory_id = i.inventory_id)
INNER JOIN film_category fc
ON (i.film_id = fc.film_id)
INNER JOIN category c
ON (fc.category_id = c.category_id)
GROUP BY c.name
ORDER BY SUM(amount) DESC;

#8a
SELECT fc.category_id, c.name, SUM(p.amount) AS gross_rev
FROM payment p 
LEFT JOIN rental r ON p.rental_id = r.rental_id
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN film_category fc ON i.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
WHERE p.rental_id IS NOT NULL
GROUP BY fc.category_id
ORDER BY gross_rev DESC;

#8b
SELECT * FROM revenue_view;

#8c
DROP VIEW revenue_view;
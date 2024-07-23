with payments as (

SELECT 
	p.payment_id, 
	p.customer_id, 
	i.store_id, 
	f.film_id, 
	f.title AS film_name,
	r.rental_date,
	r.return_date,
	p.payment_date,
	p.amount
FROM payment p
     JOIN rental r ON p.rental_id = r.rental_id
     JOIN inventory i ON r.inventory_id = i.inventory_id
     JOIN film f ON i.film_id = f.film_id
     JOIN film_category fc ON f.film_id = fc.film_id
     JOIN category c ON fc.category_id = c.category_id

)

select * from payments
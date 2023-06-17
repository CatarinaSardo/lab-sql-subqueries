-- How many copies of the film Hunchback Impossible exist in the inventory system?

select count(*) as copy_count
from film
join inventory on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible';

-- List all films whose length is longer than the average of all the films.

select *
from film
where length > (select avg(length) from film);

-- Use subqueries to display all actors who appear in the film Alone Trip.

select actor.actor_id, actor.first_name, actor.last_name
from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film.film_id = film_actor.film_id
where film.title = 'Alone Trip';

-- Identify all movies categorized as family films.

select f.film_id, f.title, c.name as category
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Family';

-- Get name and email from customers from Canada using subqueries. Do the same with joins.
-- por terminar..
select c.first_name, c.last_name, c.email
from customer c
join address a on c.address_id = a.address_id
join city ct on a.city_id = ct.city_id
join country cn on ct.country_id = cn.country_id
where cn.country = 'Canada';

-- Which are films starred by the most prolific actor?

select a.actor_id, concat(a.first_name, ' ', a.last_name) as actor_name, count(*) as film_count
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, actor_name
order by film_count desc
limit 1;

select f.film_id, f.title
from film f
join film_actor fa on f.film_id = fa.film_id
where fa.actor_id = 107;

-- Films rented by most profitable customer. 

select distinct f.film_id, f.title
from rental r
join customer c on r.customer_id = c.customer_id
join payment p on c.customer_id = p.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
where c.customer_id = (
  select customer_id
  from payment
  group by customer_id
  order by sum(amount) desc
  limit 1
);

-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id
having sum(amount) > (
  select avg(amount)
  from payment
);





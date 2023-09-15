--Chapter 9 JOINING Tables

--Q1
/*Create a list that displays the title of each book 
and the name and phone number of the contact at the publisher’s 
office for reordering each book*/

select b.title, p.contact, p.phone
from books b
join publisher p using (pubid);

--Q2
/*Determine which orders haven’t yet shipped and the name of the customer 
who placed the order. Sort the results by the date on which the order was placed.*/

select c.firstname, o.order#
from customers c, orders o
where c.customer# = o.customer#
and o.shipdate IS NULL
order by o.orderdate;


--Q3
/*Produce a list of all customers who live in the 
state of Florida and have ordered books about computers.*/
select c.lastname, c.customer#
from books b
join orderitems using(isbn)
join orders using(order#)
join customers c on orders.customer# = c.customer#
where c.state = 'FL'
and b.category = 'COMPUTER';

--Q4
/*Determine which books customer Jake Lucas has purchased. 
Perform the search using the customer name, not the customer number. 
If he has purchased multiple copies of the same book, unduplicate the results.*/

select distinct b.title
from customers c 
join orders using(customer#)
join orderitems using(order#)
join books b using(isbn)
where c.firstname = 'JAKE'
and c.lastname = 'LUCAS';

--Q5
/*Determine the profit of each book sold to Jake Lucas, using the actual price 
the customer paid (not the book’s regular retail price). Sort the results by 
order date. If more than one book was ordered, sort the results by profit 
amount in descending order. Perform the search using the customer name, 
not the customer number*/

select b.title, i.paideach-cost
from customers c, orders o, orderitems i, books b
where c.customer# = o.customer#
and o.order# = i.order#
and c.firstname = 'JAKE'
and c.lastname = 'LUCAS'
order by o.orderdate, i.paideach-b.cost DESC;

--Q6
/*Which books were written by an author with the last name Adams? 
Perform the search using the author name.*/

select b.title
from books b
JOIN bookauthor USING(isbn)
JOIN author a USING(authorid)
WHERE a.lname = 'ADAMS';

--Q7
/*What gift will a customer who orders the book Shortest Poems receive? 
Use the actual book retail value to determine the gift*/

select p.gift 
from books b
join promotion p on b.retail between p.minretail and p.maxretail
where b.title = 'SHORTEST POEMS';


--Q8
/*Identify the authors of the books Becca Nelson ordered. 
Perform the search using the customer name.*/

select b.title, a.lname, a.fname
from customers c
JOIN orders USING(customer#)
JOIN orderitems USING(order#)
JOIN books b USING(isbn)
JOIN bookauthor USING(isbn)
JOIN author a USING(authorid)
WHERE c.firstname = 'BECCA'
AND c.lastname = 'NELSON';

--Q9
/*Display a list of all books in the BOOKS table. 
If a book has been ordered by a customer, also list the corresponding 
order number and the state in which the customer resides.*/

select b.title, order#, c.state
from books b
LEFT OUTER JOIN orderitems i USING(isbn)
LEFT OUTER JOIN orders USING (order#)
LEFT OUTER JOIN customers c USING(customer#);























--David Sims 301268408 Assignment 1 - F23
--Using the Juss Lee and City Jail database 
-- Provide SQL Statemetns using subqueries to satisfy the requests

--Question 1
/*Determine which author or authors wrote the books most frequently purchased by
-- customers of JustLee Books.*/
select * from bookauthor;
select * from orderitems;

SELECT fname FirstName, lname LastName FROM bookauthor JOIN author USING(authorid)
where isbn IN(SELECT isbn FROM orderitems GROUP BY isbn having SUM(quantity) = 
(SELECT MAX(COUNT(QUANTITY)) FROM orderitems GROUP BY isbn));

--Question 2
/*List the shipping city and state for the order that had the longest 
shipping delay.*/
select * from orders;
--Longest delay is the difference between the shipdate and orderdate
SELECT shipstate State, shipcity City FROM orders
where shipdate - orderdate = (SELECT MAX(shipdate-orderdate) FROM orders);

--Question 3
/*Determine which customers placed orders for the least expensive book 
(in terms of regular -- retail price) carried by JustLee Books*/
select * from customers;
select * from orders;

select firstname, lastname, customer# from customers JOIN orders USING(customer#)
JOIN orderitems USING(order#) JOIN books USING(isbn)
where retail = (select min(retail) FROM books);

--Question 4
/*List the information on crime charges for each charge 
that has had a fine above average and a sum paid below average.*/
select * from crime_charges;

Select * from crime_charges WHERE fine_amount > (SELECT AVG(fine_amount) 
FROM crime_charges) AND amount_paid < (Select AVG(amount_paid) from crime_charges);

--Question 5
/*List the names of all criminals who have had any 
of the crime code charges involved in crime ID 10089. */
select * from crime_codes;
select * from crime_charges;
select * from criminals;
select * from crimes;

select last, first FROM criminals JOIN crimes USING (criminal_id) 
JOIN crime_charges USING (crime_id) 
WHERE crime_code = (select crime_code from crimes where crime_id = 10089); 

--Question 6
/*Use a correlated subquery to determine which 
criminals have had at least one probation period assigned.*/
select * from criminals;
select * from prob_officers;
select * from sentences;

Select last, first, criminal_id from criminals JOIN sentences USING (criminal_ID) 
WHERE EXISTS (SELECT criminal_id from sentences where prob_ID IS NOT NULL) ;





















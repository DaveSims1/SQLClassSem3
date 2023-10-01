--Subqueries questions

--Question 1
/*List the book title and retail price for all books with a retail 
price lower than the average retail price of all books sold by JustLee Books.*/

SELECT title, retail
FROM books
WHERE retail < (SELECT AVG(retail) FROM books);

--Question 2
--Determine which books cost less than the average cost of other books in the same category.
select a.title, b.category, a.cost
FROM books a, (SELECT category, AVG(cost)avgcost 
from books GROUP BY category) b
WHERE a.category = b.category
AND a.cost < b.avgcost;

--Question 3
--Determine which orders were shipped to the same state as order 1014.
























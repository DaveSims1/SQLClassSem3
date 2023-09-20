--Week 2 - Chapter 6 - Database objects Lab Questions 1-10

--Question 1
/*Create a sequence for populating the Customer# column of the CUSTOMERS table. When
setting the start and increment values, keep in mind that data already exists in this table. The
options should be set to not cycle the values and not cache any values, and no minimum
or maximum values should be declared*/

select * from customers;


CREATE SEQUENCE customers_customer#_seq
INCREMENT BY 1
START WITH 1021
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;


--Question 2

/*Add a new customer row by using the sequence created in Question 1. The only data currently
available for the customer is as follows: last name = Shoulders, first name = Frank, and
zip = 23567.*/

INSERT INTO customers (customer#, lastname, firstname, zip)
VALUES (customers_customer#_seq.NEXTVAL, 'Shoulders', 'Frank', 23567);



--Question 3
/*Create a sequence that generates integers starting with the value 5. Each value should be
three less than the previous value generated. The lowest possible value should be 0, and the
sequence shouldn’t be allowed to cycle. Name the sequence MY_FIRST_SEQ.*/

CREATE SEQUENCE MY_FIRST_SEQ
INCREMENT BY -3
START WITH 5
MAXVALUE 5
MINVALUE 0
NOCYCLE;


--Question 4
/*Issue a SELECT statement that displays NEXTVAL for MY_FIRST_SEQ three times.
Because the value isn’t being placed in a table, use the DUAL table in the FROM clause of
the SELECT statement. What causes the error on the third SELECT?*/

SELECT MY_FIRST_SEQ.NEXTVAL
FROM dual;
SELECT MY_FIRST_SEQ.NEXTVAL
FROM dual;
SELECT MY_FIRST_SEQ.NEXTVAL   --ERROR HERE BECAUSE CURRVAL IS 2, IF IT GOES -3 IT WILL BE BELOW THE MINVALUE
FROM dual;
SELECT MY_FIRST_SEQ.CURRVAL
FROM dual;


--Question 5
/*Change the setting of MY_FIRST_SEQ so that the minimum value that can be generated is
-1000.*/

ALTER SEQUENCE MY_FIRST_SEQ
MINVALUE -1000;


--Question 6
/*Create a private synonym that enables you to reference the MY_FIRST_SEQ object as
NUMGEN.*/

CREATE SYNONYM NUMGEN
FOR MY_FIRST_SEQ;


--Question 7
/*Use a SELECT statement to view the CURRVAL of NUMGEN. Delete the NUMGEN
synonym and MY_FIRST_SEQ.*/

SELECT NUMGEN.CURRVAL
FROM dual;

DROP SYNONYM NUMGEN;

--Question 8
/*Create a bitmap index on the CUSTOMERS table to speed up queries that search for customers
based on their state of residence. Verify that the index exists, and then delete the index.*/

CREATE BITMAP INDEX customer_state_idx
ON customers (state);

SELECT table_name, index_name, index_type
FROM user_indexes
WHERE table_name = 'CUSTOMERS';


DROP INDEX customer_state_idx;

--Question 9
/*Create a B-tree index on the customer’s Lastname column. Verify that the index exists by
querying the data dictionary. Remove the index from the database.*/

CREATE INDEX customer_lastname_idx
ON CUSTOMERS (Lastname);

SELECT table_name, index_name, index_type
FROM user_indexes
WHERE table_name = 'CUSTOMERS';

DROP INDEX customer_lastname_idx;


--Question 10
/*Many queries search by the number of days to ship (number of days between the order and
shipping dates). Create an index that might improve the performance of these queries.*/

CREATE INDEX days_to_ship_idx
ON ORDERS(BETWEEN(shipdate AND orderdate));

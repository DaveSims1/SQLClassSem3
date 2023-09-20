--Week 2 - Chapter 6 - Views Lab Questions 1-10


--Question 1
/*Create a view that lists the name and phone number of the 
contact person at each publisher. Don’t include the publisher’s 
ID in the view. Name the view CONTACT.*/

--Question 1
/*Create a view that lists the name and phone number of the contact person 
at each publisher. Don’t include the publisher’s ID in the view. Name the view CONTACT.*/
CREATE OR REPLACE VIEW contact
AS SELECT contact, phone
FROM publisher;

--Question 2
/*Change the CONTACT view so that no users can accidentally 
perform DML operations on the view.*/
CREATE OR REPLACE VIEW contact
AS SELECT contact, phone
FROM publisher
WITH READ ONLY;

select * from contact;

--Question 3
/*Create a view called HOMEWORK13 that includes the columns named 
Col1 and Col2 from the FIRSTATTEMPT table. Make sure the view is created 
even if the FIRSTATTEMPT table doesn’t exist*/

CREATE FORCE VIEW homework10
AS SELECT col1, col2 FROM firstattempt;

--Question 4
/*Attempt to view the structure of the HOMEWORK13 view.*/
DESC homework10;


--Question 5
/*Create a view that lists the ISBN and title for each book in inventory 
along with the name and phone number of the person to contact if the book 
needs to be reordered. Name the view REORDERINFO*/
CREATE OR REPLACE VIEW reorderinfo 
AS SELECT isbn, title, contact, phone
FROM books JOIN publisher USING(pubid);

select * from reorderinfo;

--Question 6
/*Try to change the name of a contact person in the REORDERINFO 
view to your name. Was an error message displayed when performing this 
step? If so, what was the cause of the error message?*/

UPDATE reorderinfo 
SET contact = 'David'
WHERE title LIKE '%MICKEY%';


--Error is
/*cannot modify a column which maps to a non key-preserved table*/

--Question 7
/*Select one of the books in the REORDERINFO view and try to change 
its ISBN. Was an error message displayed when performing this step? 
If so, what was the cause of the error message?*/

UPDATE reorderinfo
SET isbn = '1321231231'
WHERE title LIKE '%MICKEY%';

-- ERROR : integrity constraint (COMP214_F23_ZO_84.ORDERITEMS_ISBN_FK) violated - child record found

--Question 8
/*Delete the record in the REORDERINFO view containing your name. 
(If you weren’t able to perform #6 successfully, delete one of the contacts 
already listed in the table.) Was an error message displayed when performing this 
step? If so, what was the cause of the error message?*/

select * from reorderinfo;

DELETE FROM reorderinfo 
WHERE contact LIKE '%TOMMIE%';

-- integrity constraint (COMP214_F23_ZO_84.ORDERITEMS_ISBN_FK) violated - child record found



--Question 9
/*Issue a rollback command to undo any changes made with the preceding DML operations.*/

ROLLBACK;


--Question 10
/*Delete the REORDERINFO view*/
DROP VIEW reorderinfo;

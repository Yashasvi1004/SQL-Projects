create database book_store ;
use book_store ;

-- 1) Retrieve all books in the "Fiction" genre

SELECT 
    Title, Author, Genre
FROM
    books
WHERE
    Genre = 'Fiction';


-- 2) Find books published after the year 1950:

SELECT 
    *
FROM
    books
WHERE
    Published_Year > 1950
ORDER BY Published_Year;


-- 3) List all customers from the Canada

SELECT 
    *
FROM
    customers
WHERE
    Country = 'Canada';


-- 4) Show orders placed in November 2023

SELECT 
    *
FROM
    orders
WHERE
    MONTH(Order_date) = 11;


-- 5) Retrieve the total stock of books available

SELECT 
    SUM(Stock) AS Total_stocks
FROM
    books;
    
    
-- 6) Find the details of the most expensive book

SELECT 
    *
FROM
    books
WHERE
    price = (SELECT 
            MAX(Price)
        FROM
            books);   


-- Method 2 

SELECT 
    *
FROM
    books
ORDER BY price DESC
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book

SELECT 
    *
FROM
    customers AS c
        JOIN
    orders AS o ON c.Customer_id = o.customer_id
WHERE
    o.quantity > 1
ORDER BY o.quantity DESC;


-- 8) Retrieve all orders where the total amount exceeds $20

SELECT 
    *
FROM
    orders
WHERE
    total_amount > 20
ORDER BY total_amount DESC;


-- 9) List all genres available in the Books table

SELECT DISTINCT
    genre
FROM
    books;
    

-- 10) Find the book with the lowest stock

SELECT 
    *
FROM
    books
ORDER BY stock
LIMIT 5;


-- 11) Calculate the total revenue generated from all orders

SELECT 
    ROUND(SUM(total_amount), 2)
FROM
    orders;



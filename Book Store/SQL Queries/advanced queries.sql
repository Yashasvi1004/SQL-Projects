-- 1) Retrieve the total number of books sold for each genre

SELECT 
    b.genre, SUM(o.quantity) AS Total_quantity
FROM
    orders AS o
        JOIN
    books AS b ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY total_quantity DESC;


-- 2) Find the average price of books in the "Fantasy" genre

SELECT 
    genre, ROUND(AVG(price), 2) AS average_price
FROM
    books
GROUP BY genre
HAVING (genre = 'fantasy');

-- method 2 

SELECT 
    genre, average_price
FROM
    (SELECT 
        ROUND(AVG(price), 2) AS average_price, genre
    FROM
        books
    GROUP BY genre) AS t
WHERE
    genre = 'fantasy'; 


-- 3) List customers who have placed at least 2 orders

SELECT 
    c.Customer_ID, c.name, COUNT(o.Order_ID) AS order_count
FROM
    customers AS c
        JOIN
    orders AS o ON c.Customer_ID = o.Customer_ID
GROUP BY c.customer_id , c.name
HAVING order_count >= 2;


-- method 2 

SELECT 
    Customer_ID, name, order_count
FROM
    (SELECT 
        c.Customer_ID, c.name, COUNT(o.Order_ID) AS order_count
    FROM
        customers AS c
    JOIN orders AS o ON c.Customer_ID = o.Customer_ID
    GROUP BY c.customer_id , c.name) AS t
WHERE
    order_count >= 2;


-- 4) Find the most frequently ordered book

SELECT 
    book_id, title, frequency
FROM
    (SELECT 
        b.Book_ID, b.title, COUNT(o.Order_ID) AS frequency
    FROM
        books AS b
    JOIN orders AS o ON b.Book_ID = o.Book_ID
    GROUP BY b.book_id , b.title
    ORDER BY frequency DESC) AS t
WHERE
    frequency = 4;


-- method2 

SELECT 
    b.book_id, b.title, COUNT(o.order_id) AS frequency
FROM
    orders AS o
        JOIN
    books AS b ON o.Book_ID = b.Book_ID
GROUP BY b.Book_ID , b.title
HAVING frequency = 4;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre

SELECT 
    *
FROM
    books
WHERE
    genre = 'fantasy'
ORDER BY price DESC
LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author

SELECT 
    b.author, SUM(o.quantity) AS quantity
FROM
    books AS b
        JOIN
    orders AS o ON b.book_id = o.book_id
GROUP BY b.author
ORDER BY quantity DESC;


-- 7) List the cities where customers who spent over $30 are located

SELECT DISTINCT
    (c.city)
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
WHERE
    o.Total_amount > 30;
    
    
-- 8) Find the customer who spent the most on orders

SELECT 
    c.customer_id,
    c.name,
    ROUND(SUM(o.total_amount), 0) AS total_spent
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.name
ORDER BY total_spent DESC
LIMIT 1;


-- 9) Calculate the stock remaining after fulfilling all orders

SELECT 
    b.book_id,
    b.title,
    b.stock,
    COALESCE(SUM(o.quantity), 0) AS order_quantity,
    (b.stock - COALESCE(SUM(o.quantity), 0)) AS remaining_stock
FROM
    books AS b
        LEFT JOIN
    orders AS o ON b.book_id = o.book_id
GROUP BY b.book_id , b.title , b.stock ;









































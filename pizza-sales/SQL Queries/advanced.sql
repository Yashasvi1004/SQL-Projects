-- (1) Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    t.category,
    ROUND(((revenue / (SELECT 
                    ROUND(SUM(p.price * od.quantity), 2)
                FROM
                    pizzas AS p
                        JOIN
                    order_details AS od ON p.pizza_id = od.pizza_id)) * 100 ),
            2) AS percentage
FROM
    (SELECT 
        pt.category, SUM(p.price * od.quantity) AS revenue
    FROM
        pizzas AS p
    JOIN order_details AS od ON p.pizza_id = od.pizza_id
    JOIN pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category
    ORDER BY revenue DESC) AS t
GROUP BY t.category;


-- (2) Analyze the cumulative revenue generated over time.

select 
order_date , sum(daily_revenue) over (order by order_date ) as cum_revenue from 
(SELECT 
    o.order_date,
    ROUND(SUM(p.price * od.quantity), 2) AS daily_revenue
FROM
    order_details AS od
        JOIN
    orders AS o ON o.order_id = od.order_id
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date)
 as sales ;
 

-- (3) Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category , name , revenue   from 
(select category , name , revenue , rank()  
over(partition by category   order by revenue  desc) as rn
from 
(SELECT 
    pt.category, pt.name, SUM(od.quantity * p.price) AS revenue
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category , pt.name)as t )
as a 
where rn <=3; 
 

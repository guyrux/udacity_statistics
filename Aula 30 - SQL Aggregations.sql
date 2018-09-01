/* Aula 30.7 Quiz: SUM */

/*
01 - Find the total amount of poster_qty paper ordered in the orders table.
*/
SELECT SUM(poster_qty) total_poster_qty
  FROM orders;

/*
02 - Find the total amount of standard_qty paper ordered in the orders table.
*/
SELECT SUM(standard_qty) total_standard_qty
  FROM orders;

/*
03 - Find the total dollar amount of sales using the total_amt_usd in the orders table.
*/
SELECT SUM(total_amt_usd) total_amt_usd
  FROM orders;

/*
04 - Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order
in the orders table. This should give a dollar amount for each order in the table.
*/
SELECT SUM(standard_amt_usd + gloss_amt_usd) total_amount
  FROM orders;

/*
05 - Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both
an aggregation and a mathematical operator.
*/
SELECT SUM(standard_amt_usd/(standard_qty+0.0001)) standard_unit_price
  FROM orders;





/* Aula 30.11 Quiz: MIN, MAX, & AVG */

/*
01 - When was the earliest order ever placed? You only need to return the date.
*/
SELECT MAX(occurred_at)
  FROM orders;

/*
02 - Try performing the same query as in question 1 without using an aggregation function.
*/
SELECT occurred_at last_occurrency
  FROM orders
  ORDER BY occurred_at DESC
  LIMIT 1;

/*
03 - When did the most recent (latest) web_event occur?
*/
SELECT MAX(occurred_at)
  FROM web_events;

/*
04 - Try to perform the result of the previous query without using an aggregation function.
*/
SELECT occurred_at last_occurrency
  FROM web_events
  ORDER BY occurred_at DESC
  LIMIT 1;

/*
05 - Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean
amount of each paper type purchased per order. Your final answer should have 6 values - one for
each paper type for the average number of sales, as well as the average amount.
*/
SELECT AVG(standard_qty) average_standard_qty,
       AVG(gloss_qty) average_gloss_qty,
       AVG(poster_qty) average_poster_qty,
       AVG(standard_amt_usd) average_standard_amt,
       AVG(gloss_amt_usd) average_gloss_amt,
       AVG(poster_amt_usd) average_poster_amt
  FROM orders;

/*
06 - Via the video, you might be interested in how to calculate the MEDIAN. Though this is more
advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
*/
SELECT MEDIAN(total_usd)
  FROM orders;



/* Aula 30.14 - Quiz: GROUP BY*/

/*
01- Which account (by name) placed the earliest order? Your solution should have the account name and
the date of the order.
*/
SELECT a.name account_name, MAX(o.occurred_at) occurred_at
  FROM orders o
  LEFT JOIN accounts a
  ON o.account_id = a.id
  GROUP BY a.name
  ORDER BY occurred_at;


/*
02 - Find the total sales in usd for each account. You should include two columns - the total sales
for each company's orders in usd and the company name.
*/
SELECT SUM(o.total_amt_usd) total_sales, a.name account_name
  FROM orders o
  LEFT JOIN accounts a
  ON o.account_id = a.id
  GROUP BY a.name
  ORDER BY total_sales DESC;


/*
03 - Via what channel did the most recent (latest) web_event occur, which account was associated with this
web_event? Your query should return only three values - the date, channel, and account name.
*/
SELECT MAX(w.occurred_at) last_date, w.channel channel, a.name account_name
  FROM web_events w
  LEFT JOIN accounts a
  ON w.account_id = a.id
  GROUP BY account_name, channel
  ORDER BY last_date DESC
  LIMIT 1;


/*
04 - Find the total number of times each type of channel from the web_events was used. Your final table
should have two columns - the channel and the number of times the channel was used.
*/
SELECT w.channel channel, COUNT(w.channel) times_used
  FROM web_events w
 GROUP BY channel
 ORDER BY times_used DESC;


/*
05 - Who was the primary contact associated with the earliest web_event?
*/
SELECT MIN(w.occurred_at) earliest_web_event, a.primary_poc primary_poc
  FROM web_events w
  JOIN accounts a
  ON w.account_id = a.id
  GROUP BY primary_poc
  ORDER BY earliest_web_event
  LIMIT 1;

/*
06 - What was the smallest order placed by each account in terms of total usd. Provide only two columns
- the account name and the total usd. Order from smallest dollar amounts to largest.
*/
SELECT a.name account_name, MIN(o.total_amt_usd) smallest_order_in_usd
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
 GROUP BY account_name
 ORDER BY smallest_order_in_usd
 LIMIT 1;

/*
07 - Find the number of sales reps in each region. Your final table should have two columns - the region
and the number of sales_reps. Order from fewest reps to most reps.
*/
SELECT  r.name region, COUNT(s.name) number_of_reps
  FROM region r
  LEFT JOIN sales_reps s
  ON s.region_id = r.id
 GROUP BY region
 ORDER BY number_of_reps;


/*AULA 30.17 - Quiz: GROUP BY Part II*/

/*
01 - For each account, determine the average amount of each type of paper they purchased across their orders.
Your result should have four columns - one for the account name and one for the average quantity purchased for
each of the paper types for each account.
*/
SELECT a.name account_name, AVG(standard_qty) avg_standard_qty, AVG(gloss_qty) avg_gloss_qty, AVG(poster_qty) avg_poster_qty
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
 GROUP BY account_name
 ORDER BY account_name;

/*
02 - For each account, determine the average amount spent per order on each paper type. Your result should
have four columns - one for the account name and one for the average amount spent on each paper type.
*/
SELECT a.name account_name,
       AVG(standard_amt_usd) avg_standard_amt,
       AVG(gloss_amt_usd) avg_gloss_amt,
       AVG(poster_amt_usd) avg_poster_amt
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
 GROUP BY account_name
 ORDER BY account_name; 

/*
03 - Determine the number of times a particular channel was used in the web_events table for each sales rep.
Your final table should have three columns - the name of the sales rep, the channel, and the number of
occurrences. Order your table with the highest number of occurrences first.
*/
SELECT s.name sales_rep_name,
       w.channel channel,
       COUNT(w.*) occurrences
  FROM sales_reps s
  JOIN accounts a
  ON a.sales_rep_id = s.id
  JOIN web_events w
  ON w.account_id = a.id
 GROUP BY sales_rep_name, channel
 ORDER BY occurrences DESC;

/*
04 - Determine the number of times a particular channel was used in the web_events table for each region.
Your final table should have three columns - the region name, the channel, and the number of occurrences.
Order your table with the highest number of occurrences first.
*/
SELECT r.name region,
       w.channel channel,
       COUNT(w.*) occurrences
  FROM region r
  JOIN sales_reps s
  ON s.region_id = r.id
  JOIN accounts a
  ON a.sales_rep_id = s.id
  JOIN web_events w
  ON w.account_id = a.id
 GROUP BY region, channel
 ORDER BY occurrences DESC;


/* AULA 30.20 - Quiz: DISTINCT */
/*
01 - Use DISTINCT to test if there are any accounts associated with more than one region.
*/
SELECT DISTINCT a.name account_name,
                r.name region
  FROM accounts a
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  JOIN region r
  ON s.region_id = r.id;

/*
02- Have any sales reps worked on more than one account?
*/
SELECT DISTINCT a.name account_name,
                s.name sales_rep_name
  FROM accounts a
  LEFT JOIN sales_reps s
  ON a.sales_rep_id = s.id
 ORDER BY sales_rep_name;





/* AULA 30.23 - HAVING */
/*
01 - How many of the sales reps have more than 5 accounts that they manage?
*/
SELECT s.name sales_rep_name, COUNT(a.*) total_accounts
  FROM sales_reps s
  JOIN accounts a
  ON a.sales_rep_id = s.id
  GROUP BY sales_rep_name
  HAVING COUNT(a.*) > 5
  ORDER BY total_accounts DESC;
/*RESPOSTA 34*/


/*
02 - How many accounts have more than 20 orders?
*/
SELECT a.name account_name, COUNT(o.*) total_orders
  FROM accounts a
  LEFT JOIN orders o 
  ON o.account_id = a.id
 GROUP BY account_name
 HAVING COUNT(o.*) > 20
 ORDER BY total_orders DESC;
/* RESPOSTA 120*/

/*
03 - Which account has the most orders?
*/
SELECT a.name account_name, COUNT(o.*) total_orders
  FROM accounts a
  LEFT JOIN orders o 
  ON o.account_id = a.id
 GROUP BY account_name
 HAVING COUNT(o.*) > 20
 ORDER BY total_orders DESC
 LIMIT 1;
/*RESPOSTA Leucadia National*/

/*
04 - How many accounts spent more than 30,000 usd total across all orders?
*/
SELECT a.name account_name, SUM(o.total_amt_usd) total_in_usd
  FROM accounts a
  LEFT JOIN orders o 
  ON o.account_id = a.id
 GROUP BY account_name
 HAVING SUM(o.total_amt_usd) > 30000
 ORDER BY total_in_usd DESC;
/*RESPOSTA 204*/

/*
05 - How many accounts spent less than 1,000 usd total across all orders?
*/
SELECT a.name account_name, SUM(o.total_amt_usd) total_in_usd
  FROM accounts a
  LEFT JOIN orders o 
  ON o.account_id = a.id
 GROUP BY account_name
 HAVING SUM(o.total_amt_usd) < 1000
 ORDER BY total_in_usd DESC;
/*RESPOSTA 3*/

/*
06 - Which account has spent the most with us?
*/
SELECT a.name account_name, SUM(o.total_amt_usd) total_in_usd
  FROM accounts a
  LEFT JOIN orders o 
  ON o.account_id = a.id
 GROUP BY account_name
 HAVING SUM(o.total_amt_usd) < 1000
 ORDER BY total_in_usd DESC
 LIMIT 1;
/*Level 3 Communications*/

/*
07 - Which account has spent the least with us?
*/
SELECT a.name account_name, SUM(o.total_amt_usd) total_in_usd
  FROM accounts a
  LEFT JOIN orders o 
  ON o.account_id = a.id
 GROUP BY account_name
 HAVING SUM(o.total_amt_usd) < 1000
 ORDER BY total_in_usd;
/*RESPOSTA Nike*/


/*
08 - Which accounts used facebook as a channel to contact customers more than 6 times?
*/

/*
09 - Which account used facebook most as a channel? 
*/

/*
10 - Which channel was most frequently used by most accounts?
*/






/* AULA 30.27 - Quiz: DATE Functions */
/*
01 - Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.
Do you notice any trends in the yearly sales totals?
*/
SELECT DATE_TRUNC('year', o.occurred_at) sales_year,
       SUM(o.total_amt_usd) total_in_us
  FROM orders o
 GROUP BY DATE_TRUNC('year',o.occurred_at)
 ORDER BY total_in_us DESC;


/*
02 - Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly
represented by the dataset?
*/
SELECT DATE_PART('month', o.occurred_at) sales_month,
       SUM(o.total_amt_usd) total_in_us
  FROM orders o
 GROUP BY DATE_PART('month', o.occurred_at)
 ORDER BY total_in_us DESC;
/*REPOSTA Mês 12. E as vendas não são distribuidas igualmente. */

/*
03 - Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years
evenly represented by the dataset?
*/
SELECT DATE_PART('year', o.occurred_at) sales_year,
       COUNT(o.total_amt_usd) total_orders
  FROM orders o
 GROUP BY DATE_PART('year',o.occurred_at)
 ORDER BY total_orders DESC;
 /*REPOSTA O ano de 2016 foi o ano de maior número de ordens. E a distribuição não é uniforme. */

/*
04 - Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months
evenly represented by the dataset?
*/
SELECT DATE_PART('month', o.occurred_at) sales_month,
       COUNT(o.total_amt_usd) total_orders
  FROM orders o
 GROUP BY DATE_PART('month', o.occurred_at)
 ORDER BY total_orders	 DESC;
 /* REPOSTA Mês 12. E as ordens não são igualemnte distribuidas ao longo dos meses. */

/*
05 - In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
*/
SELECT DATE_TRUNC('month', o.occurred_at) sales_month,
       SUM(o.gloss_amt_usd) total_in_us
  FROM orders o
 GROUP BY DATE_TRUNC('month', o.occurred_at)
 ORDER BY total_in_us DESC;
 /* REPOSTA No mês 12 do ano de 2016. */





/* AULA 30.31 Quiz: CASE */

/*
01 - We would like to understand 3 different levels of customers based on the amount associated with their purchases.
The top branch includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second
branch is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 usd. Provide a table that includes
the level associated with each account. You should provide the account name, the total sales of all orders for the
customer, and the level. Order with the top spending customers listed first.
*/
SELECT a.name account_name,
       SUM(o.total_amt_usd) lifetime_value,
       CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'top branch'
            WHEN SUM(o.total_amt_usd) <= 200000 AND SUM(o.total_amt_usd) > 100000 THEN 'second branch'
            ELSE 'lowest branch' END AS branch_level
  FROM orders o
  LEFT JOIN accounts a
  ON o.account_id = a.id
  GROUP BY account_name
  ORDER BY SUM(o.total_amt_usd) DESC;


/*
02 - We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by
customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers
listed first.
*/
SELECT a.name account_name,
       SUM(o.total_amt_usd) lifetime_value,
       CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'top branch'
            WHEN SUM(o.total_amt_usd) <= 200000 AND SUM(o.total_amt_usd) > 100000 THEN 'second branch'
            ELSE 'lowest branch' END AS branch_level
  FROM orders o
  LEFT JOIN accounts a
  ON o.account_id = a.id
  GROUP BY account_name, o.occurred_at
  HAVING DATE_PART('year', o.occurred_at) = '2016' OR DATE_PART('year', o.occurred_at) = '2017'
  ORDER BY SUM(o.total_amt_usd) DESC;


/*
03 - We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders.
Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they
have more than 200 orders. Place the top sales people first in your final table.
*/

/*
04 - The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides
they want to see these characteristics represented as well. We would like to identify top performing sales reps, which
are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with
more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales
across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on
dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!
*/







/* AULA 31.07 - Quiz: More On Subqueries */

/*02*/
SELECT AVG(o.standard_qty) avg_standard_qty, AVG(o.gloss_qty) avg_gloss_qty, AVG(o.poster_qty) avg_poster_qty
  FROM orders o
  WHERE DATE_TRUNC('month',o.occurred_at) =
        (SELECT DATE_TRUNC('month',MIN(o.occurred_at)) AS min_dia
          FROM orders o)

/* AULA 31.10 - Quiz: Subquery Mania */

/*
01 - Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
*/

/*
02 - For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
*/

/*
03 - For the name of the account that purchased the most (in total over their lifetime as a customer)
standard_qty paper, how many accounts still had more in total purchases? 
*/

/*
04 - For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd,
how many web_events did they have for each channel?
*/

/*
05 - What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
*/

/*
06 - What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more
than the average of all orders.
*/


/* AULA 31.14 - Quiz: WITH*/

/*
01 - Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
*/

/*
02 - For the region with the largest sales total_amt_usd, how many total orders were placed? 
*/

/*
03 - For the name of the account that purchased the most (in total over their lifetime as a
customer) standard_qty paper, how many accounts still had more in total purchases? 
*/

/*
04 - For the customer that spent the most (in total over their lifetime as a customer)
total_amt_usd, how many web_events did they have for each channel?
*/

/*
05 - What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
*/

/*
06 - What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent
more than the average of all accounts.
*/




/* AULA 32.03 - Quiz: LEFT & RIGHT */
/*
01 - In the accounts table, there is a column holding the website for each company. The last three digits specify
what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions
and provide how many of each website type exist in the accounts table.
*/
SELECT RIGHT(website,3) AS extension,
       COUNT(RIGHT(website,3)) AS extension_counter
  FROM accounts
  GROUP BY extension;
 

/*
02 - 
There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts
table to pull the first letter of each company name to see the distribution of company names that begin with each
letter (or number). 
*/

/*
03 - 
Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number
and a second group of those company names that start with a letter. What proportion of company names start with a letter?
*/

/*
04 - Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start
with anything else? 
*/




/* AULA 32.06 - Quiz: POSITION, STRPOS, & SUBSTR - AME DATA AS QUIZ 1*/

/*
01 - Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.  
*/

/*
02 - Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
*/


/* AULA 32.09 - Quiz: CONCAT */
/*
01 - Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the
first name of the primary_poc . last name primary_poc @ company name .com.
*/

/*
02 - You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work
in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but
otherwise your solution should be just as in question 1. Some helpful documentation is here.
*/

/*
03 - We would also like to create an initial password, which they will change after their first log in. The first password will be
the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter
of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number
of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces. 
*/
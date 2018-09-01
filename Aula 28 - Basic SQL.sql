/* Aula 28.38 - Questions using IN operator */
/* 01 Use the accounts table to find the
account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.*/
SELECT name, primary_poc, sales_rep_id
  FROM accounts
 WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/* 02 Use the web_events table to find all
information regarding individuals who were contacted via the channel of organic or adwords.*/
SELECT *
  FROM web_events
 WHERE channel IN ('organic', 'adwords');


/* Aula 28.41 - Questions using the NOT operator */
/* 01 Use the accounts table to find the
account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.*/
SELECT name, primary_poc, sales_rep_id
  FROM accounts
 WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

/* 02 Use the web_events table to find all information
regarding individuals who were contacted via any method except using organic or adwords methods.*/
SELECT *
  FROM web_events
 WHERE channel NOT IN ('organic', 'adwords');

 /* 03 Use the accounts table to find: 
 All the companies whose names do not start with 'C'.*/
SELECT *
  FROM accounts
 WHERE name NOT LIKE 'C%' OR name NOT LIKE 'c%';

 /* 04 Use the accounts table to find: 
 All companies whose names do not contain the string 'one' somewhere in the name.*/
 SELECT *
  FROM accounts
 WHERE name NOT LIKE '%one%' OR name NOT LIKE 'One%';

 /* 05 Use the accounts table to find: 
 All companies whose names do not end with 's'.*/
 SELECT *
  FROM accounts
 WHERE name NOT LIKE '%s' OR name NOT LIKE '%S';


 /* Aula 28.44 - Questions using AND and BETWEEN operators */
 /*01 Write a query that returns all the orders where the
 standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.*/
  SELECT *
    FROM orders
  WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

 /*02 Using the accounts table find all the companies whose
 names do not start with 'C' and end with 's'.*/
  SELECT *
    FROM accounts
  WHERE name NOT LIKE 'C%' OR name NOT LIKE '%s';


 /*03 Use the web_events table to find all information regarding
 individuals who were contacted via organic or adwords and started
 their account at any point in 2016 sorted from newest to oldest.*/
  SELECT *
    FROM web_events
  WHERE channel IN ('organic','adwords') AND
        occurred_at >= '2016-01-01' AND
        occurred_at <= '2016-12-31'
  ORDER BY occurred_at DESC;

 /*O ANTERIOR TBM PODERIA TER SIDO RESOLVIDO COM BETWEEN*/
  SELECT *
    FROM web_events
  WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
  ORDER BY occurred_at DESC;



 /* Aula 28.47 - Questions using the OR operator */
 /* 01 Find list of orders ids where either gloss_qty or
 poster_qty is greater than 4000. Only include the id field in the resulting table. */
SELECT id
  FROM orders
 WHERE gloss_qty > 4000 OR poster_qty > 4000;

 /* 02 Write a query that returns a list of orders where
 the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.. */
 SELECT *
  FROM orders
 WHERE (gloss_qty > 1000 OR poster_qty > 1000) AND     standard_qty = 0;

 /* 03 Find all the company names that start with a 'C'
 or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'. */
SELECT *
  FROM accounts
 WHERE (name LIKE 'C%' OR name LIKE 'W%') AND
       (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND
       (primary_poc NOT LIKE '%eana%')



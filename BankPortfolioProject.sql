# Customer Demographics**

# 1. What is the distribution of customers by job type, marital status, and education level?
select job, count(*) as job_counts, avg(balance) as average_balance
from bank_data
group by job
order by 2 desc ,3 desc;

select marital, count(*) as marital_counts, avg(balance) as average_balance
from bank_data
group by marital
order by 2 desc, 3 desc;

select education, count(*) as education_counts, avg(balance) as average_balance
from bank_data
group by education
order by 2 desc, 3 desc;

# 2.What is the average balance of customers segmented by job type, marital status, and education level?
select job, avg(balance) as average_balance
from bank_data
group by job
order by 2 desc;

select marital, avg(balance) as average_balance
from bank_data
group by marital
order by 2 desc;

select education, avg(balance) as average_balance
from bank_data
group by education
order by 2 desc;

# 3. How many customers have housing loans or personal loans, and what are their balances?
select count(customer_id) as housing_personal_loans
from bank_data
where housing = 'yes' or loan = 'yes';

select count(customer_id) as housing_personal_loans
from bank_data
where housing = 'yes' and loan = 'yes';

#only housing loan and no personal loan
select count(customer_id) as housing_personal_loans
from bank_data
where housing = 'yes' and loan = 'no';

#only personal loan and no housing loan
select count(customer_id) as housing_personal_loans
from bank_data
where housing = 'no' and loan = 'yes';

# Campaign Performance

#4. How many customers were contacted during the campaign (`campaign`), and how does this correlate with subscription rates (`y`)?
# campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
# From the table result,irrespective of call duration, we can observe that as the campaign(number of contacts performed) increases the subscription count decreases

with success_subscriptions as 
(select campaign, count(*) as yes_subscriptions
from bank_data
where y = 'yes'
group by campaign
)

select a.campaign, count(a.customer_id) as customers_contacted, (yes_subscriptions*100/count(a.customer_id)) as subscription_rate
from bank_data a
join success_subscriptions b 
on a.campaign = b.campaign
group by a.campaign
order by a.campaign;

#5. What is the average call duration (`duration`) for customers who subscribed vs. those who did not?

select y as subscribed, avg(duration) as call_duration
from bank_data
group by y
order by 2 desc;

#6. What is the success rate of the campaign based on the number of previous contacts (`previous`) or days since last contact (`pdays`)?

with success_contacts as 
(select pdays, count(*) as yes_subscriptions
from bank_data
where y = 'yes'
group by pdays
)

select a.pdays, count(a.customer_id) as customers_contacted, (yes_subscriptions*100/count(a.customer_id)) as subscription_rate
from bank_data a
join success_contacts b 
on a.pdays = b.pdays
group by a.pdays
order by a.pdays;

#Subscription Analysis

#7. What percentage of customers subscribed to a term deposit (`y = 'yes'`) across different age groups?

SELECT 
    CASE 
        WHEN age < 18 THEN 'Under 18'
        WHEN age >= 18 AND age <= 28 THEN 'Adult'
        WHEN age >= 29 AND age < 50 THEN 'Mid-aged'
        WHEN age >= 50 THEN 'Old'
    END AS age_group, (COUNT(*)*100/(select count(*) from bank_data where y='yes')) as subscription_rate
    from bank_data
    where y = "yes"
    group by age_group
    order by 2 desc;

#8. Which job types have the highest subscription rates? 

select job, (COUNT(*)*100/(select count(*) from bank_data where y='yes')) as subscription_rate
from bank_data
where y = 'yes'
group by job
order by 2 desc;

#9. How does loan status (housing or personal loans) impact subscription likelihood?

select 
  housing, 
  loan, 
  count(*) as customers_contacted, 
  sum(case when y = 'yes' then 1 else 0 end) as yes_subscriptions,
  round((sum(case when y = 'yes' then 1 else 0 end) / count(*)) * 100, 2) as subscription_rate
from bank_data
where housing = 'yes' or loan = 'yes'
group by housing, loan
order by subscription_rate desc;


# Financial Insights

#10. What is the correlation between customer balance and subscription rates?

WITH subscription_data AS (
  SELECT 
    balance, 
    CASE WHEN y = 'yes' THEN 1 ELSE 0 END AS subscription
  FROM bank_data
),
stats AS (
  SELECT 
    AVG(balance) AS avg_balance,
    AVG(subscription) AS avg_subscription,
    STDDEV(balance) AS stddev_balance,
    STDDEV(subscription) AS stddev_subscription
  FROM subscription_data
),
correlation AS (
  SELECT 
    SUM((balance - (SELECT avg_balance FROM stats)) * 
        (subscription - (SELECT avg_subscription FROM stats))) /
    ((SELECT stddev_balance FROM stats) * (SELECT stddev_subscription FROM stats) * COUNT(*)) AS correlation_coefficient
  FROM subscription_data
)
SELECT correlation_coefficient FROM correlation;


#11. How many customers have negative balances, and what percentage of them subscribed?

WITH negative_blnc AS (
  SELECT COUNT(customer_id) AS negative_balance
  FROM bank_data
  WHERE balance < 0 AND y = 'yes'
),
total_negative AS (
  SELECT COUNT(customer_id) AS total_negative_balance
  FROM bank_data
  WHERE balance < 0
)
SELECT 
  t.total_negative_balance, 
  ROUND((n.negative_balance * 100.0) / t.total_negative_balance, 2) AS percent_subscribed
FROM negative_blnc n, total_negative t;

# Temporal Insights

#12. Which months (`month`) had the highest success rates for subscriptions?

with monthly_data as
(select month, count(*) as total, 
sum(case when y='yes' then 1 else 0 end) as total_y
from bank_data
group by month)

select month, round((total_y*100.00/total),2) as subscription_rate
from monthly_data
order by subscription_rate desc;

#13. On which days were calls most effective in converting subscriptions?

with daily_data as
(select day, count(*) as total,
sum(case when y='yes' then 1 else 0 end) as total_y
from bank_data
group by day)

select day, round((total_y*100.00/total),2) as subscription_rate
from daily_data
order by subscription_rate desc;

# Actionable Insights

#14. What is the relationship between call duration and subscription success? Is there an optimal call duration range?

WITH duration_ranges AS (
  SELECT 
    CASE 
      WHEN duration BETWEEN 0 AND 30 THEN '0-30 seconds'
      WHEN duration BETWEEN 31 AND 60 THEN '31-60 seconds'
      WHEN duration BETWEEN 61 AND 120 THEN '61-120 seconds'
      WHEN duration BETWEEN 121 AND 300 THEN '121-300 seconds'
      WHEN duration > 300 THEN '300+ seconds'
    END AS duration_range,
    COUNT(*) AS total_calls,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS successful_calls
  FROM bank_data
  GROUP BY 
    CASE 
      WHEN duration BETWEEN 0 AND 30 THEN '0-30 seconds'
      WHEN duration BETWEEN 31 AND 60 THEN '31-60 seconds'
      WHEN duration BETWEEN 61 AND 120 THEN '61-120 seconds'
      WHEN duration BETWEEN 121 AND 300 THEN '121-300 seconds'
      WHEN duration > 300 THEN '300+ seconds'
    END
)
SELECT 
  duration_range,
  total_calls,
  successful_calls,
  ROUND((successful_calls * 100.0 / total_calls), 2) AS subscription_rate
FROM duration_ranges
ORDER BY duration_range;


#15. How does customer default status (`default`) affect subscription rates?

WITH default_data AS (
  SELECT 
    `default`,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS successful_subscriptions
  FROM bank_data
  GROUP BY `default`
)
SELECT 
  `default`,
  total_customers,
  successful_subscriptions,
  ROUND((successful_subscriptions * 100.0 / total_customers), 2) AS subscription_rate
FROM default_data
ORDER BY subscription_rate DESC;





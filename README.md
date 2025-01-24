# Bank Marketing Campaign Analysis

## Problem Statement
The goal of this analysis is to understand factors influencing customer behavior and the effectiveness of a bank's marketing campaign in driving subscriptions to term deposits (`y`). By analyzing the dataset, we aim to identify key characteristics of customers who are more likely to subscribe and determine the impact of various campaign strategies. The insights will help the bank optimize future marketing efforts and increase subscription rates.

## Dataset
The dataset contains details about the bank's marketing campaign, including customer demographics, financial information, and campaign-related attributes. The primary focus is to analyze customer attributes, campaign performance, and temporal trends in subscription rates.

**Source**:  
[Bank Data CSV](https://github.com/Bhavani458/SQL_BankMarketing_Campaign/blob/main/bank_data.csv)

**View the whole presentation here:** [Bank Marketing Presentation](https://github.com/Bhavani458/SQL_BankMarketing_Campaign/blob/main/BankMarketing.pdf)_

## Objectives
1. Identify customer profiles with the highest likelihood of subscribing to term deposits.
2. Evaluate the impact of campaign features like call duration, previous contacts, and days since last contact on subscription rates.
3. Provide actionable insights and recommendations to improve targeting and campaign efficiency.

### Situation
The bank's marketing campaign aims to increase subscriptions to term deposits. The challenge is to identify key factors that lead to higher subscription rates and understand how customer demographics, campaign features, and temporal patterns influence success.

### Task
We need to analyze customer segmentation, campaign performance, and various factors affecting subscription outcomes. The specific tasks include identifying effective customer profiles, evaluating campaign strategies, and understanding correlations between customer attributes and subscription success.

### Action
We performed an in-depth analysis using SQL-based queries to answer key questions about customer behavior, campaign performance, and temporal insights. The questions were grouped into the following categories:

#### 1. **Customer Demographics**  
   - Distribution of customers by job type, marital status, and education level.
   - Average balance by demographic categories.
   - Housing and personal loans impact on customer balances.

#### 2. **Campaign Performance**  
   - Impact of campaign contacts and call duration on subscription rates.
   - Success rates based on the number of previous contacts and days since last contact.

#### 3. **Subscription Analysis**  
   - Subscription rates by age group, job type, and loan status.
   - Analysis of customer balances, negative balances, and subscription outcomes.

#### 4. **Temporal Insights**  
   - Success rates by month and day of the week.
   - Correlation between call duration and subscription success.

#### 5. **Actionable Insights**  
   - Identifying optimal call duration ranges for higher subscription success.
   - Exploring the effect of customer default status on subscription likelihood.

### Results

#### Key Findings:
- **Customer Segmentation**:  
  Mid-aged individuals (29–49 years) contribute the most to subscriptions (60%), followed by older customers (50+ years) and younger adults (under 29 years).
  
- **Campaign Performance**:  
  - Longer call durations (300+ seconds) are linked to higher subscription rates (28.17%).  
  - Recent contacts show a significantly higher subscription rate (40% at `pdays = 1` and 66.67% at `pdays = 10`).  
  - No prior contact leads to a much lower subscription rate (9.16% for clients with no previous contact).

- **Subscription Analysis**:  
  - Management roles show the highest subscription rates (~25%), while housemaids have the lowest (~2%).  
  - Customers with housing or personal loans have higher subscription rates (~8% and ~7%), while those with both loans show lower rates (~6%).

- **Financial Insights**:  
  - There is a weak positive correlation (0.0528) between customer balance and subscription rates, suggesting that balance alone is not a strong predictor for subscriptions.

- **Temporal Insights**:  
  - March had the highest subscription rate (over 50%), while May had the lowest (~6%).  
  - Contacting customers on the 1st, 10th, or 30th of each month increases the likelihood of subscription.

#### Recommendations:
1. **Focus on Mid-Aged Customers**:  
   Target mid-aged individuals (29–49 years), as they are most likely to subscribe. Develop personalized campaigns that cater to their needs.

2. **Leverage Long Call Durations**:  
   Ensure that call durations are longer (300+ seconds) to increase the likelihood of subscriptions. Train agents to engage customers more thoroughly during calls.

3. **Engage Recent Contacts**:  
   Prioritize recent contacts, especially those with `pdays` of 1-10. Follow up promptly after initial engagement to maximize conversion rates.

4. **Increase Engagement with Non-Default Customers**:  
   Focus marketing efforts on customers without a default status, as they show a higher subscription rate (11.80% vs. 6.38% for default customers).

5. **Optimize Campaign Timing**:  
   Run campaigns in March, December, and September, as these months show the highest subscription rates. Focus outreach on the 1st, 10th, and 30th of each month to align with peak success days.

6. **Target Customers with Housing or Personal Loans**:  
   Customers with loans tend to have higher subscription rates, so consider offering tailored products or benefits for these groups.

7. **Understand the Impact of Occupation**:  
   Occupation influences subscription rates significantly. Focus on management and technician roles for higher conversion rates, while adjusting strategies for lower-performing occupations like housemaids.

## Conclusion
This analysis provides actionable insights that can help the bank optimize its marketing strategies. By focusing on key customer demographics, campaign features, and temporal patterns, the bank can improve its subscription rates for term deposits. Implementing the recommended strategies will lead to more targeted campaigns, better resource allocation, and ultimately, higher conversion rates.

## Future Work
Future analysis could explore deeper relationships between customer attributes and subscription success, consider additional features such as product offerings, and refine strategies based on more granular temporal data (e.g., specific hours of the day).

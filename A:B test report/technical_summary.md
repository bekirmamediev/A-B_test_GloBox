# A/B Test Report: Food and Drink Banner

## Purpose

We conduct the A/B test to understand how food&drink banner influnces on purchase activity.
And check how the banner brings awareness to this product category to increase revenue.

## Hypotheses

Null-hypotheses: There is no difference in conversion and average spent between two groups.
Alternative: There is a difference in conversion and average spent between two groups.

## Methodology

### Test Design

- **Population:** the test group has 24343 people and control groups has 24600.
- **Duration:** Test starts on 01-25-2023 and ends on 02-06-2023.
- **Success Metrics:** Convesrion and average spent

## Results

### Data Analysis

- **Pre-Processing Steps:** I wrote the following SQL queries

The first query is for obtaining the final analysis dataset

```sql

SELECT
	u.id
  , u.country
  , u.gender
  , COALESCE(g.device, 'no information') as device
  , g.group
  , COALESCE(SUM(a.spent), 0) as total_spent
FROM users u
LEFT JOIN groups g ON u.id = g.uid
LEFT JOIN activity a ON a.uid = u.id
GROUP BY u.id
  , u.country
  , u.gender
  , g.device
  , g.group

```

We have columns with NULL values, which we can replace with 0 using COALESCE function.

The second query is for advanced tasks

```sql

SELECT
	u.id
  , u.country
  , u.gender
  , COALESCE(g.device, 'no information') as device
  , g.group
  , COALESCE(SUM(a.spent), 0) as total_spent
  , a.dt
FROM users u
LEFT JOIN groups g ON u.id = g.uid
LEFT JOIN activity a ON a.uid = u.id
GROUP BY u.id
  , u.country
  , u.gender
  , g.device
  , g.group
  , a.dt


```

- **Statistical Tests Used:** Two-sample t-test for proportion. Two-sample t-test with unpooled variance for mean
- **Results Overview:** The test group showed a conversion of 4.6%, while the control group had a conversion of 3.9%, indicating a significant improvement with the new banner.
  There wasn’t a big difference in average spent per user between the two groups $3.37 for the control and $3.39 for the test group.
  From our data, we have insights that users with iPhones have better success metrics compared to Android users, with an average spending of $4.98 and $2.38, respectively, and conversion rates of 6.14% and 3.14%, respectively. We found that female users have higher average spending than male users, with $4.30 and $2.43, respectively, and better conversion rates of 5.29% and 3.21%, respectively.

### Findings

## Interpretation

- **Outcome of the Test(s):** We reject Null-hypothesis for conversion and fail to reject null-hypothesis for average spent. It means that the analysis revealed a statistically significant difference in conversion rates between the test and control groups, indicating that the food and drink banner led to a higher conversion rate. However, there was no significant difference in average spending between the two groups, so the banner didn't inprove average spending per user.
- **Confidence Level:** 95%

## Conclusions

- **Key Takeaways:** The food and drink banner resulted in a higher conversion rate compared to the control group, indicating its effectiveness in driving user engagement and prompting purchases.
  However, there was no significant difference observed in average spending between users exposed to the banner and those who were not.
- **Limitations/Considerations:** While the higher conversion rate suggests the effectiveness of the food and drink banner, the lack of impact on average spending raises questions about its ability to generate increased revenue directly.

## Recommendations

- **Next Steps:** Considering the positive impact on conversion rates, we recommend implementing the new banner to improve overall conversion rates and potentially drive higher revenue. Additionally, it may be beneficial to monitor user behavior closely after implementation to assess any further improvements or adjustments needed.
- **Further Analysis:** Investigate the specific products or categories that experienced increased sales due to the banner. Determine if there is a notable increase in sales for lower-priced food items compared to higher-priced items like furniture.

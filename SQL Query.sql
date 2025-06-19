-- 1. Total Users by Churn Status
SELECT churn, COUNT(*) AS total_users
FROM users
GROUP BY churn;

-- 2. Feature Usage by User and Subscription Plan
SELECT 
    u.user_id, 
    u.subscription_plan, 
    f.feature_name, 
    COUNT(*) AS usage_count
FROM users u
JOIN activities f ON u.user_id = f.user_id
GROUP BY u.user_id, u.subscription_plan, f.feature_name;

-- 3. Monthly Revenue Trend (for Active Subscriptions)
SELECT 
    strftime('%Y-%m', start_date) AS month,
    SUM(amount) AS monthly_revenue
FROM subscriptions
WHERE status = 'Active'
GROUP BY month
ORDER BY month;

-- 4. Churn Rate Calculation
SELECT 
    COUNT(CASE WHEN churn = TRUE THEN 1 END) * 100.0 / COUNT(*) AS churn_rate_percentage
FROM users;

-- 5. Top 5 Most Used Features Overall
SELECT 
    feature_name, 
    COUNT(*) AS total_usage
FROM activities
GROUP BY feature_name
ORDER BY total_usage DESC
LIMIT 5;

-- 6. Average Revenue Per User (ARPU)
SELECT 
    ROUND(SUM(amount) * 1.0 / COUNT(DISTINCT user_id), 2) AS ARPU
FROM subscriptions;

-- 7. Active Users by Age Group
SELECT 
    age_group, 
    COUNT(*) AS total_users
FROM users
WHERE churn = FALSE
GROUP BY age_group;

-- 8. Monthly New User Sign-ups
SELECT 
    strftime('%Y-%m', join_date) AS month,
    COUNT(*) AS new_users
FROM users
GROUP BY month
ORDER BY month;

-- 9. Churn Rate by Gender
SELECT 
    gender,
    COUNT(CASE WHEN churn = TRUE THEN 1 END) * 100.0 / COUNT(*) AS churn_rate_percentage
FROM users
GROUP BY gender;

-- 10. Average Feature Usage per User
SELECT 
    ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT user_id), 2) AS avg_feature_usage_per_user
FROM activities;

-- 11. Conversion Rate: Free to Paid Users
SELECT 
    ROUND(COUNT(CASE WHEN subscription_plan != 'Free' THEN 1 END) * 100.0 / COUNT(*), 2) AS conversion_rate_percentage
FROM users;

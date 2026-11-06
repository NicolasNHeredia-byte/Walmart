# Walmart Sales Analysis

Retail sales analysis focused on understanding product performance,
Store efficiency, and customer behavior.

This project was built to answer business questions for a retail portfolio, not just to show charts.

## Tools used
- **SQL** Data cleaning, joins, and business queries.
- **Power BI** Interactive dashboard with 6 pages
- **GitHub Pages** Portfolio deployment

### Project Structure
- 'Query_Products_Walmart.SQL'
- 'Query_Sales_Walmart.SQL'
- 'Query_Stores_Walmart.SQL'
- 'Walmart2Query.SQL'
- 'Dashboard-Walmart-PowerBI.pbix'
- 'Walmart.csv'

### What I Did
1. Cleaned and standardized dataset.
2. Built 3 core queries to calculate KPIs (Total Sales, Margin, Units Sold)
3. Created a 6-page Power BI dashboard: Overview, Products Analysis, Customers Analysis, Stores Analysis, External Factors, Main conclusion.

### Key insights
- **Customers** I used loyalty tiers to group users and track their buying patterns, how much they spend and total purchases.
- **Stores** Since the raw data repeats 20 stores per city, I simplified the dashboard layout to focus on key logistics metrics like inventory levels, stockouts, reorder points, and lead times. 
- **Products** This section breaks down product-level logistics and revenue, letting stakeholders cross-reference store performance with specific items.
- **Sales** Monthly data serves as the baseline, but users can drill down day-by-day across the 8-month period to spot trends, forecast errors and promo impacts.
- **External factors** Added conditions like holidays and weather to see how external variables affect sales, using simple boolean flags ( True for Holidays, False for regular days)
- **Main Conclusion** Walmart's core issue here is clearly operational. I mapped out the logistics bottleneck and put together a clear diagnostic framework to fix it.

## Author
**Nicolas N. Heredia** - Data Analyst | SQL | Power BI
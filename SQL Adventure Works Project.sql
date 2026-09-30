Create database Adventure_Works;
use Adventure_Works;

#0th Question - Union of Fact Internet sales and Fact internet sales new
CREATE TABLE Sales AS

SELECT *
FROM factinternetsales

UNION ALL

SELECT *
FROM fact_internet_sales_new;

select *from sales;

#1st Question - Lookup the productname from the Product sheet to Sales sheet. 
  ALTER TABLE sales
ADD COLUMN ProductName VARCHAR(255);
 
 set sql_safe_updates=0;
UPDATE sales s
JOIN DimProduct d
  ON s.ProductKey = d.ProductKey
SET s.ProductName = d.EnglishProductName;
select *from sales;


#2nd ques a - Lookup the Customerfullname from the Customer and to Sales sheet.
 ALTER TABLE sales
ADD COLUMN CustomerFullName VARCHAR(255);   

UPDATE Sales s
INNER JOIN DimCustomer c
    ON s.CustomerKey = c.CustomerKey
SET s.CustomerFullName = CONCAT_WS(' ', c.FirstName, c.MiddleName, c.LastName);
select *from sales;
  
#2nd question b - Lookup the Unit Price from Product sheet and to Sales sheet.
ALTER TABLE sales
ADD COLUMN Unit_Price int;

UPDATE Sales s
INNER JOIN DimProduct p
    ON s.ProductKey = p.ProductKey
SET s.Unit_Price = p.UnitPrice;
select *from sales;

#4th question - Calculate the Sales amount uning the columns(unit price,order quantity,unit discount)
ALTER TABLE Sales ADD COLUMN SalesAmount1 DECIMAL(10,2);

UPDATE Sales
SET `SalesAmount1` = UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct);
select *from sales;

#Q3. - Calculate the following fields from the Orderdatekey field
#Year
ALTER TABLE Sales
ADD COLUMN Year INT;

UPDATE Sales
SET Year = YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'));
select *from sales;

#Month Number
ALTER TABLE Sales
ADD COLUMN MonthNo INT;

UPDATE Sales
SET MonthNo = MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'));
select *from sales;

#MonthFullName
ALTER TABLE Sales
ADD COLUMN MonthFullName VARCHAR(20);
 
UPDATE Sales
SET MonthFullName = MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'));    
select *from sales;

#Quater
ALTER TABLE Sales
ADD COLUMN Quarter VARCHAR(2);

UPDATE Sales
SET Quarter = CONCAT('Q', QUARTER(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')));
select *from sales;

#YearMonth
ALTER TABLE Sales
ADD COLUMN YearMonth VARCHAR(8);

UPDATE Sales
SET YearMonth = DATE_FORMAT(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'),'%Y-%b');
select *from sales;

#Weekdayno
ALTER TABLE Sales
ADD COLUMN WeekdayNo INT;

UPDATE Sales
SET WeekdayNo = WEEKDAY(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 1;
select *from sales;


#Weekdayname
ALTER TABLE Sales
ADD COLUMN WeekdayName VARCHAR(15);

UPDATE Sales
SET WeekdayName = DAYNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'));
select *from sales;

#FinancialMonth
ALTER TABLE Sales
ADD COLUMN FinancialMonth INT;

UPDATE Sales
SET FinancialMonth =
CASE
    WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) >= 4
        THEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) - 3
    ELSE MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 9
END;
select *from sales;

##FinancialQuarter
ALTER TABLE Sales
ADD COLUMN FinancialQuarter VARCHAR(2);

UPDATE Sales
SET FinancialQuarter =
CASE
    WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 4 AND 6 THEN 'Q1'
    WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 7 AND 9 THEN 'Q2'
    WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 10 AND 12 THEN 'Q3'
    ELSE 'Q4'
END;
select *from sales;

##Q5 - Calculate the Productioncost uning the columns(unit cost ,order quantity)
ALTER TABLE Sales
ADD COLUMN UnitCost DECIMAL(10,2);

UPDATE Sales
SET UnitCost = ProductStandardCost / OrderQuantity;
select *from sales;

ALTER TABLE Sales
ADD COLUMN ProductionCost DECIMAL(10,2);

UPDATE Sales
SET ProductionCost = UnitCost * OrderQuantity;
select *from sales;

##Q6 Calculate the Profit
ALTER TABLE Sales
ADD COLUMN Profit DECIMAL(12,2);

UPDATE Sales
SET Profit = SalesAmount1 - ProductionCost;
select *from sales;


##Q7 - Create a Pivot table for month and sales (provide the Year as filter to select a particular Year)
SELECT
    `MonthFullName`,
    SUM(SalesAmount1) AS `TotalSales`
FROM Sales
WHERE YEAR = 2013    
GROUP BY
    `MonthNo`,
    `MonthFullName`
ORDER BY
    `MonthNo`;

##Q8 - Create a Bar chart to show yearwise Sales
SELECT Year,
ROUND(SUM(SalesAmount1),2) AS TotalSales
FROM sales
GROUP BY Year
ORDER BY Year;

##Q9 - Create a Line Chart to show Monthwise sales
SELECT
    MonthFullName AS Month,
    ROUND(SUM(SalesAmount),2) AS TotalSales
FROM Sales
GROUP BY
    MonthNo,
    MonthFullName
ORDER BY
    MonthNo;

##Q10 - Create a Pie chart to show Quarterwise sales
SELECT
Quarter,
ROUND(SUM(SalesAmount1),2) AS TotalSales
FROM Sales
GROUP BY Quarter
ORDER BY Quarter;

##Q11 - Create a combinational chart (bar and Line) to show Salesamount and Productioncost together
SELECT 
Year,
ROUND(SUM(SalesAmount1),2) AS Salesamount,
ROUND(SUM(ProductionCost),2) AS Productioncost
FROM Sales
GROUP BY Year
ORDER BY Year;

##Q12 - Build addtional KPI /Charts for Performance by Products, Customers, Region
SELECT
    SUM(Profit) AS Total_Profit
FROM Sales;

SELECT
	SUM(OrderQuantity) AS Total_Products_Sold
FROM Sales;

SELECT 
	COUNT(DISTINCT CustomerKey) AS TotalCustomers
FROM Sales;

SELECT
    ROUND((SUM(Profit) / SUM(SalesAmount)) * 100, 2) AS ProfitMargin
FROM Sales;

SELECT
    ROUND(SUM(SalesAmount)) AS TotalSales
FROM Sales;
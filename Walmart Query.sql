use sandra 
go

--1.What is the average weekly sales made by each store during holiday week and regular week?
select Store, IsHoliday, avg(Weekly_Sales) as AvgSales 
from walmart
group by Store, IsHoliday

--2.Compare average weekly sales for holidays vs regular week
select IsHoliday,AVG(Weekly_Sales) as AvgWeeklySales
from Walmart
group by IsHoliday

--3.Show top 5 and bottom 5 performing stores by rank
select Store,sum(Weekly_Sales) as TotalSales, RANK() over (order by sum(Weekly_Sales) desc) as SalesRank
from Walmart
group by Store

--4.What is the total sales by store?
select store, sum(Weekly_Sales) as Total_Sales
from Walmart
group by Store
order by Total_Sales

--5.What is the monthly sales trend?
select FORMAT(Date,'yyyy-MM') as Month, sum(Weekly_Sales) as Monthly_Sales
from Walmart
group by FORMAT(Date,'yyyy-MM')
Order by Month

--6.What is the yearly sales trend?
select YEAR(Date)as Year, sum(Weekly_Sales) as Total_Sales 
from Walmart
group by YEAR(Date)

--7.What is the highest sales week?
select top 1 Date,sum(Weekly_Sales) as Sales
from Walmart
group by Date
order by Sales desc

--8.How much sales were made during holidays
select Date, sum(Weekly_Sales) as Holiday_Sales
from Walmart
where IsHoliday='Holiday'
group by Date

--9.Which store generated the highest total sales overall?
select top 1 Store, sum(Weekly_Sales) as Total_Sales from Walmart
group by Store
order by Total_Sales desc

--10.Which store generated the lowest total sales overall?
select top 1 store, sum(weekly_sales) as Total_Sales from Walmart
group by Store
order by Total_Sales ASC

--11.Which month recorded the highest sales?
select top 1 MONTH(Date) as Month, sum( Weekly_Sales) as Total_Sales from Walmart
group by Month(Date)
order by Total_Sales desc

--12.Which month recorded the lowest sales?
select top 1 Month(Date) as Month, sum(Weekly_Sales) as Total_Sales
from Walmart
group by Month(Date)
order by Total_Sales asc

--13.Which year had the highest total sales?
select top 1 YEAR(Date) as Year, sum(Weekly_Sales) as Total_Sales
from Walmart
group by YEAR(Date)
order by Total_Sales desc

--14.Which store had the highest single-week sales?
select top 1 store,Date,Weekly_Sales from Walmart
order by Weekly_Sales desc

--15.What is the average CPI by year?
select YEAR(Date) as Year,ROUND(AVG(CPI),2) AS Avg_CPI
From Walmart
group by YEAR(Date)
order by Year

--16.Which weeks had the highest CPI values?
select TOP 10 Date, store,ROUND (CPI, 2) AS CPI
from Walmart
order by CPI DESC

--17.Compare sales during periods of high CPI vs low CPI.
select case when CPI >= (Select AVG(CPI) from Walmart)
then 'High CPI' ELSE 'Low CPI' 
End as 'CPI_Level', ROUND(avg(Weekly_Sales),2) as Avg_Weekly_Sales
from Walmart
group by CPI

--18.What is the average unemployment rate by year?
select YEAR(Date) as Year, ROUND(avg(unemployment),2) as Avg_Unemployment
from walmart
group by YEAR(Date)
order by Avg_Unemployment

--19.Which weeks had the highest unemployment rates?
select top 10 date, store, unemployment
from walmart
order by unemployment desc

--20.Compare average sales during periods of high unemployment vs low unemployment.
select case when Unemployment >= (select AVG(Unemployment) from Walmart)
then 'High Unemployment' else 'Low Unemployment'
End as 'Unemployment_Level', ROUND(avg(Weekly_Sales),2) As Avg_Weekly_Sales
from Walmart
group by Unemployment

--21.Which store performed best when unemployment was highest?
select top 1 store, sum(Weekly_Sales) as Total_Sales from walmart
where Unemployment = (select MAX(unemployment) from walmart)
group by Store
order by Total_Sales desc
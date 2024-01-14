Create database Telangana;
Use Telangana;
Select * from domestic_visitors;
Select * from foreign_visitors;

--1.Total domestic visitors to Telangana between 2016-2019.
Select sum(visitors) as total_domestic_visitors from domestic_visitors;

--2.Total Foreign visitors to Telangana between 2016-2019.
Select sum(visitors) as total__foreign_visitors from foreign_visitors;

--3.Top 10 districts with highest number of domestic visitors overall
Select * from (
Select *, RANK() over(order by total_visitors desc) as rnk from (
Select district, SUM(visitors) as total_visitors from domestic_visitors
group by district ) as a)as b where rnk between 1 and 10 ;

--4.Peak and low season months for Hyderabad based on data from 2016 and 2019
Select * , rank() over(order by total_visitors) as rnk from(
Select district, month , sum(tv) as total_visitors from (
Select district, month,(dv+fv) as tv from (
Select d.district,d.month,d.visitors as dv,f.visitors as fv from domestic_visitors d 
join foreign_visitors f on d.district=f.district where d.district='Hyderabad') as a) as b 
group by district, month) as a ;

--5.Find out top and bottom 3 districts wrt domestic to foreign tourist ratio
Select district, (total_dv/total_fv) as 'dv : fv' from ( 
Select district, sum(cast(dv as bigint)) as total_dv, sum(cast(fv as bigint)) as total_fv 
from(Select d.district,d.visitors as dv,f.visitors as fv from domestic_visitors d 
join foreign_visitors f on d.district=f.district) as a 
group by district) as b  where total_fv<>0 order by 'dv : fv' desc;
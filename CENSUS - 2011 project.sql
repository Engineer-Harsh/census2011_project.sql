use Census2011_project

exec sp_rename 'dataset1','dataset1_census2011'
exec sp_rename 'dataset2','dataset2_census2011'

select * from dataset1_census2011
select * from dataset2_census2011



----No of Rows present in our dataset

select count(*) from dataset1_census2011--1000
select count(*) from dataset2_census2011--640

select count(*)as total_rows, count(district)as total_district from dataset1_census2011 --as we can see here 359 rows are empty
select count(*)total_rows, count(district)total_district from dataset2_census2011

select count(*)as total_rows, count(district)as total_district from dataset1_census2011
select count(*)as total_rows, count(state)as total_state from dataset1_census2011
select count(*)as total_rows, count(growth)as total_growth from dataset1_census2011
select count(*)as total_rows, count(sex_ratio)as total_sex_ratio from dataset1_census2011
select count(*)as total_rows, count(literacy)as total_literacy from dataset1_census2011

delete from dataset1_census2011 where district is null---now the null rows are removed
select * from dataset1_census2011 where growth is null
delete from dataset1_census2011 where growth is null---now the records are clean

select count(*) from dataset1_census2011--640
select count(*) from dataset2_census2011--640


---Query all the Records from Bihar and Jharkhand

select * from dataset1_census2011 where state ='bihar'
select * from dataset1_census2011 where state = 'jharkhand'

select * from dataset1_census2011 where state in ('bihar','jharkhand')


---What is the Total Population of India

select sum(population)total_population from dataset2_census2011---total population(1210854977)


----What is Average Growth of India
select avg(growth)as avg_growth from dataset1_census2011--avg growth(0.19245921875)

select cast(avg(growth)*100 as decimal(10,2))as avg_growth from dataset1_census2011--avg growth(19.25%)


---What is the Average Growth Percentage of all the States

select State, avg(growth)*100 as Growth_percentage from dataset1_census2011 group by state

select state, cast(avg(growth)*100 as decimal(10,2)) as Growth_percentage from dataset1_census2011 group by state

---What is the Average Sex_ratio of India

select avg(sex_ratio) as Avg_Sex_ratio from dataset1_census2011--Average sex ratio(945.4328125)

select cast(avg(sex_ratio) as decimal(10,2))as Average_sex_ratio from dataset1_census2011

---Find Average sex ratio per state

select state, round(avg(sex_ratio),0)as Average_sex_ratio from dataset1_census2011 group by state
order by Average_sex_ratio desc;

---find which States have Max sex ratio

select max(sex_ratio) as state_with_max_ratio from dataset1_census2011 

select state, sex_ratio from dataset1_census2011 
where sex_ratio=(select max(sex_ratio) as state_with_max_ratio from dataset1_census2011)

---find states  with least sex ratio

select state, sex_ratio from dataset1_census2011
where sex_ratio=(select min(sex_ratio) from dataset1_census2011)

select * from dataset1_census2011
select * from dataset2_census2011
select state, avg(sex_ratio) from dataset1_census2011 group by [State ]
-------------------------------------------------------------------------------------------------------------------------------
---find the states which are below the average sex ratio of india

select state, round(avg(sex_ratio),0) as Below_then_Average_sex_ratio from dataset1_census2011 
where sex_ratio < (select avg(sex_ratio)avg_sex_ratio_of_India from dataset1_census2011)
group by state----below--might be not correct answer
----------
SELECT State, 

       AVG(CAST(Sex_Ratio AS DECIMAL(10, 2))) AS Average_Sex_Ratio 

FROM dataset1_census2011

GROUP BY State

HAVING AVG(CAST(Sex_Ratio AS DECIMAL(10, 2))) < 

       (SELECT AVG(CAST(Sex_Ratio AS DECIMAL(10, 2))) 

        FROM dataset1_census2011);
		---------
SELECT State, 

       AVG(CAST(Sex_Ratio AS DECIMAL(10, 2))) AS Average_Sex_Ratio 

FROM dataset1_census2011

GROUP BY State

HAVING AVG(CAST(Sex_Ratio AS DECIMAL(10, 2))) > 

       (SELECT AVG(CAST(Sex_Ratio AS DECIMAL(10, 2))) 

        FROM dataset1_census2011);

----------
select state, cast(avg(sex_ratio)as decimal(10,2)) as above_then_Average_sex_ratio from dataset1_census2011 
where sex_ratio > (select avg(sex_ratio)avg_sex_ratio_of_India from dataset1_census2011)
group by state----above--might be not correct answer

--------------
SELECT state, CAST(AVG(sex_ratio) AS DECIMAL(10, 2)) AS Above_then_Average_sex_ratio FROM dataset1_census2011
WHERE sex_ratio > (SELECT CAST(AVG(sex_ratio) AS DECIMAL(10, 2)) FROM dataset1_census2011) GROUP BY state;
---------------
select count(state) from dataset1_census2011

select state,count(state)total_no_of_district from dataset1_census2011 group by state

select state, cast(avg(sex_ratio) as decimal(10,2))as Average_sex_ratio from dataset1_census2011 group by state

select state, round(avg(sex_ratio),0)as Average_sex_ratio from dataset1_census2011 group by state


---find the states which are below the average sex ratio of india and find how much they are below by it

select state, sex_ratio, (round(avg(sex_ratio)over(),0)-sex_ratio)as difference from dataset1_census2011 
where sex_ratio < (select avg(sex_ratio)avg_sex_ratio_of_India from dataset1_census2011)--might be not correct answer

--------------------------------------------------------------------------------------------------------------------------------

---Average literacy rate
select * from dataset1_census2011

select cast(avg(literacy)as decimal(10,2)) Average_literacy from dataset1_census2011

----average state literacy rate

select state, cast(avg(literacy) as decimal(10,2))average_literacy_rate_per_state from dataset1_census2011
group by state order by average_literacy_rate_per_state desc;

---state where literacy rate is more than 90%

select state, cast(avg(literacy) as decimal(10,2))average_literacy_rate_per_state from dataset1_census2011
group by state 
having cast(avg(literacy) as decimal(10,2)) > 90
order by average_literacy_rate_per_state desc

---which are the top 3 states which have displayed highest growth rate percentage

select * from dataset1_census2011

select top(3)state, round(sum(growth)*100,2)as growth_percentage from dataset1_census2011 group by state
order by sum(growth) desc

---which are the top 3 states which have displayed highest average growth rate percentage

select top(3)state, round(avg(growth)*100,2)as growth_percentage from dataset1_census2011 group by state
order by avg(growth) desc

---show the state with lowest sex_ratio
select top(3)[State ], sum(sex_ratio) from dataset1_census2011 group by [State ] order by sum(sex_ratio) asc

select top(3)[State ], avg(sex_ratio) from dataset1_census2011 group by [State ] order by avg(sex_ratio) asc
--i think bottom query is the correct one


---top and bottom states with literacy ratio
select T1.* from (
					select top(3)state, round(avg(literacy),2) average_literacy_ratio from dataset1_census2011 
					group by [State ] order by avg(literacy) desc) T1
	union all 
select T2.* from(
				select top(3)state, round(avg(literacy),2) average_literacy_ratio from dataset1_census2011 
				group by [State ] order by avg(literacy) asc) T2 


--- states starting with letter A
select * from dataset1_census2011 where [State ] like 'A%'

select distinct([State ]) from dataset1_census2011  where [State ] like 'A%'

select distinct([State ]) from dataset1_census2011  where [State ] like 'A%' or [State ] like '%d'

select distinct([State ]) from dataset1_census2011  where [State ] like 'j%' and [State ] like '%d'

---what is the number of males and females in the states
select * from dataset1_census2011 order by District
select * from dataset2_census2011

with cte as (
			select d1.District,d1.[State ], Sex_Ratio, Population from 
			dataset1_census2011 d1 full outer join dataset2_census2011 d2 
			on d1.District=d2.District )
select state, sum(((sex_ratio/1000)*Population))Females from cte group by state;
--or--
with cte as (
			select d1.District,d1.[State ], Sex_Ratio, Population from 
			dataset1_census2011 d1 full outer join dataset2_census2011 d2 
			on d1.District=d2.District )
select state, sum(population - ((population)/(sex_ratio + 1)))females from cte group by state;

with cte as (
			select d1.District,d1.[State ], Sex_Ratio, Population from 
			dataset1_census2011 d1 full outer join dataset2_census2011 d2 
			on d1.District=d2.District )
select state, sum((sex_ratio/1000)*Population)Females,sum(population-((sex_ratio/1000)*Population)) Males
from cte
group by state;

with cte as (
			select d1.District,d1.[State ], Sex_Ratio, Population from 
			dataset1_census2011 d1 full outer join dataset2_census2011 d2 
			on d1.District=d2.District )
select state, round(sum((sex_ratio/1000)*Population),0)Females,
round(sum(population-((sex_ratio/1000)*Population)),0) Males
from cte
group by state;

---what is the total no of literate and illiterate people
select * from dataset1_census2011
select * from dataset2_census2011;
--as we know literacy rate = (No. of literates/Total population)*100
--so from here No.of literate persons= (literacy rate*total population)/100

select 
	jn.[State ], sum(jn.population)total_population, round(sum((jn.literacy*jn.population)/100),0)no_of_literates, 
	round(sum(jn.population -((jn.literacy*jn.population)/100)),0)no_of_illiterates 
	from 
		(select d1.[State ], d1.Literacy, d2.population from 
			(dataset1_census2011 d1 full outer join dataset2_census2011 d2 
					on d1.District=d2.District))jn
group by [State ] order by [State ]


---what was the population of previouse census and curent census and what is the difference b/w them

select * from dataset1_census2011
select * from dataset2_census2011

-- current population = previous population + (Previous Population * growth)
-- current population = previous populatio( 1 + growth)
-- previous population = (current population)/(1 + growth)

select a.state,a.growth,(a.population)current_census ,round(((a.population)/(1 + a.growth)),0)previous_census, 
		round((a.population -  ((a.population)/(1 + a.growth))),0)Diff
from 	
	(select d1.state, sum(d1.growth)growth, sum(d2.population)population from 
	dataset1_census2011 d1 full outer join dataset2_census2011 d2 
	on d1.District=d2.District 
	group by d1.state)a

---what is the total population in previous and current census
select sum(y.current_census)total_current_population, sum(y.previous_census)total_previous_population from (
select a.state,a.growth,(a.population)current_census ,round(((a.population)/(1 + a.growth)),0)previous_census, 
		round((a.population -  ((a.population)/(1 + a.growth))),0)Diff
from 	
	(select d1.state, sum(d1.growth)growth, sum(d2.population)population from 
	dataset1_census2011 d1 full outer join dataset2_census2011 d2 
	on d1.District=d2.District 
	group by d1.state)a )y
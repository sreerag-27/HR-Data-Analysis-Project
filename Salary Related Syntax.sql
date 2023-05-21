-- Q1 Average Salary of Easch department
select Department,round(avg(monthlyincome)) from general_data group by department order by round(avg(monthlyincome)) desc; 
#  Research and development = 67,224 | Sales = 61,383 |  Human resources = 58,101 

-- Q2 Highest Salary Of employee in different job role and department
select employeeid,department,jobrole,max(monthlyincome) from general_data
group by jobrole 
order by max(monthlyincome) desc limit 10;

-- Q3 Lowest salary of employees in each job role in department
select employeeid,department,jobrole,min(monthlyincome) from general_data 
group by jobrole 
order by min(monthlyincome) desc limit 10;

-- Q4 Highest salary of employee but low job involvement
select g.employeeid,g.department,g.jobrole,max(g.monthlyincome), m.jobinvolvement from general_data  g
join manager_survey_data m
on g.employeeid = m.Employeeid
where JobInvolvement = 'Low'
group by jobrole,department
order by max(monthlyincome) desc ;

-- Q5 Lowest salary of employee but very high job involvement
select g.employeeid,g.department,g.jobrole,min(g.monthlyincome), m.jobinvolvement from general_data  g
join manager_survey_data m
on g.employeeid = m.Employeeid
where JobInvolvement = 'Very High'
group by jobrole,department
order by min(monthlyincome) desc ;
# salary of these employees can be increased as their Job Involvement is Very High

-- Q6 Percentage of Salary Hike
# Highest Salary Hike of Employees     
select employeeid,department,jobrole,monthlyincome,max(percentsalaryhike) from general_data; # Maximum salary hike 25 %
select employeeid,department,jobrole,monthlyincome,min(percentsalaryhike) from general_data;# Minimum Salary hke 11 %

select employeeid,department,jobrole,monthlyincome,max(percentsalaryhike) from general_data 
group by jobrole 
order by max(percentsalaryhike) desc ;
 
 -- Q7 Salary hike of employees with lowest job involvement 
 select g.employeeid,g.department,g.jobrole, g.percentsalaryhike, m.jobinvolvement from general_data g
 join manager_survey_data m
 on m.employeeid = g.employeeid
 where jobinvolvement = 'Low'
 order by percentsalaryhike desc limit 10; 
 
 -- Q8 Salary hike of employees with very high job involvement and ountstanding performance rating
 select g.employeeid,g.department,g.jobrole, g.percentsalaryhike, m.jobinvolvement from general_data g
join manager_survey_data m
on m.employeeid = g.employeeid
where jobinvolvement = 'Very high' and
performancerating = 'outstanding'
order by percentsalaryhike asc limit 10; 
 
--  Q9 Percentage hike less than 15 % of employees
select employeeid,jobrole,percentsalaryhike from general_data where PercentSalaryHike <13 order by percentsalaryhike asc;
-- Male and Female Salary/Income  Ratio
select sum(monthlyincome) from general_data where gender ='Male'; #171540870
select sum(monthlyincome) from general_data where gender = 'Female'; # 113559510
select sum(monthlyincome) from general_data ;# 285100380

select round((171540870/285100380)*100) as male_income_ratio; # 60 % male income ratio
select round((113559510/285100380)*100) as female_income_ratio; # 40 % DFemale income ratio

-- Q10 hardworking female employees which have high performance rating amd job involvement but has less than average salary
select g.employeeid,g.department,g.jobrole,g.gender, g.monthlyincome, m.jobinvolvement,m.performancerating from general_data g
join manager_survey_data m
on g.employeeid = m.employeeid
where monthlyincome < (select avg(monthlyincome) from general_data where gender = 'Female')
and  gender = 'Female'
and m.jobinvolvement = 'Very High'
and m.Performancerating = 'Excellent'
order by monthlyincome desc;

# -------------------------------------------------------------------------------------------
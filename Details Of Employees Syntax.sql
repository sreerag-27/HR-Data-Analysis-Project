create database hr_project ;
use hr_project ;

select * from general_data;
select * from employee_survey_data;
select * from manager_survey_data;
commit;
savepoint a;

# About Employees

-- Q1 Avg age of employees 
select avg(age) from general_data;
select ceil(avg(age)) from general_data; # Ceil() function is used as decimals where close to .9 
# Average age of employees is 37 years.

-- Q2 Average age of employees respective to department
select department, avg(age) from general_data group by department; 
select department, floor(avg(age)) from general_data group by department; #floor() function is used as it will show different average age of different department;

-- average age of employees in job roles
select jobrole, avg(age) from general_data group by jobrole; 
select jobrole, floor(avg(age)) from general_data group by jobrole;

-- Q3 Count of employees of each job role (visualization)
 select department,jobrole,count(employeeid) from general_data group by jobrole order by count(employeeid) desc;

-- Q4 Non Travellers employees who has high involvement should be given travelling opportunity
select g.employeeid, g.businesstravel,g.department,m.jobinvolvement,m.performancerating from general_data g
join manager_survey_data m
on g.employeeid = m.employeeid
where businesstravel = 'non-travel' and jobinvolvement = 'Very High' and performancerating = 'Very High' 
order by employeeId asc;
# employee id such as 657, 1421, 2127, 2891, 3597, 4361 can give an opportunity for business travel by upper management

 -- Q5 Greater distance more than 20 killometeres of employees can give travell allowances
select employeeid, distancefromhome from general_data where distancefromhome between 20 and 29;
select Count(employeeid) from general_data where distancefromhome between 20 and 29;
# There are total 683 Employees where travell distance lies in range between of 20 to 25 and can be given travell allowances to increase job satisfaction

-- Q6 Total Number of employees with different different education (visualization)
select count(employeeid) from general_data where education = 'bachelor' ; # 1701 employees
select count(employeeid) from general_data where education = 'college' ; # 842 employees
select count(employeeid) from general_data where education = 'below college' ; # 508 employees
select count(employeeid) from general_data where education = 'master'; # 1188 employees
select count(employeeid) from general_data where education = 'doctor'; # 143 employees
# Employees with Bachelor level education has highest number of employees that is 1701 and lowest number of employees with doctor degree that is !43

-- Q7 Male To Female ratio in Organisation  (visualization )
select count(gender) from general_data; # 4382
select  count(gender) from general_data where gender = 'male'; #2626
select round((2626/4382)*100) as male_ratio; 
# 60 % of employees are male

select count(gender)  from general_data where gender = 'Female'; #1756
select round((1756/4382)*100) as female_ratio;
# 40 % of employees are female 


-- Q8  Easiest and Hardest Job with respect to job level                     ???????????????
 select employeeid,department,jobrole,joblevel from general_data where joblevel = 1 or  joblevel = 5;
 

-- Q9 Employees who's performance is very high and has the hardest job level
select g.employeeid,g.jobrole,g.joblevel,m.PerformanceRating from general_data as g
join manager_survey_data as m 
on g.employeeid = m.employeeid
where PerformanceRating = 'Excellent' and joblevel = 5;


-- Q10 Married, Divorced, Single rate of employees (Visualization)
select count(employeeid) from general_data;

select count(employeeid) from general_data where maritalstatus  ='Married'; # 2007
select count(employeeid) from general_data where maritalstatus ='Divorced'; # 970
select count(employeeid) from general_data where maritalstatus ='Single'; # 1405

select round((2007/4382)*100) as married_ratio; # 46 % Married Ratio
select round((970/4382)*100) as divorced_ratio; # 22 % Divorced Ratio
select round((1405/4382)*100) as  Single_ratio; # 32 % single Ratio
select (46 + 22 +32) as marital_status_ratio;


-- Q11 Employees above 58 years may retire in coming years, inplace of those employees new employees have to be hired 
select employeeid , department,jobrole , age from general_data where age >= 58; #  Total 87 employees are above age 58
select count(age) from general_data where age >=58 ; # 87 employees above age 57

-- Q12 Employees of above 58 age in each job role 
select employeeid, department,jobrole,count(age) from general_data where age>=58 group by jobrole order by count(age) desc;
select  (24 + 21 + 18 + 9 +  6+ 6 + 3) as total_above58_employee_count;

-- Q13 Employees with Highest working years in company
select employeeid,department,jobrole,totalworkingyears from general_data where TotalWorkingYears between 30 and 40 order by  Totalworkingyears  desc;

-- Q14 Employees who has low environment satisfaction and low job satisfaction and have changed companies many time may leave this one also .
-- so we can prepare to hire new employess matching the same job role and department in future if employees leave the company     
select g.employeeid, g.department,g.jobrole, e.EnvironmentSatisfaction,e.JobSatisfaction,g.NumCompaniesWorked from general_data  g
join employee_survey_data e
on e.employeeid = g.employeeid
where environmentsatisfaction = 'low' and 
jobsatisfaction = 'Low' and
NumCompaniesWorked > 5 ;

select count(g.NumCompaniesWorked) from general_data  g
join employee_survey_data e
on e.employeeid = g.employeeid
where environmentsatisfaction = 'low' and 
jobsatisfaction = 'Low' and
NumCompaniesWorked > 5 ; # total there are 33 employees with low environment satisfaction and low job satisfaction


-- Q15 Stock option level is 0 who are harworking employees must grant stocks as a incentive
select g.employeeid, g.department,g.jobrole,m.JobInvolvement,m.PerformanceRating,g.StockOptionLevel from general_data g
join manager_survey_data m
on m.employeeid = g.employeeid
where JobInvolvement = 'Very high' and 
PerformanceRating ='Outstanding' and StockOptionLevel =0;

-- Q16 Less training for employees last year but has higher performance rating and very high job involvement
select g.employeeid, g.trainingtimeslastyear,m.performancerating from general_data g
join manager_survey_data m
on g.employeeid = m.employeeid
where performancerating = 'outstanding' and 
jobinvolvement = 'very high' and
TrainingTimesLastYear <= 2;  # total 42 employees 

-- Q17 Highest job involvement and  performance rating  and has more than 5 years at company and not yet promoted
select g.employeeid,g.department,g.jobrole, m.jobinvolvement,m.performancerating,g.YearsAtCompany,g.YearsSinceLastPromotion from general_data g
join  manager_survey_data  m
on g.employeeid = m.employeeid
where jobinvolvement = 'Very High' and
performancerating = 'Outstanding' and 
YearsAtCompany >5  
order by  YearsSinceLastPromotion desc; # there are total 33 employees who has worked for many years and their last promotion was years ago

-- Q18 Employees more than 10 years with current manager
select employeeid, yearsatcompany , yearswithcurrmanager from general_data where YearsWithCurrManager >= 10;
    # 300 employees have more than 10 years of experience with current manager

-- Q19 Environment satisfaction of employees of each department
select g.department,g.jobrole,environmentsatisfaction,count(e.environmentsatisfaction) as Total_environment_satisfaction from general_data  g
join employee_survey_data e
on g.employeeid = e.employeeid
group by jobrole,EnvironmentSatisfaction
order by department,jobrole;

-- Q20 Job Involvement of employees in various department
select g.department,g.jobrole,m.jobinvolvement,count(m.jobinvolvement) from general_data g
join manager_survey_data m
on g.employeeid = m.employeeid
group by jobrole,jobinvolvement;


-- Q21 Highest performance rating of employees in respective field
select g.employeeid, g.department, g.jobrole,m.performancerating,m.JobInvolvement from general_data g 
join manager_survey_data m
on g.EmployeeID = m.EmployeeID
where performancerating = 'Outstanding' and
jobinvolvement = 'Very High'; # 66 employees with Outstanding Performance rating and very high job involvement

-- Q22 Employees with very high environment satisfaction,very high job satisfaction and best Work life balance
select g.employeeid , g.department,g.jobrole,e.environmentsatisfaction,e.jobsatisfaction,e.worklifebalance  from general_data g
join employee_survey_data e
on g.EmployeeID = e.EmployeeID
where EnvironmentSatisfaction = 'Very High'and
jobsatisfaction = 'very high' and
worklifebalance = 'Best'
order by department,jobrole; 
#54 employees with very high jobsatisfaction and environment satisfaction and best work life balance



 # ----------------------------------------------------------------------------------------------------------------------------------------------------- #
 
#### Department Related Questions

-- Q1 Which department has higher Involvement rate  (Visulaization)
select distinct(department) from general_data;
select count(department) from general_data; # 4382

select count(department) from general_data where department = 'Sales'; #1330
select round((1330/4382)*100) as sales_ratio; # 30 % of employees are of sales

select count(department) from general_data where department = 'Research & Development'; # 2865
select round((2865/4382)*100) as Research_and_development; # 65 % of employees are of Research And Development

select count(department) from general_data where department = 'Human Resources'; # 187
select ceil((187/4382)*100) as human_resources; # 4 % of employees are of Human Resources

select (30 + 65 + 5) as total_ratio; # 100 %  (addition for cross checking purpose)


# --------------------------------------------------------------------------------------------------------------------------------------
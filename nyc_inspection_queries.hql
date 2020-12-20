-- 84 distinct cuisines
select distinct cuisine_desc from nyc_inspection;

-- Restaurants without critical violations
select distinct X.dba from nyc_inspection X where X.camis not in (select camis from nyc_inspection where critical='Y');

-- Count of violations per restaurant 
select dba, count(*) from nyc_inspection where length(violation_code)>0 group by dba;
-- Count of violations per cuisine 
select cuisine_desc, count(*) from nyc_inspection where length(violation_code)>0 group by cuisine_desc;
-- Count of violations per cuisine (critical v noncritical) 
select cuisine_desc, count(*) from nyc_inspection where critical='Y' group by cuisine_desc;
select cuisine_desc, count(*) from nyc_inspection where critical='N' group by cuisine_desc;

with t1 as (select dba rest_name, count(*) total_violation from nyc_inspection where length(action)>0 group by dba)
select t1.rest_name, t1.total_violation, t2.item_name, t2.max_calories from t1 join maxvalues t2 on UPPER(t1.rest_name)=UPPER(t2.restaurant_name) order by t1.total_violation;

with t1 as (select dba from nyc_inspection group by dba, building, street, boro, zipcode),
t2 as (select dba, count(*) num_rest from t1 group by t1.dba),
t3 as (select dba, count(*) tot_violations from nyc_inspection where length(action)>0 group by dba),
t4 as (select t2.dba, t3.tot_violations/t2.num_rest avg_violations from t2 join t3 on t2.dba = t3.dba)
select t4.dba, t4.avg_violations, t5.item_name, t5.max_calories from t4 join maxvalues t5 on UPPER(t4.dba) = UPPER(t5.restaurant_name) order by t4.avg_violations;

with t1 as (select dba from nyc_inspection group by dba, building, street, boro, zipcode),
t2 as (select dba, count(*) num_rest from t1 group by t1.dba),
t3 as (select dba, count(*) tot_violations from nyc_inspection where length(action)>0 group by dba),
t4 as (select t2.dba, t3.tot_violations/t2.num_rest avg_violations from t2 join t3 on t2.dba = t3.dba)
select t4.dba, t4.avg_violations, t5.avg_calories from t4 join avgvalues t5 on UPPER(t4.dba) = UPPER(t5.restaurant_name) order by t4.avg_violations;


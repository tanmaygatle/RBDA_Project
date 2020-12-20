with t1 as (select dba, count(*) as total_violations from yd1568.nyc_inspection where length(action)>0 group by dba)
select t1.dba, t1.total_violations, t2.avg_rating from t1 join yd1568.yelp_rating t2 on
UPPER(t1.dba) = UPPER(t2.restaurant_name) order by t2.avg_rating desc

with t1 as (select dba from nyc_inspection group by dba, building, street, boro, zipcode),
t2 as (select dba, count(*) num_rest from t1 group by t1.dba),
t3 as (select dba, count(*) tot_violations from nyc_inspection where length(action)>0 group by dba),
t4 as (select t2.dba, t3.tot_violations/t2.num_rest avg_violations from t2 join t3 on t2.dba = t3.dba)
select t4.dba, t4.avg_violations, t5.avg_rating from t4 join yelp_rating t5 on UPPER(t4.dba) = UPPER(t5.restaurant_name)
order by t4.avg_violations desc

with t1 as (select dba from nyc_inspection group by dba, building, street, boro, zipcode),
t2 as (select dba, count(*) num_rest from t1 group by t1.dba),
t3 as (select dba, count(*) tot_violations from nyc_inspection where length(action)>0 group by dba),
t4 as (select t2.dba, t3.tot_violations/t2.num_rest avg_violations from t2 join t3 on t2.dba = t3.dba)
select t4.dba, t4.avg_violations, t5.avg_rating from t4 join yelp_rating t5 on UPPER(t4.dba) = UPPER(t5.restaurant_name)
order by t4.avg_violations desc
with t2 as (select distinct B.restaurant_name as restaurant_name, B.item_name as item_name, B.calories as min_calories from (select restaurant_name, min(calories) as min_calories_inner from tvg238.nyc_menudata where food_category != "Beverages" and calories != 0 group by restaurant_name) as A inner join tvg238.nyc_menudata as B on A.restaurant_name = B.restaurant_name and A.min_calories_inner = B.calories)
select t1.restaurant_name, t1.item_name, t1.min_calories from (select *, row_number() over (partition by restaurant_name) rn from t2) t1 where rn = 1;

with t2 as (select distinct B.restaurant_name, B.item_name, B.calories as max_calories from (select restaurant_name, max(calories) as max_calories_inner from tvg238.nyc_menudata group by restaurant_name) as A inner join tvg238.nyc_menudata as B on A.restaurant_name = B.restaurant_name and A.max_calories_inner = B.calories)
select t1.restaurant_name, t1.item_name, t1.max_calories from (select *, row_number() over (partition by restaurant_name) rn from t2) t1 where rn = 1;

select restaurant_name, food_category, coalesce(avg(calories),0) as avg_calories from tvg238.nyc_menudata group by restaurant_name,food_category;

select restaurant_name, avg(calories) as avg_calories from tvg238.nyc_menudata group by restaurant_name;

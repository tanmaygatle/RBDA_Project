create external table NYC_INSPECTION (camis string, dba string, boro string, building string, street string, zipcode string, phone string, cuisine_desc string, inspection_date string, action string, violation_code string, violation_desc string, critical string, score int, grade string, grade_date string, record_date string, inspection_type string, latitude decimal, longitude decimal, community_board int, council_dist int, bin string, bbl string, nta string) row format delimited fields terminated by '=' location '/user/yd1568/ProjectData/NYC_Inspection/Hive' tblproperties ("skip.header.line.count"="1");

create external table NYC_MENUDATA (menu_item_id int, year int, restaurant_item_name string, restaurant_name string, restaurant_id int, item_name string, item_description string, food_category string, serving_size int, serving_size_text string, serving_size_unit string, serving_size_household string, calories int, total_fat int, saturated_fat int, trans_fat int, cholesterol int, sodium int, potassium int, carbohydrates int, protein int, sugar int, dietary_fiber int,calories_100g int, total_fat_100g int,saturated_fat_100g int, trans_fat_100g int, cholesterol_100g int, sodium_100g int, potassium_100g int, carbohydrates_100g int, protein_100g int, sugar_100g int, dietary_fiber_100g int, calories_text string,total_fat_text string,saturated_fat_text string,trans_fat_text string,cholesterol_text string, sodium_text string,potassium_text string,carbohydrates_text string,protein_text string,sugar_text string,dietary_fiber_text string,kids_meal int,limited_time_offer int,regional int, shareable int) row format delimited fields terminated by '=' location '/user/tvg238/MenuData_hive' tblproperties ("skip.header.line.count"="1");

create external table yelp_metadata (userid int, productid int, rating float, label int, dateid date) row format delimited fields terminated by '\t' location '/user/tvg238/YelpData/Metadata';

create external table yelp_productidmapping (restaurant_name string, productid int) row format delimited fields terminated by '\t' location '/user/tvg238/YelpData/Productidmapping';

create external table yelp_reviews(restaurant_name string, productid int, rating double) row format delimited fields terminated by '=' location '/user/yd1568/ProjectData/Yelp';

create external table yelp_rating (restaurant_name string, avg_rating double) row format delimited fields terminated by '=' location '/user/yd1568/ProjectData/Yelp_Rating';

with inspection_count as (select dba, count(*) as cnt from nyc_inspection where length(violation_code)>0 group by dba) 
	select A.dba, A.cnt, B.avg_rating from inspection_count A JOIN yelp_rating B ON UPPER(A.dba) = UPPER(B.restaurant_name);

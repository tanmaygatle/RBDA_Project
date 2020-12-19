yelp_data = LOAD 'ProjectData/Yelp/yelp_data' USING PigStorage('=') as (restaurant_name:chararray, productid:int, rating:double);
rated_yelp = GROUP yelp_data BY restaurant_name;
yelp_rating = FOREACH rated_yelp GENERATE group, AVG(yelp_data.rating) as average_rating; 


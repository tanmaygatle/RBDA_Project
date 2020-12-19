metadata = LOAD 'YelpData/Metadata/metadata' USING PigStorage('\t') as (userid:int, productid:int, rating:double, label:int, dateid:chararray);
productdata = LOAD 'YelpData/Productidmapping/productIdMapping' USING PigStorage('\t') as (restaurant_name:chararray, productid:int);

result = JOIN metadata BY productid,  productdata BY productid;
yelp_data = FOREACH result GENERATE productdata::restaurant_name AS restaurant_name, productdata::productid AS productid, metadata::rating AS rating;

STORE yelp_data INTO 'YelpData/Newdata' USING PigStorage('=');
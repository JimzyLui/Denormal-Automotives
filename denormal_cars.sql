-- login: psql -U postgres 
CREATE USER denormal_user;
CREATE DATABASE denormal_cars
OWNER denormal_user;
\du  --to check that the user has been created
\l -- to check that the database has been created
\i scripts/denormal_data.sql;
\dS car_models;
-- no difference between \dS and \d here

SELECT DISTINCT make_title from car_models;
SELECT DISTINCT model_title from car_models WHERE make_code='VOLKS';
SELECT DISTINCT make_code, model_code, model_title, year
FROM car_models WHERE make_code='LAM';
SELECT COUNT(*) FROM car_models WHERE YEAR >=2010 AND YEAR <=2015;


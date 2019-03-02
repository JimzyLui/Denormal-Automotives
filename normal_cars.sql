CREATE USER normal_user;
CREATE DATABASE normal_cars OWNER normal_user;
\du;  --to check that the user has been created
\l; -- to check that the database has been created
\c normal_cars;
\i scripts/denormal_data.sql;
\dS car_models;


select count(distinct make_code) from car_models;
select count(distinct make_title) from car_models;

select count(distinct model_code) from car_models;
select count(distinct model_title) from car_models;
select count(distinct model_code,model_title) from car_models;

select count(*) distinct make_code, make_title from car_models;

select distinct model_code,model_title, count(model_title) from car_models 
group by model_code,model_title
having count(model_title) > 1
order by model_code,model_title;
select * from car_models where model_title is null;

CREATE TABLE IF NOT EXISTS cars(
  id SERIAL PRIMARY KEY,
  makeId INTEGER REFERENCES makes(id),
  modelId INTEGER REFERENCES models(id),
  yearId INTEGER REFERENCES years(id)
);
CREATE TABLE IF NOT EXISTS makes(
  id SERIAL PRIMARY KEY,
  code VARCHAR(125) NOT NULL,
  title VARCHAR(125) NOT NULL,
);
CREATE TABLE IF NOT EXISTS models(
  id SERIAL PRIMARY KEY,
  code VARCHAR(125) NOT NULL,
  title VARCHAR(125) NOT NULL,
);
CREATE TABLE IF NOT EXISTS years(
  id SERIAL PRIMARY KEY,
  year VARCHAR(4) NOT NULL,
);

Insert into years(year)
Select distinct year from car_models Order By year;

Insert into makes(code, title)
Select distinct make_code, make_title from car_models Order By make_code, make_title;

Insert into models(code, title)
Select distinct model_code, model_title from car_models Order By model_code, model_title;

Insert into cars(makeId, modelId, yearId)
select m1.id, m2.id, y.id
--c.make_code, c.make_title, c.model_code, c.model_title, c.year 
from car_models c
LEFT JOIN makes m1 ON c.make_code=m1.code
LEFT JOIN models m2 ON c.model_code=m2.code
LEFT JOIN years y ON c.year=y.year

SELECT distinct title FROM cars c LEFT JOIN makes m ON c.makeId=m.id;

SELECT distinct m2.title FROM cars c 
LEFT JOIN makes m1 ON c.makeId=m1.id 
LEFT JOIN models m2 ON c.modelId=m2.id
WHERE m1.code = 'VOLKS';


SELECT distinct m1.code, m2.code, m2.title, y.year FROM cars c 
LEFT JOIN makes m1 ON c.makeId=m1.id 
LEFT JOIN models m2 ON c.modelId=m2.id
WHERE m1.code = 'LAM'; 

SELECT distinct m1.code, m1.title, m2.code, m2.title, y.year FROM cars c 
LEFT JOIN makes m1 ON c.makeId=m1.id 
LEFT JOIN models m2 ON c.modelId=m2.id
WHERE y.year >= 2010 and y.year <= 2015;


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

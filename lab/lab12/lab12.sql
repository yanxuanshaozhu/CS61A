.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet from students
  where color = 'blue' and pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song from students
  where color = 'blue' and pet = 'dog';


CREATE TABLE smallest_int AS
  SELECT time, smallest from students
  where smallest > 2
  order by smallest asc
  limit 20;


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color from students as a, students as b
  where a.pet = b.pet and a.song = b.song and a.time < b.time;


CREATE TABLE sevens AS
    select a.seven from students as a join numbers as b
    where a.time = b.time and a.number = 7 and b.'7' = 'True';



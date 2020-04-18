-- Here we created a relational database from each member of a cast with their id obtained
-- from another database and their movie titles.

-- Drop table if already existed.
DROP TABLE title_cast ;
DROP TABLE no_cast ;
DROP TABLE no_title ;
DROP TABLE netflix_cast_id ;
DROP TABLE table_cast_title ;

-- Create Tables.
-- In Python is already all the information that
-- would be imported here.

-- TABLE for casting.
CREATE TABLE no_cast (
	id_cast INT PRIMARY KEY,
	actor_actress TEXT
);

-- TABLE for the movie titles.
CREATE TABLE no_title (
	id_movie INT PRIMARY KEY,
	title TEXT
);

-- TABLE for the separeted cast per movie title.
CREATE TABLE title_cast (
	actor_actress TEXT,
	title TEXT
);

-- Import the information from Python.
-- Visualization.
SELECT * FROM no_cast;
SELECT * FROM no_title;
SELECT * FROM title_cast;

-- The TABLE title_cast needs a better view.
-- So we make another table to gather each actor 
-- with their respective movies.

-- Create a table with actors and their respective movie titles.
CREATE TABLE table_cast_title AS
	SELECT title_cast.actor_actress,
	STRING_AGG(ALL title,',') title 
	FROM title_cast
	GROUP BY actor_actress
	
-- Visualization
SELECT * FROM table_cast_title;

-- If we want to know info of a certain actor/actress 
-- just add the WHERE clause
SELECT * FROM table_cast_title
	 WHERE actor_actress = 'James Franco' -- Maybe try with other actor/actress.

-- Adding the relationship of each actor/actress and respective no_id.
CREATE TABLE netflix_cast_id AS
	SELECT table_cast_title.actor_actress, id_cast.id_cast, table_cast_title.title
	FROM table_cast_title 
	JOIN no_cast AS id_cast
	ON table_cast_title.actor_actress = id_cast.actor_actress

-- Set PRIMARY KEY
ALTER TABLE netflix_cast_id
ADD PRIMARY KEY (id_cast);

-- Now we have a cast table and their respective movies.
SELECT * FROM netflix_cast_id;

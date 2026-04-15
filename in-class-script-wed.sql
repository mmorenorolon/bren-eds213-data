.table

# DISTINCT
SELECT DISTINCT Location
    FROM Site
    ORDER BY Location
    LIMIT 3;

## FILTERING 
-- looks just like R or Python
SELECT * FROM Site WHERE Area < 200;
SELECT * FROM Site WHERE Area < 200 AND Latitude > 60;

-- Older-style operators
SELECT * FROM Site WHERE Code != 'iglo';
SELECT * FROM Site WHERE Code <> 'iglo'; -- older-style

-- expression: usual operators + regex functions

## EXPRESSIONS
SELECT Site_name, Area * 2.47 FROM Site;
SELECT Site_name, Area * 2.47 FROM Site AS Area_acres FROM Site;

-- string concatenation
-- old-style operator: ||
-- This adds a comma and a space between the site name and location
SELECT Site_name ||  ', ' || Location AS Full_name FROM Site;

-- new-style operator with + is not supported in all databases, but is more intuitive and easier to read

SELECT Site_name + Location AS Full_name FROM Site; -- gives an error

-- Mathematical operations can be performed 
SELECT 2 + 2;

-- adding AS needs to come right after the column you want to name
SELECT Site_name AS some_other_name FROM Site LIMIT 1;

## AGGREGATION and GROUPING

-- "How many rows are in this table?"
SELECT COUNT(*) FROM Bird_nests; -- counts all rows, including those with null values

-- How many non-null values are in a table?
SELECT COUNT(*) FROM Species;
-- This counts all non-null values in the Scientific_name column, which is the primary key and therefore cannot be null, so it gives the same result as COUNT(*)
SELECT COUNT(Scientific_name) FROM Species;

-- Count number of distinct values in a column
SELECT COUNT(DISTINCT Location) FROM Site; -- counts all distinct non-null values
SELECT COUNT(Location) FROM Site; -- counts all non-null values, including duplicates

-- reminder from Monday:
SELECT DISTINCT Location FROM Site; -- this gives us the distinct values, but not the count of them

-- Fundamental aggregation functions
SELECT AVG(Area) FROM Site;
SELECT MIN(Area) FROM Site;
SELECT MAX(Area) FROM Site;
SELECT SUM(Area) FROM Site;

-- Suppose we want to list the 7 locations (not possible)
SELECT Location, AVG(Area) FROM Site;
    --  There is a mismatch between the number of rows in the output and the number of rows in the input. We need to group by Location.
-- Corrected query:
SELECT Location, AVG(Area) FROM Site GROUP BY Location;

-- similar for counting
SELECT Location, COUNT(*) FROM Site GROUP BY Location;

-- for comparison:
-- Site |> group_by(Location) |> summarise(count = n())

-- WHERE clauses
SELECT Location, COUNT(*)
    FROM Site
    WHERE Location LIKE '%Canada' -- old-style operator for string matching, NOT full regex, just wildcard (%) 
    GROUP BY Location;

-- order of clauses reflect order of operations
-- in the case we want to filter after grouping, we need to use HAVING instead of WHERE

SELECT Location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING Max_area > 200 -- this is a filter on the output of the aggregation
    ORDER BY Max_area DESC;

## RELATIONAL ALGEBRA
-- Everything is a table
-- Every query returns a table
SELECT COUNT(*) FROM Site;

-- you cansave tables and nest queries
SELECT COUNT(*) FROM ( SELECT COUNT(*) FROM Site ); 

-- Nesting is useful for subqueries.
SELECT DISTINCT SPECIES FROM Bird_nests;
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT SPECIES FROM Bird_nests);

## NULL PROCESSING
-- NULL means the absence of a value
-- In an expression, NULL is treated as unknown, so any comparison with NULL returns NULL (not true or false)
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = 'float';

-- This won't work
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = NULL;

-- To check for NULL values, you need to use IS NULL or IS NOT NULL
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod IS NULL;

## JOINING TABLES
-- 90% of the time, we will join tables based on a foreign key relationship
SELECT * FROM Camp_assignment;
SELECT * FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation
    LIMIT 10;

-- JOIN is a general operation that can be applied to any tables, with any expression as the join condition.
-- Fundamentally, joins always start from the Cartesian product of the table.
-- CROSS JOIN is the Cartesian product of two tables, which is the set of all possible combinations of rows from the two tables.
SELECT * FROM Site CROSS JOIN Species;
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) FROM Species;
SELECT 99+16;

-- *any* condition can be an expression, including the always-true condition (which gives a CROSS JOIN)
SELECT * FROM Site JOIN Species ON 1=1; -- this is a CROSS JOIN

-- When there is a foregin key relationsip, we can use an INNER JOIN to get only the rows that match the foreign key relationship
-- The result is the same as the table with the foreign key, but with the columns from the other table added in.

SELECT * FROM Bird_nests BN JOIN Species S -- we are aliasing the tables to make the query easier to read without using AS
    ON BN.Species = S.Code
    LIMIT 5; -- LIMIT looks at the first 5 rows of the output, not the input

-- if the primary key is the same name as the foreign key, you can use USING
SELECT * FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)






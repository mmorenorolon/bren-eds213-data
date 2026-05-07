/*
Find the site name and area of the site having the largest area. 
Do so by ordering the rows in a particularly convenient order, 
and using LIMIT to select just the first row. Your result should look like:

┌──────────────┬────────┐
│  Site_name   │  Area  │
│   varchar    │ float  │
├──────────────┼────────┤
│ Coats Island │ 1239.1 │
└──────────────┴────────┘
*/

SELECT Site_name, MAX(Area) FROM Site GROUP BY Site_name;

SELECT Site_name, Area FROM Site
    ORDER BY Area DESC
    LIMIT 1;

-- Nested query
SELECT Site_name, Area 
    FROM Site 
    WHERE Area = (SELECT MAX(Area) FROM Site);
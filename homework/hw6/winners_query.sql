SELECT Name, COUNT(Egg_num) AS total_eggs
FROM Bird_eggs
JOIN Bird_nests USING (Nest_ID)
JOIN Personnel ON Personnel.Abbreviation = Bird_nests.Observer
GROUP BY Name
ORDER BY total_eggs DESC
LIMIT 3;

/* 
So the mental steps are:

Join eggs to nests using Nest_ID

After the join, each egg row now has an observer

Group by observer name

Count how many egg rows each observer has

Sort from highest to lowest

Take the top 3
*/

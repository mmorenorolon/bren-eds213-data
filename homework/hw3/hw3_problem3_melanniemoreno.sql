-- Step 1: Find the average egg volume per nest
CREATE TEMP TABLE Egg_averages AS
    SELECT Nest_ID, 
    AVG(3.14 * Width * Width * Length / 6) AS Avg_vol -- using the volume formula 
    FROM Bird_eggs
    GROUP BY Nest_ID;

-- Step 2: Find the maximum average volume of eggs per species
-- goal: Join nests to their average volumes and then collapse by species
CREATE TEMP TABLE Species_max AS
    SELECT Species AS Species_code,
    MAX(Avg_vol) AS Max_avg_vol
    FROM Bird_nests
    JOIN Egg_averages USING (Nest_ID)
    GROUP BY Species;

-- Step 3: Join to get scientific names
SELECT Scientific_name, Max_avg_vol
FROM Species_max
JOIN Species
    ON Species_max.Species_code = Species.Code
ORDER BY Max_avg_vol DESC; -- sort from largest to smallest

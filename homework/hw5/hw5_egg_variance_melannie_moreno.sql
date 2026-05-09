-- Step 1
CREATE TABLE Nests_big AS SELECT * FROM 'nests_big.csv';

CREATE TABLE Eggs_big AS SELECT * FROM 'eggs_big.csv';

-- Step 2
SELECT * FROM Eggs_big
  JOIN Nests_big USING (Nest_ID)
  JOIN Species ON Nests_big.Species = Species.Code
  WHERE Scientific_name = 'Calidris alpina';

-- Step 3
SELECT Site, (3.14 * Width * Width * Length) / 6 AS Volume
    FROM Eggs_big
    JOIN Nests_big USING (Nest_ID)
    JOIN Species ON Nests_big.Species = Species.Code
    WHERE Scientific_name = 'Calidris alpina';

-- Step 4
SELECT Site.Longitude, (3.14 * Eggs_big.Width * Eggs_big.Width * Eggs_big.Length) / 6 AS Volume
    FROM Eggs_big
    JOIN Nests_big USING (Nest_ID)
    JOIN Species ON Nests_big.Species = Species.Code
    JOIN Site ON Nests_big.Site = Site.Code
    WHERE Species.Scientific_name = 'Calidris alpina';

-- Step 5
SELECT CASE WHEN Site.Longitude > 0 
            THEN Site.Longitude - 360
            ELSE Site.Longitude 
            END AS Longitude,
        (3.14 * Eggs_big.Width * Eggs_big.Width * Eggs_big.Length) / 6 AS Volume
FROM Eggs_big
    JOIN Nests_big USING (Nest_ID)
    JOIN Species ON Nests_big.Species = Species.Code
    JOIN Site ON Nests_big.Site = Site.Code
    WHERE Species.Scientific_name = 'Calidris alpina';

-- Step 6. Save as a TEMP table
CREATE TEMP VIEW Calidris_egg_vol AS
SELECT CASE WHEN Site.Longitude > 0 THEN Site.Longitude - 360
            ELSE Site.Longitude
            END AS Longitude, 
            (3.14 * Eggs_big.Width * Eggs_big.Width * Eggs_big.Length) / 6 AS Volume
FROM Eggs_big
    JOIN Nests_big USING (Nest_ID)
    JOIN Species ON Nests_big.Species = Species.Code
    JOIN Site ON Nests_big.Site = Site.Code
    WHERE Species.Scientific_name = 'Calidris alpina';

-- Step 7

SELECT REGR_SLOPE(Volume, Longitude) AS Slope, CORR(Volume, Longitude) AS PCC
    FROM Calidris_egg_vol;


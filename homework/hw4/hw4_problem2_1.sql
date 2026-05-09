SELECT * FROM Camp_assignment A JOIN Camp_assignment B 
    ON (A.Site = B.Site) AND (A.Start = B.Start);


    --WHERE (A.Site = 'lkri') AND (A.Observer < B.Observer);
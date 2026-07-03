/* Find neighborhood with fewer than 1,000 residents, at least three distinct Airbnb
listings, and long-term rental prices greater than €20 per square meter */

SELECT DISTINCT
	lt.id ,
    pop.neighborhood,
    pop.num_residents,
    lt.price_per_sqm
FROM
    G_NeighborhoodPopulation pop,
    G_ShortTerms st1,
    G_ShortTerms st2,
    G_ShortTerms st3,
    G_LongTerms lt
WHERE

    pop.num_residents < 1000 
    
    AND st1.neighborhood = pop.neighborhood
    AND st2.neighborhood = pop.neighborhood
    AND st3.neighborhood = pop.neighborhood
	
    AND st1.id < st2.id 
    AND st2.id < st3.id
    
  
    AND lt.neighborhood = pop.neighborhood
    AND lt.price_per_sqm > 20;
/* Find long-term rental that are in a neighborhood with at least 2
metro stations and with a cost per month lower than 600. */

SELECT DISTINCT
    lt.id,
    lt.neighborhood,
    lt.price_monthly,
    lt.m2
FROM
    G_LongTerms lt,
    G_NeighborhoodInterest ni1,
    G_NeighborhoodInterest ni2
WHERE
    lt.neighborhood = ni1.neighborhood
    AND lt.neighborhood = ni2.neighborhood
    AND ni1.category = 'metro'
    AND ni2.category = 'metro'
    AND ni1.id < ni2.id
    AND lt.price_monthly < 600
ORDER BY lt.m2 desc;
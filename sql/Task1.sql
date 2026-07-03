/* Find the Airbnb listings that have a review score above 4.8 and are located in
neighborhoods that contain at least 3 distinct tourist attractions. */

SELECT DISTINCT
    st.name,
    st.price_daily,
    st.rating,
    st.neighborhood
FROM
    G_ShortTerms st,
    G_NeighborhoodInterest ni1,
    G_NeighborhoodInterest ni2,
    G_NeighborhoodInterest ni3
WHERE
    st.rating > 4.8
    AND st.neighborhood = ni1.neighborhood
    AND st.neighborhood = ni2.neighborhood
    AND st.neighborhood = ni3.neighborhood
    AND ni1.category = 'tourist attraction'
    AND ni2.category = 'tourist attraction'
    AND ni3.category = 'tourist attraction'
    
    AND ni1.id < ni2.id
    AND ni2.id < ni3.id;
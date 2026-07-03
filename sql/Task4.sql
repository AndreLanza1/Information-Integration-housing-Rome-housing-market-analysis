/* Returns for each short term rental its daily price compared with the monthly
price of the long term rental (in the same neighborhood and with the same size). */

SELECT 
    st.name, 
    st.price_daily, 
    st.size, 
    st.neighborhood, 
    lt.price_monthly
FROM 
    G_ShortTerms st
JOIN 
    G_LongTerms lt 
    ON st.size = lt.size 
    AND st.neighborhood = lt.neighborhood;
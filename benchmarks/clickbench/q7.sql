-- ClickBench Query 7: Multiple GROUP BY columns

SELECT SearchPhrase, COUNT(DISTINCT UserID) AS u 
FROM hits 
WHERE SearchPhrase != '' 
GROUP BY SearchPhrase 
ORDER BY u DESC 
LIMIT 10;

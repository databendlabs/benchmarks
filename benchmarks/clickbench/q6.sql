-- ClickBench Query 6: GROUP BY with aggregation

SELECT SearchPhrase, COUNT(*) AS c 
FROM hits 
WHERE SearchPhrase != '' 
GROUP BY SearchPhrase 
ORDER BY c DESC 
LIMIT 10;

WITH DISTINCT_MARQUEE_RULE
AS (
  SELECT DISTINCT MARQUEE_RULE.SYSTEM_TABNUM, MARQUEE_RULE.SYSTEM_TABNUM || MARQUEE_RULE.SUFFIX AS SYSTEM_TABNUM_WITH_SUFFIX, MUNICIPALITY, SYSTEM_LINEUP_TYPE FROM MARQUEE_RULE ORDER BY SYSTEM_TABNUM
)
SELECT  POSTAL_ZIP_CODE, SYSTEM_TABNUM_WITH_SUFFIX AS CHANNEL_LINEUP, group_concat(MUNICIPALITY) AS MUNICIPALITY 
FROM
(
SELECT DISTINCT MARQUEE.POSTAL_ZIP_CODE, MARQUEE.CHANNEL_LINEUP, MARQUEE.MUNICIPALITY, PROV_CODE, SYSTEM_TABNUM_WITH_SUFFIX, SYSTEM_LINEUP_TYPE
FROM  MARQUEE
    JOIN DISTINCT_MARQUEE_RULE
    ON MARQUEE.CHANNEL_LINEUP = DISTINCT_MARQUEE_RULE.SYSTEM_TABNUM
	  AND MARQUEE.MUNICIPALITY = DISTINCT_MARQUEE_RULE.MUNICIPALITY
)
/* Filter */
WHERE (PROV_CODE = "ON" AND SYSTEM_LINEUP_TYPE = "HD")
  OR (PROV_CODE <> "ON" AND SYSTEM_LINEUP_TYPE = "SD")
GROUP BY POSTAL_ZIP_CODE, SYSTEM_TABNUM_WITH_SUFFIX

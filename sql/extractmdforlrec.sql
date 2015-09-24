-- names --

SELECT distinct 'name', N.name as name_norm, '' as name FROM lremap_resource_keys K,  lremap_resource_norm N, lremap_resource R
where N.resourceid=K.resource_normid and R.resourceid=K.resourceid and R.name <> '__NOT_PROVIDED__' and R.name <> '' and R.name=N.name 
union 
SELECT distinct 'name', N.name as name_norm, R.name FROM lremap_resource_keys K,  lremap_resource_norm N, lremap_resource R
where N.resourceid=K.resource_normid and R.resourceid=K.resourceid and R.name <> '__NOT_PROVIDED__' and R.name <> '' and R.name<>N.name ;

-- type other --
SELECT 'typeother',
    COUNT(*),
    A.type,
    CASE
        WHEN B.value is NULL THEN "AP"
        ELSE "LP"
    END AS LP_AP
FROM
    lremap_resource_norm A
        LEFT OUTER JOIN
    lremap_side_table_resmetadata B ON (REPLACE(REPLACE(A.type, ' ', '_'),
        '/',
        '-') = B.value AND (B.attribute = 'type' or  A.type <> 'Not Inserted'))
WHERE
    (A.type <> '__NOT_PROVIDED__' ) and  CASE
        WHEN B.value is NULL THEN "AP"
        ELSE "LP" END ="AP" and type not like 'Not%'
        
GROUP BY type having count(*) > 4
ORDER BY 1 DESC;

-- use other --
SELECT 'useother',
    COUNT(*),
    A.resourceusage,
    CASE
        WHEN B.value is NULL THEN "AP"
        ELSE "LP"
    END AS LP_AP
FROM
    lremap_resource_norm A
        LEFT OUTER JOIN
    lremap_side_table_resmetadata B ON (REPLACE(REPLACE(A.resourceusage, ' ', '_'),
        '/',
        '-') = B.value AND (B.attribute = 'use' ))
WHERE
    (A.resourceusage <> '__NOT_PROVIDED__' or   A.resourceusage <> '') AND CASE
        WHEN B.value is NULL THEN "AP"
        ELSE "LP" END ="AP" and A.resourceusage not like 'Not%'
        
GROUP BY resourceusage
ORDER BY 2 DESC;

-- langs --
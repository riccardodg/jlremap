/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Riccardo Del Gratta &lt;riccardo.delgratta@ilc.cnr.it&gt;
 * Created: Apr 29, 2019
 */


-- sub
SELECT 
    COUNT(*), conf, year
FROM
    lremap_subs
GROUP BY conf , year
ORDER BY 1 DESC;

-- sub_norm
SELECT 
    COUNT(*), conf, year
FROM
    lremap_subs_norm
GROUP BY conf , year
ORDER BY 1 DESC;

-- keys
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_keys k,
    lremap_subs s
WHERE
    k.resourceid = s.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- keys_norm
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_keys k,
    lremap_subs_norm s
WHERE
    s.resourceid = k.resource_normid
GROUP BY conf , year
ORDER BY 1 DESC;

-- resources
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resources
GROUP BY conf , year
ORDER BY 1 DESC;

-- resources_norm
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resources_norm
GROUP BY conf , year
ORDER BY 1 DESC;

-- langs
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_langs l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- langs_norm
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_langs_norm l,
    lremap_resources_norm r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- pivoted
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_pivoted_langs l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- pivoted langs_norm
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_pivoted_langs_norm l,
    lremap_resources_norm r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- other
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_other_langs l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- other_norm
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_other_langs l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- dim
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_langs_dim l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- dim_norm
SELECT 
    COUNT(*), conf, year
FROM
    lremap_resource_langs_dim_norm l,
    lremap_resources_norm r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- authors

SELECT count(*), conf, year FROM lremap_authors l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

SELECT count(*), conf, year FROM lremap_authors_norm l,
    lremap_resources_norm r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- papers
SELECT count(*), conf, year FROM lremap_papers l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

SELECT count(*), conf, year FROM lremap_papers_norm l,
    lremap_resources_norm r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;


-- ISLRN
SELECT count(*), conf, year FROM lremap_resources_ISLRN l,
    lremap_resources r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;

-- ISLRN norm
SELECT count(*), conf, year FROM lremap_resources_ISLRN_norm l,
    lremap_resources_norm r
WHERE
    r.resourceid = l.resourceid
GROUP BY conf , year
ORDER BY 1 DESC;
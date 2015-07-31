-- langs --
SELECT
    T.ID,
    C.NAME,
    C.YEAR,
    TL.passcode,
    1,
    TL.ResourceType,
    '' asResourceType_clean,
    TL.resourceName,
    '' AS resourceName_clean,
    T.ResourceProdStatus,
    '' AS ResourceProdStatus_clean,
    TL.resourceLang,
    LT.lang_type
FROM
    RESOURCEMAP_TL TL,
    RESOURCEMAP_T T,
    RESOURCEMAP_LANGTYPE LT,
    CONFERENCES C
WHERE
    C.ID = TL.C_ID AND T.ID=TL.ID and TL.ID=LT.ID
ORDER BY 1 , 2 , 3,4,5 ASC;


--part warehouse 

SELECT w.Company,
       CONCAT('Prefix', p.PartNum) AS PartNum,
       CASE
           WHEN w.WarehouseCode IN ( 'second', 'site', 'warehouses' ) THEN
               'Site2'
           ELSE
               'MfgSys'
       END AS Plant,
       UPPER(w.WarehouseCode) AS WarehouseCode
FROM erp.partwhse w
    INNER JOIN Part p
        ON w.company = p.company
           AND w.partnum = p.partnum
WHERE w.company = 'YourCompany' -- Selecting records with Company equal to 'YourCompany'        
      AND InActive = 0 -- Selecting active parts        
      AND classID != 'YourClass' -- Excluding records with ClassID equal to 'YourClass'        
      AND TrackSerialNum = 0 -- Filtering out serial tracked parts       
      AND prodcode IN ( 'your', 'prod', 'code') -- Including specific ProdCode values     
      AND (
              (
                  RIGHT(p.PartNum, 3) IN ( 'FRN', 'MAS' )
                  AND LEFT(p.PartNum, LEN(p.PartNum) - 3)NOT LIKE '%[^0-9]%'
              )
              OR 
              (
                  RIGHT(p.PartNum, 2) = 'UP'
                  AND LEFT(p.PartNum, LEN(p.PartNum) - 2)NOT LIKE '%[^0-9]%'
              )
          ) -- Filtering out part numbers ending with 'FRN', 'MAS', or 'UP' and containing only numeric characters before these endings 

ORDER BY p.PartNum
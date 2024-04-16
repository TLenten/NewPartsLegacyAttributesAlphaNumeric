--PartCost

SELECT c.Company,
       'MfgSys' AS Plant,
       CONCAT('Prefix', c.PartNum) AS PartNum, -- Creating a new 'PartNum' by concatenating 'Prefix' with the original 'PartNum'                        
       AvgLaborCost AS AvgLbrUnitCost,
       AvgBurdenCost AS AvgBurUnitCost,
       AvgMaterialCost AS AvgMtlUnitCost,
       AvgSubContCost AS AvgSubUnitCost,
       AvgMtlBurCost AS AvgMatBurUnitCost,
       StdLaborCost AS StdLbrUnitCost,
       StdBurdenCost AS StdBurUnitCost,
       StdMaterialCost AS StdMtlUnitCost,
       StdSubContCost AS StdSubUnitCost,
       StdMtlBurCost AS StdMatBurUnitCost,
       LastLaborCost AS LastLbrUnitCost,
       LastBurdenCost AS LastBurUnitCost,
       LastMaterialCost AS LastMtlUnitCost,
       LastSubContCost AS LastSubUnitCost,
       LastMtlBurCost AS LastMatBurUnitCost,
       'Misc' AS ReasonCode,                 
       'prefix cost load' AS Reference        

FROM partcost c
    INNER JOIN part p
        ON c.company = p.company
           AND c.partnum = p.partnum

WHERE p.company = 'YourCompany'
      AND InActive = 0 -- Filtering out InActive parts      
      AND classID != 'YourClass' -- Checking if 'classID' is not 'YourClass'        
      AND TrackSerialNum = 0 -- filtering out serial tracked parts       
      AND prodcode IN ( 'Your', 'Prod', 'Codes') -- Including specific ProdCode values     
      AND (
              (
                  RIGHT(p.partnum, 3) = 'FRN'
                  AND LEFT(p.partnum, LEN(p.partnum) - 3)NOT LIKE '%[^0-9]%'
              )
              OR -- Checking for 'FRN' suffix and numeric characters before it  
              (
                  RIGHT(p.partnum, 3) = 'MAS'
                  AND LEFT(p.partnum, LEN(p.partnum) - 3)NOT LIKE '%[^0-9]%'
              )
              OR -- Checking for 'MAS' suffix and numeric characters before it  
              (
                  RIGHT(p.partnum, 2) = 'UP'
                  AND LEFT(p.partnum, LEN(p.partnum) - 2)NOT LIKE '%[^0-9]%'
              ) -- Checking for 'UP' suffix and numeric characters before it  
          )
      AND (
              AvgLaborCost != 0
              OR AvgBurdenCost != 0
              OR AvgMaterialCost != 0
              OR AvgSubContCost != 0
              OR AvgMtlBurCost != 0
              OR StdLaborCost != 0
              OR StdBurdenCost != 0
              OR StdMaterialCost != 0
              OR StdSubContCost != 0
              OR StdMtlBurCost != 0
              OR LastLaborCost != 0
              OR LastBurdenCost != 0
              OR LastMaterialCost != 0
              OR LastSubContCost != 0
              OR LastMtlBurCost != 0
          )
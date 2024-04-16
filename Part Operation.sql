--part operation
SELECT o.Company,
       'MfgSys' AS 'Plant',
       CONCAT('Prefix', o.PartNum) AS 'PartNum', -- Creating a new 'PartNum' by concatenating 'Prefix' with the original 'PartNum'                        
       'partchange' AS 'ECOGroupID',
       o.RevisionNum,
       o.OpCode,
       o.OprSeq,
       o.EstSetHours,
       o.EstProdHours,
       o.ProdStandard,
       o.StdFormat,
       o.StdBasis,
       o.OpsPerPart,
       o.QtyPer,
       o.Machines,
       o.SetUpCrewSize,
       o.ProdCrewSize,
       o.EstScrap,
       o.EstScrapType,
       o.SubContract,
       o.IUM,
       o.EstUnitCost,
       o.DaysOut,
       o.SubPartNum,
       o.VendorNum,
       o.CommentText,
       o.SchedRelation,
       LEFT(o.RunQty, 4) AS 'RunQty',
       o.LaborEntryMethod,
       o.OpDesc,
       o.WeightUOM
FROM PartOpr o
    INNER JOIN partrev r
        ON o.Company = r.Company
           AND o.PartNum = r.PartNum
           AND o.RevisionNum = r.RevisionNum
           AND o.AltMethod = r.AltMethod
    INNER JOIN part p
        ON p.Company = o.Company
           AND p.PartNum = o.PartNum
WHERE o.Company = 'YourCompany' -- Selecting records with Company equal to 'HSM'      
      AND p.InActive = 0 -- Filtering out InActive parts      
      AND classID != 'YourClass' -- Excluding records with ClassID equal to 'YourClass'      
      AND TrackSerialNum = 0 -- Filtering out serial tracked parts    
      AND prodcode IN ( 'Your', 'Prod', 'Codes') -- Including specific ProdCode values     
      AND (
              (
                  RIGHT(p.PartNum, 3) = 'FRN'
                  AND LEFT(p.PartNum, LEN(p.PartNum) - 3)NOT LIKE '%[^0-9]%'
              )
              OR -- Checking for 'FRN' suffix and numeric characters before it 
              (
                  RIGHT(p.PartNum, 3) = 'MAS'
                  AND LEFT(p.PartNum, LEN(p.PartNum) - 3)NOT LIKE '%[^0-9]%'
              )
              OR -- Checking for 'MAS' suffix and numeric characters before it 
              (
                  RIGHT(p.PartNum, 2) = 'UP'
                  AND LEFT(p.PartNum, LEN(p.PartNum) - 2)NOT LIKE '%[^0-9]%'
              ) -- Checking for 'UP' suffix and numeric characters before it 
          )
      AND r.Approved = 1
ORDER BY o.PartNum
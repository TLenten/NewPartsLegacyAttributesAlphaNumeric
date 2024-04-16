--part plant

SELECT pp.company,
       pp.plant,
       primwhse,
       CONCAT('Prefix', pp.partnum) AS PartNum,
       minimumqty,
       maximumqty,
       pp.safetyqty,
       minorderqty,
       leadtime,
       VendorNum,
       backflush,
       mfglotsize,
       MinMfgLotSize,
       MaxMfgLotSize,
       mfglotmultiple,
       DaysOfSupply,
       ReOrderLevel,
       MRPRecalcNeeded,
       ProcessMRP,
       GenerateSugg,
       TransferPlant,
       SourceType,
       TransferLeadTime,
       pp.BuyerID,
       ReceiveTime,
       PlanTimeFence,
       ReschedOutDelta,
       ReschedInDelta,
       PersonID,
       pp.CostMethod
FROM PartPlant pp
    INNER JOIN Part p
        ON pp.company = p.company
           AND pp.partnum = p.partnum
WHERE pp.company = 'YourCompany' -- Selecting records with Company equal to 'YourCompany'      
      AND p.InActive = 0 -- Selecting active parts      
      AND classID != 'YourClass' -- Excluding records with ClassID equal to 'YourClass'      
      AND TrackSerialNum = 0 -- Filtering out serial tracked parts      
      AND prodcode IN ( 'your', 'prod', 'codes') -- Including specific ProdCode values   
      AND (
              (
                  RIGHT(p.partnum, 3) IN ( 'FRN', 'MAS' )
                  AND LEFT(p.partnum, LEN(p.partnum) - 3)NOT LIKE '%[^0-9]%'
              )
              OR 
			  (
                  RIGHT(p.partnum, 2) = 'UP'
                  AND LEFT(p.partnum, LEN(p.partnum) - 2)NOT LIKE '%[^0-9]%'
              )
          ) -- Filtering out part numbers ending with 'FRN', 'MAS', or 'UP' and containing only numeric characters before these endings
ORDER BY PartNum;

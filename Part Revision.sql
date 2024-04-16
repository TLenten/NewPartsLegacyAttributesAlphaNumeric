--part rev  

SELECT r.company,
       CONCAT('Prefix', r.partnum) AS PartNum,
       r.RevisionNum,
       r.RevShortDesc,
       r.RevDescription,
       r.Approved,
       r.ApprovedBy,
       r.DrawNum,
       r.ECO,
       r.Method,
       r.AutoRecOpr,
       r.FinalOpr,
       r.EffectiveDate,
       'Prefix' AS PartAudit#ChangeDescription
FROM PartRev r
    INNER JOIN Part p
        ON r.company = p.company
           AND r.partnum = p.partnum
WHERE r.company = 'YourCompany' -- Selecting records with Company equal to 'YourCompany'     
      AND p.InActive = 0 -- Selecting active parts     
      AND p.classID != 'YourClass' -- Excluding records with ClassID equal to 'YourClass'     
      AND p.TrackSerialNum = 0 -- Selecting parts with TrackSerialNum equal to 0     
      AND prodcode IN ( 'Your', 'Prod', 'Codes') -- Including specific ProdCode values    
      AND r.Approved = 1 -- Selecting only approved revisions  
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

ORDER BY PartNum


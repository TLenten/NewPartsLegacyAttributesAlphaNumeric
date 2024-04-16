--PartMtl Children      

SELECT m.company,
       'MfgSys' as 'Plant',
       CASE
           WHEN p2.TrackSerialNum <> 1
                AND ISNUMERIC(m.partnum) = 1 THEN
               CONCAT('Prefix', m.partnum)
           ELSE
               m.partnum
       END AS 'partnum',
       m.RevisionNum,
       m.MtlSeq,
       CASE
           WHEN p.trackserialnum <> 1 THEN
               CONCAT('Prefix', m.MtlPartNum)
           ELSE
               m.Mtlpartnum
       END AS 'MtlPartNum',
       m.QtyPer,
       --, m.FixedQty        
       --, m.RelatedOperation        
       --, m.EstScrap        
       --, m.EstScrapType        
       m.PullAsAsm,
       m.ViewAsAsm,
       --, m.PlanAsASM        
       'prefix' as 'ECOGroupID',
       'prefix' as 'AuditText'

FROM PartMtl m
    INNER JOIN Part p
        ON p.company = m.company
           AND p.partnum = m.mtlpartnum --Child Parts.         
    INNER JOIN Part p2
        ON p2.company = m.company
           AND p2.partnum = m.partnum --Parent parts.         
    INNER JOIN partrev r
        ON m.company = r.company
           AND m.PartNum = r.PartNum --change this to join on mtlpart? I think this is ok to check for valid parent.         
           AND m.RevisionNum = r.RevisionNum
           AND m.AltMethod = r.AltMethod
WHERE m.company = 'YourCompany'
      AND TRY_CAST(m.mtlpartnum AS INT) IS NOT NULL --Filtering for numeric child part       
      AND p.InActive = 0 --Active Child        
      AND p2.InActive = 0 --Active Parent        
      AND p.classID != 'YourClass' --Filtering out 'YourClass'
      AND p.TrackSerialNum = 0 -- Serialized Child 
      and p.prodcode in ( 'your', 'prod', 'codes') -- Including specific ProdCode values               
      and r.Approved = 1 --Filtering for approved parent          

order by p.TrackSerialNum,
         m.PartNum
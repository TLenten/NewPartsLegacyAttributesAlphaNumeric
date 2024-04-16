--Partmtl Parents    

SELECT m.company,
       'MfgSys' as 'Plant',
       CASE
           WHEN p.TrackSerialNum <> 1 THEN
               CONCAT('Prefix', m.partnum)
           ELSE
               m.partnum
       END AS 'PartNum',
       m.revisionnum,
       'prefix' as 'ECOGroupID',
       m.MtlSeq,
       case
           when ISNUMERIC(m.MtlPartNum) = 1 then
               CONCAT('Prefix', m.mtlpartnum)
           else
               m.mtlpartnum
       end as 'MtlPartNum',
       m.QtyPer,
       --, m.FixedQty      
       --, m.RelatedOperation       
       --, m.EstScrap      
       --, m.EstScrapType      
       m.PullAsAsm,
       m.ViewAsAsm,
       --, m.PlanAsASM      
       'prefix' as 'AuditText'

FROM PartMtl m
    INNER JOIN Part p
        ON p.company = m.company
           AND p.partnum = m.partnum --Parent parts     
    INNER JOIN Part p2
        ON p2.company = m.company
           AND p2.partnum = m.mtlpartnum --Child parts    
    Inner Join partrev r
        on m.company = r.company
           and m.PartNum = r.PartNum
           and m.RevisionNum = r.RevisionNum
           and m.AltMethod = r.AltMethod
WHERE m.company = 'YourCompany'
      AND TRY_CAST(m.partnum AS INT) IS NOT NULL --Filtering for numeric parent        
      AND p.InActive = 0 --Active Parent    
      AND p2.InActive = 0 --Active Child  
      AND p.classID != 'YourClass' --Filtering out 'YourClass'
      AND p.TrackSerialNum = 0
      AND p.prodcode IN ( 'your', 'prod', 'codes') -- Including specific ProdCode values          
      AND r.Approved = 1 --Filtering for approved parent       

ORDER BY p.trackserialnum,
         Partnum,
         RevisionNum
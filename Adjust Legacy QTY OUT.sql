--PartBin Adjust Legacy Out 
SELECT b.company,
       (case
            when WarehouseCode in ( 'second', 'site', 'warehouses' ) then
                'Site2'
            else
                'MfgSys'
        END
       ) as 'Plant',
       b.PartNum,
       case
           when OnhandQty <= 0 then
               0
           Else
       (OnhandQty * -1)
       end as 'AdjustQuantity',
       WarehouseCode as 'WareHseCode',
       BinNum,
       'Misc' as 'ReasonCode',
       'prefix qty out' as 'Reference'

FROM erp.partbin b
    INNER JOIN part p
        ON p.company = b.company
           AND p.partnum = b.partnum

WHERE p.company = 'YourCompany'
      AND p.InActive = 0 -- Checking if 'InActive' is false          
      AND p.classID != 'YourClass' -- Checking if 'classID' is not 'YourClass'          
      AND p.TrackSerialNum = 0 -- Checking if 'TrackSerialNum' is 0          
      AND p.prodcode IN ( 'your', 'prod', 'codes') -- Including specific ProdCode values         
      AND p.QtyBearing = 1 -- qty bearing true
      AND p.OnHold = 0 --filtering out OnHold parts
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
order by AdjustQuantity desc
--Part    AlphaNumeric Parts

SELECT p.Company,
       CONCAT('PreFix', p.PartNum) AS PartNum, -- Combines 'HS' with the value of PartNum      
       TrackSerialNum,
       SUBSTRING(SearchWord, 1, 8) AS 'SearchWord',
       PartDescription,
       ClassID,
       IUM,
       PUM,
       TypeCode,
       NonStock,
       PurchasingFactor,
       UnitPrice,
       PricePerCode,
       InternalUnitPrice,
       InternalPricePerCode,
       ProdCode,
       MfgComment,
       PurComment,
       CostMethod,
       InActive,
       p.Method,
       PhantomBOM,
       SalesUM,
       SellingFactor,
       MtlBurRate,
       NetWeight,
       UsePartRev,
       PartsPerContainer,
       PartLength,
       PartWidth,
       PartHeight,
       LotShelfLife,
       WebPart,
       RunOut,
       Diameter,
       Gravity,
       AnalysisCode,
       GlobalPart,
       MtlAnalysisCode,
       GlobalLock,
       ISSuppUnitsFactor,
       p.PDMObjID,
       ConsolidatedPurchasing,
       PurchasingFactorDirection,
       SellingFactorDirection,
       RecDocReq,
       MDPV,
       ShipDocReq,
       ReturnableContainer,
       NetVolume,
       QtyBearing,
       UOMClassID,
       NetWeightUOM,
       NetVolumeUOM,
       BuyToOrder,
       DropShip,
       IsConfigured,
       p.ExtConfig,
       RefCategory,
       CSFCJ5,
       CSFLMW,
       GrossWeight,
       GrossWeightUOM,
       PricingUOM,
       MobilePart,
       AGUseGoodMark,
       AGProductMark,
       DEDenomination,
       PartLengthWidthHeightUM,
       Character01,
       Character02,
       Character03,
       Character04,
       Character05,
       Character06,
       Character09,
       Character10,
       Number01,
       Number02,
       Number04,
       Number08,
       CheckBox01,
       CheckBox02,
       CheckBox03,
       CheckBox04,
       CheckBox05,
       Number19,
       CheckBox06,
       CheckBox07,
       CheckBox08,
       CheckBox09,
       CheckBox17,
       CheckBox20,
       ShortChar01,
       ShortChar02,
       ShortChar03,
       ShortChar04,
       ShortChar05,
       ShortChar06,
       ShortChar07,
       ShortChar08,
       ShortChar09,
       ShortChar10,
       CheckBox10,
       CheckBox11
FROM Part p
WHERE p.company = 'YourCompany' -- Selecting records with Company equal to 'YourCompany'       
      and p.partnum != '' -- Ensuring that PartNum is not empty       
      and p.InActive = 0 -- Selecting active parts       
      and classID != 'YourClass' -- Excluding records with ClassID equal to 'YourClass'       
      and TrackSerialNum = 0 -- Selecting parts that are not serial tracked      
      and prodcode in ( 'Your', 'Prod', 'Codes') -- Including specific ProdCode values       
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
ORDER BY partnum -- Sorting the results  
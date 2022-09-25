
--Team A - Market Purchase Report

SELECT CAST(dbo.tobdt(tss.CreatedOn) as DATE) BoughtDate,pv.Id PVID,pv.Name ProductName,
count(*) ProductQTY,sum(t.costprice) Costprice
FROM thingtransaction tss
JOIN thingevent te ON tss.id = te.thingtransactionid
JOIN thing t ON t.id = te.thingid
JOIN productvariant pv on pv.id = t.productvariantid
WHERE tss.CreatedOn>= '2022-09-24 00:00:00 +06:00'
and tss.CreatedOn< '2022-09-25 00:00:00 +06:00'
AND fromstate IN (44, 45)
AND tostate IN ( 65536,268435456)
and t.CostPrice is not null
AND pv.Id in (
select ProductVariantId from ProductVariantVendorMapping where 
VendorId in (4,279,324,433,470,531,615,708,789,806,811,893,1013,1073,1142,758,871,52,138,577,822,44,1010,48,23,558,717,767,833,1015,1029,457,367,476,824,847,937,979,992,1023,1028,1030,1031,1097,1161,198,259,980,578,392,645,652,722,729,534,232,1042,881,967,344,621,622,1080,75,246,285,446,524,644,664,759,916,944,1154,580,576,636,1148,1014,238,253,356,155,692,868,911,952,982,551,1035,1041,613,216,1011,1012,1016,1017,1074,217,600,39,72,186,187,765,862,24,31,40,11,1104,131,697,173,809,964,463,562,220,29,38,92,598,640,584,599,355,10,80,1096,1075,1076,541,202,235,36,1021,812,165,180,659,983,493,1062,693,407,957,1060,1071,989,406,397,973
))
GROUP BY CAST(dbo.tobdt(tss.CreatedOn) as DATE),pv.Id, pv.Name
order by 4 desc



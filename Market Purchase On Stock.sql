select * 

from (SELECT CWS.ProductVariantId
		,pv.Name Product
		,V.Id VendorID
		,V.Name Vendor
		,SUM(CWS.Shelved+CWS.MarkedForRecall) CurrentStock,
		RequiredStock,
		(case when cws.WarehouseId = 3 then 'BN' when cws.WarehouseId = 5 then 'RB' when cws.WarehouseId = 6 then 'DL' when cws.WarehouseId = 8 then 'RP' when cws.WarehouseId = 9 then 'JT'
			when cws.WarehouseId = 14 then 'BA' when cws.WarehouseId = 15 then 'UK' when cws.WarehouseId = 18 then 'HA' when cws.WarehouseId = 41 then 'CB' when cws.WarehouseId = 21 then 'NK' 
			when cws.WarehouseId = 2 then 'KP' when cws.WarehouseId = 1 then 'UT' when cws.WarehouseId = 4 then 'MP' when cws.WarehouseId = 7 then 'HZ' when cws.WarehouseId = 11 then 'FR'
			when cws.WarehouseId = 12 then 'PT' when cws.WarehouseId = 16 then 'MM' when cws.WarehouseId = 26 then 'SP' when cws.WarehouseId = 27 then 'LM' when cws.WarehouseId = 45 then 'LB'
			when cws.WarehouseId = 22 then 'CK' when cws.WarehouseId = 23 then 'MB' when cws.WarehouseId = 24 then 'GE' when cws.WarehouseId = 25 then 'JS' when cws.WarehouseId = 37 then 'KH'
			when cws.WarehouseId = 40 then 'SY' when cws.WarehouseId = 44 then 'RJ' when cws.WarehouseId = 48 then 'GZ' when cws.WarehouseId = 34 then 'EX' else null end) [Warehouse],

			(case when cws.WarehouseId in (3,5,6,8,9,14,15,18,41,21) then 'RP' when cws.WarehouseId in (2,1,4,7,11,12,16,26,27,45) then 'HP' when cws.WarehouseId in (22,23,24) then 'CTG' 
			when cws.WarehouseId = 25 then 'JS' when cws.WarehouseId = 37 then 'KH' when cws.WarehouseId = 40 then 'SY' when cws.WarehouseId = 44 then 'RJ' when cws.WarehouseId = 48 then 'GZ' 
			when cws.WarehouseId = 34 then 'EX' else null end ) [City],

			(case when cws.WarehouseId in (3,5,6,8,9,14,15,18,41,21) then 1 when cws.WarehouseId in (2,1,4,7,11,12,16,26,27,45) then 2 when cws.WarehouseId in (22,23,24) then 3 
			when cws.WarehouseId = 25 then 4 when cws.WarehouseId = 37 then 5 when cws.WarehouseId = 40 then 6 when cws.WarehouseId = 44 then 7 when cws.WarehouseId = 48 then 8 
			when cws.WarehouseId = 34 then 9 else null end ) [Serial]

	FROM CurrentWarehouseStock cws
	JOIN Warehouse W ON W.Id = CWS.WarehouseId
	JOIN ProductVariant PV ON PV.Id = CWS.ProductVariantId
	LEFT JOIN ProductVariantVendorMapping PVVM ON PVVM.ProductVariantId = PV.ID
		AND (PVVM.WarehouseId = W.SourcesNonPerishablesFromWarehouseId
	OR PVVM.WarehouseId = W.SourcesPerishablesFromWarehouseId)
	JOIN Vendor V ON V.Id = PVVM.VendorId
	JOIN ProductVariantAvailabilityRestriction PVR ON PVR.ProductVariantId = PV.Id and pvr.WarehouseId=w.Id
	JOIN MetropolitanArea MA ON MA.Id = w.MetropolitanAreaId
	WHERE PV.Deleted = 0
	AND PVR.IsMarketPurchasable = 1
	AND V.ID IN
	(
	4,279,324,433,470,531,615,708,789,806,811,893,1013,1073,1142,758,871,52,138,577,822,44,1010,48,23,558,717,767,833,1015,1029,457,367,476,824,847,937,979,992,1023,1028,1030,1031,1097,1161,198,259,980,578,392,645,652,722,729,534,232,1042,881,967,344,621,622,1080,75,246,285,446,524,644,664,759,916,944,1154,580,576,636,1148,1014,238,253,356,155,692,868,911,952,982,551,1035,1041,613,216,1011,1012,1016,1017,1074,217,600,39,72,186,187,765,862,24,31,40,11,1104,131,697,173,809,964,463,562,220,29,38,92,598,640,584,599,355,10,80,1096,1075,1076,541,202,235,36,1021,812,165,180,659,983,493,1062,693,407,957,1060,1071,989,406,397,973
	
	)
	
	GROUP BY CWS.ProductVariantId
		,V.Id
		,MA.Name
		,V.Name 
		,pv.Name,RequiredStock,
		(case when cws.WarehouseId = 3 then 'BN' when cws.WarehouseId = 5 then 'RB' when cws.WarehouseId = 6 then 'DL' when cws.WarehouseId = 8 then 'RP' when cws.WarehouseId = 9 then 'JT'
			when cws.WarehouseId = 14 then 'BA' when cws.WarehouseId = 15 then 'UK' when cws.WarehouseId = 18 then 'HA' when cws.WarehouseId = 41 then 'CB' when cws.WarehouseId = 21 then 'NK' 
			when cws.WarehouseId = 2 then 'KP' when cws.WarehouseId = 1 then 'UT' when cws.WarehouseId = 4 then 'MP' when cws.WarehouseId = 7 then 'HZ' when cws.WarehouseId = 11 then 'FR'
			when cws.WarehouseId = 12 then 'PT' when cws.WarehouseId = 16 then 'MM' when cws.WarehouseId = 26 then 'SP' when cws.WarehouseId = 27 then 'LM' when cws.WarehouseId = 45 then 'LB'
			when cws.WarehouseId = 22 then 'CK' when cws.WarehouseId = 23 then 'MB' when cws.WarehouseId = 24 then 'GE' when cws.WarehouseId = 25 then 'JS' when cws.WarehouseId = 37 then 'KH'
			when cws.WarehouseId = 40 then 'SY' when cws.WarehouseId = 44 then 'RJ' when cws.WarehouseId = 48 then 'GZ' when cws.WarehouseId = 34 then 'EX' else null end),

			(case when cws.WarehouseId in (3,5,6,8,9,14,15,18,41,21) then 'RP' when cws.WarehouseId in (2,1,4,7,11,12,16,26,27,45) then 'HP' when cws.WarehouseId in (22,23,24) then 'CTG' 
			when cws.WarehouseId = 25 then 'JS' when cws.WarehouseId = 37 then 'KH' when cws.WarehouseId = 40 then 'SY' when cws.WarehouseId = 44 then 'RJ' when cws.WarehouseId = 48 then 'GZ' 
			when cws.WarehouseId = 34 then 'EX' else null end ),

			(case when cws.WarehouseId in (3,5,6,8,9,14,15,18,41,21) then 1 when cws.WarehouseId in (2,1,4,7,11,12,16,26,27,45) then 2 when cws.WarehouseId in (22,23,24) then 3 
			when cws.WarehouseId = 25 then 4 when cws.WarehouseId = 37 then 5 when cws.WarehouseId = 40 then 6 when cws.WarehouseId = 44 then 7 when cws.WarehouseId = 48 then 8 
			when cws.WarehouseId = 34 then 9 else null end ) 

having SUM(CWS.Shelved+CWS.MarkedForRecall)<10
)t1

where t1.Warehouse is not null

order by 1 asc
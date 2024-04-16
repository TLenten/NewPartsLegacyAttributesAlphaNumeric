This procedure intends to create new part numbers using as many part attributes from existing parts as possible to DMT back into Epicor. Changing part number is not practical or supported and most likely to result in compromised data integrity and possibly a non functional system.
Original scope was numeric only non-serial tracked parts. This expanded to a few product groups of alphanumeric parts and some serial tracked children in Bill of Materials. 
I used SSMS to extract the data and DMT to load it back into Epicor.


DMT Load order:

PART
	DMT - Part
PART PLANT
	DMT - Part Plant
PART WAREHOUSE
	DMT - Part Warehouse
PART REVISION
	DMT - Part Revision
PART COST
	DMT - Cost Adjustment
PART OPERATIONS
	DMT - Bill of Operations
PARTMTL - Two Passes
	PARTMTL - CHILDREN (MtlPartNum)
	PARTMTL - PARENTS (PartNum)
		DMT - Bill Of Materials
QUANTITY ADJUSTMENT
	Adjust QTY IN
	Adjust Legacy QTY OUT
		DMT - Quantity Adjustment

You might have other tables to consider, such as 
	CustXpart 
		DMT - Cust Part X Ref 
	PartXRefVend
		DMT - Supplier Part
	VendPBrk
		DMT - Supplier Price List
	PriceLstParts
		DMT - Price List Part
	PartSubs,
		DMT - Alternate Part
	UD Tables
		DMT - UD**

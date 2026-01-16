# DAF Praha App CHANGES  
---------------------------------------------------------------------------------------------------------------------------------------------------
## version: 
    "14.721.1.260116"
## date: 
    16.1.2026
## change by: 
    FJC 
## change:                                                                                                                
//NOTE: Credit Limit
## details: 
-	Added Credit Limit (LCY) to Customer Details Factbox
## changed objects:
[CustomerDetailsFactBox.pageextension.al]

## change:                                                                                                                
//NOTE: Update Document Status 
## details: 
-	Change Document Status Code to 'ZARUKA ODESLANA' when updated field TEXT 6 (Warranty Claim No.)
## changed objects:
[CodeManagementSubscriber.codeunit.al]
## change:                                                                                                                
//NOTE: Target Price  
## details: 
-	Added Target Price to Service Scheduling Order
## changed objects:
[ServiceSchedulingOrderExtPageExt.al]
## change:                                                                                                                
//NOTE: VAT Reg. No.  
## details: 
-	Added VAT Reg. No. to Parts Purchase Credit Memo and Parts Purchase Invoice
## changed objects:
[DPGPartsPurchCrMemoExt.pageextension.al]
[PartsPurchaseInvExtPageExt.al]
---------------------------------------------------------------------------------------------------------------------------------------------------
## version: 
    "14.721.1.251119"
## date: 
    19.11.2025
## change by: 
    FJC 
## change:                                                                                                                
//NOTE: CRM report   
## details: 
-	report for CRM to see the combination of To-Do, Interaction and Vehicle Sales Quote. from Maarten
## changed objects:
[CVM_Report_VehicleSalesCRMoverview.al](src\report\CVM_Report_VehicleSalesCRMoverview.al),
[CVM_Layout_VehicleSalesCRMoverview.rdlc](src\report\CVM_Layout_VehicleSalesCRMoverview.rdl),

## change:
 //NOTE: Purchase Receipt VAT Change 
## details: 
-	Function ‘PurchaseReceiptChangeVAT’ you can use to send a purchase invoice no (posted) to change the receipt and item ledger entry
-	Function ‘PurchaseReceiptChangeVATInvoiceSelect’ is a function where you can fill in the DAF vendor no and the amount of days back. The function will look for all purchase invoices and process them 
## changed objects:
[CodeUnitFunctions.al](src\codeunit\CodeUnitFunctions.al)
[JobBatch.al](src\codeunit\JobBatch.al)   

--------------------------------------------------------------------------------------------------------------------------------------------------   
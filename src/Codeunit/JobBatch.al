codeunit 80007 "DAF_JobBatch"
{
    trigger OnRun()
    begin
        IF JobMgntG.ParamIsJob(JobLineG, IsTestG) THEN BEGIN
            ProtocolTypeG := JobLineG."Protocol Type";
            JobMgntG.ParamFill(JobLineG, IsTestG);

            CASE JobLineG."Code 1" OF
                /*'COMPANYCUSTOMERSYNCH':
                    CU_CVM_Functions.CompanyCustomerSynchronize('');
                'COMPANYVENDORSYNCH':
                    CU_CVM_Functions.CompanyVendorSynchronize('');
                'EDOCCUSTNOMAIL':
                    CU_CVM_Functions.eDoc_Customer_NoMailAddress(JobLineG."Text 1");
                'EDOCCUSTREPORTSELECT':
                    CU_CVM_Functions.eDoc_Customer_CustomReportSelection(JobLineG."Text 1");
                'DELETEPURCHASEORDER':
                    CU_CVM_Functions.DeletePurchaseOrder();
                'DELETEPARTSSALESORDE':
                    CU_CVM_Functions.DeletePartsSalesOrder();
                'ARCHIVESALESQUOTE':
                    CU_CVM_Functions.ArchiveSalesQuote();
                'DELETEPARTSSALESRETU':
                    CU_CVM_Functions.DeletePartsSalesReturnOrder();
                'DELETESERVICEORDER':
                    CU_CVM_Functions.DeleteServiceOrder(JobLineG.Bool);
                'ARCHIVESERVICEQUOTE':
                    CU_CVM_Functions.ArchiveServiceQuote();
                'MAILINTERNALINVOICES':
                    CU_CVM_Functions.MailInternalInvoiceOverview(JobLineG."Text 1", JobLineG."Int 1", JobLineG."Text 2");
                'MAILPARTSSALESSHIPM':
                    CU_CVM_Functions.MailPartsSalesShipment(JobLineG."Code 2", JobLineG."Text 1", JobLineG.Bool);
                'MAILPARTSZEROSTOCK':
                    CU_CVM_Functions.MailPartsZeroStockWithMutation(JobLineG."Text 1", JobLineG."Code 2", JobLineG."Int 1");
                'MAILSTOCKEMPTYBIN':
                    CU_CVM_Functions.MailItemStockEmptyBIN(JobLineG."Text 1", JobLineG."Code 2");
                'RMCITMESALESPRICECAL':
                    CU_CVM_Functions.RMCItemSalesPriceCalculation(JobLineG."Code 2");
                'SERVDISABLEREQUISIT':
                    CU_CVM_Functions.ServiceOrderDisableForRequisition(JobLineG."Text 1", JobLineG."Code 2");
                'PURCHQTYDISCCLEAN':
                    CU_CVM_Functions.ItemPurchQtyDiscountClean(JobLineG."Code 2", JobLineG.Bool);
                'SETWARRANTYCLAIMCOMP':
                    CU_CVM_Functions.SetWarrantyClaimCompleted();
                'SERVICEREPAIRBOOKNO':
                    CU_CVM_Functions.ServiceorderRepairBookNo('');
                'SERVICEREPAIRINTCUST':
                    CU_CVM_Functions.ServiceOrderInternalInvoiceCustomerRepairLines();
                'VENDORRECEIPTRATING':
                    CU_CVM_Functions.VendorReceiptRatingToDo(JobLineG."Text 1", JobLineG."Text 2", JobLineG."Code 2", JobLineG."Int 1");
                'OWNOPTIONSFROMPACKAG':
                    CU_CVM_Functions.OwnOptionsFromPackages(JobLineG.Bool, JobLineG."Bool 2", '', 0);
                'FIXSCLES':
                    CU_CVM_Functions.FixWrongRMCServContrLedgerEntrySurcharges();
                'DAFTOPECORDERNO':
                    CU_CVM_Functions.DAFTopecFactoryOrderNoRepair();
                'DAFEORDERPURCHLNK':
                    CU_CVM_Functions.DAFeOrderConfirmationOrderLink();
                'ITEMBINCLEAN':
                    CU_CVM_Functions.ItemBinClean();
                'VEHICLEARCHIVE':
                    CU_CVM_Functions.VehicleArchive();
                'ITEMSALPRICEFROMMAST':
                    CU_CVM_Functions.ItemSalesPriceFromMaster(JobLineG."Code 2", JobLineG."Text 1", JobLineG.Bool, JobLineG."Int 1");
                'REQSTATUSSPECIALPRIC':
                    CU_CVM_Functions.RequisitionStatusSpecialPrice(JobLineG."Code 2", JobLineG."Text 1");
                'WARCUSSAT':
                    CU_CVM_Functions.WarrantyCustomerSatisfactionTask(JobLineG."Code 2", JobLineG."Text 1", JobLineG."Text 2", JobLineG."Int 1");
                'MASTERUOMADJUST':
                    CU_CVM_Functions.ItemMasterUOMadjust(JobLineG."Code 2", JobLineG."Text 1");
                'MAILDAFCOGSERROR':
                    CU_CVM_Functions.MailDAFCOGSError(JobLineG."Text 1", JobLineG."Text 2", JobLineG."Int 1");
                'MAILJOBBATCHERRORS':
                    CU_CVM_Functions.MailJobBatchEntryErrors(JobLineG."Code 2", JobLineG."Text 1", JobLineG."Int 1", JobLineG."Text 2");*/
                //NOTE: Start Purchase Receipt VAT Change 
                'VATRECEIPTCHANGE':
                    CU_CVM_Functions.PurchaseReceiptChangeVATInvoiceSelect(JobLineG."Text 1", JobLineG."Int 1");
            //NOTE: Stop Purchase Receipt VAT Change 
            END;
        end;
    end;

    var
        JobMgntG: Codeunit "Job Management";
        JobLineG: Record "Job Batch Line";
        IsTestG: Boolean;
        ProtocolTypeG: Option;
        // CU_ReportPackage: Codeunit "CVM_ReportPackage";
        CU_CVM_Functions: Codeunit "DAF CodeUnit Functions";
}

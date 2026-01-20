codeunit 80006 "DAF CodeUnit Functions"
{

    //NOTE: Start Purchase Receipt VAT Change 
    //Function ‘PurchaseReceiptChangeVATInvoiceSelect’ is a function where you can fill in the DAF vendor no and the amount of days back. The function will look for all purchase invoices and process them 
    procedure PurchaseReceiptChangeVATInvoiceSelect(VendorNo: Text; AmountDaysBack: Integer)
    var
        G_PurchInvoiceHeader: Record "Purch. Invoice Header";
        G_PurchInvoiceLine: Record "Purch. Invoice Line";
    begin
        G_PurchInvoiceHeader.RESET;
        G_PurchInvoiceHeader.SETRANGE("Pay-to Vendor No.", VendorNo);
        G_PurchInvoiceHeader.SETFILTER("Posting Date", '>=%1', CALCDATE('<-' + FORMAT(AmountDaysBack) + 'D>', WORKDATE));
        IF G_PurchInvoiceHeader.FINDSET THEN begin
            repeat
                PurchaseReceiptChangeVAT(G_PurchInvoiceHeader."No.");
            until G_PurchInvoiceHeader.Next = 0;
        end;
    end;

    //Function ‘PurchaseReceiptChangeVAT’ you can use to send a purchase invoice no (posted) to change the receipt and item ledger entry
    procedure PurchaseReceiptChangeVAT(InvoiceNo: Text)
    var
        TEMP_Receipts: Record "Temporary Statistics" temporary;
        TEMP_DocumentNo: Text;
        L_VATPostingSetup: Record "VAT Posting Setup";
        G_PurchInvoiceHeader: Record "Purch. Invoice Header";
        G_PurchInvoiceLine: Record "Purch. Invoice Line";
        G_ValueEntry: Record "Value Entry";
        G_ItemLedgerEntry: Record "Item Ledger Entry";
        G_PurchReceiptHeader: Record "Purch. Receipt Header";
        G_PurchReceiptLine: Record "Purch. Receipt Line";

    begin
        IF G_PurchInvoiceHeader.GET(InvoiceNo) THEN begin

            G_PurchInvoiceLine.RESET;
            G_PurchInvoiceLine.SETRANGE("Document No.", G_PurchInvoiceHeader."No.");
            G_PurchInvoiceLine.SETRANGE("Type", G_PurchInvoiceLine."Type"::"Item");
            IF G_PurchInvoiceLine.FINDSET THEN begin
                repeat
                    G_ValueEntry.RESET;
                    G_ValueEntry.SETRANGE("Document No.", G_PurchInvoiceLine."Document No.");
                    G_ValueEntry.SETRANGE("Document Line No.", G_PurchInvoiceLine."Line No.");
                    G_ValueEntry.SETFILTER("Item Ledger Entry No.", '<>%1', 0);
                    IF G_ValueEntry.FINDFIRST THEN begin
                        IF G_ItemLedgerEntry.GET(G_ValueEntry."Item Ledger Entry No.") THEN begin
                            TEMP_Receipts.RESET;
                            TEMP_Receipts.SETRANGE("Entry No.", G_ItemLedgerEntry."Entry No.");
                            IF NOT TEMP_Receipts.FINDSET THEN begin
                                TEMP_Receipts.INIT;
                                TEMP_Receipts."Entry No." := G_ItemLedgerEntry."Entry No.";
                                TEMP_Receipts."Code 01" := G_ItemLedgerEntry."Document No.";
                                TEMP_Receipts."Code 02" := G_ItemLedgerEntry."Country Code";
                                TEMP_Receipts.INSERT(FALSE);
                            end;
                        end;
                    end;
                until G_PurchInvoiceLine.Next = 0;
            end;

            TEMP_DocumentNo := '';
            TEMP_Receipts.RESET;
            TEMP_Receipts.SETCURRENTKEY("Code 01");
            IF TEMP_Receipts.FINDSET THEN begin
                repeat
                    IF (TEMP_DocumentNo <> TEMP_Receipts."Code 01") THEN begin
                        IF G_PurchReceiptHeader.GET(TEMP_Receipts."Code 01") THEN begin
                            IF (G_PurchReceiptHeader."VAT Registration No." <> G_PurchInvoiceHeader."VAT Registration No.") OR (G_PurchReceiptHeader."VAT Bus. Posting Group" <> G_PurchInvoiceHeader."VAT Bus. Posting Group") OR (G_PurchReceiptHeader."VAT Country Code" <> G_PurchInvoiceHeader."VAT Country Code") THEN begin

                                G_PurchReceiptLine.RESET;
                                G_PurchReceiptLine.SETRANGE("Document No.", G_PurchReceiptHeader."No.");
                                IF G_PurchReceiptLine.FINDSET THEN begin
                                    repeat
                                        IF L_VATPostingSetup.GET(G_PurchInvoiceHeader."VAT Bus. Posting Group", G_PurchReceiptLine."VAT Prod. Posting Group") THEN begin
                                            G_PurchReceiptLine.Validate("VAT Calculation Type", L_VATPostingSetup."VAT Calculation Type");
                                        end;
                                        G_PurchReceiptLine.Validate("VAT Bus. Posting Group", G_PurchInvoiceHeader."VAT Bus. Posting Group");
                                        G_PurchReceiptLine.Modify(TRUE);
                                    until G_PurchReceiptLine.Next = 0;
                                end;

                                G_PurchReceiptHeader."VAT Registration No." := G_PurchInvoiceHeader."VAT Registration No.";
                                G_PurchReceiptHeader."VAT Bus. Posting Group" := G_PurchInvoiceHeader."VAT Bus. Posting Group";
                                G_PurchReceiptHeader."VAT Country Code" := G_PurchInvoiceHeader."VAT Country Code";
                                G_PurchReceiptHeader.MODIFY(FALSE);
                            end;
                        end;
                    end;

                    IF (TEMP_Receipts."Code 01" <> G_PurchInvoiceHeader."VAT Country Code") THEN begin
                        G_ItemLedgerEntry.RESET;
                        IF G_ItemLedgerEntry.GET(TEMP_Receipts."Entry No.") THEN begin
                            G_ItemLedgerEntry."Country Code" := G_PurchInvoiceHeader."VAT Country Code";
                            G_ItemLedgerEntry.MODIFY(FALSE);
                        end;
                    end;

                    TEMP_DocumentNo := TEMP_Receipts."Code 01";
                until TEMP_Receipts.Next = 0;
            end;
        end;
    end;

    //NOTE: Send Service Preview by e-mail start

    procedure PrintServPreviewToPDF(ServHdrP: Record "Service Header"): Text
    var
        ServReportSelectionL: Record "Service Manag. Rep. Selection";
        FileManagement: Codeunit "File Management";
        FilePath: Text;
        FileName: Text;
        TempFileName: Text;
        GeneratedFiles: Text; // Delimited list of file paths
    begin
        ServHdrP.SETRANGE("No.", ServHdrP."No.");
        ServReportSelectionL.SETRANGE(Usage, ServReportSelectionL.Usage::"Service Preview");
        ServReportSelectionL.GetReportSelection(ServReportSelectionL, ServHdrP."Make Code", ServHdrP."Location Code");
        ServReportSelectionL.FINDSET;

        FilePath := 'C:\Temp\'; // Or configurable path

        GeneratedFiles := '';

        REPEAT
            FileName := StrSubstNo('ServicePreview_%1_%2.pdf', ServHdrP."No.", Format(Today(), 0, '<Year4><Month,2><Day,2>'));
            TempFileName := FilePath + FileName;

            REPORT.SaveAsPDF(ServReportSelectionL."Report ID", TempFileName, ServHdrP);

            IF FileManagement.ServerFileExists(TempFileName) THEN BEGIN
                IF GeneratedFiles <> '' THEN
                    GeneratedFiles += '|'; // delimiter
                GeneratedFiles += TempFileName;
            END;
        UNTIL ServReportSelectionL.NEXT = 0;

        EXIT(GeneratedFiles);
    end;
    //NOTE: Send Service Preview by e-mail stop

    procedure GetLabel(LabelID: Text) LabelDescription: Text;
    var
        lbl_DocumentTypeDescriptionInvoice: Label 'Invoice';
        lbl_DocumentTypeDescriptionCreditMemo: Label 'Credit Memo';
        lbl_DocumentTypeDescriptionProforma: Label 'Proforma';
        lbl_DocumentTypeDescriptionConfirmation: Label 'Confirmation';
        lbl_DocumentTypeDescriptionQuote: Label 'Quote';
        lbl_DocumentTypeDescriptionServiceinvoice: Label 'Service invoice';
        lbl_DocumentTypeDescriptionPurchaseinvoice: Label 'Purchase invoice';
        lbl_DocumentTypeDescriptionPurchaseorder: Label 'Purchase order';
        lbl_DocumentTypeDescriptionServiceorder: Label 'Service order';
        lbl_DocumentTypeDescriptionPurchasereturnorder: Label 'Purchase returnorder';
        lbl_DocumentTypeDescriptionShipment: Label 'Packing slip';
        lbl_DocumentTypeDescriptionReturnShipment: Label 'Return packing slip';
        lbl_DocumentTypeDescriptionChargeItem: Label 'Charge item';
        lbl_PaymentRemark: Label 'Please state customer and invoice number when paying.';
        lbl_ShowGrossUnitPrice: Label 'NB: Fixed price, gross price entered in description.';
        lbl_GrossUnitPrice: Label 'Gross price';
        lbl_PaymentTermsVehicleSales: Label 'Payment in accordance with the order confirmation.';
        lbl_PriceNote: Label 'Prices subject to availability, board approval and financing acceptance.';
        lbl_PaymentConditionDAFSGate: Label 'Pay this invoice to PACCAR Parts Fleet Services IBAN: DE72 5001 0900 0018 0680 13 BIC: BOFADEFX';
        lbl_PaymentConditionIncasso: Label 'This invoice is debited from your account by means of a direct debit';
        lbl_VATIntraCommunity: Label 'Intra-Community supply of goods, VAT reverse charge (art. 138, 1, VAT Directive 2006/112)';
        lbl_PrepaymentVehicle: Label 'Prepayment regarding your vehicle sales order';
        lbl_ExchangepartsReturnRemark: Label 'To ensure that the crediting of exchanged parts runs smoothly, you must return the parts in the original packaging, clean, free of (leaking) oil/liquids and with this returnable deposit slip.';
        lbl_ItemReturnRemark: Label 'To ensure that the crediting of return and exchange parts runs smoothly, you must return the parts in the original packaging, clean and with a copy of the packing slip.';
        lbl_OrderApproval: Label 'Order approval';
        lbl_ConfirmationLine1: Label 'If you agree with this quote and want to proceed with delivery, please sign this page.';
        lbl_ConfirmationLine2: Label 'By signing you agree to the attached specification, delivery and payment conditions, quotation and you definitively confirm the delivery order.';
        lbl_ConfirmationSignedForAgreement: Label 'Signed for agreement';
        lbl_ConfirmationAuthorizedToSign: Label 'Authorized to sign on behalf of';
        lbl_ServiceOrderDeliveryTerms: Label 'The order was placed subject to acceptance of the general delivery terms.';
        lbl_others: Label 'Others';
        lbl_surcharge: Label 'Surcharge';
        lbl_Location: Label 'Location';
        lbl_BookNo: Label 'Book Number';
        lbl_VIN: Label 'VIN';
        lbl_LicenseNo: Label 'License No.';
        lbl_Fleetnumber: Label 'Fleetnumber';
        lbl_TradeIn: Label 'TradeIn';
        lbl_Prepayment: Label 'Prepayment';
        lbl_CashpaymentDescription: Label 'Cashpayment';
        lbl_Make: Label 'Make';
        lbl_Model: Label 'Model';
        lbl_Configuration: Label 'Configuration';
        lbl_TransmissionType: Label 'Transmission Type';
        lbl_EngineType: Label 'Engine Type';
        lbl_EngineNumber: Label 'Engine Number';
        lbl_Interval: Label 'Interval';
        lbl_InitialRegistration: Label 'Initial registration date';
        lbl_VehicleDeliveryDate: Label 'Delivery date';
        lbl_Mileage: Label 'Mileage';
        lbl_RunningTime: Label 'Runningtime';
        lbl_Number: Label 'number';
        lbl_Date: Label 'date';
        lbl_ValidFromDate: Label 'Valid from date';
        lbl_ValidToDate: Label 'Valid to date';
        lbl_OrderNumber: Label 'Ordernumber';
        lbl_OrderDate: Label 'Orderdate';
        lbl_ExpectedReceiptDate: Label 'Expected receiptdate';
        lbl_Name: Label 'Name';
        lbl_Signature: Label 'Signature';
        lbl_ConcernsOurCustomer: Label 'Concerns our customer';
        lbl_OrderCustomer: Label 'Order customer';
        lbl_CustomerNo: Label 'Customer No.';
        lbl_Customer: Label 'Customer';
        lbl_VendorNo: Label 'Vendor No.';
        lbl_VendorName: Label 'Vendor Name';
        lbl_Salesperson: Label 'Salesperson';
        lbl_VATnumber: Label 'VAT number';
        lbl_YourContactPerson: Label 'Your contact person';
        lbl_MailAddress: Label 'E-mail address';
        lbl_PhoneNumber: Label 'Phone number';
        lbl_InvoiceAddress: Label 'Invoice address';
        lbl_ShipmentAddress: Label 'Shipment address';
        lbl_DueDate: Label 'Due date';
        lbl_POnumber: Label 'PO number';
        lbl_CustomerReference: Label 'Customer reference';
        lbl_YourReference: Label 'Your reference';
        lbl_SettlementNo: Label 'Credit regarding invoice';
        lbl_Header_IBAN: Label 'IBAN';
        lbl_Header_BIC: Label 'BIC';
        lbl_Header_VAT: Label 'VAT';
        lbl_Header_COC: Label 'COC';
        lbl_Header_Phone: Label 'Phone';
        lbl_Header_Mail: Label 'E-mail';
        lbl_VAT: Label 'VAT';
        lbl_ExchangeVAT: Label 'Exchange VAT';
        lbl_Subtotal: Label 'Subtotal';
        lbl_Total: Label 'Total';
        lbl_TotalToPay: Label 'Total, including VAT';
        lbl_TotalToReceive: Label 'Total, including VAT';
        lbl_Exclusive: Label 'Exclusive';
        lbl_VATover: Label 'from';
        lbl_Line_Type: Label 'Line Type';
        lbl_Line_No: Label 'Line No.';
        lbl_Line_Code: Label 'Code';
        lbl_Line_Description: Label 'Description';
        lbl_Line_Quantity: Label 'Quantity';
        lbl_Line_Amount: Label 'Amount';
        lbl_Line_TotalAmount: Label 'Total amount';
        lbl_UnitPriceHour: Label 'Hour unit price';
        lbl_FixedPrice: Label 'Fixed price';
        lbl_Discount: Label 'Discount';
        lbl_LaborAnalyse_ErrorNoLaborPriceGroup: Label 'No existing Labor Price Group';
        lbl_LaborAnalyse_ErrorNoLaborChargingCode: Label 'No existing Labor Charging Code';
        lbl_LaborAnalyse_ErrorNoChargingGroup: Label 'No existing Charging Group';
        lbl_LaborAnalyse_ErrorMissingCombination: Label 'Missing combination';
        lbl_ErrorDescription: Label 'Error Description';
        lbl_ChargingGroup: Label 'Charging Group';
        lbl_LaborChargingCode: Label 'Labor Charging Code';
        lbl_LaborPriceGroup: Label 'Labor Price Group';
        lbl_LaborPriceGroupDescription: Label 'Labor Price Group Description';
        lbl_RMC_Confirmation: Label 'Contract';
        lbl_RMC_Undersigned: Label 'Undersigned';
        lbl_RMC_Customer: Label 'Customer';
        lbl_RMC_Dealer: Label 'Dealer';
        lbl_RMC_ContractConditions: Label 'Declare to have concluded a repair and maintenance contract for the vehicle below on the basis of the conditions agreeds below and in the general terms and conditions.';
        lbl_RMC_QuoteConditions: Label 'Validity of quotation up to one month after calculation date';
        lbl_RMC_ContractInformation: Label 'Contract information';
        lbl_RMC_ContractNo: Label 'Contract No.';
        lbl_RMC_QuoteNo: Label 'Quote No.';
        lbl_RMC_Description: Label 'Description';
        lbl_RMC_Description2: Label 'Description 2';
        lbl_RMC_StartingDate: Label 'Starting Date';
        lbl_RMC_LatestStartingDate: Label 'Latest Starting Date';
        lbl_RMC_EndingDate: Label 'Ending Date';
        lbl_RMC_MoreMileage: Label 'More mileage';
        lbl_RMC_LessMileage: Label 'Less mileage';
        lbl_RMC_MileagePerYear: Label 'Mileage per year';
        lbl_RMC_StartingMileage: Label 'Starting mileage';
        lbl_RMC_EndMileageCalculated: Label 'Ending mileage';
        lbl_RMC_DurationMonths: Label 'Duration';
        lbl_RMC_Months: Label 'months';
        lbl_RMC_VehicleInformation: Label 'Vehicle information';
        lbl_RMC_VehicleQuantity: Label 'Number of vehicles';
        lbl_RMC_VehicleDeployment: Label 'Vehicle deployment';
        lbl_RMC_GeographicStake: Label 'Geographic stake';
        lbl_RMC_UsageType: Label 'Usage type';
        lbl_RMC_Application: Label 'Application';
        lbl_RMC_RoadType: Label 'Road type';
        lbl_RMC_DeliveryPerDay: Label 'DeliveryPerDay';
        lbl_RMC_PTOHoursPerDay: Label 'PTO hours per day';
        lbl_RMC_OilEngine: Label 'Engine oil';
        lbl_RMC_OilGearbox: Label 'Gearbox oil';
        lbl_RMC_OilDifferential: Label 'Differential oil';
        lbl_RMC_FinancialInformation: Label 'Financial information';
        lbl_RMC_MileageRate: Label 'Mileage rate';
        lbl_RMC_IndexPeriod: Label 'Index period';
        lbl_RMC_Basic: Label 'Basic';
        lbl_RMC_Ratios: Label 'Ratios';
        lbl_RMC_Wages: Label 'Wages';
        lbl_RMC_Components: Label 'Components';
        lbl_RMC_Oil: Label 'Oil';
        lbl_RMC_InstallmentAmount: Label 'Installment amount';
        lbl_RMC_InvoiceFrequency: Label 'Invoice frequency';
        lbl_RMC_AdditionalConditions: Label 'Additional conditions';
        lbl_RMC_Covered: Label 'Covered';
        lbl_RMC_Excluded: Label 'Excluded';
        lbl_RMC_Signatures: Label 'Signatures';
        lbl_RMC_PricesExclVAT: Label 'Mentioned prices are exclusive of VAT.';
        lbl_RMC_OnBehalfOfCustomer: Label 'On behalf of the customer';
        lbl_RMC_OnBehalfOfDealer: Label 'On behalf of the dealer';
        lbl_RMC_By: Label 'By';
        lbl_RMC_Signature: Label 'Signature';
        lbl_RMC_MainContract: Label 'Main contract';
        lbl_RMC_MainContractYes: Label 'Yes';
        lbl_RMC_MainContractNo: Label 'No, subcontract of contract no.';
        lbl_Order2Cash_RouteCode: Label 'Route code';
        lbl_Order2Cash_JobCode: Label 'Job code';
        lbl_Order2Cash_DamageNo: Label 'Damage no.';
        lbl_ShipmentNumber: Label 'Shipmentnumber';
        lbl_ShipmentMethod: Label 'Shipment method';
        lbl_DeliveryDate: Label 'Delivery date';
        lbl_BIN: Label 'BIN';
        lbl_Line_QuantityBackorder: Label 'Quantity backorder';
        lbl_Line_Ordered: Label 'Quantity ordered';
        lbl_Line_QuantityPurchased: Label 'Quantity purchased';
        lbl_Line_QuantityStock: Label 'Quantity stock';
        lbl_Line_TotalQuantityStock: Label 'Total quantity stock';
        lbl_Line_QuantityToReturn: Label 'Quantity to return';
        lbl_EntryNo: Label 'Entry No.';
        lbl_Line_NetAmount: Label 'Net amount';
        lbl_ExchangepartsReturnDocument: Label 'Exchangepart return document';
        lbl_IntakeBy: Label 'Intake by';
        lbl_IntakeDate: Label 'Intake date';
        lbl_IntakeTitle: Label 'To be completed below when taken by an employee of';
        lbl_QualityCheck: Label 'Quality check';
        lbl_QualityCheckOk: Label 'Ok';
        lbl_QualityCheckDamage: Label 'Damaged';
        lbl_QualityCheckDisapproval: Label 'Disapproved';
        lbl_ReturnPeriod: Label 'Return period';
        lbl_page: Label 'page';
        lbl_Counted: Label 'Counted';
        lbl_ToDo: Label 'To Do';
        lbl_LastInventory: Label 'Last inventory';
        lbl_Item: Label 'Item';
        lbl_YearAbbreviation: Label 'Y';
        lbl_QuarterAbbreviation: Label 'Q';
        lbl_MonthAbbreviation: Label 'M';
        lbl_DayAbbreviation: Label 'D';
        lbl_Purchase_IndicatingNumber: Label 'Indicating purchase number';
        lbl_Purchase_SendDigitally: Label 'Please send a separate invoice per purchase number and address digitally to';
        lbl_DocumentType: Label 'Document type';
        lbl_DocumentDate: Label 'Document date';
        lbl_PickList: Label 'Picklist';
        lbl_UOM: Label 'Unit of Measure';
        lbl_QuantityDelivered: Label 'Qauntity delivered';
        lbl_QuantityToPick: Label 'Quantity to pick';
        lbl_PrintDate: Label 'Print date';
        lbl_UnitCost: Label 'Unit cost';
        lbl_AmountNotInvoiced: Label 'Amount not invoiced';
        lbl_QuantityAbbreviation: Label 'Q';
        lbl_ReceivedAbbreviation: Label 'R';
        lbl_InvoicedAbbreviation: Label 'I';
        lbl_InvoiceCustomer: Label 'Invoice customer';
        lbl_Planning: Label 'Planning';
        lbl_From: Label 'From';
        lbl_To: Label 'To';
        lbl_Vehicle: Label 'Vehicle';
        lbl_AxleType: Label 'Axle type';
        lbl_MileageWriteDown: Label 'Mileage & running hours notation';
        lbl_VehicleAppointments: Label 'Vehicle appointments';
        lbl_MOT: Label 'MOT';
        lbl_Tacho: Label 'Tachograph';
        lbl_Warranty: Label 'Warranty';
        lbl_OEMRandM: Label 'OEM R&M';
        lbl_DealerRandM: Label 'Dealer R&M';
        lbl_Complaint: Label 'Complaint';
        lbl_Instruction: Label 'Instruction';
        lbl_Package: Label 'Package';
        lbl_Payer: Label 'Payer';
        lbl_SignatureCustomer: Label 'Signature customer';
        lbl_SignatureChief: Label 'Signature chief';
        lbl_Hours: Label 'Hours';
        lbl_RepeatRepair: Label 'Repeat repair';
        lbl_Fluids: Label 'Fluids';
        lbl_Mechanic: Label 'Mechanic';
        lbl_Warehouse: Label 'Warehouse';
        lbl_WorkshopChief: Label 'Workshop chief';
        lbl_TestcomputerUsage: Label 'Testcomputer usage';
        lbl_PartsReturned: Label 'Parts returned';
        lbl_FinalInspection: Label 'Final inspection';
        lbl_CabinTiltWarning: Label 'The cabin can be tilted';
        lbl_RequisitionStatus: Label 'Requisition status';
        lbl_ItemNumber: Label 'Part number';
        lbl_Turnover: Label 'Turnover';
        lbl_TurnoverYear: Label 'Turnover year';
        lbl_VendorInvoiceNo: Label 'Vendor Invoice No.';
        lbl_VendorOrderNo: Label 'Vendor Order No.';
        lbl_OriginalDocumentNo: Label 'Original document no.';
        lbl_OriginalDocumentLineNo: Label 'Original document line no.';
        lbl_CockpitDocument: Label 'Cockpit document';
        lbl_StartingNo: Label 'Starting no.';
        lbl_EndingNo: Label 'Ending no.';
        lbl_LastNoUsed: Label 'Last no. used';
        lbl_LastDateUsed: Label 'Last date used';
    begin
        CASE LabelID OF
            'lbl_DocumentTypeDescriptionInvoice':
                Exit(lbl_DocumentTypeDescriptionInvoice);
            'lbl_DocumentTypeDescriptionCreditMemo':
                Exit(lbl_DocumentTypeDescriptionCreditMemo);
            'lbl_DocumentTypeDescriptionProforma':
                Exit(lbl_DocumentTypeDescriptionProforma);
            'lbl_DocumentTypeDescriptionConfirmation':
                Exit(lbl_DocumentTypeDescriptionConfirmation);
            'lbl_DocumentTypeDescriptionQuote':
                Exit(lbl_DocumentTypeDescriptionQuote);
            'lbl_DocumentTypeDescriptionServiceinvoice':
                Exit(lbl_DocumentTypeDescriptionServiceinvoice);
            'lbl_DocumentTypeDescriptionPurchaseinvoice':
                Exit(lbl_DocumentTypeDescriptionPurchaseinvoice);
            'lbl_DocumentTypeDescriptionPurchaseorder':
                Exit(lbl_DocumentTypeDescriptionPurchaseorder);
            'lbl_DocumentTypeDescriptionServiceorder':
                Exit(lbl_DocumentTypeDescriptionServiceorder);
            'lbl_DocumentTypeDescriptionPurchasereturnorder':
                Exit(lbl_DocumentTypeDescriptionPurchasereturnorder);
            'lbl_DocumentTypeDescriptionShipment':
                Exit(lbl_DocumentTypeDescriptionShipment);
            'lbl_DocumentTypeDescriptionReturnShipment':
                Exit(lbl_DocumentTypeDescriptionReturnShipment);
            'lbl_DocumentTypeDescriptionChargeItem':
                Exit(lbl_DocumentTypeDescriptionChargeItem);
            'lbl_PaymentRemark':
                Exit(lbl_PaymentRemark);
            'lbl_ShowGrossUnitPrice':
                Exit(lbl_ShowGrossUnitPrice);
            'lbl_GrossUnitPrice':
                Exit(lbl_GrossUnitPrice);
            'lbl_PaymentTermsVehicleSales':
                Exit(lbl_PaymentTermsVehicleSales);
            'lbl_PriceNote':
                Exit(lbl_PriceNote);
            'lbl_PaymentConditionDAFSGate':
                Exit(lbl_PaymentConditionDAFSGate);
            'lbl_PaymentConditionIncasso':
                Exit(lbl_PaymentConditionIncasso);
            'lbl_VATIntraCommunity':
                Exit(lbl_VATIntraCommunity);
            'lbl_PrepaymentVehicle':
                Exit(lbl_PrepaymentVehicle);
            'lbl_ExchangepartsReturnRemark':
                Exit(lbl_ExchangepartsReturnRemark);
            'lbl_ItemReturnRemark':
                Exit(lbl_ItemReturnRemark);
            'lbl_OrderApproval':
                Exit(lbl_OrderApproval);
            'lbl_ConfirmationLine1':
                Exit(lbl_ConfirmationLine1);
            'lbl_ConfirmationLine2':
                Exit(lbl_ConfirmationLine2);
            'lbl_ConfirmationSignedForAgreement':
                Exit(lbl_ConfirmationSignedForAgreement);
            'lbl_ConfirmationAuthorizedToSign':
                Exit(lbl_ConfirmationAuthorizedToSign);
            'lbl_others':
                Exit(lbl_others);
            'lbl_surcharge':
                Exit(lbl_surcharge);
            'lbl_Location':
                Exit(lbl_Location);
            'lbl_BookNo':
                Exit(lbl_BookNo);
            'lbl_VIN':
                Exit(lbl_VIN);
            'lbl_LicenseNo':
                Exit(lbl_LicenseNo);
            'lbl_Fleetnumber':
                Exit(lbl_Fleetnumber);
            'lbl_TradeIn':
                Exit(lbl_TradeIn);
            'lbl_Prepayment':
                Exit(lbl_Prepayment);
            'lbl_CashpaymentDescription':
                Exit(lbl_CashpaymentDescription);
            'lbl_Make':
                Exit(lbl_Make);
            'lbl_Model':
                Exit(lbl_Model);
            'lbl_Configuration':
                Exit(lbl_Configuration);
            'lbl_TransmissionType':
                Exit(lbl_TransmissionType);
            'lbl_EngineType':
                Exit(lbl_EngineType);
            'lbl_EngineNumber':
                Exit(lbl_EngineNumber);
            'lbl_Interval':
                Exit(lbl_Interval);
            'lbl_InitialRegistration':
                Exit(lbl_InitialRegistration);
            'lbl_VehicleDeliveryDate':
                Exit(lbl_VehicleDeliveryDate);
            'lbl_Mileage':
                Exit(lbl_Mileage);
            'lbl_RunningTime':
                Exit(lbl_RunningTime);
            'lbl_Number':
                Exit(lbl_Number);
            'lbl_Date':
                Exit(lbl_Date);
            'lbl_ValidFromDate':
                Exit(lbl_ValidFromDate);
            'lbl_ValidToDate':
                Exit(lbl_ValidToDate);
            'lbl_OrderNumber':
                Exit(lbl_OrderNumber);
            'lbl_OrderDate':
                Exit(lbl_OrderDate);
            'lbl_ExpectedReceiptDate':
                Exit(lbl_ExpectedReceiptDate);
            'lbl_Name':
                Exit(lbl_Name);
            'lbl_Signature':
                Exit(lbl_Signature);
            'lbl_ConcernsOurCustomer':
                Exit(lbl_ConcernsOurCustomer);
            'lbl_OrderCustomer':
                Exit(lbl_OrderCustomer);
            'lbl_CustomerNo':
                Exit(lbl_CustomerNo);
            'lbl_Customer':
                Exit(lbl_Customer);
            'lbl_VendorNo':
                Exit(lbl_VendorNo);
            'lbl_VendorName':
                Exit(lbl_VendorName);
            'lbl_Salesperson':
                Exit(lbl_Salesperson);
            'lbl_VATnumber':
                Exit(lbl_VATnumber);
            'lbl_YourContactPerson':
                Exit(lbl_YourContactPerson);
            'lbl_MailAddress':
                Exit(lbl_MailAddress);
            'lbl_PhoneNumber':
                Exit(lbl_PhoneNumber);
            'lbl_InvoiceAddress':
                Exit(lbl_InvoiceAddress);
            'lbl_ShipmentAddress':
                Exit(lbl_ShipmentAddress);
            'lbl_DueDate':
                Exit(lbl_DueDate);
            'lbl_POnumber':
                Exit(lbl_POnumber);
            'lbl_CustomerReference':
                Exit(lbl_CustomerReference);
            'lbl_YourReference':
                Exit(lbl_YourReference);
            'lbl_SettlementNo':
                Exit(lbl_SettlementNo);
            'lbl_Header_IBAN':
                Exit(lbl_Header_IBAN);
            'lbl_Header_BIC':
                Exit(lbl_Header_BIC);
            'lbl_Header_VAT':
                Exit(lbl_Header_VAT);
            'lbl_Header_COC':
                Exit(lbl_Header_COC);
            'lbl_Header_Phone':
                Exit(lbl_Header_Phone);
            'lbl_Header_Mail':
                Exit(lbl_Header_Mail);
            'lbl_VAT':
                Exit(lbl_VAT);
            'lbl_ExchangeVAT':
                Exit(lbl_ExchangeVAT);
            'lbl_Subtotal':
                Exit(lbl_Subtotal);
            'lbl_Total':
                Exit(lbl_Total);
            'lbl_TotalToPay':
                Exit(lbl_TotalToPay);
            'lbl_TotalToReceive':
                Exit(lbl_TotalToReceive);
            'lbl_Exclusive':
                Exit(lbl_Exclusive);
            'lbl_VATover':
                Exit(lbl_VATover);
            'lbl_Line_Type':
                Exit(lbl_Line_Type);
            'lbl_Line_Code':
                Exit(lbl_Line_Code);
            'lbl_Line_No':
                Exit(lbl_Line_No);
            'lbl_Line_Description':
                Exit(lbl_Line_Description);
            'lbl_Line_Quantity':
                Exit(lbl_Line_Quantity);
            'lbl_Line_Amount':
                Exit(lbl_Line_Amount);
            'lbl_Line_TotalAmount':
                Exit(lbl_Line_TotalAmount);
            'lbl_UnitPriceHour':
                Exit(lbl_UnitPriceHour);
            'lbl_FixedPrice':
                Exit(lbl_FixedPrice);
            'lbl_Discount':
                Exit(lbl_Discount);
            'lbl_LaborAnalyse_ErrorNoLaborPriceGroup':
                Exit(lbl_LaborAnalyse_ErrorNoLaborPriceGroup);
            'lbl_LaborAnalyse_ErrorNoLaborChargingCode':
                Exit(lbl_LaborAnalyse_ErrorNoLaborChargingCode);
            'lbl_LaborAnalyse_ErrorNoChargingGroup':
                Exit(lbl_LaborAnalyse_ErrorNoChargingGroup);
            'lbl_LaborAnalyse_ErrorMissingCombination':
                Exit(lbl_LaborAnalyse_ErrorMissingCombination);
            'lbl_ErrorDescription':
                Exit(lbl_ErrorDescription);
            'lbl_LaborPriceGroup':
                Exit(lbl_LaborPriceGroup);
            'lbl_LaborPriceGroupDescription':
                Exit(lbl_LaborPriceGroupDescription);
            'lbl_LaborChargingCode':
                Exit(lbl_LaborChargingCode);
            'lbl_ChargingGroup':
                Exit(lbl_ChargingGroup);
            'lbl_RMC_Confirmation':
                Exit(lbl_RMC_Confirmation);
            'lbl_RMC_ContractConditions':
                Exit(lbl_RMC_ContractConditions);
            'lbl_RMC_QuoteConditions':
                Exit(lbl_RMC_QuoteConditions);
            'lbl_RMC_ContractInformation':
                Exit(lbl_RMC_ContractInformation);
            'lbl_RMC_Undersigned':
                Exit(lbl_RMC_Undersigned);
            'lbl_RMC_Customer':
                Exit(lbl_RMC_Customer);
            'lbl_RMC_Dealer':
                Exit(lbl_RMC_Dealer);
            'lbl_RMC_ContractNo':
                Exit(lbl_RMC_ContractNo);
            'lbl_RMC_QuoteNo':
                Exit(lbl_RMC_QuoteNo);
            'lbl_RMC_Description':
                Exit(lbl_RMC_Description);
            'lbl_RMC_Description2':
                Exit(lbl_RMC_Description2);
            'lbl_RMC_StartingDate':
                Exit(lbl_RMC_StartingDate);
            'lbl_RMC_LatestStartingDate':
                Exit(lbl_RMC_LatestStartingDate);
            'lbl_RMC_EndingDate':
                Exit(lbl_RMC_EndingDate);
            'lbl_RMC_MoreMileage':
                Exit(lbl_RMC_MoreMileage);
            'lbl_RMC_LessMileage':
                Exit(lbl_RMC_LessMileage);
            'lbl_RMC_MileagePerYear':
                Exit(lbl_RMC_MileagePerYear);
            'lbl_RMC_StartingMileage':
                Exit(lbl_RMC_StartingMileage);
            'lbl_RMC_EndMileageCalculated':
                Exit(lbl_RMC_EndMileageCalculated);
            'lbl_RMC_DurationMonths':
                Exit(lbl_RMC_DurationMonths);
            'lbl_RMC_Months':
                Exit(lbl_RMC_Months);
            'lbl_RMC_VehicleInformation':
                Exit(lbl_RMC_VehicleInformation);
            'lbl_RMC_VehicleQuantity':
                Exit(lbl_RMC_VehicleQuantity);
            'lbl_RMC_VehicleDeployment':
                Exit(lbl_RMC_VehicleDeployment);
            'lbl_RMC_GeographicStake':
                Exit(lbl_RMC_GeographicStake);
            'lbl_RMC_UsageType':
                Exit(lbl_RMC_UsageType);
            'lbl_RMC_Application':
                Exit(lbl_RMC_Application);
            'lbl_RMC_RoadType':
                Exit(lbl_RMC_RoadType);
            'lbl_RMC_DeliveryPerDay':
                Exit(lbl_RMC_DeliveryPerDay);
            'lbl_RMC_PTOHoursPerDay':
                Exit(lbl_RMC_PTOHoursPerDay);
            'lbl_RMC_OilEngine':
                Exit(lbl_RMC_OilEngine);
            'lbl_RMC_OilGearbox':
                Exit(lbl_RMC_OilGearbox);
            'lbl_RMC_OilDifferential':
                Exit(lbl_RMC_OilDifferential);
            'lbl_RMC_FinancialInformation':
                Exit(lbl_RMC_FinancialInformation);
            'lbl_RMC_MileageRate':
                Exit(lbl_RMC_MileageRate);
            'lbl_RMC_IndexPeriod':
                Exit(lbl_RMC_IndexPeriod);
            'lbl_RMC_Basic':
                Exit(lbl_RMC_Basic);
            'lbl_RMC_Ratios':
                Exit(lbl_RMC_Ratios);
            'lbl_RMC_Wages':
                Exit(lbl_RMC_Wages);
            'lbl_RMC_Components':
                Exit(lbl_RMC_Components);
            'lbl_RMC_Oil':
                Exit(lbl_RMC_Oil);
            'lbl_RMC_InstallmentAmount':
                Exit(lbl_RMC_InstallmentAmount);
            'lbl_RMC_InvoiceFrequency':
                Exit(lbl_RMC_InvoiceFrequency);
            'lbl_RMC_AdditionalConditions':
                Exit(lbl_RMC_AdditionalConditions);
            'lbl_RMC_Covered':
                Exit(lbl_RMC_Covered);
            'lbl_RMC_Excluded':
                Exit(lbl_RMC_Excluded);
            'lbl_RMC_Signatures':
                Exit(lbl_RMC_Signatures);
            'lbl_RMC_PricesExclVAT':
                Exit(lbl_RMC_PricesExclVAT);
            'lbl_RMC_OnBehalfOfCustomer':
                Exit(lbl_RMC_OnBehalfOfCustomer);
            'lbl_RMC_OnBehalfOfDealer':
                Exit(lbl_RMC_OnBehalfOfDealer);
            'lbl_RMC_By':
                Exit(lbl_RMC_By);
            'lbl_RMC_Signature':
                Exit(lbl_RMC_Signature);
            'lbl_RMC_MainContract':
                Exit(lbl_RMC_MainContract);
            'lbl_RMC_MainContractYes':
                Exit(lbl_RMC_MainContractYes);
            'lbl_RMC_MainContractNo':
                Exit(lbl_RMC_MainContractNo);
            'lbl_Order2Cash_RouteCode':
                Exit(lbl_Order2Cash_RouteCode);
            'lbl_Order2Cash_JobCode':
                Exit(lbl_Order2Cash_JobCode);
            'lbl_Order2Cash_DamageNo':
                Exit(lbl_Order2Cash_Damageno);
            'lbl_ShipmentNumber':
                Exit(lbl_ShipmentNumber);
            'lbl_ShipmentMethod':
                Exit(lbl_ShipmentMethod);
            'lbl_DeliveryDate':
                Exit(lbl_DeliveryDate);
            'lbl_BIN':
                Exit(lbl_BIN);
            'lbl_Line_QuantityBackorder':
                Exit(lbl_Line_QuantityBackorder);
            'lbl_Line_Ordered':
                Exit(lbl_Line_Ordered);
            'lbl_Line_QuantityPurchased':
                Exit(lbl_Line_QuantityPurchased);
            'lbl_Line_QuantityStock':
                Exit(lbl_Line_QuantityStock);
            'lbl_Line_TotalQuantityStock':
                Exit(lbl_Line_TotalQuantityStock);
            'lbl_Line_QuantityToReturn':
                Exit(lbl_Line_QuantityToReturn);
            'lbl_EntryNo':
                Exit(lbl_EntryNo);
            'lbl_Line_NetAmount':
                Exit(lbl_Line_NetAmount);
            'lbl_ExchangepartsReturnDocument':
                Exit(lbl_ExchangepartsReturnDocument);
            'lbl_IntakeBy':
                Exit(lbl_IntakeBy);
            'lbl_IntakeDate':
                Exit(lbl_IntakeDate);
            'lbl_IntakeTitle':
                Exit(lbl_IntakeTitle);
            'lbl_QualityCheck':
                Exit(lbl_QualityCheck);
            'lbl_QualityCheckOk':
                Exit(lbl_QualityCheckOk);
            'lbl_QualityCheckDamage':
                Exit(lbl_QualityCheckDamage);
            'lbl_QualityCheckDisapproval':
                Exit(lbl_QualityCheckDisapproval);
            'lbl_ReturnPeriod':
                Exit(lbl_ReturnPeriod);
            'lbl_Page':
                Exit(lbl_Page);
            'lbl_Counted':
                Exit(lbl_Counted);
            'lbl_ToDo':
                Exit(lbl_ToDo);
            'lbl_LastInventory':
                Exit(lbl_LastInventory);
            'lbl_Item':
                Exit(lbl_Item);
            'lbl_YearAbbreviation':
                Exit(lbl_YearAbbreviation);
            'lbl_QuarterAbbreviation':
                Exit(lbl_QuarterAbbreviation);
            'lbl_MonthAbbreviation':
                Exit(lbl_MonthAbbreviation);
            'lbl_DayAbbreviation':
                Exit(lbl_DayAbbreviation);
            'lbl_Purchase_IndicatingNumber':
                Exit(lbl_Purchase_IndicatingNumber);
            'lbl_Purchase_SendDigitally':
                Exit(lbl_Purchase_SendDigitally);
            'lbl_DocumentType':
                Exit(lbl_DocumentType);
            'lbl_DocumentDate':
                Exit(lbl_DocumentDate);
            'lbl_PickList':
                Exit(lbl_PickList);
            'lbl_UOM':
                Exit(lbl_UOM);
            'lbl_QuantityDelivered':
                Exit(lbl_QuantityDelivered);
            'lbl_QuantityToPick':
                Exit(lbl_QuantityToPick);
            'lbl_AmountNotInvoiced':
                Exit(lbl_AmountNotInvoiced);
            'lbl_UnitCost':
                Exit(lbl_UnitCost);
            'lbl_PrintDate':
                Exit(lbl_PrintDate);
            'lbl_QuantityAbbreviation':
                Exit(lbl_QuantityAbbreviation);
            'lbl_ReceivedAbbreviation':
                Exit(lbl_ReceivedAbbreviation);
            'lbl_InvoicedAbbreviation':
                Exit(lbl_InvoicedAbbreviation);
            'lbl_InvoiceCustomer':
                Exit(lbl_InvoiceCustomer);
            'lbl_Planning':
                Exit(lbl_Planning);
            'lbl_From':
                Exit(lbl_From);
            'lbl_To':
                Exit(lbl_To);
            'lbl_Vehicle':
                Exit(lbl_Vehicle);
            'lbl_AxleType':
                Exit(lbl_AxleType);
            'lbl_MileageWriteDown':
                Exit(lbl_MileageWriteDown);
            'lbl_VehicleAppointments':
                Exit(lbl_VehicleAppointments);
            'lbl_MOT':
                Exit(lbl_MOT);
            'lbl_Tacho':
                Exit(lbl_Tacho);
            'lbl_Warranty':
                Exit(lbl_Warranty);
            'lbl_OEMRandM':
                Exit(lbl_OEMRandM);
            'lbl_DealerRandM':
                Exit(lbl_DealerRandM);
            'lbl_Complaint':
                Exit(lbl_Complaint);
            'lbl_Instruction':
                Exit(lbl_Instruction);
            'lbl_Package':
                Exit(lbl_Package);
            'lbl_Payer':
                Exit(lbl_Payer);
            'lbl_SignatureCustomer':
                Exit(lbl_SignatureCustomer);
            'lbl_SignatureChief':
                Exit(lbl_SignatureChief);
            'lbl_Hours':
                Exit(lbl_Hours);
            'lbl_RepeatRepair':
                Exit(lbl_RepeatRepair);
            'lbl_Fluids':
                Exit(lbl_Fluids);
            'lbl_Mechanic':
                Exit(lbl_Mechanic);
            'lbl_Warehouse':
                Exit(lbl_Warehouse);
            'lbl_WorkshopChief':
                Exit(lbl_WorkshopChief);
            'lbl_TestcomputerUsage':
                Exit(lbl_TestcomputerUsage);
            'lbl_PartsReturned':
                Exit(lbl_PartsReturned);
            'lbl_FinalInspection':
                Exit(lbl_FinalInspection);
            'lbl_ServiceOrderDeliveryTerms':
                Exit(lbl_ServiceOrderDeliveryTerms);
            'lbl_CabinTiltWarning':
                Exit(lbl_CabinTiltWarning);
            'lbl_RequisitionStatus':
                Exit(lbl_RequisitionStatus);
            'lbl_ItemNumber':
                Exit(lbl_ItemNumber);
            'lbl_Turnover':
                Exit(lbl_Turnover);
            'lbl_TurnoverYear':
                Exit(lbl_TurnoverYear);
            'lbl_VendorInvoiceNo':
                Exit(lbl_VendorInvoiceNo);
            'lbl_VendorOrderNo':
                Exit(lbl_VendorOrderNo);
            'lbl_OriginalDocumentNo':
                Exit(lbl_OriginalDocumentNo);
            'lbl_OriginalDocumentLineNo':
                Exit(lbl_OriginalDocumentLineNo);
            'lbl_CockpitDocument':
                Exit(lbl_CockpitDocument);
            'lbl_StartingNo':
                Exit(lbl_StartingNo);
            'lbl_EndingNo':
                Exit(lbl_EndingNo);
            'lbl_LastNoUsed':
                Exit(lbl_LastNoUsed);
            'lbl_LastDateUsed':
                Exit(lbl_LastDateUsed);
            else
                Exit('?');
        END;
    end;

}

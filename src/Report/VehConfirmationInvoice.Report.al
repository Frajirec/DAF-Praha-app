report 80036 "DPG Veh. Confirmation/Invoice" // 1057606 "Veh. Confirmation/Invoice CZ"
{
    // // @ Area VehicleSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   05.08.10 Changes made to print original/duplicate invoices.
    // PA032178   27.10.10 DD 1798176 docu trigger and version list corrected.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   21.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Variable PrintOption was having 0,1,2 option which is replaced by
    //                          print selected lines,print all lines,print no lines
    //                        - Variable PrintUnitPrice was having 0,1,2 option which is replaced by
    //                          print selected prices,print all prices,print no prices
    //                        - Layout 1 Layout 2 and layout Concepts added.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Sales Header - OnAfterGetRecord()"
    // PA033733   02.11.12 GB 9064562: Change Caption to 'Veh. Confirmation/Invoice'
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036090   11.07.14 GJ 24330 Header and Print corrections.
    // PA035395   27.12.13 GD 18593 Fixed FooterLines and Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   01.04.14 GF 20759 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   13.01.15 GK 32400 RDLC Layout corrections-Main Table fixed to print all Sales Invoice Lines according to filters
    // PA037341   21.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035484.20759
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // --- NAVCZ ---
    // API.1      20.03.18 PV New object created as a copy of Report 5025413 Veh. Confirmation/Invoice
    // API.1.0.1  24.04.18 LC CZ Localisation company identifiers added, layout adjusted
    // API.1.0.3  07.08.18 PV NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    //                        Translation of req.page, put VAT% instead of VAT identifier
    //                        Final design of header, Bank source, SK legislation,
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/VehConfirmationInvoice.rdlc';

    Caption = 'Veh. Confirmation/Invoice';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Invoice), "Order Type" = CONST("Vehicle Sales & Purchases"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CustAddr_1_; CustAddrG[1])
                    {
                    }
                    column(CustAddr_2_; CustAddrG[2])
                    {
                    }
                    column(CustAddr_3_; CustAddrG[3])
                    {
                    }
                    column(CustAddr_4_; CustAddrG[4])
                    {
                    }
                    column(CustAddr_6_; CustAddrG[6])
                    {
                    }
                    column(CustAddr_5_; CustAddrG[5])
                    {
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddrG[1])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddrG[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                    }
                    column(Sales_Header___Document_Date_; FORMAT("Sales Header"."Document Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Cust__No__; CustG."No.")
                    {
                    }
                    column(CoTelephoneText; CoTelephoneTextG)
                    {
                    }
                    column(CoFaxText; CoFaxTextG)
                    {
                    }
                    column(CoEmailText; CoEmailTextG)
                    {
                    }
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(CoFax; CoFaxG)
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA031550';
                    }
                    column(OutputNo; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintFooterLine_Control1101339004; PrintFooterLineG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintAddrBlock; PrintAddrBlockG)
                    {
                        Description = 'PA033336';
                    }
                    column(ShowUnitsofMeasure; ShowUnitsofMeasureG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintSentFromLine; PrintSentFromLineG)
                    {
                        Description = 'PA033336';
                    }
                    column(RePrintOriginalInvoiceG; RePrintOriginalInvG)
                    {
                        Description = 'PA033336';
                    }
                    column(DoNotShowVAT_Control1101338997; DoNotShowVATG)
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Duplicate_Graphic_; ReportLayoutSetupG."Duplicate Graphic")
                    {
                        Description = 'PA033336';
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvG))
                    {
                        Description = 'PA033336';
                    }
                    column(NoPrinted_; RDLHideOutput("Sales Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
                    {
                    }
                    column(DiscText; DiscTextG)
                    {
                    }
                    column(Collective_TextShowOutput_SalesLine_FIELDCAPTION__Unit_of_Measure___ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesLineG.FIELDCAPTION("Unit of Measure"), ShowUnitsofMeasureG))
                    {
                    }
                    column(BankText; BankTextG)
                    {
                    }
                    column(FooterField43; RDLHideOutput(PrintFooterLineG AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_6_6_; ReportLayoutSetupG."Footer 6-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_5_4_; ReportLayoutSetupG."Footer 5-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_6_4_; ReportLayoutSetupG."Footer 6-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_5_5_; ReportLayoutSetupG."Footer 5-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_6_5_; ReportLayoutSetupG."Footer 6-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_5_6_; ReportLayoutSetupG."Footer 5-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_3_; ReportLayoutSetupG."Footer 2-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_3_; ReportLayoutSetupG."Footer 3-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_3_; ReportLayoutSetupG."Footer 4-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_5_3_; ReportLayoutSetupG."Footer 5-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_6_3_; ReportLayoutSetupG."Footer 6-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_4_; ReportLayoutSetupG."Footer 2-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_4_; ReportLayoutSetupG."Footer 3-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_4_; ReportLayoutSetupG."Footer 4-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_5_; ReportLayoutSetupG."Footer 2-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_5_; ReportLayoutSetupG."Footer 3-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_5_; ReportLayoutSetupG."Footer 4-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_6_; ReportLayoutSetupG."Footer 2-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_6_; ReportLayoutSetupG."Footer 3-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_6_; ReportLayoutSetupG."Footer 4-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_6_2_; ReportLayoutSetupG."Footer 6-2")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_5_2_; ReportLayoutSetupG."Footer 5-2")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_2_; ReportLayoutSetupG."Footer 4-2")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_2_; ReportLayoutSetupG."Footer 3-2")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_2_; ReportLayoutSetupG."Footer 2-2")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_1_2_; ReportLayoutSetupG."Footer 1-2")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_1_3_; ReportLayoutSetupG."Footer 1-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_1_4_; ReportLayoutSetupG."Footer 1-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_1_5_; ReportLayoutSetupG."Footer 1-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_1_6_; ReportLayoutSetupG."Footer 1-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_1_1_; ReportLayoutSetupG."Footer 1-1")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_1_; ReportLayoutSetupG."Footer 2-1")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_1_; ReportLayoutSetupG."Footer 3-1")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_1_; ReportLayoutSetupG."Footer 4-1")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_5_1_; ReportLayoutSetupG."Footer 5-1")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_6_1_; ReportLayoutSetupG."Footer 6-1")
                    {
                        Description = 'PA033336';
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(IsRepSelectionSetupAvailable; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(Sales_Header___No__Caption; Sales_Header___No__CaptionLbl)
                    {
                    }
                    column(Sales_Header___Document_Date_Caption; Sales_Header___Document_Date_CaptionLbl)
                    {
                    }
                    column(PageLbl; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
                    {
                    }
                    column(No_Caption; No_CaptionLbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(Qty_Caption; Qty_CaptionLbl)
                    {
                    }
                    column(UoM; UoMLbl)
                    {
                        Description = 'PA033336';
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(BankName_Comp; BankNameG)
                    {
                    }
                    column(BankBranchNo_Comp; BankBranchNoG)
                    {
                    }
                    column(BankSwift_Comp; BankSwiftG)
                    {
                    }
                    column(BankIban_Comp; BankIbanG)
                    {
                    }
                    column(BankAccountNo_Comp; BankAccountNoG)
                    {
                    }
                    column(PaymentMethodCode_SH; "Sales Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SH; "Sales Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SH; "Sales Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SH; "Sales Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SH; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SH; "Sales Header"."Tax Registration No.")
                    {
                    }
                    column(RegistrationNo_Comp; CompanyInfoG."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_Comp; CompanyInfoG."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_Comp; CompanyInfoG."Tax Registration No.")
                    {
                    }
                    column(Description_PayMethod; PaymentMethodG.Description)
                    {
                    }
                    column(SellToAddr1; OrderCustAddrG[1])
                    {
                    }
                    column(SellToAddr2; OrderCustAddrG[2])
                    {
                    }
                    column(SellToAddr3; OrderCustAddrG[3])
                    {
                    }
                    column(SellToAddr4; OrderCustAddrG[4])
                    {
                    }
                    column(SellToAddr5; OrderCustAddrG[5])
                    {
                    }
                    column(SellToAddr6; OrderCustAddrG[6])
                    {
                    }
                    column(SellToAddr7; OrderCustAddrG[7])
                    {
                    }
                    column(SellToAddr8; OrderCustAddrG[8])
                    {
                    }
                    column(ColonLbl; ColonLbl)
                    {
                    }
                    column(SlashLbl; SlashLbl)
                    {
                    }
                    column(ReceiverLbl; ReceiverLbl)
                    {
                    }
                    column(IssuedByLbl; IssuedByLbl)
                    {
                    }
                    column(TaxRegNoLbl; TaxRegNoLbl)
                    {
                    }
                    column(VATRegNoLbl; VATRegNoLbl)
                    {
                    }
                    column(RegNoLbl; RegNoLbl)
                    {
                    }
                    column(BankInstitutionLbl; BankInstitutionLbl)
                    {
                    }
                    column(BankAccountNoLbl; BankAccountNoLbl)
                    {
                    }
                    column(IbanSwiftLbl; IbanSwiftLbl)
                    {
                    }
                    column(DocumentDateLbl; DocumentDateLbl)
                    {
                    }
                    column(DueDateCpn_SH; "Sales Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SH; "Sales Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SH; "Sales Header".FIELDCAPTION("Variable Symbol"))
                    {
                    }
                    column(EmailCpn_Comp; CompanyInfoG.FIELDCAPTION("E-Mail"))
                    {
                    }
                    column(PhoneLbl; PhoneLbl)
                    {
                    }
                    column(IbanCpn_Comp; CompanyInfoG.FIELDCAPTION(IBAN))
                    {
                    }
                    column(SwiftLbl; SwiftLbl)
                    {
                    }
                    column(PaymentMethodDescLbl; PaymentMethodDescLbl)
                    {
                    }
                    column(PrintDocTitleAndNoUp; PrintDocTitleAndNoUpG)
                    {
                    }
                    column(TitleTextLeft; TitleTextLeftG)
                    {
                    }
                    column(TitleTextCenter; TitleTextCenterG)
                    {
                    }
                    column(TitleTextRight; TitleTextRightG)
                    {
                    }
                    column(ShowDuplicateImage; ShowDuplicateImageG)
                    {
                    }
                    column(EmployeeFullName; EmployeeFullNameG)
                    {
                    }
                    column(ShipToAddrG1; ShipToAddrG[1])
                    {
                    }
                    column(ShipToAddrG2; ShipToAddrG[2])
                    {
                    }
                    column(ShipToAddrG3; ShipToAddrG[3])
                    {
                    }
                    column(ShipToAddrG4; ShipToAddrG[4])
                    {
                    }
                    column(ShipToAddrG5; ShipToAddrG[5])
                    {
                    }
                    column(ShipToAddrG6; ShipToAddrG[6])
                    {
                    }
                    column(ShipToAddrG7; ShipToAddrG[7])
                    {
                    }
                    column(ShipToAddrG8; ShipToAddrG[8])
                    {
                    }
                    column(VATDateLbl; VATDateLbl)
                    {
                    }
                    column(BillToLbl; BillToLbl)
                    {
                    }
                    column(ShipToLbl; ShipToLbl)
                    {
                    }
                    column(SellToLbl; SellToLbl)
                    {
                    }
                    column(VendorLbl; VendorLbl)
                    {
                    }
                    column(ShowTaxNoG; ShowTaxNoG)
                    {
                    }
                    column(MakeCaption; MakeCaptionLbl)
                    {
                    }
                    column(LetterAmount; LetterAmountG)
                    {
                    }
                    column(AmountWithoutLetter; AmountWithoutLetterG)
                    {
                    }
                    column(PaymentsLbl; PaymentsLbl)
                    {
                    }
                    column(AmountIncludingVAT_SH; "Sales Header"."Amount Including VAT")
                    {
                    }
                    column(CurrencyCode_SH; "Sales Header"."Currency Code")
                    {
                    }
                    column(CalculatedExchRate; CalculatedExchRate)
                    {
                    }
                    column(ExchRateText; ExchRateText)
                    {
                    }
                    column(ToDateLbl; ToDateLbl)
                    {
                    }
                    column(PostingDate_SH; "Sales Header"."Posting Date")
                    {
                    }
                    column(LCYCode_GLS; GLSetupG."LCY Code")
                    {
                    }
                    column(ShowCurrency; ShowCurrencyG)
                    {
                    }
                    column(WithoutVATLbl; WithoutVATLbl)
                    {
                    }
                    column(ShowVehicleInfo; ShowVehicleInfoG)
                    {
                    }
                    column(VatRegNoLbl2; VATRegNoLbl)
                    {
                    }
                    column(TaxRegNoLbl2; TaxRegNoLbl)
                    {
                    }
                    column(RegNoLbl2; RegNoLbl)
                    {
                    }
                    column(VatRegNo2; CompanyInfoG."VAT Registration No.")
                    {
                    }
                    column(TaxRegNo2; CompanyInfoG."Tax Registration No.")
                    {
                    }
                    column(RegNo2; CompanyInfoG."Registration No.")
                    {
                    }
                    column(OrderDate_SH; "Sales Header"."Order Date")
                    {
                    }
                    column(OrderDateCpn_SH; "Sales Header".FIELDCAPTION("Order Date"))
                    {
                    }
                    dataitem(HeaderHeaderText; "Sales Document Text")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Header/Footer" = CONST(Header));
                        column(HeaderHeaderText_Text; Text)
                        {
                        }
                        column(HeaderHeaderText_Document_Type; "Document Type")
                        {
                        }
                        column(HeaderHeaderText_Document_No_; "Document No.")
                        {
                        }
                        column(HeaderHeaderText_Header_Footer; "Header/Footer")
                        {
                        }
                        column(HeaderHeaderText_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem("Sales Line"; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(CurrentVehicle; CurrentVehicleG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Description; SalesLineG.Description)
                        {
                        }
                        column(Sales_Line___Unit_Price_; SalesLineG."Unit Price")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line__Type; SalesLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line_LineNo; SalesLineG."Line No.")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line___Line_Discount___; SalesLineG."Line Discount %")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line___Item_Type_; SalesLineG."Item Type")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line___Unit_of_Measure_Code_; SalesLineG."Unit of Measure Code")
                        {
                            AutoFormatExpression = 'JMD';
                            Description = 'PA033336';
                        }
                        column(Sales_Line___Vehicle_Status_; SalesLineG."Vehicle Status")
                        {
                            Description = 'PA033336';
                        }
                        column(SalesLineItemTypeG; SalesLineItemTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesLineTypeG; SalesLineTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesLine_Description_Control58; SalesLineG.Description)
                        {
                        }
                        column(SalesLine_Quantity; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPct; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmount; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput_SalesLine__Unit_of_Measure__ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(PrintOptionHelpG; PrintOptionHelpG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintUnitPriceHelp; PrintUnitPriceHelpG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesLine_Description_Control1109420000; SalesLineG.Description)
                        {
                        }
                        column(SalesLine_Quantity_Control1109420001; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Collective_TextShowOutput_SalesLine__Unit_of_Measure__ShowUnitsofMeasure__Control1109420002; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(SalesLine__Description_2_; SalesLineG."Description 2")
                        {
                        }
                        column(SalesLine__No__; SalesLineG."No.")
                        {
                        }
                        column(SalesLine_Description_Control65; SalesLineG.Description)
                        {
                        }
                        column(SalesLine_Quantity_Control66; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice_Control68; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPct_Control69; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmount_Control70; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput_SalesLine__Unit_of_Measure__ShowUnitsofMeasure__Control67; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(SalesLine__Description_2__Control39; SalesLineG."Description 2")
                        {
                        }
                        column(VehicleDescription; VehicleDescriptionG)
                        {
                        }
                        column(ShowSalPrice_Control143; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPct_Control145; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmount_Control146; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__No___Control147; SalesLineG."No.")
                        {
                        }
                        column(CurrentVehicle_Control22; CurrentVehicleG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Inv__Discount_Amount_; -SalesLineG."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmtG; -TotalInvDiscAmtG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            Description = 'PA033336';
                        }
                        column(SalesLine_Amount; SalesLineG.Amount)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLineG.VATAmountText)
                        {
                        }
                        column(ShowCurrency1; ShowCurrencyG)
                        {
                        }
                        column(SalesLine__Amount_Including_VAT____SalesLine_Amount; SalesLineG."Amount Including VAT" - SalesLineG.Amount)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(SalesLine__Amount_Including_VAT_; SalesLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCurrVatAmtG; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(DoNotShowVAT; DoNotShowVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalInclVATText_Control10; TotalInclVATTextG)
                        {
                        }
                        column(SalesLine__Amount_Including_VAT__Control13; SalesLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CurrentVehicleCaption; CurrentVehicleCaptionLbl)
                        {
                        }
                        column(CurrentVehicle_Control22Caption; CurrentVehicle_Control22CaptionLbl)
                        {
                        }
                        column(SalesLine__Inv__Discount_Amount_Caption; SalesLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(Sales_Line_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Line";
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT SalesLineG.FIND('-') THEN BEGIN
                                    SalesLineG.SETRANGE("Item Type", SalesLineG."Item Type"::Item);
                                    SalesLineG.FIND('-');
                                END;
                                VINOldG := SalesLineG.VIN;
                            END ELSE
                                IF SalesLineG.NEXT = 0 THEN BEGIN
                                    SalesLineG.SETRANGE("Item Type", SalesLineG."Item Type"::Item);
                                    SalesLineG.FIND('-');
                                END;

                            // Check if Option is available
                            OptionVariantG.SETRANGE(Area, OptionVariantG.Area::Sale);
                            OptionVariantG.SETRANGE("Document Type", OptionVariantG."Document Type"::"Inv.");
                            OptionVariantG.SETRANGE("Document No.", SalesLineG."Document No.");
                            OptionVariantG.SETRANGE("Document Line No.", SalesLineG."Line No.");
                            OptionFoundG := OptionVariantG.FIND('-');

                            VATAmountLineG.INIT;
                            // Start PA033011.5983155
                            VATAmountLineG."VAT Identifier" := FORMAT(SalesLineG."VAT %");
                            VATAmountLineG."Sales Amount" := SalesLineG.Amount;
                            // Stop PA033011.5983155
                            VATAmountLineG."VAT %" := SalesLineG."VAT %";
                            VATAmountLineG."VAT Base" := SalesLineG.Amount;
                            VATAmountLineG."Amount Including VAT" := SalesLineG."Amount Including VAT";
                            VATAmountLineG.InsertLine();

                            IF DoNotShowVATG THEN BEGIN
                                IF SalesLineG.Type = SalesLineG.Type::Item THEN BEGIN
                                    CASE SalesLineG."Item Type" OF
                                        SalesLineG."Item Type"::Item:
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumOtherG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::Vehicle:
                                            SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::"Own Option":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumOwnOptG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumTransferFeesG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::"Charge (Item)":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumChargeItemsG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";
                                    END;
                                END ELSE
                                    IF (SalesLineG.Type = SalesLineG.Type::"Account (G/L)") OR
                                       (SalesLineG.Type = SalesLineG.Type::"Charge (Item)")
                                    THEN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                           SalesLineG."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"print no lines")
                                        THEN
                                            SumOtherG += SalesLineG."Amount Including VAT"
                                        ELSE
                                            SumVehicleG += SalesLineG."Amount Including VAT"
                            END ELSE BEGIN
                                IF SalesLineG.Type = SalesLineG.Type::Item THEN BEGIN
                                    CASE SalesLineG."Item Type" OF
                                        SalesLineG."Item Type"::Item:
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumOtherG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount"
                                            ELSE BEGIN
                                                SumVehicleG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                                            END;
                                        SalesLineG."Item Type"::Vehicle:
                                            SumVehicleG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                                        SalesLineG."Item Type"::"Own Option":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumOwnOptG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount"
                                            ELSE
                                                SumVehicleG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                                        SalesLineG."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumTransferFeesG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount"
                                            ELSE
                                                SumVehicleG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                                        SalesLineG."Item Type"::"Charge (Item)":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"print no lines")
                                            THEN
                                                SumChargeItemsG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount"
                                            ELSE
                                                SumVehicleG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                                    END;
                                END ELSE
                                    IF (SalesLineG.Type = SalesLineG.Type::"Account (G/L)") OR
                                       (SalesLineG.Type = SalesLineG.Type::"Charge (Item)")
                                    THEN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print selected lines") AND
                                           SalesLineG."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND (PrintOptionG = PrintOptionG::"print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND SalesLineG."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"print no lines")
                                        THEN
                                            SumOtherG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount"
                                        ELSE
                                            SumVehicleG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                            END;
                            IF (SalesLineG.Type <> SalesLineG.Type::" ") AND
                               ((SalesLineG.Amount <> 0) OR (SalesLineG."Amount Including VAT" <> 0))
                            THEN BEGIN
                                TotalsLineL.RESET;
                                TotalsLineL.SETCURRENTKEY("Document Type", "Document No.", Type, "No.");
                                TotalsLineL.SETRANGE("Document Type", SalesLineG."Document Type");
                                TotalsLineL.SETRANGE("Document No.", SalesLineG."Document No.");
                                TotalsLineL.SETRANGE(Type, SalesLineG.Type);
                                TotalsLineL.SETRANGE("No.", SalesLineG."No.");
                                TotalsLineL.CALCSUMS(Amount, "Amount Including VAT");
                                IF (TotalsLineL.Amount = 0) AND (TotalsLineL."Amount Including VAT" = 0) THEN
                                    CurrReport.SKIP;
                            END;

                            // Start PA035597
                            SalesLineTypeG := SalesLineG.Type;
                            SalesLineItemTypeG := SalesLineG."Item Type";
                            TotalInvDiscAmtG += SalesLineG."Inv. Discount Amount";
                            PrintOptionHelpG := (PrintOptionG = PrintOptionG::"print all lines") OR
                              ((PrintOptionG = PrintOptionG::"print selected lines") AND SalesLineG."Print Option Line");
                            PrintUnitPriceHelpG := FunctionPrintUnitPrice;

                            ShowSalPriceG := 0;
                            ShowLineDiscPctG := 0;
                            IF DoNotShowVATG THEN
                                DspAmountG := getSalPrice(SalesLineG, 1)
                            ELSE
                                DspAmountG := getSalPrice(SalesLineG, 2) + getLineDiscPct(SalesLineG, 2);
                            IF PrintDiscG THEN BEGIN
                                ShowSalPriceG := getSalPrice(SalesLineG, 0);
                                ShowLineDiscPctG := getLineDiscPct(SalesLineG, 0);
                                IF (ShowSalPriceG <> 0) THEN BEGIN
                                    IF DoNotShowVATG THEN
                                        DspAmountG := getSalPrice(SalesLineG, 2) + getLineDiscPct(SalesLineG, 2);
                                    ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                END;
                            END;
                            TotalVehG := TotalVehG + DspAmountG;
                            VehicleDescriptionG := SalesLineG."Shortcut Dimension 2 Code" + ' ' + SalesLineG.Description;
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            SalesLineG.RESET;
                            SalesLineG.SETRANGE("Document Type", "Sales Header"."Document Type");
                            SalesLineG.SETRANGE("Document No.", "Sales Header"."No.");
                            MoreLinesG := SalesLineG.FIND('+');
                            WHILE MoreLinesG AND (SalesLineG.Description = '') AND
                               (SalesLineG."No." = '') AND (SalesLineG.Quantity = 0) AND
                               (SalesLineG.Amount = 0)
                            DO
                                MoreLinesG := SalesLineG.NEXT(-1) <> 0;

                            IF NOT MoreLinesG THEN
                                CurrReport.BREAK;

                            SalesLineG.SETRANGE("Line No.", 0, SalesLineG."Line No.");

                            SETRANGE(Number, 1, SalesLineG.COUNT);

                            SalesLineG.SETCURRENTKEY(VIN, "Item Type");
                            SalesLineG.SETFILTER("Item Type", '<>%1', SalesLineG."Item Type"::Item);
                            CurrReport.CREATETOTALS(SalesLineG.Amount, SalesLineG."Amount Including VAT",
                              SalesLineG."Inv. Discount Amount");
                            // Start PA033336
                            CLEAR(TotalInvDiscAmtG);
                            // Stop PA033336
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrency_Control38; ShowCurrencyG)
                        {
                        }
                        column(SalesLine_Amount_Control44; SalesLineG.Amount)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCurrVatAmt1G; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(DoNotShowVAT_Control1101338963; DoNotShowVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(ShowCurrency_Control1101338964; ShowCurrencyG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control108; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Amount_Including_VAT_Base; VATAmountLineG."Amount Including VAT" - VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base__Control112; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control113; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control48; TotalInclVATTextG)
                        {
                        }
                        column(SalesLine__Amount_Including_VAT__Control51; SalesLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control34; TotalCaption_Control34Lbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(VAT_onCaption; VAT_onCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control111; ContinuedCaption_Control111Lbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLineG.COUNT <= 1 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Payment Terms"; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PaymentTerms_Description; PaymentTermsG.Description)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(Payment_Terms_Number; Number)
                        {
                        }
                    }
                    dataitem(HeaderFooterText; "Sales Document Text")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Header/Footer" = CONST(Footer));
                        column(HeaderFooterText_Text; Text)
                        {
                        }
                        column(HeaderFooterText_Document_Type; "Document Type")
                        {
                        }
                        column(HeaderFooterText_Document_No_; "Document No.")
                        {
                        }
                        column(HeaderFooterText_Header_Footer; "Header/Footer")
                        {
                        }
                        column(HeaderFooterText_Line_No_; "Line No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // Start PA035597
                        IF PrintFooterLineG THEN
                            PageLoopFooterG := 1;
                        // Stop PA035597
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;
                    // Start PA033336
                    // Start PA035597
                    IF Number > 1 THEN
                        // Stop PA035597
                        OutputNoG := OutputNoG + 1;

                    IF ("Sales Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC001;
                    // Stop PA033336

                    // Start PA035597
                    // Stop PA035597
                    DspAmountG := 0;
                    SumVehicleG := 0;
                    SumTotVehicleG := 0;
                    SumMfgOptG := 0;
                    SumOwnOptG := 0;
                    SumTransferFeesG := 0;
                    SumOtherG := 0;
                    TotalVehG := 0;
                    CurrentVehicleG := 0;
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA035395.18593
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrintedG.RUN("Sales Header");
                    // Stop PA035395.18593
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA043099
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    // Stop PA043099
                    IF NoOfLoopsG <= 0 THEN
                        NoOfLoopsG := 1;
                    CopyTextG := '';
                    // Start PA031550
                    DuplicateTextG := '';
                    // Stop PA031550

                    SETRANGE(Number, 1, NoOfLoopsG);

                    // Start PA035597
                    OutputNoG := 1;
                    // Stop PA035597
                end;
            }

            trigger OnAfterGetRecord()
            var
                IntCustL: Code[20];
                bankAccountL: Record "Bank Account";
            begin
                // Start API.1.0.3
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                // Stop API.1.0.3

                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Veh. Confirmation/Invoice");  // API.1.0.3

                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN BEGIN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                END;

                ReportSelectionG.SETRANGE(Usage, ReportSelectionG.Usage::"Invoice Test Report");
                ReportSelectionG.GetReportSelection(ReportSelectionG, "Shortcut Dimension 2 Code", "Location Code");
                ReportSelectionG.SETRANGE("Report ID", REPORT::"DPG Veh. Confirmation/Invoice"); //API.1.0.3

                ReportTitleG := ReportSelectionG.GetReportTitle("Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Veh. Confirmation/Invoice", C_INC033); // API.1.0.3
                // Stop PA035395.18593

                // Start API.1.0.3
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Header"."Original User ID");

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;
                // Stop API.1.0.3

                IF NOT CustG.GET("Bill-to Customer No.") THEN
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();

                PrintDiscG := "Sales Header"."Show Discount";

                SeparatorG := '';
                Separator2G := '';
                Separator3G := '';
                Separator4G := '';

                IF NOT LocationG.GET("Location Code") THEN
                    CLEAR(LocationG);
                IntCustL := CompanyInfoG."Internal Customer";
                IF LocationG."Internal Customer" <> '' THEN
                    IntCustL := LocationG."Internal Customer";
                IF (LocationG."Ship-to Address Code" <> '') AND
                   (OwnDelivAddressG.GET(IntCustL, LocationG."Ship-to Address Code"))
                THEN BEGIN
                    FormatAddrG.OwnCustomerAddress(CompanyAddrG, OwnDelivAddressG);
                    CoTelephoneG := OwnDelivAddressG."Phone No.";
                    CoFaxG := OwnDelivAddressG."Fax No.";
                    CoEmailG := OwnDelivAddressG."E-Mail";
                    IF PrintSentFromLineG THEN BEGIN
                        FormatAddrG.OwnAddressLetterWindow(CoAddrSenderLineG, OwnDelivAddressG);
                        IF CoAddrSenderLineG[2] <> '' THEN
                            SeparatorG := C_INC005;
                        IF CoAddrSenderLineG[3] <> '' THEN
                            Separator2G := C_INC005;
                        IF CoAddrSenderLineG[4] <> '' THEN
                            Separator3G := C_INC005;
                        IF CoAddrSenderLineG[5] <> '' THEN
                            Separator4G := C_INC005;
                        CompAddrG := CoAddrSenderLineG[1] + SeparatorG + CoAddrSenderLineG[2] + Separator2G + CoAddrSenderLineG[3] +
                          Separator3G + CoAddrSenderLineG[4] + Separator4G + CoAddrSenderLineG[5];
                    END;
                END ELSE BEGIN
                    FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
                    IF PrintSentFromLineG THEN BEGIN
                        FormatAddrG.CompanyLetterAddressWindow(CoAddrSenderLineG, CompanyInfoG);
                        IF CoAddrSenderLineG[2] <> '' THEN
                            SeparatorG := C_INC005;
                        IF CoAddrSenderLineG[3] <> '' THEN
                            Separator2G := C_INC005;
                        IF CoAddrSenderLineG[4] <> '' THEN
                            Separator3G := C_INC005;
                        IF CoAddrSenderLineG[5] <> '' THEN
                            Separator4G := C_INC005;
                        CompAddrG := CoAddrSenderLineG[1] + SeparatorG + CoAddrSenderLineG[2] + Separator2G + CoAddrSenderLineG[3] +
                          Separator3G + CoAddrSenderLineG[4] + Separator4G + CoAddrSenderLineG[5];
                    END;
                END;


                IF PrintAddrBlockG THEN BEGIN
                    CoTelephoneTextG := C_INC002;
                    CoFaxTextG := C_INC003;
                    CoEmailTextG := C_INC004;
                END ELSE BEGIN
                    CLEAR(CompanyAddrG);
                    CoTelephoneG := '';
                    CoFaxG := '';
                    CoEmailG := '';
                END;

                //Start API.1.0.3
                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccountL.RESET;
                IF bankAccountL.GET("Sales Header"."Bank Account Code") THEN BEGIN
                    BankNameG := bankAccountL.Name;
                    BankBranchNoG := bankAccountL."Bank Branch No."; //not used on layout
                                                                     //vapa??
                                                                     //  IF BankAccountNoG = '' THEN BEGIN
                                                                     //    BankAccountNoG := bankAccountL."Bank Account No.";
                                                                     //    BankIbanG:= bankAccountL.IBAN;
                                                                     //    BankSwiftG := bankAccountL."SWIFT Code";
                                                                     //  END;
                END;
                // IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                //  OwnBanksG.GET(IntCustL, LocationG."Bank Code")
                // THEN
                //  BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                // ELSE
                //  BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                //Start API.1.0.3

                SalesLineG.RESET;
                SalesLineG.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesLineG.SETRANGE("Document No.", "Sales Header"."No.");
                SalesLineG.SETRANGE("VAT Calculation Type", SalesLineG."VAT Calculation Type"::"Differential Tax");
                IF SalesLineG.FIND('-') THEN BEGIN
                    DiffTaxG := TRUE;
                    DoNotShowVATG := TRUE;
                    PrintDiscG := FALSE;
                END ELSE
                    DiffTaxG := FALSE;

                IF "Your Reference" = '' THEN
                    ReferenceTextG := ''
                ELSE
                    ReferenceTextG := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoTextG := ''
                ELSE
                    VATNoTextG := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE BEGIN
                    ShowCurrencyG := "Currency Code";
                END;
                IF DiffTaxG THEN
                    TotalInclVATTextG := STRSUBSTNO(C_INC010, ShowCurrencyG)
                ELSE
                    TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);
                FormatAddrG.SalesHeaderBillTo(CustAddrG, "Sales Header");

                // API.1.0.3
                IF NOT PaymentMethodG.GET("Sales Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // API.1.0.3

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipMethodG.INIT
                ELSE
                    ShipMethodG.GET("Shipment Method Code");

                FormatAddrG.SalesHeaderShipTo(ShipToAddrG, "Sales Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                IF AddressSalutationG.GET("Sales Header"."Bill-to Salutation Code") THEN
                    SalesAddrSaluationG := AddressSalutationG."Document Salutation";
                SeparatorG := '';
                Separator2G := '';
                Separator3G := '';
                Separator4G := '';

                IF "Sales Header"."Sell-to Customer No." <> "Sales Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesHeaderCust(OrderCustAddrG, "Sales Header");
                    IF OrderCustAddrG[2] <> '' THEN
                        SeparatorG := C_INC005;
                    IF OrderCustAddrG[3] <> '' THEN
                        Separator2G := C_INC005;
                    IF OrderCustAddrG[4] <> '' THEN
                        Separator3G := C_INC005;
                    IF OrderCustAddrG[5] <> '' THEN
                        Separator4G := C_INC005;
                    OrderCustAddrLineG := C_INC008 + OrderCustAddrG[1] + SeparatorG + OrderCustAddrG[2] + Separator2G + OrderCustAddrG[3] +
                      Separator3G + OrderCustAddrG[4] + Separator4G + OrderCustAddrG[5];
                END ELSE
                    OrderCustAddrLineG := '';


                IF PrintDiscG THEN BEGIN
                    DiscCheckSalLineG.SETRANGE("Document Type", "Document Type");
                    DiscCheckSalLineG.SETRANGE("Document No.", "No.");
                    DiscCheckSalLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckSalLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    "Sales Header"."Customer Confirmation Date" := TODAY;
                    "Sales Header".MODIFY;
                END;
                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Možnosti")
                {
                    Caption = 'Options';
                    field(NoOfCopiesG; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(PrintOptionG; PrintOptionG)
                    {
                        Caption = 'Print Option';
                    }
                    field(PrintUnitPriceG; PrintUnitPriceG)
                    {
                        Caption = 'Print Unit Price';
                    }
                    field(ShowUnitsofMeasureG; ShowUnitsofMeasureG)
                    {
                        Caption = 'Print UoM';
                    }
                    field(DoNotShowVATG; DoNotShowVATG)
                    {
                        Caption = 'Do not show VAT';
                    }
                    field(PrintSentFromLineG; PrintSentFromLineG)
                    {
                        Caption = 'Print Sent-From Line';
                    }
                    field(PrintAddrBlockG; PrintAddrBlockG)
                    {
                        Caption = 'Print Address Block';
                    }
                    field(PrintFooterLineG; PrintFooterLineG)
                    {
                        Caption = 'Print Footer Line';
                    }
                    field(RePrintOriginalInvG; RePrintOriginalInvG)
                    {
                        Caption = 'Re-print Original Invoice';
                        Editable = ReqRePrintControlG;
                        MultiLine = true;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA035597
            //NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(REPORT::"Veh. Confirmation/Invoice"); //API.1.0.3
            PrintOptionG := PrintOptionG::"print selected lines";
            PrintUnitPriceG := PrintUnitPriceG::"print selected prices";
            PrintDiscG := TRUE;

            // Start API.1.0.3
            GetReportSelection();
            // ReportSelectionG.SETCURRENTKEY("Report ID");
            // // Start PA035395.18593
            // ReportSelectionG.SETRANGE("Report ID", REPORT::"Veh. Confirmation/Invoice");
            // // Stop PA035395.18593
            // IF ReportSelectionG.FINDFIRST THEN BEGIN
            //  PrintSentFromLineG := ReportSelectionG."Print Sent-From Line";
            //  PrintAddrBlockG := ReportSelectionG."Print Address Block";
            // // Start PA035395.18593
            //  PrintFooterLineG := ReportSelectionG."Print Footer Line";
            // // Stop PA035395.18593
            // END ELSE BEGIN
            //  PrintSentFromLineG := TRUE;
            //  PrintAddrBlockG := TRUE;
            // END;
            // RePrintOriginalInvG := FALSE;
            //
            // IF UserSetupG.GET(USERID) THEN
            //  ReqRePrintControlG := TRUE
            // ELSE
            //  ReqRePrintControlG := FALSE;
            // // Stop PA035597
            // Stop API.1.0.3
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(REPORT::"Veh. Confirmation/Invoice"); API.1.0.3.
        // Start PA035597
        // Stop PA035597
        GLSetupG.GET;
        PrintOptionG := PrintOptionG::"print selected lines";
        PrintUnitPriceG := PrintUnitPriceG::"print selected prices";
        PrintDiscG := TRUE;
        // Start API.1.0.3
        GetReportSelection();
        // Start PA03333
        // PrintFooterLineG := TRUE;
        // // Stop PA033336
        // // Start PA035484.20759
        // ReportSelectionG.SETCURRENTKEY("Report ID");
        // ReportSelectionG.SETRANGE("Report ID", REPORT::"Veh. Confirmation/Invoice");
        // IF ReportSelectionG.FINDFIRST THEN BEGIN
        //  PrintSentFromLineG := ReportSelectionG."Print Sent-From Line";
        //  PrintAddrBlockG := ReportSelectionG."Print Address Block";
        //  PrintFooterLineG := ReportSelectionG."Print Footer Line";
        // // Stop PA035484.20759
        // // Start PA033336
        // // Stop PA033336
        // END ELSE BEGIN
        //  PrintSentFromLineG := TRUE;
        //  PrintAddrBlockG := TRUE;
        // // Start PA033336
        // // Stop PA033336
        // END;
        // Stop API.1.0.3
    end;

    var
        AddressSalutationG: Record "Address Salutation";
        ReportSelectionG: Record "Vehicle Sales Rep. Selection";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        DiscCheckSalLineG: Record "Sales Line";
        OptionVariantG: Record "Option Variant";
        SalesLineG: Record "Sales Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        UserSetupG: Record "User Setup";
        ReportSelection2G: Record "Vehicle Sales Rep. Selection";
        ReportLayoutSetupG: Record "Report Layout Setup";
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        SalesCountPrintedG: Codeunit "Sales-Printed";
        ShowCurrencyG: Text[30];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        SeparatorG: Text[2];
        Separator2G: Text[2];
        Separator3G: Text[2];
        Separator4G: Text[2];
        CopyTextG: Text[30];
        ShipToAddrG: array[8] of Text[50];
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        DiscTextG: Text[30];
        ReferenceTextG: Text[30];
        TotalInclVATTextG: Text[50];
        SalesAddrSaluationG: Text[30];
        VehicleDescriptionG: Text[100];
        DuplicateTextG: Text[30];
        VINOldG: Code[20];
        PrintOptionG: Option "print selected lines","print all lines","print no lines";
        PrintUnitPriceG: Option "print selected prices","print all prices","print no prices";
        ShowSalPriceG: Decimal;
        ShowLineDiscPctG: Decimal;
        DspAmountG: Decimal;
        CurrentVehicleG: Decimal;
        TotalVehG: Decimal;
        SumOwnOptG: Decimal;
        SumVehicleG: Decimal;
        SumTotVehicleG: Decimal;
        SumMfgOptG: Decimal;
        SumOtherG: Decimal;
        SumChargeItemsG: Decimal;
        SumTransferFeesG: Decimal;
        C_INC001: Label 'D U P L I C A T E';
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        C_INC008: Label 'Order Customer:';
        C_INC009: Label 'Disc. %';
        C_INC010: Label 'Ending Total %1';
        C_INC029: Label 'Copy';
        C_INC031: Label 'Total %1 Incl. VAT';
        TotalInvDiscAmtG: Decimal;
        TotalCurrVatAmtG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        OutputNoG: Integer;
        SalesLineItemTypeG: Integer;
        SalesLineTypeG: Integer;
        PageLoopFooterG: Integer;
        PrintOptionHelpG: Boolean;
        PrintUnitPriceHelpG: Boolean;
        RePrintOriginalInvG: Boolean;
        C_INC033: Label 'Vehicle Invoice Confirmation';
        [InDataSet]
        ReqRePrintControlG: Boolean;
        OptionFoundG: Boolean;
        ShowUnitsofMeasureG: Boolean;
        ShowShippingAddrG: Boolean;
        MoreLinesG: Boolean;
        PrintDiscG: Boolean;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        DoNotShowVATG: Boolean;
        DiffTaxG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        Sales_Header___No__CaptionLbl: Label 'Order No.';
        Sales_Header___Document_Date_CaptionLbl: Label 'Order Date';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        SalesPurch_NameCaptionLbl: Label 'Salesperson';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        Qty_CaptionLbl: Label 'Qty.';
        UoMLbl: Label 'UoM';
        Payments_to_CaptionLbl: Label 'Payments to:';
        CurrentVehicleCaptionLbl: Label 'Continued';
        CurrentVehicle_Control22CaptionLbl: Label 'Sum carried forward';
        SalesLine__Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        TotalCaption_Control34Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        VAT_onCaptionLbl: Label '% VAT on';
        ContinuedCaption_Control111Lbl: Label 'Continued';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        ReportTitleG: Text[250];
        ColonLbl: Label ': ';
        SlashLbl: Label ' / ';
        ReceiverLbl: Label 'Receiver';
        IssuedByLbl: Label 'Issued By';
        TaxRegNoLbl: Label 'Tax Reg.No.';
        VATRegNoLbl: Label 'VAT Reg.No.';
        RegNoLbl: Label 'Reg. No.';
        IbanSwiftLbl: Label 'IBAN/SWIFT';
        DocumentDateLbl: Label 'Date of Issue';
        BankInstitutionLbl: Label 'Banking Institution';
        PaymentMethodDescLbl: Label 'Payment method';
        BankAccountNoLbl: Label 'Account No.';
        PhoneLbl: Label 'Phone';
        SwiftLbl: Label 'SWIFT';
        Sales_Invoice_Header___Order_No__CaptionLbl: Label 'Order No.';
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        MakeCaptionLbl: Label 'Make';
        PaymentsLbl: Label 'Payments List';
        VATIdentLbl: Label 'VAT Recapitulation';
        VATPercentLbl: Label 'VAT %';
        VATBaseLbl: Label 'VAT Base';
        VATAmtLbl: Label 'VAT Amount';
        TotalLbl: Label 'total';
        VATLbl: Label 'VAT';
        ToDateLbl: Label 'to date';
        SumAdvancePaymentsLbl: Label 'Sum Advance Payments';
        RestToPayLbl: Label 'Rest to pay';
        WithoutVATLbl: Label 'without VAT';
        _incadea_vars: Integer;
        UserSessionG: Codeunit "User Session Unit";
        __API_vars: Integer;
        BankNameG: Text[50];
        BankBranchNoG: Text[20];
        BankSwiftG: Code[20];
        BankIbanG: Code[50];
        BankAccountNoG: Text[34];
        PaymentMethodG: Record "Payment Method";
        PrintDocTitleAndNoUpG: Boolean;
        TitleTextLeftG: Text;
        TitleTextCenterG: Text;
        TitleTextRightG: Text;
        ShowDuplicateImageG: Boolean;
        EmployeeFullNameG: Text;
        ShowVING: Boolean;
        ShowTaxNoG: Boolean;
        AmountWithoutLetterG: Decimal;
        LetterAmountG: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        VATAmountLetterG: Decimal;
        PreviousVATDocLetterNoG: Code[20];
        AmountIncludingVAT_SIH: Decimal;
        ExchRateText: Text[50];
        CalculatedExchRate: Decimal;
        TempVATAmountLineG: Record "VAT Amount Line" temporary;
        ExchPartsTaxAmountSumG: Decimal;
        VATPctG: Decimal;
        ExchTaxPctG: Decimal;
        ShowVehicleInfoG: Boolean;
        LanguageG: Record Language;

    [Scope('Internal')]
    procedure FunctionPrintUnitPrice(): Boolean
    begin
        IF ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND
           SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND
           NOT SalesLineG."Print Option Line" AND SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND
           NOT SalesLineG."Print Option Line" AND SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND
           SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           (PrintUnitPriceG = PrintUnitPriceG::"print no prices")
        THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure getSalPrice(SalesLineP: Record "Sales Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        OptionVariantL: Record "Option Variant";
        SalesPriceL: Decimal;
    begin
        // Start PA035597
        // Stop PA035597
        CurrentVehicleG := DspAmountG;
        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Inv.");
        OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        OptionVariantL.SETRANGE(Type, OptionVariantL.Type::Vehicle);
        IF OptionVariantL.FIND('-') THEN
            CASE ValueTypeP OF
                0:
                    SalesPriceL := OptionVariantL."Unit Price";
                1:
                    SalesPriceL := OptionVariantL."Amount Including VAT";
                2:
                    SalesPriceL := OptionVariantL.Amount;
            END
        ELSE
            SalesPriceL := 0;
        IF (PrintOptionG <> PrintOptionG::"print all lines") OR (PrintUnitPriceG <> PrintUnitPriceG::"print all prices") THEN BEGIN

            IF (PrintOptionG = PrintOptionG::"print selected lines") OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print no prices")) OR
               (PrintOptionG = PrintOptionG::"print no lines")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Inv.");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices"))
                THEN
                    OptionVariantL.SETRANGE("Print Unit Price", FALSE);
                IF OptionVariantL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                SalesPriceL += OptionVariantL."Unit Price";
                            1:
                                SalesPriceL += OptionVariantL."Amount Including VAT";
                            2:
                                SalesPriceL += OptionVariantL.Amount;
                        END;
                    UNTIL (OptionVariantL.NEXT = 0);
            END;

            IF (PrintOptionG = PrintOptionG::"print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Inv.");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                OptionVariantL.SETRANGE("Print Option Line", FALSE);
                OptionVariantL.SETRANGE("Print Unit Price", TRUE);
                IF OptionVariantL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                SalesPriceL += OptionVariantL."Unit Price";
                            1:
                                SalesPriceL += OptionVariantL."Amount Including VAT";
                            2:
                                SalesPriceL += OptionVariantL.Amount;
                        END;
                    UNTIL (OptionVariantL.NEXT = 0);
            END;
            IF (PrintOptionG = PrintOptionG::"print selected lines") OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print no prices")) OR
               (PrintOptionG = PrintOptionG::"print no lines")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices")) OR
                   ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices"))
                THEN
                    SalesLineL.SETRANGE("Print Unit Price", FALSE);
                IF SalesLineL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                SalesPriceL += SalesLineL."Unit Price";
                            1:
                                SalesPriceL += SalesLineL."Amount Including VAT";
                            2:
                                SalesPriceL += SalesLineL.Amount;
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;

            IF (PrintOptionG = PrintOptionG::"print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);

                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                SalesLineL.SETRANGE("Print Option Line", FALSE);
                SalesLineL.SETRANGE("Print Unit Price", TRUE);
                IF SalesLineL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                SalesPriceL += SalesLineL."Unit Price";
                            1:
                                SalesPriceL += SalesLineL."Amount Including VAT";
                            2:
                                SalesPriceL += SalesLineL.Amount;
                        END;
                    UNTIL (SalesLineL.NEXT = 0);

            END;
        END;
        EXIT(SalesPriceL);
    end;

    [Scope('Internal')]
    procedure getLineDiscPct(SalesLineP: Record "Sales Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        OptionVariantL: Record "Option Variant";
        LineDiscPctL: Decimal;
    begin
        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Inv.");
        OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        OptionVariantL.SETRANGE(Type, OptionVariantL.Type::Vehicle);
        IF OptionVariantL.FIND('-') THEN
            CASE ValueTypeP OF
                0:
                    IF (PrintUnitPriceG <> PrintUnitPriceG::"print no prices") THEN
                        LineDiscPctL := OptionVariantL."Line Discount %"
                    ELSE
                        LineDiscPctL := SalesLineP."Line Discount %";
                2:
                    LineDiscPctL := 0;
            END
        ELSE
            LineDiscPctL := 0;

        IF (PrintOptionG <> PrintOptionG::"print all lines") OR (PrintUnitPriceG <> PrintUnitPriceG::"print all prices") THEN BEGIN

            IF (PrintOptionG = PrintOptionG::"print selected lines") OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print no prices")) OR
               (PrintOptionG = PrintOptionG::"print no lines")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Inv.");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices"))
                THEN
                    OptionVariantL.SETRANGE("Print Unit Price", FALSE);
                IF OptionVariantL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += OptionVariantL."Line Discount %";
                            2:
                                LineDiscPctL += OptionVariantL."Line Discount Amount";
                        END;
                    UNTIL (OptionVariantL.NEXT = 0);
            END;

            IF (PrintOptionG = PrintOptionG::"print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Inv.");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                OptionVariantL.SETRANGE("Print Option Line", FALSE);
                OptionVariantL.SETRANGE("Print Unit Price", TRUE);
                IF OptionVariantL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += OptionVariantL."Line Discount %";
                            2:
                                LineDiscPctL += OptionVariantL."Line Discount Amount";
                        END;
                    UNTIL (OptionVariantL.NEXT = 0);
            END;

            IF (PrintOptionG = PrintOptionG::"print selected lines") OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print no prices")) OR
               (PrintOptionG = PrintOptionG::"print no lines")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print no prices")) OR
                   ((PrintOptionG = PrintOptionG::"print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print all prices")) OR
                   ((PrintOptionG = PrintOptionG::"print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"print selected prices"))
                THEN
                    SalesLineL.SETRANGE("Print Unit Price", FALSE);
                IF SalesLineL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += SalesLineL."Line Discount %";
                            2:
                                LineDiscPctL += SalesLineL."Inv. Discount Amount";
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;

            IF (PrintOptionG = PrintOptionG::"print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"print selected prices")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                SalesLineL.SETRANGE("Print Option Line", FALSE);
                SalesLineL.SETRANGE("Print Unit Price", TRUE);
                IF SalesLineL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += SalesLineL."Line Discount %";
                            2:
                                LineDiscPctL += SalesLineL."Inv. Discount Amount";
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;

        END;

        EXIT(LineDiscPctL);
    end;

    [Scope('Internal')]
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA035395.18593
        EXIT(NOT ShowOutputP);
        // Stop PA035395.18593
    end;

    [Scope('Internal')]
    procedure AddNoOfCopiesFromCust()
    var
        CustL: Record Customer;
        SalesHdrL: Record "Sales Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        SalesHdrL.SETRANGE(SalesHdrL."No.", "Sales Header".GETFILTER("No."));
        IF SalesHdrL.FINDSET THEN BEGIN
            IF NOT CustL.GET(SalesHdrL."Bill-to Customer No.") THEN
                CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
        END;
        // Stop PA043099
    end;

    [Scope('Internal')]
    procedure GetReportSelection()
    var
        RecordRefL: RecordRef;
        ReportIDTextL: Text;
        ReportIDL: Integer;
    begin
        // @ This function sets request page filters from Report Selection setup through User Session Unit.

        // Start PA039225.51457
        ReportSelectionG."Print Sent-From Line" := TRUE;
        ReportSelectionG."Print Address Block" := TRUE;
        ReportSelectionG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC033;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionG);
            IF ReportSelectionG."Print Report Title" THEN
                ReportTitleG := ReportSelectionG."Report Title"
            ELSE BEGIN
                ReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        PrintSentFromLineG := ReportSelectionG."Print Sent-From Line";
        PrintAddrBlockG := ReportSelectionG."Print Address Block";
        PrintFooterLineG := ReportSelectionG."Print Footer Line";
        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        // Stop PA039225.51457
    end;

    local procedure SetTitles()
    var
        headerGraphicCount: Integer;
    begin
        // @ This function sets variables to  identify whether and where (not) to print Report title and "Document No.", ... on layout
        // Start API.1.0.3
        PrintDocTitleAndNoUpG := (ReportLayoutSetupG."Auth. Left Line 1" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 2" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 3" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 4" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 5" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 1" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 2" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 3" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 4" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 5" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 1" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 2" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 3" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 4" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 5" = '');

        headerGraphicCount := 0;
        IF PrintDocTitleAndNoUpG THEN BEGIN
            IF (ReportLayoutSetupG."Header Graphic Left".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := '';
                TitleTextCenterG := ReportTitleG;
                TitleTextRightG := "Sales Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Header"."No.";
                TitleTextRightG := '';
            END;
        END ELSE BEGIN
            TitleTextLeftG := '';
            TitleTextCenterG := '';
            TitleTextRightG := '';
        END;
        IF headerGraphicCount > 1 THEN
            PrintDocTitleAndNoUpG := FALSE;
        // Stop API.1.0.3
    end;

    local procedure GetUserIDFullName(UserIDP: Code[50]) FullNameR: Text
    var
        userSetupL: Record "User Setup";
        employeeL: Record Employee;
    begin
        // @ This function get fullname from Employee table of passed user id
        // @ param UserIDP - Code[50]
        // @ retval FullNameR - Text
        // Start API.1.0.3
        FullNameR := '';
        IF userSetupL.GET(UserIDP) THEN BEGIN
            IF employeeL.GET(userSetupL."Employee No.") THEN
                FullNameR := employeeL.FullName;
        END;
        EXIT(FullNameR);
        // Stop API.1.0.3
    end;
}


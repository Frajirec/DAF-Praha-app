report 80018 "DPG Parts Purch. Invoice CZ" // 1057620 "Parts Purch. Invoice CZ"
{
    // // @ Area Parts Purchase
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033052   05.05.11 PR Added code to print the report title from 'Report Selection' setup.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   06.04.12 GE 7055966: Add functionality for Rem. Amount Status for Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   21.09.12 RDLC Development
    //                        - In request page editable code commented
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    // PA033336   17.10.12 SS 8746211: Modified Report - OnInitReport, OnOpenForm
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036461   22.08.14 GI 27191 Corrections in the rdlc
    // PA035484   02.04.14 GF 20946 Removed PrintFooterLineG variable and code because it is not used.
    // PA037341   22.01.15 GJ Merge N.6.1.4 to N.7.1.0 of PA035484.20946
    // PA036549   03.02.15 GP 33385 RDLC Layout corrections.
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   09.08.16 JS Merge of PA039225.51457
    // PA040445   18.07.16 VJ Merge of PA039225.51457
    // PA040833   30.05.16 KR Changed the Paper Size to A4 from letter.
    // PA040952   29.07.16 JS Merge of PA040833
    // PA042484   28.12.16 PT Added the code to print word Duplicate if its not a original invoice
    // PA042484   20.01.17 PT Added the text box in RDLC to print word "DUPLICATE"
    // PA042485   10.05.17 PT 95156 Added the check on NoOfCopies value if its less than 0
    // --- 7.1.5 ---
    // PA041023   28.11.16 KB Report modified to Show VIN field.
    // PA041023   03.02.17 SV 87225 Report Modified to Show "Refernece License No." information and Caption change of "Refernece VIN"
    // PA041187   12.04.17 AK 93990 Added deleted line in Documentation trigger
    // --- 7.1.6 ---
    // EU.0002138 28.06.17 AK 2101 Merge of PA042484 & PA042485.95156
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5028811 Parts Purch. Invoice
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsPurchInvoiceCZ.rdlc';

    Caption = 'Parts Purch. Invoice';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purch. Invoice Header"; "Purch. Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Parts Purch. Invoice';
            column(Purch__Invoice_Header_No_; "No.")
            {
            }
            column(Purch__Invoice_Header_Cash_Register_Receipt_No_; "Cash Register Receipt No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(VendAddr_1_; VendAddrG[1])
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
                    column(VendAddr_3_; VendAddrG[3])
                    {
                    }
                    column(VendAddr_4_; VendAddrG[4])
                    {
                    }
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(VendAddr_5_; VendAddrG[5])
                    {
                    }
                    column(CoFax; CoFaxG)
                    {
                    }
                    column(Purch__Invoice_Header___Document_Date_; FORMAT("Purch. Invoice Header"."Document Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(Purch__Invoice_Header___No__; "Purch. Invoice Header"."No.")
                    {
                    }
                    column(Purch__Invoice_Header___Order_No__; "Purch. Invoice Header"."Order No.")
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Purch__Invoice_Header___Order_Date_; FORMAT("Purch. Invoice Header"."Order Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(CustomerNoG; CustNoG)
                    {
                    }
                    column(VendAddr_2_; VendAddrG[2])
                    {
                    }
                    column(CoFaxText; CoFaxTextG)
                    {
                    }
                    column(CoEmailText; CoEmailTextG)
                    {
                    }
                    column(CoTelephoneText; CoTelephoneTextG)
                    {
                    }
                    column(VendAddr_6_; VendAddrG[6])
                    {
                    }
                    column(VendAddr_7_; VendAddrG[7])
                    {
                    }
                    column(VendAddr_8_; VendAddrG[8])
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(Vend__No__; VendG."No.")
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(OutputNo; CopyLoopNoG)
                    {
                        Description = 'PA033336,PA042484';
                    }
                    column(PayToAddrLineG; PayToAddrLineG)
                    {
                    }
                    column(Purch__Invoice_Header___No__Caption; Purch__Invoice_Header___No__CaptionLbl)
                    {
                    }
                    column(Purch__Invoice_Header___Document_Date_Caption; Purch__Invoice_Header___Document_Date_CaptionLbl)
                    {
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(CustomerNoGCaption; CustomerNoGCaptionLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
                    {
                    }
                    column(Purch__Invoice_Header___Order_No__Caption; Purch__Invoice_Header___Order_No__CaptionLbl)
                    {
                    }
                    column(Purch__Invoice_Header___Order_Date_Caption; Purch__Invoice_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(Vend__No__Caption; Vend__No__CaptionLbl)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA042484';
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Show_VIN_Boolean_Header; ShowVING)
                    {
                        Description = 'PA041023';
                    }
                    column(Purchase_Invoice_Header_VIN; "Purch. Invoice Header"."Supply VIN")
                    {
                        Description = 'PA041023';
                    }
                    column(Purchase_Invoice_Header_Reference_License_No; "Purch. Invoice Header"."Reference License No.")
                    {
                        Description = 'PA041023.87225';
                    }
                    column(IsRepSelectionSetupAvailableG; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Duplicate_Graphic_; ReportLayoutSetupG."Duplicate Graphic")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; ReportLayoutSetupG."One Column Footer")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Footer_6_6_; ReportLayoutSetupG."Footer 6-6")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_5_4_; ReportLayoutSetupG."Footer 5-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_6_4_; ReportLayoutSetupG."Footer 6-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_5_5_; ReportLayoutSetupG."Footer 5-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_6_5_; ReportLayoutSetupG."Footer 6-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_5_6_; ReportLayoutSetupG."Footer 5-6")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_3_; ReportLayoutSetupG."Footer 2-3")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_3_; ReportLayoutSetupG."Footer 3-3")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_3_; ReportLayoutSetupG."Footer 4-3")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_5_3_; ReportLayoutSetupG."Footer 5-3")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_6_3_; ReportLayoutSetupG."Footer 6-3")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_4_; ReportLayoutSetupG."Footer 2-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_4_; ReportLayoutSetupG."Footer 3-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_4_; ReportLayoutSetupG."Footer 4-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_5_; ReportLayoutSetupG."Footer 2-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_5_; ReportLayoutSetupG."Footer 3-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_5_; ReportLayoutSetupG."Footer 4-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_6_; ReportLayoutSetupG."Footer 2-6")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_6_; ReportLayoutSetupG."Footer 3-6")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_6_; ReportLayoutSetupG."Footer 4-6")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_6_2_; ReportLayoutSetupG."Footer 6-2")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_5_2_; ReportLayoutSetupG."Footer 5-2")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_2_; ReportLayoutSetupG."Footer 4-2")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_2_; ReportLayoutSetupG."Footer 3-2")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_2_; ReportLayoutSetupG."Footer 2-2")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_1_2_; ReportLayoutSetupG."Footer 1-2")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_1_3_; ReportLayoutSetupG."Footer 1-3")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_1_4_; ReportLayoutSetupG."Footer 1-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_1_5_; ReportLayoutSetupG."Footer 1-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_1_6_; ReportLayoutSetupG."Footer 1-6")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_1_1_; ReportLayoutSetupG."Footer 1-1")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_1_; ReportLayoutSetupG."Footer 2-1")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_1_; ReportLayoutSetupG."Footer 3-1")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_1_; ReportLayoutSetupG."Footer 4-1")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_5_1_; ReportLayoutSetupG."Footer 5-1")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_6_1_; ReportLayoutSetupG."Footer 6-1")
                    {
                        Description = 'PA033052';
                    }
                    column(Supply_VIN_Caption; Supply_VIN_Caption)
                    {
                    }
                    column(Reference_License_No; Reference_License_No)
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
                    column(PaymentMethodCode_PIH; "Purch. Invoice Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_PIH; "Purch. Invoice Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_PIH; "Purch. Invoice Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_PIH; "Purch. Invoice Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_PIH; "Purch. Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_PIH; "Purch. Invoice Header"."Tax Registration No.")
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
                    column(SellToAddr1; PayToAddrG[1])
                    {
                    }
                    column(SellToAddr2; PayToAddrG[2])
                    {
                    }
                    column(SellToAddr3; PayToAddrG[3])
                    {
                    }
                    column(SellToAddr4; PayToAddrG[4])
                    {
                    }
                    column(SellToAddr5; PayToAddrG[5])
                    {
                    }
                    column(SellToAddr6; PayToAddrG[6])
                    {
                    }
                    column(SellToAddr7; PayToAddrG[7])
                    {
                    }
                    column(SellToAddr8; PayToAddrG[8])
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
                    column(DueDate_PIH; "Purch. Invoice Header"."Due Date")
                    {
                    }
                    column(DueDateCpn_PIH; "Purch. Invoice Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_PIH; "Purch. Invoice Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_PIH; "Purch. Invoice Header".FIELDCAPTION("Variable Symbol"))
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
                    dataitem("Header Text"; "Posted Purchase Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Header));
                        column(COPYSTR_Text_1_80_; COPYSTR(Text, 1, 80))
                        {
                        }
                        column(COPYSTR_Text_81_20_; COPYSTR(Text, 81, 20))
                        {
                        }
                        column(Header_Text_Document_Type; "Document Type")
                        {
                        }
                        column(Header_Text_Document_No_; "Document No.")
                        {
                        }
                        column(Header_Text_Header_Footer; "Header/Footer")
                        {
                        }
                        column(Header_Text_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem("Purch. Inv. Line"; "Purch. Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(DiscText; DiscTextG)
                        {
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purch__Inv__Line_Description; Description)
                        {
                        }
                        column(Purch__Inv__Line__Purch__Inv__Line__Type; "Purch. Inv. Line".Type)
                        {
                            Description = 'PA033336';
                        }
                        column(PurchTypeG; PurchTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Purch__Inv__Line_Description_Control65; Description)
                        {
                        }
                        column(Purch__Inv__Line_Quantity; Quantity)
                        {
                        }
                        column(Purch__Inv__Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Purch__Inv__Line__Direct_Unit_Cost_; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purch__Inv__Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control70; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintNo; PrintNoG)
                        {
                        }
                        column(Purch__Inv__Line_Description_Control73; Description)
                        {
                        }
                        column(Purch__Inv__Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Purch__Inv__Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Purch__Inv__Line__Direct_Unit_Cost__Control84; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purch__Inv__Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control86; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control1109400002; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purch__Inv__Line__Direct_Unit_Cost__Control1109400003; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purch__Inv__Line__Line_Discount____Control1109400004; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Purch__Inv__Line_Quantity_Control1109400005; Quantity)
                        {
                        }
                        column(Purch__Inv__Line__Unit_of_Measure__Control1109400006; "Unit of Measure")
                        {
                        }
                        column(Purch__Inv__Line_Description_Control1109400007; Description)
                        {
                        }
                        column(PrintNo_Control1109400008; PrintNoG)
                        {
                        }
                        column(Purch__Inv__Line__Description_2_; "Description 2")
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ShowCurrency; ShowCurrencyG)
                        {
                        }
                        column(Purch__Inv__Line__Purch__Inv__Line__Amount; "Purch. Inv. Line".Amount)
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purch__Inv__Line___Amount_Including_VAT_____Purch__Inv__Line__Amount____Exch__Parts_Tax_Amount_; "Purch. Inv. Line"."Amount Including VAT" - "Purch. Inv. Line".Amount - "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPct; VATPctG)
                        {
                        }
                        column(Purch__Inv__Line__VAT_Base_Amount_; "VAT Base Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(Purch__Inv__Line__Exch__Parts_Tax_Amount_; "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct; ExchTaxPctG)
                        {
                        }
                        column(Purch__Inv__Line__Exch__Parts_Tax_Base_; "Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Purch__Inv__Line__Purch__Inv__Line___Amount_Including_VAT_; "Purch. Inv. Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(No_Caption; No_CaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
                        {
                        }
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125Caption; Amount____Inv__Discount_Amount__Control125CaptionLbl)
                        {
                        }
                        column(SumItemCaption; SumItemCaptionLbl)
                        {
                        }
                        column(SumOtherCaption; SumOtherCaptionLbl)
                        {
                        }
                        column(Inv__Discount_Amount_Caption; Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(VAT_ofCaption; VAT_ofCaptionLbl)
                        {
                        }
                        column(Exch__Tax_fromCaption; Exch__Tax_fromCaptionLbl)
                        {
                        }
                        column(Purch__Inv__Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purch__Inv__Line_Line_No_; "Line No.")
                        {
                        }
                        column(Purchase_Invoice_Line_VIN; "Purch. Inv. Line"."Supply VIN")
                        {
                            Description = 'PA041023';
                        }
                        column(Purchase_Invoice_Line_Reference_License_No; "Purch. Inv. Line"."Reference License No.")
                        {
                            Description = 'PA041023.87225';
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemL: Record Item;
                        begin
                            VATAmountLineG.INIT;
                            // Start PA033011.5983155
                            VATAmountLineG."VAT Identifier" := FORMAT("VAT %");
                            VATAmountLineG."Sales Amount" := Amount;
                            // Stop PA033011.5983155
                            VATAmountLineG."VAT %" := "VAT %";
                            //IF "VAT %" <> 0 THEN
                            IF ("VAT %" <> 0) AND (Quantity <> 0) THEN
                                VATPctG := "VAT %";
                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."VAT Base" := "VAT Base Amount";
                            // Start PA032441
                            // Stop PA032441
                            //IF "Exch. Parts VAT %" <> 0 THEN
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                                ExchTaxPctG := "Exch. Parts VAT %";

                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLineG.InsertLine;
                            NoPropertyG := '';
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                                NoPropertyG := C_INC016;
                            IF Type = Type::Item THEN
                                SumItemG := SumItemG + Amount + "Inv. Discount Amount"
                            ELSE
                                SumOtherG := SumOtherG + Amount + "Inv. Discount Amount";

                            // Start PA035597
                            PurchTypeG := Type;
                            IF ("Line Discount Amount" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                "Direct Unit Cost" := (Amount + "Inv. Discount Amount") / Quantity;
                                "Line Discount %" := 0;
                            END;

                            PrintNoG := "No.";
                            IF Type = Type::Item THEN
                                IF ItemL.GET("No.") THEN
                                    IF ItemL."Manufacturer No." <> '' THEN
                                        PrintNoG := ItemL."Manufacturer No.";
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            CurrReport.CREATETOTALS("Line Discount Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Exch. Parts Tax Amount",
                              "Exch. Parts Tax Base", "VAT Base Amount");

                            VATPctG := 0;
                            ExchTaxPctG := 0;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrency_Control37; ShowCurrencyG)
                        {
                        }
                        column(Purch__Inv__Line__Amount; "Purch. Inv. Line".Amount)
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control106; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control107; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_COUNT_Control1101315985; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base__Control110; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct_Control94; ExchTaxPctG)
                        {
                        }
                        column(Purch__Inv__Line___Exch__Parts_Tax_Amount_; "Purch. Inv. Line"."Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(C_INC016_Control23; C_INC016)
                        {
                        }
                        column(TotalInclVATText_Control44; TotalInclVATTextG)
                        {
                        }
                        column(Purch__Inv__Line___Amount_Including_VAT_; "Purch. Inv. Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Purch. Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control98; TotalCaption_Control98Lbl)
                        {
                        }
                        column(ContinuedCaption_Control101; ContinuedCaption_Control101Lbl)
                        {
                        }
                        column(VAT_ofCaption_Control100; VAT_ofCaption_Control100Lbl)
                        {
                        }
                        column(ContinuedCaption_Control109; ContinuedCaption_Control109Lbl)
                        {
                        }
                        column(Exch__Tax_fromCaption_Control108; Exch__Tax_fromCaption_Control108Lbl)
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
                    dataitem("Footer Text"; "Posted Purchase Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Footer));
                        column(COPYSTR_Text_1_80__Control30; COPYSTR(Text, 1, 80))
                        {
                        }
                        column(COPYSTR_Text_81_20__Control1109400001; COPYSTR(Text, 81, 20))
                        {
                        }
                        column(Footer_Text_Document_Type; "Document Type")
                        {
                        }
                        column(Footer_Text_Document_No_; "Document No.")
                        {
                        }
                        column(Footer_Text_Header_Footer; "Header/Footer")
                        {
                        }
                        column(Footer_Text_Line_No_; "Line No.")
                        {
                        }
                        column(HideFooterTextBody2; NOT (STRLEN("Footer Text".Text) > 80))
                        {
                            Description = 'PA036461.27191';
                        }
                    }
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt No.");
                        DataItemLinkReference = "Purch. Invoice Header";
                        DataItemTableView = SORTING("No.") WHERE("Type of Document to be Printed" = CONST("Purch. Invoice"));
                        column(Posted_Cash_Register_Header__Payment__In_Out__; "Payment (In/Out)")
                        {
                        }
                        column(Posted_Cash_Register_Header_No_; "No.")
                        {
                        }
                        dataitem("Cash Reg. Add Disc Split Post."; "Cash Reg. Add Disc Split Post.")
                        {
                            DataItemLink = "Applies-to ID" = FIELD("No.");
                            DataItemTableView = SORTING("Source Type", "Source No.", "Applies-to ID");
                            column(Cash_Reg__Add_Disc_Split_Post___Posting_Date_; FORMAT("Posting Date"))
                            {
                                Description = 'PA033336';
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_; "Appl.-to Document Type")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__; "Appl.-to Document No.")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Currency_Code_; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Remaining_Amount_; "Remaining Amount")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Pmt__Discount_Total_; "Pmt. Discount Total")
                            {
                            }
                            column(AmountMinusDiscount; AmountMinusDiscG)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Posting_Date_Caption; Cash_Reg__Add_Disc_Split_Post___Posting_Date_CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_Caption; Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__Caption; Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Currency_Code_Caption; Cash_Reg__Add_Disc_Split_Post___Currency_Code_CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Remaining_Amount_Caption; Cash_Reg__Add_Disc_Split_Post___Remaining_Amount_CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Pmt__Discount_Total_Caption; Cash_Reg__Add_Disc_Split_Post___Pmt__Discount_Total_CaptionLbl)
                            {
                            }
                            column(AmountMinusDiscountCaption; AmountMinusDiscountCaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Entry_No_; "Entry No.")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Source_Type; "Source Type")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Document_No_; "Document No.")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Applies_to_ID; "Applies-to ID")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                AmountMinusDiscG := "Cash Reg. Add Disc Split Post."."Remaining Amount" - "Cash Reg. Add Disc Split Post.".
                                  "Pmt. Discount Total";
                                IF ("Appl.-to Document Type" = "Appl.-to Document Type"::Payment) OR
                                   ("Appl.-to Document Type" = "Appl.-to Document Type"::" ")
                                THEN BEGIN
                                    AmountMinusDiscG := -ABS(AmountMinusDiscG);
                                    "Cash Reg. Add Disc Split Post."."Remaining Amount" := -ABS("Cash Reg. Add Disc Split Post."."Remaining Amount");
                                    "Cash Reg. Add Disc Split Post."."Pmt. Discount Total" := -ABS("Cash Reg. Add Disc Split Post."."Pmt. Discount Total");
                                END ELSE BEGIN
                                    AmountMinusDiscG := ABS(AmountMinusDiscG);
                                    "Cash Reg. Add Disc Split Post."."Remaining Amount" := ABS("Cash Reg. Add Disc Split Post."."Remaining Amount");
                                    "Cash Reg. Add Disc Split Post."."Pmt. Discount Total" := ABS("Cash Reg. Add Disc Split Post."."Pmt. Discount Total");
                                END;
                            end;
                        }
                        dataitem("Posted Cash Register Line"; "Posted Cash Register Line")
                        {
                            DataItemLink = "Document No." = FIELD("No.");
                            DataItemTableView = SORTING("Document No.", "Line No.");
                            column(Posted_Cash_Register_Header___Currency_Code_; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Amount_to_Pay__LCY__; "Posted Cash Register Header"."Amount to Pay (LCY)")
                            {
                            }
                            column(Posted_Cash_Register_Line__Means_of_Payment_Code_; "Means of Payment Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Line__Currency_Code_; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Line_Amount; Amount)
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_; "Posted Cash Register Header"."Amount Given")
                            {
                            }
                            column(Posted_Cash_Register_Header___Currency_Code__Control131; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Currency_Code__Control132; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Change_Money_; "Posted Cash Register Header"."Change Money")
                            {
                            }
                            column(RemainingStatusTextG; RemainingStatusTextG)
                            {
                            }
                            column(RemainingAmountTextG; RemainingAmountTextG)
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_to_Pay__LCY__Caption; Posted_Cash_Register_Header___Amount_to_Pay__LCY__CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_Caption; Posted_Cash_Register_Header___Amount_Given_CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Header___Change_Money_Caption; Posted_Cash_Register_Header___Change_Money_CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Line_Document_No_; "Document No.")
                            {
                            }
                            column(Posted_Cash_Register_Line_Line_No_; "Line No.")
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033086.7055966
                            RemainingAmountTextG := '';
                            IF "Posted Cash Register Header"."Rem. Outstanding Status" <> 0 THEN BEGIN
                                RemainingStatusTextG := C_INC_RemainingStatus;
                                CASE "Posted Cash Register Header"."Rem. Outstanding Status" OF
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Remaining Amount":
                                        RemainingAmountTextG := C_INC_RemainingAmount;
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Payment Tolerance":
                                        RemainingAmountTextG := C_INC_PaymTolerance;
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Payment Discount Tolerance":
                                        RemainingAmountTextG := C_INC_PaymentDiscTolerance;
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Both Payment Tolerances":
                                        RemainingAmountTextG := C_INC_BothPaymentTolerance;
                                END;
                            END;
                            // Stop PA033086.7055966
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT PmtMethodG.GET("Purch. Invoice Header"."Payment Method Code") OR NOT PmtMethodG."Cash Payment" THEN BEGIN
                                CurrReport.BREAK;
                            END;
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PaymentTerms_Description; PaymentTermsG.Description)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddrG THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    // Start PA033336
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;
                    // Start PA042484
                    ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    IF ("Purch. Invoice Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN  //API.1      01.03.18 PV
                            DuplicateTextG := C_INC_DuplicateText
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV
                    CopyLoopNoG := CopyLoopNoG + 1;
                    // Stop PA042484
                    SumItemG := 0;
                    SumOtherG := 0;
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        PurchInvCountPrintedG.RUN("Purch. Invoice Header");
                    // Stop PA032727
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA042484
                    CopyTextG := '';
                    SETRANGE(Number, 1, ABS(NoOfCopiesG) + 1);
                    DuplicateTextG := '';
                    // Stop PA042484
                end;
            }

            trigger OnAfterGetRecord()
            var
                OurAccNoL: Record "Our Account/Dealer No.";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                //Start API.1      01.03.18 PV
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Parts Purch. Invoice CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                //Stop API.1      01.03.18 PV

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Purch. Invoice Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Purch. Invoice Header"."User ID");
                //Stop API.1      01.03.18 PV

                IF NOT LocationG.GET("Location Code") THEN
                    CLEAR(LocationG);
                IntCustG := CompanyInfoG."Internal Customer";
                IF LocationG."Internal Customer" <> '' THEN
                    IntCustG := LocationG."Internal Customer";
                IF (LocationG."Ship-to Address Code" <> '') AND
                   (OwnDelivAddressG.GET(IntCustG, LocationG."Ship-to Address Code"))
                THEN BEGIN
                    FormatAddrG.OwnCustomerAddress(CompanyAddrG, OwnDelivAddressG);
                    CoTelephoneG := OwnDelivAddressG."Phone No.";
                    CoFaxG := OwnDelivAddressG."Fax No.";
                    CoEmailG := OwnDelivAddressG."E-Mail";
                    FormatAddrG.OwnAddressLetterWindow(CoAddrSenderLineG, OwnDelivAddressG);
                END ELSE BEGIN
                    FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
                    FormatAddrG.CompanyLetterAddressWindow(CoAddrSenderLineG, CompanyInfoG);
                END;
                IF PrintSentFromLineG THEN
                    CompAddrG := FormatAddrG.GetWindowAddress(C_INC005);


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

                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE BEGIN
                    ShowCurrencyG := "Currency Code";
                END;
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);

                FormatAddrG.PurchInvBuyFrom(VendAddrG, "Purch. Invoice Header");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Purch. Invoice Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // Stop API.1      01.03.18 PV

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipMethodG.INIT
                ELSE
                    ShipMethodG.GET("Shipment Method Code");

                //
                ShowShippingAddrG := "Buy-from Vendor No." <> "Pay-to Vendor No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> VendAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                IF NOT SalesPurchG.GET("Purchaser Code") THEN
                    SalesPurchG.Name := "Purchaser Code";

                IF "Buy-from Vendor No." <> '' THEN
                    VendG.GET("Buy-from Vendor No.");

                IF "Purch. Invoice Header"."Pay-to Vendor No." <> "Purch. Invoice Header"."Buy-from Vendor No." THEN BEGIN
                    FormatAddrG.PurchInvPayAddr(PayToAddrG, "Purch. Invoice Header");
                    PayToAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    PayToAddrLineG := '';

                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscCheckPurchInvLineG.SETRANGE("Document No.", "No.");
                    DiscCheckPurchInvLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckPurchInvLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(14) <> '';
                    IF LogInteractionG THEN
                        SegMgntG.LogDocument(
                          14, "No.", 0, 0, DATABASE::Vendor, "Pay-to Vendor No.",
                          "Purchaser Code", '', "Posting Description");
                END;
                CustNoG := OurAccNoL.GetOurAccDealerNo("Buy-from Vendor No.", "Shortcut Dimension 2 Code", "Location Code", "Order Type" + 1);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                // Start PA042484
                CopyLoopNoG := 0;
                // Stop PA042484
            end;
        }
    }

    requestpage
    {
        Caption = 'Parts Purchases - Invoice';
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

                        trigger OnValidate()
                        begin
                            // Start PA042485.95156
                            IF NoOfCopiesG < 0 THEN
                                ERROR(C_INC_NoOfCopiesValue);
                            //Stop PA042485.95156
                        end;
                    }
                    field(PrintSentFromLineG; PrintSentFromLineG)
                    {
                        Caption = 'Print Sent-From Line';
                    }
                    field(PrintAddrBlockG; PrintAddrBlockG)
                    {
                        Caption = 'Print Address Block';
                    }
                    field("Print VIN"; ShowVING)
                    {
                        Caption = 'Print VIN/License No';
                        Description = 'PA041023.87225';
                    }
                    field("Re-Print Original Invoice"; RePrintOriginalInvG)
                    {
                        Caption = 'Re-Print Original Invoice';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA032727
            // Start PA039225.51457
            // Start PA033336
            // Stop PA033336
            // Start PA033336
            // Stop PA033336
            // Stop PA032727
            GetReportSelection();
            // Stop PA039225.51457
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetupG.GET;
        // Start PA035484.20946
        // Stop PA035484.20946
        // Stop PA033336
        // Start PA032727
        // Start PA039225.51457
        // Start PA035597
        // Stop PA035597
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        // Stop PA032727
        GetReportSelection();
        // Stop PA039225.51457
    end;

    var
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Report Selection";
        PrinterSelectionG: Record "Printer Selection";
        OwnDelivAddressG: Record "Ship-to Address";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        VendG: Record Vendor;
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        DiscCheckPurchInvLineG: Record "Purch. Invoice Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        ReportSelection2G: Record "Report Selection";
        PmtMethodG: Record "Payment Method";
        PurchInvCountPrintedG: Codeunit "Purch. Inv.-Printed";
        SegMgntG: Codeunit SegManagement;
        FormatAddrG: Codeunit "Format Address";
        UserSessionG: Codeunit "User Session Unit";
        PrintNoG: Code[20];
        IntCustG: Code[20];
        ShowCurrencyG: Text[30];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        TotalInclVATTextG: Text[50];
        VendAddrG: array[8] of Text[50];
        ShipToAddrG: array[8] of Text[50];
        CompAddrG: Text[250];
        CopyTextG: Text[30];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        DiscTextG: Text[30];
        PayToAddrG: array[8] of Text[50];
        PayToAddrLineG: Text[250];
        CustNoG: Text[30];
        NoPropertyG: Text[30];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        DuplicateTextG: Text[100];
        ExchTaxPctG: Decimal;
        AmountMinusDiscG: Decimal;
        SumItemG: Decimal;
        SumOtherG: Decimal;
        VATPctG: Decimal;
        NoOfCopiesG: Integer;
        [InDataSet]
        CopyLoopNoG: Integer;
        IG: Integer;
        PurchTypeG: Integer;
        ShowShippingAddrG: Boolean;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Payment due on:';
        C_INC009: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC029: Label 'Copy';
        C_INC031: Label 'Total %1 Incl. VAT';
        LogInteractionG: Boolean;
        _INCADEA_: Boolean;
        C_INC032: Label 'Parts Purch. Invoice';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        C_INC_DuplicateText: Label 'D U P L I C A T E';
        C_INC_NoOfCopiesValue: Label 'Please enter value greater than 0 or equal to 0';
        Purch__Invoice_Header___No__CaptionLbl: Label 'Invoice No.';
        Purch__Invoice_Header___Document_Date_CaptionLbl: Label 'Invoice Date';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        CustomerNoGCaptionLbl: Label 'Our Customer No.';
        SalesPurch_NameCaptionLbl: Label 'Purchaser';
        Purch__Invoice_Header___Order_No__CaptionLbl: Label 'Purch. Order No.';
        Purch__Invoice_Header___Order_Date_CaptionLbl: Label 'Order Date';
        Vend__No__CaptionLbl: Label 'Vendor No.';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        ContinuedCaptionLbl: Label 'Continued';
        Amount____Inv__Discount_Amount__Control125CaptionLbl: Label 'Sum carried forward';
        SumItemCaptionLbl: Label 'Sum Item';
        SumOtherCaptionLbl: Label 'Sum Other';
        Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        VAT_ofCaptionLbl: Label '% VAT of';
        Exch__Tax_fromCaptionLbl: Label '% Exch. Tax from';
        TotalCaption_Control98Lbl: Label 'Total';
        ContinuedCaption_Control101Lbl: Label 'Continued';
        VAT_ofCaption_Control100Lbl: Label '% VAT of';
        ContinuedCaption_Control109Lbl: Label 'Continued';
        Exch__Tax_fromCaption_Control108Lbl: Label '% Exch. Tax from';
        Cash_Reg__Add_Disc_Split_Post___Posting_Date_CaptionLbl: Label 'Date';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_CaptionLbl: Label 'Type';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__CaptionLbl: Label 'Document Number';
        Cash_Reg__Add_Disc_Split_Post___Currency_Code_CaptionLbl: Label 'Currency';
        Cash_Reg__Add_Disc_Split_Post___Remaining_Amount_CaptionLbl: Label 'Remaining Amount';
        Cash_Reg__Add_Disc_Split_Post___Pmt__Discount_Total_CaptionLbl: Label 'PmtDisc';
        AmountMinusDiscountCaptionLbl: Label 'Amount';
        Posted_Cash_Register_Header___Amount_to_Pay__LCY__CaptionLbl: Label 'Amount to Pay';
        Posted_Cash_Register_Header___Amount_Given_CaptionLbl: Label 'Amount given';
        Posted_Cash_Register_Header___Change_Money_CaptionLbl: Label 'Change Money';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        ReportTitleG: Text[100];
        ShowVING: Boolean;
        RePrintOriginalInvG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
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
        LanguageG: Record Language;
        Supply_VIN_Caption: Label 'Reference VIN';
        Reference_License_No: Label 'Reference License No.';
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
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC032;
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

        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        // Stop PA039225.51457
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

    local procedure SetTitles()
    var
        headerGraphicCount: Integer;
    begin
        // @ This function sets variables to  identify whether and where (not) to print Report title and "Document No.", ... on layout
        // Start API.1      01.03.18 PV
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
                TitleTextRightG := "Purch. Invoice Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Purch. Invoice Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Purch. Invoice Header"."No.";
                TitleTextRightG := '';
            END;
        END ELSE BEGIN
            TitleTextLeftG := '';
            TitleTextCenterG := '';
            TitleTextRightG := '';
        END;
        IF headerGraphicCount > 1 THEN
            PrintDocTitleAndNoUpG := FALSE;
        // Stop API.1      01.03.18 PV
    end;

    local procedure GetUserIDFullName(UserIDP: Code[50]) FullNameR: Text
    var
        userSetupL: Record "User Setup";
        employeeL: Record Employee;
    begin
        // @ This function get fullname from Employee table of passed user id
        // @ param UserIDP - Code[50]
        // @ retval FullNameR - Text
        // Start API.1      01.03.18 PV
        FullNameR := '';
        IF userSetupL.GET(UserIDP) THEN BEGIN
            IF employeeL.GET(userSetupL."Employee No.") THEN
                FullNameR := employeeL.FullName;
        END;
        EXIT(FullNameR);
        // Stop API.1      01.03.18 PV
    end;
}


report 80028 "DPG Service Internal Cr. Memo" // 1057612 "Service Internal Credit MemoCZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   05.08.10 Changes made to print original/duplicate invoices.
    // PA032178   27.10.10 DD 1798176 docu trigger and version list corrected.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   14.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Report Layout Concept incorporated.
    // PA033336   03.10.12 8747489: Provided space between the 'Qty.' and 'UoM' column.Proper Alignment for ReportTitle
    //                        Formatting of Pickup Date and time
    // PA033336   17.10.12 SS 8746211
    //                        - Modified "Sales Credit Memo Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (4) - OnPreSection()"
    // PA033336   05.11.12 SS 8719075
    //                        - Added Text Constant C_INC040 to "* = Exchange Part".
    //                        - Code changes in "Sales Credit Memo Line - OnPreDataItem()"
    //                        - Code changes in "Sales Credit Memo Line - OnAfterGetRecord()"
    //                        - Modified Section "Sales Credit Memo Line, Body (4)"
    //                        - New Section "Sales Credit Memo Line, Footer (15)"
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033988   10.05.13 SM Reason Code field is promoted on a header of the printout.
    // PA033988   28.05.13 SM I001012: Print Reason Code field is is set to TRUE by default.
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA035395   27.12.13 GD 18593 Fixed FooterLines and Duplicate visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   01.04.14 GF 20864 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   12.01.15 GD 32439 RDL Layout issues fixed.
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035484.20864
    // PA036549   29.01.15 GN 33286 Visibility for Reason Code field is fixed
    //                        Set Request Page booleans to get their values from report selection
    //                        Visibility of header images fixed
    // PA037047   03.09.15 LR 44308 Correctly filter in RDLC
    // PA040669   25.05.16 GV 61670 RDLC layout modifications
    // PA040669   31.05.16 GD 61670 RDLC layout modifications
    // PA040669   01.06.16 GV 61670 Change visibility of own options section
    //                        Change layout of Vehicle Data section
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA041125   12.08.16 GN 68077 RDLC Layout Modifications
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5025605 Service Credit Memo
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed, translation
    //                        Final design of vehicle/contract info part of header
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, Bank source, Final header design
    //                        SK legislation,
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceInternalCrMemo.rdlc';

    Caption = 'Service Internal Credit Memo';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Credit Memo Header"; "Sales Credit Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Internal Invoice';
            column(Sales_Credit_Memo_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(PrintReasonCode_G; PrintReasonCodeG)
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
                        Description = 'PA040669.61670';
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA040669.61670';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ServiceHeaderG__Pickup_Time_; FORMAT(ServHdrG."Pickup Time", 0, '<Hours24,2> : <Minutes,2>'))
                    {
                        Description = 'PA033336';
                    }
                    column(ServiceHeaderG__Pickup_Date_; FORMAT(ServHdrG."Pickup Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Credit_Memo_Header___Service_Order_No__; "Sales Credit Memo Header"."Service Order No.")
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(ServiceHeaderG__Order_Date_; FORMAT(ServHdrG."Order Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
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
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(CoFax; CoFaxG)
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(CoEmailText; CoEmailTextG)
                    {
                    }
                    column(ServiceHeaderG__Time_of_Order_; FORMAT(ServHdrG."Time of Order", 0, '<Hours24,2> : <Minutes,2>'))
                    {
                    }
                    column(ServiceHeaderG__License_No__; ServHdrG."License No.")
                    {
                    }
                    column(Make_Name; MakeG.Name)
                    {
                    }
                    column(ServiceHeaderG_Model; ServHdrG.Model)
                    {
                    }
                    column(ServiceHeaderG_VIN; ServHdrG.VIN)
                    {
                    }
                    column(ServiceHeaderG__Initial_Registration_; FORMAT(ServHdrG."Initial Registration"))
                    {
                        Description = 'PA033336';
                    }
                    column(ServiceHeaderG_Mileage; ServHdrG.Mileage)
                    {
                        DecimalPlaces = 0 : 0;
                        Description = 'PA040669.61670';
                    }
                    column(ServAdvisor; ServAdvisorG)
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
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
                    column(CustAddr_5_; CustAddrG[5])
                    {
                    }
                    column(CustAddr_6_; CustAddrG[6])
                    {
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(SalesPurch_Name_Control46; SalesPurchG.Name)
                    {
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
                    {
                    }
                    column(Sales_Credit_Memo_Header___No__; "Sales Credit Memo Header"."No.")
                    {
                    }
                    column(Collective_TextShowOutput_C_INC032__PrintAddrBlock_; CollectiveG.TextShowOutput(C_INC032, PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo_FIELDCAPTION__VAT_Registration_No_____PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__VAT_Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(ServiceHeaderG__Guide_No__; ServHdrG."Guide No.")
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA031550';
                    }
                    column(OutputNoG; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA039504';
                    }
                    column(ReportLayoutSetup1G_Duplicate_Graphic1; ReportLayoutSetupG."Duplicate Graphic")
                    {
                        Description = 'PA033336';
                    }
                    column(Print_Reason_Code; FORMAT(PrintReasonCodeG, 0, 2))
                    {
                        Description = 'PA033988';
                    }
                    column(Sales_Credit_Memo_Header___Reason_Code__; "Sales Credit Memo Header"."Reason Code")
                    {
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(NoPrinted_; RDLHideOutput("Sales Credit Memo Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(BankText; BankTextG)
                    {
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField43; RDLHideOutput(PrintFooterLineG AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ReportLayoutSetupG__Footer_6_6_; ReportLayoutSetupG."Footer 6-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_5_6_; ReportLayoutSetupG."Footer 5-6")
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
                    column(ReportLayoutSetupG__Footer_4_5_; ReportLayoutSetupG."Footer 4-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_6_; ReportLayoutSetupG."Footer 4-6")
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
                    column(ReportLayoutSetupG__Footer_4_4_; ReportLayoutSetupG."Footer 4-4")
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
                    column(ReportLayoutSetupG__Footer_3_3_; ReportLayoutSetupG."Footer 3-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_4_; ReportLayoutSetupG."Footer 3-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_5_; ReportLayoutSetupG."Footer 3-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_3_6_; ReportLayoutSetupG."Footer 3-6")
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
                    column(ReportLayoutSetupG__Footer_2_3_; ReportLayoutSetupG."Footer 2-3")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_4_; ReportLayoutSetupG."Footer 2-4")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_5_; ReportLayoutSetupG."Footer 2-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_6_; ReportLayoutSetupG."Footer 2-6")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_2_2_; ReportLayoutSetupG."Footer 2-2")
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
                    column(sep1; FORMAT('-----------------------------------------------------------------------------------------'))
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(CopyTextG; CopyTextG)
                    {
                        Description = 'PA040669.61670';
                    }
                    column(Sales_Credit_Memo_Header___VAT_Registration_No__; "Sales Credit Memo Header"."VAT Registration No.")
                    {
                        Description = 'PA040669.61670';
                    }
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ServiceHeaderG__Pickup_Date_Caption; ServiceHeaderG__Pickup_Date_CaptionLbl)
                    {
                    }
                    column(PageLbl; PageLbl)
                    {
                    }
                    column(Customer_No_Caption; Customer_No_CaptionLbl)
                    {
                    }
                    column(ServiceHeaderG__License_No__Caption; ServiceHeaderG__License_No__CaptionLbl)
                    {
                    }
                    column(MakeCaption; MakeCaptionLbl)
                    {
                    }
                    column(Model_DescriptionCaption; Model_DescriptionCaptionLbl)
                    {
                    }
                    column(ServiceHeaderG_VINCaption; ServiceHeaderG_VINCaptionLbl)
                    {
                    }
                    column(ServiceHeaderG__Initial_Registration_Caption; ServiceHeaderG__Initial_Registration_CaptionLbl)
                    {
                    }
                    column(MileageCaption; MileageCaptionLbl)
                    {
                    }
                    column(Service_AdvisorCaption; Service_AdvisorCaptionLbl)
                    {
                    }
                    column(Sales_AdvisorCaption; Sales_AdvisorCaptionLbl)
                    {
                    }
                    column(SalesPurch_NameLbl; SalesPurch_NameLbl)
                    {
                    }
                    column(Sales_Credit_Memo_Header___Service_Order_No__Caption; Sales_Credit_Memo_Header___Service_Order_No__CaptionLbl)
                    {
                    }
                    column(ServiceHeaderG__Order_Date_Caption; ServiceHeaderG__Order_Date_CaptionLbl)
                    {
                    }
                    column(Sales_Credit_Memo_Header___No__Caption; Sales_Credit_Memo_Header___No__CaptionLbl)
                    {
                    }
                    column(Guide_No_Caption; Guide_No_CaptionLbl)
                    {
                    }
                    column(Sales_Credit_Memo_Header___Reason_Code__Caption; Sales_Credit_Memo_Header___Reason_Code__CaptionLbl)
                    {
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(BankName; BankNameG)
                    {
                    }
                    column(BankBranchNo; BankBranchNoG)
                    {
                    }
                    column(BankSwift; BankSwiftG)
                    {
                    }
                    column(BankIban; BankIbanG)
                    {
                    }
                    column(BankAccountNo; BankAccountNoG)
                    {
                    }
                    column(PaymentMethodCode_SCH; "Sales Credit Memo Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SCH; "Sales Credit Memo Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SCH; "Sales Credit Memo Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SCH; "Sales Credit Memo Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SCH; "Sales Credit Memo Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SCH; "Sales Credit Memo Header"."Tax Registration No.")
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
                    column(DueDateCpn_SCH; "Sales Credit Memo Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SCH; "Sales Credit Memo Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SCH; "Sales Credit Memo Header".FIELDCAPTION("Variable Symbol"))
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
                    column(DateOfIssueLbl; DateOfIssueLbl)
                    {
                    }
                    column(PostingDate_SCH; "Sales Credit Memo Header"."Posting Date")
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
                    column(Description_ReasonCode; ReasonCodeG.Description)
                    {
                    }
                    column(OrderNoG; OrderNoG)
                    {
                    }
                    column(OrderNoLbl; OrderNoLbl)
                    {
                    }
                    column(DocumentDate_SCH; "Sales Credit Memo Header"."Document Date")
                    {
                    }
                    column(AppliesToDocNo_SCH; "Sales Credit Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(ApplicationToLbl; ApplicationToLbl)
                    {
                    }
                    dataitem("Header Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Credit Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Header));
                        column(Header_Text_Text; Text)
                        {
                        }
                        column(HeaderPrintText; PrintTextG)
                        {
                            Description = 'PA033336';
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
                    dataitem("Sales Credit Memo Line"; "Sales Credit Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Credit Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(TotalNet; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Description; "Sales Credit Memo Line".Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Quantity; "Sales Credit Memo Line".Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(LineTotal; LineTotalG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DiffPrice; DiffPriceG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line___Unit_of_Measure_; "Sales Credit Memo Line"."Unit of Measure")
                        {
                        }
                        column(ServPostingGrp__Service_Cost_G_L_Account_; ServPostingGrpG."Service Cost G/L Account")
                        {
                        }
                        column(ServiceLineG__Sales_Department_Code_; ServLineG."Sales Department Code")
                        {
                        }
                        column(ServiceLineG_Type; ServLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(ServiceLineTypeG; ServLineTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line___No__; "Sales Credit Memo Line"."No.")
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Description_Control73; "Sales Credit Memo Line".Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Quantity_Control74; "Sales Credit Memo Line".Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line___Unit_of_Measure__Control75; "Sales Credit Memo Line"."Unit of Measure")
                        {
                        }
                        column(DiffPrice_Control37; DiffPriceG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineTotal_Control38; LineTotalG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ServPostingGrp__Service_Cost_G_L_Account__Control59; ServPostingGrpG."Service Cost G/L Account")
                        {
                        }
                        column(ServiceLineG__Sales_Department_Code__Control61; ServLineG."Sales Department Code")
                        {
                        }
                        column(OptSerialNoG; OptSerialNoG)
                        {
                        }
                        column(NoPropertyG; NoPropertyG)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Description_Control62; "Sales Credit Memo Line".Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Type; "Sales Credit Memo Line".Type)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line___Description_2_; "Sales Credit Memo Line"."Description 2")
                        {
                        }
                        column(TotalNet_Control125; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumLabor; SumLaborG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumExtServ; SumExtServG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalTextG)
                        {
                        }
                        column(TotalNet_Control88; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchangePartG; ExchangePartG)
                        {
                            Description = 'PA033336';
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
                        column(Charg_PriceCaption; Charg_PriceCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(AccountCaption; AccountCaptionLbl)
                        {
                        }
                        column(DeptCaption; DeptCaptionLbl)
                        {
                        }
                        column(TotalNetCaption; TotalNetCaptionLbl)
                        {
                        }
                        column(TotalNet_Control125Caption; TotalNet_Control125CaptionLbl)
                        {
                        }
                        column(SumLaborCaption; SumLaborCaptionLbl)
                        {
                        }
                        column(SumItemCaption; SumItemCaptionLbl)
                        {
                        }
                        column(SumExtServCaption; SumExtServCaptionLbl)
                        {
                        }
                        column(SumOtherCaption; SumOtherCaptionLbl)
                        {
                        }
                        column(Sales_Credit_Memo_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Credit_Memo_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ExtPriceG := 0;
                            DiffPriceG := 0;
                            LineTotalG := 0;
                            GetServOptionNo;
                            LineTotalG := "Sales Credit Memo Line".Amount;

                            IF "Sales Credit Memo Line".Quantity <> 0 THEN
                                DiffPriceG := LineTotalG / "Sales Credit Memo Line".Quantity
                            ELSE
                                DiffPriceG := LineTotalG;

                            IF NOT (ServLineG.GET(ServLineG."Document Type"::Order,
                               "Sales Credit Memo Line"."Service Order No.", "Sales Credit Memo Line"."Service Order Line No."))
                            THEN BEGIN
                                IF NOT (ArchServLineG.GET(ArchServLineG."Document Type"::Order,
                                   "Sales Credit Memo Line"."Service Order No.", "Sales Credit Memo Line"."Service Order Line No."))
                                THEN BEGIN
                                    CLEAR(ServLineG);
                                END ELSE BEGIN
                                    ServLineG.TRANSFERFIELDS(ArchServLineG);
                                END;
                            END;

                            IF NOT ServPostingGrpG.GET(ServLineG."Service Posting Group") THEN
                                CLEAR(ServPostingGrpG);
                            // Start PA033336
                            NoPropertyG := '';
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
                                NoPropertyG := C_INC016;
                                ExchangePartG := C_INC040;
                            END;

                            // Start PA035597
                            ServLineTypeG := ServLineG.Type;
                            IF ((ServLineG.Type = ServLineG.Type::"G/L Account") OR
                              ((ServLineG.Type IN [ServLineG.Type::Item,
                              ServLineG.Type::"Ext. Service", ServLineG.Type::Labor])))
                            THEN
                                CreateTotals();
                            // Stop PA035597
                            // Stop PA033336
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetOptionLines;
                            // Start PA033336
                            ExchangePartG := '';
                            // Stop PA033336
                        end;
                    }
                    dataitem(OwnOption; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(HideOwnOption; RDLHideOutputAsInteger(1))
                        {
                            Description = 'PA040669.61670';
                        }
                        column(SerOptionG; SerOptionG)
                        {
                            Description = 'PA033336';
                        }
                        column(TempServLineG_Amount; TempServLineG.Amount)
                        {
                        }
                        column(TempServLineG_Description_; TempServLineG.Description)
                        {
                        }
                        column(TempServLineG__No__; TempServLineG."No.")
                        {
                        }
                        column(OptSerialNoG_Control1109420008; OptSerialNoG)
                        {
                        }
                        column(C_INC035___C_INC033; C_INC035 + C_INC033)
                        {
                        }
                        column(C_INC034; C_INC034)
                        {
                        }
                        column(Created_Own_OptionsCaption; Created_Own_OptionsCaptionLbl)
                        {
                        }
                        column(PriceCaption; PriceCaptionLbl)
                        {
                        }
                        column(DescriptionCaption_Control1109420002; DescriptionCaption_Control1109420002Lbl)
                        {
                        }
                        column(Option_CodeCaption; Option_CodeCaptionLbl)
                        {
                        }
                        column(No_Caption_Control1109420004; No_Caption_Control1109420004Lbl)
                        {
                        }
                        column(ExplanationsCaption; ExplanationsCaptionLbl)
                        {
                        }
                        column(OwnOption_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempServLineG.FIND('-')
                            ELSE
                                TempServLineG.NEXT;
                            OptSerialNoG := C_INC035 + FORMAT(TempServLineG."Line No.");
                            SerOptionG := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempServLineG.RESET;
                            OwnOption.SETRANGE(Number, 1, TempServLineG.COUNT);
                        end;
                    }
                    dataitem("Footer Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Credit Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Footer));
                        column(Footer_Text_Text; Text)
                        {
                        }
                        column(PrintText; PrintTextG)
                        {
                            Description = 'PA033336';
                        }
                        column(PaymentTerms_Description; PaymentTermsG.Description)
                        {
                            Description = 'PA033336';
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
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                    // Start PA033336
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    END;

                    IF ("Sales Credit Memo Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC036;
                    // Stop PA033336

                    CurrReport.PAGENO := 1;

                    SumLaborG := 0;
                    SumItemG := 0;
                    SumExtServG := 0;
                    SumOtherG := 0;
                    TotalNetG := 0;
                    TotalVATG := 0;
                    TotalGrossG := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrintedG.RUN("Sales Credit Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
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
                InteractionLogL: Record "Interaction Log Entry";
                bankAccountL: Record "Bank Account";
                salesInvoiceHeaderL: Record "Sales Invoice Header";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Service Internal Cr. Memo");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Credit Memo Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Credit Memo Header"."User ID");

                IF ReasonCodeG.GET("Sales Credit Memo Header"."Reason Code") THEN;

                IF salesInvoiceHeaderL.GET("Sales Credit Memo Header"."Applies-to Doc. No.") THEN
                    //OrderNoG := salesInvoiceHeaderL."Applies-to Doc. No."
                    //OrderNoG := salesInvoiceHeaderL."Order No."
                    OrderNoG := salesInvoiceHeaderL."Service Order No."
                ELSE
                    OrderNoG := '';

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                ServHdrG.CALCFIELDS("Driver Name");
                //Stop API.1      01.03.18 PV

                IF NOT LocationG.GET("Location Code") THEN
                    CLEAR(LocationG);
                IntCustG := CompanyInfoG."Internal Customer";
                IF LocationG."Internal Customer" <> '' THEN
                    IntCustG := LocationG."Internal Customer";
                IF IntCustG = '' THEN
                    ERROR(C_INC022);

                IF (LocationG."Ship-to Address Code" <> '') AND
                   (OwnDelivAddressG.GET(IntCustG, LocationG."Ship-to Address Code"))
                THEN BEGIN
                    FormatAddrG.OwnCustomerAddress(CompanyAddrG, OwnDelivAddressG);
                    FormatAddrG.OwnAddressLetterWindow(AddrWindowG, OwnDelivAddressG);
                    CoTelephoneG := OwnDelivAddressG."Phone No.";
                    CoFaxG := OwnDelivAddressG."Fax No.";
                    CoEmailG := OwnDelivAddressG."E-Mail";
                END ELSE BEGIN
                    FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
                    FormatAddrG.CompanyLetterAddressWindow(AddrWindowG, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
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

                // Start API.1.0.1  09.05.18 PV
                //  Correct company bank info is filled when OnValidate of T36."Bank Account Code" is run.
                //  Then it is passed to posted tables, ... Ie. this info should be shown in reports.
                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccountL.RESET;
                IF bankAccountL.GET("Sales Credit Memo Header"."Bank Account Code") THEN BEGIN
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
                //   OwnBanksG.GET(IntCustG, LocationG."Bank Code")
                // THEN
                //  BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                // ELSE
                //  BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                // Stop API.1.0.1  09.05.18 PV

                IF "Your Reference" = '' THEN
                    ReferenceTextG := ''
                ELSE
                    ReferenceTextG := FIELDCAPTION("Your Reference");

                GLSetupG.TESTFIELD("LCY Code");
                TotalTextG := STRSUBSTNO(C_INC030, GLSetupG."LCY Code");
                CurrencyTextG := GLSetupG."LCY Code";

                // The internal document is always output in the local currency
                IF NOT CustInternalG.GET(IntCustG) THEN
                    CLEAR(CustInternalG);
                VehicleFormatAddrG.IntCustomerAdr(CustAddrG, CustInternalG);

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Credit Memo Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // Stop API.1      01.03.18 PV

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");

                // Start API.1      01.03.18 PV
                FormatAddrG.SalesCrMemoShipTo(ShipToAddrG, "Sales Credit Memo Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;
                // Stop API.1      01.03.18 PV

                PhoneTextG := '';
                IF NOT (ServHdrG.GET(ServHdrG."Document Type"::Order, "Service Order No.")) THEN BEGIN
                    IF NOT (ArchServHdrG.GET(ArchServHdrG."Document Type"::Order, "Service Order No.")) THEN BEGIN
                        CLEAR(ServHdrG);
                    END ELSE BEGIN
                        ServHdrG.TRANSFERFIELDS(ArchServHdrG);
                    END;
                END;
                IF (ServHdrG."Sell-to Mobile Phone No." <> '') OR (ServHdrG."Sell-to Home Mobile Phone No." <> '') OR
                   (ServHdrG."Sell-to Phone No." <> '') OR (ServHdrG."Sell-to Mobile Phone No." <> '')
                THEN BEGIN
                    PhoneTextG := C_INC010;
                    IF ServHdrG."Sell-to Mobile Phone No." <> '' THEN
                        PhoneTextG := PhoneTextG + ' ' + C_INC011 + ' ' + ServHdrG."Sell-to Mobile Phone No.";
                    IF ServHdrG."Sell-to Home Mobile Phone No." <> '' THEN BEGIN
                        IF ServHdrG."Sell-to Mobile Phone No." <> '' THEN
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC012
                        ELSE
                            PhoneTextG := PhoneTextG + '  ' + C_INC012;
                        PhoneTextG := PhoneTextG + ' ' + ServHdrG."Sell-to Home Mobile Phone No.";
                    END;
                    IF ServHdrG."Sell-to Phone No." <> '' THEN BEGIN
                        IF ServHdrG."Sell-to Home Mobile Phone No." <> '' THEN
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC013
                        ELSE
                            PhoneTextG := PhoneTextG + '  ' + C_INC013;
                        PhoneTextG := PhoneTextG + ' ' + ServHdrG."Sell-to Phone No.";
                    END;
                    IF ServHdrG."Sell-to Mobile Phone No." <> '' THEN BEGIN
                        IF ServHdrG."Sell-to Phone No." <> '' THEN
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC014
                        ELSE
                            PhoneTextG := PhoneTextG + '  ' + C_INC014;
                        PhoneTextG := PhoneTextG + ' ' + ServHdrG."Sell-to Mobile Phone No.";
                    END;
                END;

                PrintWithoutDiscG := NOT "Show Discount";

                IF "Shortcut Dimension 2 Code" <> '' THEN
                    MakeG.GET("Shortcut Dimension 2 Code")
                ELSE
                    MakeG.INIT;

                IF ServHdrG."Service Advisor No." <> '' THEN BEGIN
                    EmployeeG.GET(ServHdrG."Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                END ELSE
                    ServAdvisorG := '';

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.");

                ServLedgEntryG.RESET;
                ServLedgEntryG.SETCURRENTKEY("Order No.", "Order Line No.", "Entry Type");
                ServLedgEntryG.SETRANGE("Order No.", "Sales Credit Memo Header"."Service Order No.");
                ServLedgEntryG.SETRANGE("Entry Type", ServLedgEntryG."Entry Type"::Usage);

                OrderCustAddrLineG := '';
                IF "Sales Credit Memo Header"."Sell-to Customer No." <> IntCustG THEN BEGIN
                    FormatAddrG.SalesCrMemoCust(OrderCustAddrG, "Sales Credit Memo Header");
                    //OrderCustAddrLineG := C_INC008 + VehicleFormatAddrG.GetWindowAddress(C_INC005);   //API.1.0.1  09.05.18 PV
                    OrderCustAddrLineG := VehicleFormatAddrG.GetWindowAddress(C_INC005);   //API.1.0.1  09.05.18 PV
                END;
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(43) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::SrvCrMInt,
                      "No.",
                      0,
                      0,
                      DATABASE::Customer,
                      "Bill-to Customer No.",
                      "Salesperson Code",
                      '',
                      "Posting Description");
                    // Stop PA034256.I000009
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                ServSetupG.GET();
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
                group(Control1101347781)
                {
                    ShowCaption = false;
                    field("No. of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                    }
                    field("Print Sent-From Line"; PrintSentFromLineG)
                    {
                        Caption = 'Print Sent-From Line';
                    }
                    field("Print Address Block"; PrintAddrBlockG)
                    {
                        Caption = 'Print Address Block';
                    }
                    field("Print Footer Line"; PrintFooterLineG)
                    {
                        Caption = 'Print Footer Line';
                    }
                    field("Output Header/Footer Text"; PrintTextG)
                    {
                        Caption = 'Output Header/Footer Text';
                    }
                    field("Print Own Options"; PrintOwnOptionG)
                    {
                        Caption = 'Print Own Options';
                    }
                    field("Re-print Original Invoice"; RePrintOriginalInvG)
                    {
                        Caption = 'Re-print Original Invoice';
                        Editable = ReqRePrintControlG;
                    }
                    field("Print Reason Code"; PrintReasonCodeG)
                    {
                        Caption = 'Print Reason Code';
                        Description = 'PA033988';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA033336
            RePrintOriginalInvG := FALSE;
            ReqRePrintControlG := FALSE;
            IF UserSetupG.GET(USERID) THEN BEGIN
                IF UserSetupG."Re-print Original Invoice" THEN
                    ReqRePrintControlG := TRUE
                ELSE
                    ReqRePrintControlG := FALSE;
            END;
            // Stop PA033336

            // Start PA033988.I001012
            PrintReasonCodeG := TRUE;
            // Stop PA033988.I001012

            // Start PA036549.33286
            PrintTextG := FALSE;
            // Start PA039225.51457
            GetReportSelection();
            // Stop PA039225.51457
            // Stop PA036549.33286
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetupG.GET;
        PrintTextG := FALSE;
        // Start PA035395.18593
        // Start PA039225.51457
        // Start PA035484.20864
        // Stop PA035484.20864
        GetReportSelection();
        // Stop PA039225.51457
        // Stop PA035395.18593
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA035597
    end;

    var
        ReportSelectionG: Record "Service Manag. Rep. Selection";
        CustG: Record Customer;
        CustInternalG: Record Customer;
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        MakeG: Record Make;
        EmployeeG: Record Employee;
        SalesPurchG: Record "Salesperson/Purchaser";
        ServSetupG: Record "Service Setup";
        ServPreviewLineG: Record "Service Preview Line";
        ServPostingGrpG: Record "Service Posting Group";
        ServLedgEntryG: Record "Service Ledger Entry";
        PaymentTermsG: Record "Payment Terms";
        ServHdrG: Record "Service Header";
        ArchServHdrG: Record "Archived Service Header";
        ServLineG: Record "Service Line";
        ArchServLineG: Record "Archived Service Line";
        TempServLineG: Record "Service Line" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        UserSetupG: Record "User Setup";
        PrinterSelectionG: Record "Printer Selection";
        FormatAddrG: Codeunit "Format Address";
        VehicleFormatAddrG: Codeunit "Veh Format Address";
        CollectiveG: Codeunit "Collection Unit";
        SalesCrMemoCountPrintedG: Codeunit "Sales Cr. Memo-Printed";
        RTCMgmtG: Codeunit "RTC Management";
        SegMgntG: Codeunit SegManagement;
        UserSessionG: Codeunit "User Session Unit";
        ReportTitleG: Text[100];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
        AddrWindowG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoEmailG: Text[80];
        CoEmailTextG: Text[80];
        CoFaxG: Text[30];
        CoFaxTextG: Text[30];
        CoTelephoneG: Text[30];
        CoTelephoneTextG: Text[30];
        CopyTextG: Text[30];
        CompAddrG: Text[250];
        ReferenceTextG: Text[30];
        ServAdvisorG: Text[50];
        PhoneTextG: Text[250];
        TotalTextG: Text[50];
        CurrencyTextG: Text[10];
        OptSerialNoG: Text[30];
        DuplicateTextG: Text[30];
        NoPropertyG: Text[30];
        ExchangePartG: Text[30];
        IntCustG: Code[20];
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        OutputNoG: Integer;
        ServLineTypeG: Integer;
        [InDataSet]
        PageLoopFooterG: Integer;
        DiffPriceG: Decimal;
        ExtPriceG: Decimal;
        TotalGrossG: Decimal;
        TotalVATG: Decimal;
        TotalNetG: Decimal;
        SumLaborG: Decimal;
        SumItemG: Decimal;
        SumExtServG: Decimal;
        SumOtherG: Decimal;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        LineTotalG: Decimal;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        [InDataSet]
        PrintFooterLineG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC010: Label 'Phone:';
        C_INC011: Label 'Private';
        C_INC012: Label 'Mobile';
        C_INC013: Label 'Bus.';
        C_INC014: Label 'Mobile';
        C_INC016: Label '*';
        PrintWithoutDiscG: Boolean;
        PrintTextG: Boolean;
        C_INC022: Label 'An internal document cannot be printed because there is no internl customer entered.';
        C_INC029: Label 'Copy of';
        C_INC030: Label 'Total %1';
        C_INC032: Label 'Tax No.';
        PrintOwnOptionG: Boolean;
        [InDataSet]
        SerOptionG: Boolean;
        [InDataSet]
        ReqRePrintControlG: Boolean;
        LogInteractionG: Boolean;
        C_INC033: Label 'X = Serial No. of Service Options. ';
        C_INC034: Label 'Total Of Options price can vary from manual calculation because of rounding';
        C_INC035: Label 'O';
        RePrintOriginalInvG: Boolean;
        C_INC036: Label 'D U P L I C A T E';
        C_INC037: Label 'Service Internal Credit Memo';
        C_INC040: Label '* = Exchange Part';
        PrintReasonCodeG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        ServiceHeaderG__Pickup_Date_CaptionLbl: Label 'Pickup Appt.';
        PageLbl: Label 'Page';
        Customer_No_CaptionLbl: Label 'Customer No.';
        ServiceHeaderG__License_No__CaptionLbl: Label 'License No.';
        MakeCaptionLbl: Label 'Make';
        Model_DescriptionCaptionLbl: Label 'Model Description';
        ServiceHeaderG_VINCaptionLbl: Label 'VIN';
        ServiceHeaderG__Initial_Registration_CaptionLbl: Label 'Initial Registration';
        MileageCaptionLbl: Label 'Mileage';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_NameLbl: Label 'Salesperson';
        Sales_Credit_Memo_Header___Service_Order_No__CaptionLbl: Label 'Order No.';
        ServiceHeaderG__Order_Date_CaptionLbl: Label 'Receiving Date';
        Sales_Credit_Memo_Header___No__CaptionLbl: Label 'Internal Doc No.';
        Guide_No_CaptionLbl: Label 'Guide No.';
        Sales_Credit_Memo_Header___Reason_Code__CaptionLbl: Label 'Reason Code';
        Payments_to_CaptionLbl: Label 'Payments to:';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        Charg_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        AccountCaptionLbl: Label 'Account';
        DeptCaptionLbl: Label 'Dept';
        TotalNetCaptionLbl: Label 'Continued';
        TotalNet_Control125CaptionLbl: Label 'Sum carried forward';
        SumLaborCaptionLbl: Label 'Sum Labor';
        SumItemCaptionLbl: Label 'Sum Item';
        SumExtServCaptionLbl: Label 'Sum External Services';
        SumOtherCaptionLbl: Label 'Sum Other';
        Created_Own_OptionsCaptionLbl: Label 'Created Own Options';
        PriceCaptionLbl: Label 'Price';
        DescriptionCaption_Control1109420002Lbl: Label 'Description';
        Option_CodeCaptionLbl: Label 'Option Code';
        No_Caption_Control1109420004Lbl: Label 'No.';
        ExplanationsCaptionLbl: Label 'Explanations';
        __API_vars: Integer;
        ShipToAddrG: array[8] of Text[50];
        ShowShippingAddrG: Boolean;
        IG: Integer;
        ApplicationToLbl: Label 'Applied to';
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
        ShowTaxNoG: Boolean;
        ReasonCodeG: Record "Reason Code";
        OrderNoG: Code[20];
        ColonLbl: Label ': ';
        SlashLbl: Label ' / ';
        ReceiverLbl: Label 'Receiver';
        IssuedByLbl: Label 'Document Issued By';
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
        DateOfIssueLbl: Label 'Date of Issue';
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        OrderNoLbl: Label 'Order No.';
        Unit_PriceCaptionLbl: Label 'Unit Price';

    [Scope('Internal')]
    procedure Def(ArchServHdr2L: Record "Archived Service Header")
    begin
        "Sales Credit Memo Header".RESET;
        "Sales Credit Memo Header".SETRANGE("No.", ArchServHdr2L."No.");
    end;

    [Scope('Internal')]
    procedure CreateTotals()
    begin
        // CreateTotals
        WITH "Sales Credit Memo Line" DO BEGIN
            CASE ServLineG.Type OF
                ServLineG.Type::Item:
                    SumItemG := SumItemG + LineTotalG;
                ServLineG.Type::"Ext. Service":
                    IF ServSetupG."Output Ext. Service" THEN
                        SumExtServG := SumExtServG + LineTotalG
                    ELSE
                        SumLaborG := SumLaborG + LineTotalG;
                ServLineG.Type::Labor:
                    SumLaborG := SumLaborG + LineTotalG;
                ELSE
                    SumOtherG := SumOtherG + LineTotalG;
            END;
            TotalNetG := TotalNetG + LineTotalG;
        END;
    end;

    [Scope('Internal')]
    procedure SetOptionLines()
    var
        ArchServJobL: Record "Archived Service Job Line";
        ArchServLineL: Record "Archived Service Line";
        ItemL: Record Item;
        SalesCredmemoLineL: Record "Sales Credit Memo Line";
        ServJobL: Record "Service Job Line";
        ServLineL: Record "Service Line";
        SlNoL: Integer;
    begin
        IF NOT PrintOwnOptionG THEN
            EXIT;
        TempServLineG.DELETEALL;
        SalesCredmemoLineL.SETRANGE("Document No.", "Sales Credit Memo Header"."No.");
        SalesCredmemoLineL.SETRANGE(Type, SalesCredmemoLineL.Type::"Account (G/L)", SalesCredmemoLineL.Type::"Charge (Item)");
        SalesCredmemoLineL.SETFILTER(SalesCredmemoLineL."No.", '<>%1', '');
        IF SalesCredmemoLineL.FIND('-') THEN
            REPEAT
                IF (SalesCredmemoLineL."Service Order No." = '') OR
                   (SalesCredmemoLineL."Service Order Line No." = 0)
                THEN
                    EXIT;

                IF ServLineL.GET(ServLineL."Document Type"::Order,
                   SalesCredmemoLineL."Service Order No.",
                   SalesCredmemoLineL."Service Order Line No.")
                THEN
                    IF ServLineL."Value Increasing Measure" THEN BEGIN
                        TempServLineG.RESET;
                        TempServLineG.SETRANGE("Document Type", ServLineL."Document Type");
                        TempServLineG.SETRANGE("Document No.", ServLineL."Document No.");

                        IF ServLineL."Service Job No." = 0 THEN
                            TempServLineG.SETRANGE("Service Job No.", 0)
                        ELSE
                            TempServLineG.SETRANGE("Service Job No.", ServLineL."Service Job No.");
                        TempServLineG.SETRANGE("No.", ServLineL."Option Code");
                        IF NOT TempServLineG.FIND('-') THEN BEGIN
                            TempServLineG.TRANSFERFIELDS(ServLineL);
                            TempServLineG."No." := ServLineL."Option Code";
                            IF ServLineL."Service Job No." <> 0 THEN BEGIN
                                ServJobL.GET(ServLineL."Document Type", ServLineL."Document No.", ServLineL."Service Job No.");
                                IF ServJobL.Instruction <> '' THEN BEGIN
                                    TempServLineG.Description := ServJobL.Instruction;
                                    TempServLineG."Description 2" := ServJobL.Complaint;
                                END ELSE
                                    TempServLineG.Description := ServJobL.Complaint;
                            END ELSE BEGIN
                                ItemL.GET(ServLineL."Option Code");
                                TempServLineG.Description := ItemL.Description;
                                TempServLineG."Description 2" := ItemL."Description 2";
                            END;
                            SlNoL := SlNoL + 1;
                            TempServLineG."Line No." := SlNoL;
                            TempServLineG.INSERT;
                        END ELSE BEGIN
                            TempServLineG.Amount := TempServLineG.Amount + ServLineL.Amount;
                            TempServLineG.MODIFY;
                        END;
                    END;

                IF ArchServLineL.GET(ArchServLineL."Document Type"::Order,
                   SalesCredmemoLineL."Service Order No.",
                   SalesCredmemoLineL."Service Order Line No.")
                THEN
                    IF ArchServLineL."Value Increasing Measure" THEN BEGIN
                        TempServLineG.RESET;
                        TempServLineG.SETRANGE("Document Type", ArchServLineL."Document Type");
                        TempServLineG.SETRANGE("Document No.", ArchServLineL."Document No.");

                        IF ArchServLineL."Service Job No." = 0 THEN
                            TempServLineG.SETRANGE("Service Job No.", 0)
                        ELSE
                            TempServLineG.SETRANGE("Service Job No.", ArchServLineL."Service Job No.");
                        TempServLineG.SETRANGE("No.", ArchServLineL."Option Code");
                        IF NOT TempServLineG.FIND('-') THEN BEGIN
                            TempServLineG.TRANSFERFIELDS(ArchServLineL);
                            TempServLineG."No." := ArchServLineL."Option Code";
                            IF ArchServLineL."Service Job No." <> 0 THEN BEGIN
                                ArchServJobL.GET(ArchServLineL."Document Type", ArchServLineL."Document No.", ArchServLineL."Service Job No.");
                                IF ArchServJobL.Instruction <> '' THEN BEGIN
                                    TempServLineG.Description := ArchServJobL.Instruction;
                                    TempServLineG."Description 2" := ArchServJobL.Complaint;
                                END ELSE
                                    TempServLineG.Description := ArchServJobL.Complaint;
                            END ELSE BEGIN
                                ItemL.GET(ArchServLineL."Option Code");
                                TempServLineG.Description := ItemL.Description;
                                TempServLineG."Description 2" := ItemL."Description 2";
                            END;
                            SlNoL := SlNoL + 1;
                            TempServLineG."Line No." := SlNoL;
                            TempServLineG.INSERT;
                        END ELSE BEGIN
                            TempServLineG.Amount := TempServLineG.Amount + ArchServLineL.Amount;
                            TempServLineG.MODIFY;
                        END;
                    END;
            UNTIL SalesCredmemoLineL.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure GetServOptionNo()
    var
        ArchServLineL: Record "Archived Service Line";
        ServLineL: Record "Service Line";
    begin
        OptSerialNoG := '';
        IF NOT PrintOwnOptionG THEN
            EXIT;

        IF ("Sales Credit Memo Line"."Service Order No." = '') OR
           ("Sales Credit Memo Line"."Service Order Line No." = 0)
        THEN
            EXIT;

        IF ServLineL.GET(ServLineL."Document Type"::Order,
           "Sales Credit Memo Line"."Service Order No.",
           "Sales Credit Memo Line"."Service Order Line No.")
        THEN
            IF ServLineL."Value Increasing Measure" THEN BEGIN
                TempServLineG.RESET;
                TempServLineG.SETRANGE("Document Type", TempServLineG."Document Type"::Order);
                TempServLineG.SETRANGE("Document No.", "Sales Credit Memo Line"."Service Order No.");
                IF ServLineL."Service Job No." = 0 THEN
                    TempServLineG.SETRANGE("Service Job No.", 0)
                ELSE
                    TempServLineG.SETRANGE("Service Job No.", ServLineL."Service Job No.");
                TempServLineG.SETRANGE("No.", ServLineL."Option Code");
                IF TempServLineG.FIND('-') THEN
                    OptSerialNoG := C_INC035 + FORMAT(TempServLineG."Line No.");
            END;
        IF ArchServLineL.GET(ArchServLineL."Document Type"::Order,
           "Sales Credit Memo Line"."Service Order No.",
           "Sales Credit Memo Line"."Service Order Line No.")
        THEN
            IF ArchServLineL."Value Increasing Measure" THEN BEGIN
                TempServLineG.RESET;
                TempServLineG.SETRANGE("Document Type", TempServLineG."Document Type"::Order);
                TempServLineG.SETRANGE("Document No.", "Sales Credit Memo Line"."Service Order No.");
                IF ArchServLineL."Service Job No." = 0 THEN
                    TempServLineG.SETRANGE("Service Job No.", 0)
                ELSE
                    TempServLineG.SETRANGE("Service Job No.", ArchServLineL."Service Job No.");
                TempServLineG.SETRANGE("No.", ArchServLineL."Option Code");
                IF TempServLineG.FIND('-') THEN
                    OptSerialNoG := C_INC035 + FORMAT(TempServLineG."Line No.");
            END;
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
    procedure RDLHideOutputAsInteger(DummyIntegerP: Integer): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility with a dummy integer
        // @ Send different numbers to create new dataset fields
        // @ param DummyIntegerP - Integer
        // @ retval - Boolean
        // Start PA040669.61670
        EXIT(FALSE);
        // Stop PA040669.61670
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
        ReportTitleG := C_INC037;
        UserSessionG.GetRecordRef(RecordRefL);
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
                TitleTextRightG := "Sales Credit Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Credit Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Credit Memo Header"."No.";
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


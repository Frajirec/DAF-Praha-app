report 80007 "DPG Parts Sales Invoice CZ" // 1057617 "Parts Sales Invoice CZ"
{
    // // @ Area PartsSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   05.08.10 Changes made to print original/duplicate invoices.
    // PA032178   27.10.10 DD 1798176 docu trigger and version list corrected.
    // PA033041   03.03.11 PR Added code to display 'SWIFT-BIC' and 'IBAN' details.
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    //                        Added code to print the report title from 'Report Selection' setup.
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                                        Moved the VATText, VATTextLine Dataitem position as last footer.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032651   27.07.11 PR 4262653: Increased width of 'VAT Identifier' control.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA032651   27.07.11 PR 4242265: Corrected the text format error in C_INC037, C_INC038.
    // PA033041   13.12.11 PR 5913469: Modified C_INC037.
    // PA032651   16.12.11 PR 2522270: Increased the width of the 'No.' control.
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   28.03.12 GB 6570305: Add functionality for Rem. Amount from Cash Registers
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
    //                        - Layout 1, Layout 2 and Layout 3 concepts incorporated.
    // PA033336   28.09.12 8785515: Inserted space between 'Qty.' and 'UoM' for better readability.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Sales Invoice Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (4) - OnPreSection()", "PageLoop, Footer (5) - OnPreSection()"
    // PA033336   30.10.12 SS 8719075:
    //                        - Code changes in "Sales Invoice Line - OnPreDataItem()"
    //                        - Code changes in "Sales Invoice Line - OnAfterGetRecord()"
    //                        - Changes in Section Sales Invoice Line, Footer (13) to print Exchange Part footer Note.
    //                        - Added "Order Type" filter in "Sales Invoice Header".
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033765   21.12.12 GC EUTireData Dataitem added
    // PA033997   20.03.13 GX I000004: In the RDLC, changed the Visibility Settings of TableRow2, TableRow3 and TableRow7
    //                        so that Sales Invoice Lines of Type Header, Begin-Total, End-Total and Charge(Item)
    //                        are correctly displayed
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA036090   20.08.14 GI 26128 Fixed rdlc missing headers
    // PA036461   29.08.14 GF 27609 Fixed RDLC wrong Inventory Discount Amount.
    // PA035395   27.12.13 GD 18593 Fixed FooterLines and Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035439   10.01.14 KK Added missing address parameter into section and layout. Bottom fields are moved lower in section
    //                        PageLoop Header(1)
    // PA035484   17.01.14 GF 20145 Added code to set Usage & parameters for printing Deposit Ticket report.
    // PA035484   01.04.14 GF 20880 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   19.01.15 GN 32690 Multiple visibility issues fixed
    // PA037341   22.01.15 GJ Merge N.6.1.4 to N.7.1.0 of PA035395.18593,PA035439,PA035484.20145,PA035484.20880
    // PA036549   02.02.15 GN 33364 Overlapping Issues Fixed
    // PA037665   12.05.15 GI Added VAT Clause section.
    // PA037665   15.05.15 GI 37641 Changed the identation of the VATClauseCounter for the section to be shown in RDLC.
    // PA038227   12.08.15 GN Changed Header information.
    // PA038227   24.08.15 GN 43674 Changed Footer functionality.
    // PA038218   18.09.15 IS 44878 "Sales Person" field left indented and size of text box is extended in header.
    // PA039784   22.02.16 GV 45749 Do not display two times Bill-to Customer Name when the Sell-to Contact has the same value
    // PA040669   30.05.16 GP 61957 RDLC Redesign and Layout modifications
    // PA040669   02.06.16 GV 61957 RDLC Layout corrections
    // PA040669   03.06.16 GQ 61957 RDLC Layout corrections
    // PA041125   27.06.16 GV 67281 RDLC Layout corrections in document and customer section
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA041125   12.08.16 GV 68117 RDLC Layout corrections
    // PA041023   28.11.16 KB Report modified to Show VIN field.
    // PA041023   03.02.17 SV 87225 Report Modified to Show "Refernece License No." information and Caption change of "Refernece VIN".
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   04.04.17 GD 92781 Modification in "Sum Other" row visibility to not be shown when it's equal to 0.
    // PA041187   04.04.17 GD 92784 Modified Additional Item determination from "VAT Calculation Type"::"Exch. Parts Tax"
    //                        to "Additional Item"::"Additional Item".
    // PA041187   10.04.17 GL 93192 Remove option "Print Sent-From Line" from Request page and related logic. Provide missing logic for "Print Footer Line" option.
    // PA043635   25.04.17 GY Changed "VAT Registration No" visibility in RDLC.
    // --- 7.1.6 ---
    // EU.0002138 26.06.17 AK 2111 Merge of PA043635
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5028805 Parts Sales Invoice
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  09.05.18 PV RDLC Layout changed - put VAT% instead of VAT identifier
    //                         -source for company bank info changed
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page,
    //                        Final design of header, Bank source, SK legislation,
    //                        Advance Letter Payments, VAT Specification
    // API.1.0.3  07.08.18 PV RDLC Layout changed - VAT recap. table column size
    // API.1.0.4  30.10.18 DV Exclude unposted advance
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1    15.04.19 JJ DAFCZ.1 Print Exchange Rate
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsSalesInvoiceCZ.rdlc';

    Caption = 'Parts Sales Invoice';
    Permissions = TableData "Sales Shipment Line" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Order Type" = CONST("Parts Sales & Purchases"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Parts Sales Invoice';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(Sales_Invoice_Header_Cash_Register_Receipt; "Cash Register Receipt")
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
                    column(CompanyAddr_1_; CompanyAddrG[1])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddrG[2])
                    {
                    }
                    column(CustAddr_3_; CustAddrG[3])
                    {
                    }
                    column(CustAddr_4_; CustAddrG[4])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669.61957';
                    }
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(CustAddr_5_; CustAddrG[5])
                    {
                    }
                    column(CoFax; CoFaxG)
                    {
                    }
                    column(Sales_Invoice_Header___Document_Date_; "Sales Invoice Header"."Document Date")
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Invoice_Header___Order_No__; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(Sales_Invoice_Header___Order_Date_; "Sales Invoice Header"."Due Date")
                    {
                        Description = 'PA038227';
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO()))
                    {
                    }
                    column(Cust__No__; CustG."No.")
                    {
                    }
                    column(CustAddr_2_; CustAddrG[2])
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
                    column(CustAddr_6_; CustAddrG[6])
                    {
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(ShowAppText; ShowAppTextG)
                    {
                    }
                    column(Sales_Invoice_Header___VAT_Registration_No__; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DataItem151; CollectiveG.TextShowOutput("Sales Invoice Header".FIELDCAPTION("VAT Registration No."), "Sales Invoice Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo_FIELDCAPTION__VAT_Registration_No_____PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__VAT_Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_C_INC033__PrintAddrBlock_; CollectiveG.TextShowOutput(C_INC033, PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(ShipTextG; ShipTextG)
                    {
                    }
                    column(ShipDateTextG; ShipDateTextG)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA031550';
                    }
                    column(ReportTitle; ReportTitleG)
                    {
                        Description = 'PA035484.20145';
                    }
                    column(OutputNo; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
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
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                    }
                    column(VatAmLineVATBaseFormatText; VatAmLineVATBaseFormatText)
                    {
                        Description = 'PA035395.18593';
                    }
                    column(SalInvHeaderNoPrinted_; RDLHideOutput("Sales Invoice Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
                    {
                    }
                    column(BankText; BankTextG)
                    {
                        Description = 'PA033041,PA032651';
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField43; RDLHideOutput(PrintFooterLineG AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'PA035395.18593';
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
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
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
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; ReportLayoutSetupG."One Column Footer")
                    {
                        Description = 'PA040669.61957';
                    }
                    column(HideOneColumnFooter; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61957';
                    }
                    column(Sales_Invoice_Header___No__Caption; Sales_Invoice_Header___No__CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Document_Date_Caption; Sales_Invoice_Header___Document_Date_CaptionLbl)
                    {
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Order_No__Caption; Sales_Invoice_Header___Order_No__CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Order_Date_Caption; Sales_Invoice_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Show_VIN_Boolean_header; ShowVING)
                    {
                        Description = 'PA041023';
                    }
                    column(SalesInvoiceHeader_SupplyVIN; "Sales Invoice Header"."Supply VIN")
                    {
                        Description = 'PA041023';
                    }
                    column(SalesInvoiceHeader_ReferenceLicenseNo; "Sales Invoice Header"."Reference License No.")
                    {
                        Description = 'PA041023.87225';
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
                    column(PaymentMethodCode_SIH; "Sales Invoice Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SIH; "Sales Invoice Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SIH; "Sales Invoice Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SIH; "Sales Invoice Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SIH; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SIH; "Sales Invoice Header"."Tax Registration No.")
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
                    column(DueDateCpn_SIH; "Sales Invoice Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SIH; "Sales Invoice Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SIH; "Sales Invoice Header".FIELDCAPTION("Variable Symbol"))
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
                    column(LetterAmount; LetterAmountG)
                    {
                    }
                    column(AmountWithoutLetter; AmountWithoutLetterG)
                    {
                    }
                    column(PaymentsLbl; PaymentsLbl)
                    {
                    }
                    column(AmountIncludingVAT_SIH; "Sales Invoice Header"."Amount Including VAT")
                    {
                    }
                    column(CurrencyCode_SIH; "Sales Invoice Header"."Currency Code")
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
                    column(PostingDate_SIH; "Sales Invoice Header"."Posting Date")
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
                    dataitem("Header Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Header));
                        column(Header_Text_Text; Text)
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
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE("Prepayment Line" = CONST(false));
                        column(DiscText; DiscTextG)
                        {
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Description; Description)
                        {
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line__Type; FORMAT("Sales Invoice Line".Type))
                        {
                            Description = 'PA033336';
                        }
                        column(PrintSubtotals; PrintSubtotalsG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesInvoiceTypeG; SalesInvTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line_Description_Control62; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Subtotal; Subtotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Description_Control64; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Invoice_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control70; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__VAT_Identifier_; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Invoice_Line__No__; "No.")
                        {
                            Description = 'PA032651';
                        }
                        column(Sales_Invoice_Line_Description_Control73; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price__Control84; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control86; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Sales_Invoice_Line__VAT_Identifier__Control1109400016; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Invoice_Line__Line_Discount____Control1109400000; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control1109400001; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Quantity_Control1109400002; Quantity)
                        {
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure__Control1109400003; "Unit of Measure")
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price__Control1109400004; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line_Description_Control1109400005; Description)
                        {
                        }
                        column(Sales_Invoice_Line__No___Control1109400006; "No.")
                        {
                            Description = 'PA032651';
                        }
                        column(Sales_Invoice_Line__VAT_Identifier__Control1109400015; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Invoice_Line__Description_2_; "Description 2")
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Amount_SIL; "Sales Invoice Line".Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVAT_Amount_ExchPartsTaxAmount_SIL; "Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount - "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPct; VATPctG)
                        {
                        }
                        column(Sales_Invoice_Line__VAT_Base_Amount_; "VAT Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC017; ExchangePartG)
                        {
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(ExchPartsTaxAmount_SIL; "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct; ExchTaxPctG)
                        {
                        }
                        column(Sales_Invoice_Line__Exch__Parts_Tax_Base_; "Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVAT_SIL; "Sales Invoice Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(No_Caption; No_CaptionLbl)
                        {
                            Description = 'PA032651';
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
                        column(VAT_IdentifierCaption; VAT_IdentifierCaptionLbl)
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Amount____Inv__Discount_Amount_Caption; Amount____Inv__Discount_Amount_CaptionLbl)
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
                        column(TotallCaption; TotallCaptionLbl)
                        {
                        }
                        column(VAT_ofCaption; VAT_ofCaptionLbl)
                        {
                        }
                        column(Exch__Tax_fromCaption; Exch__Tax_fromCaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_; "Line No.")
                        {
                        }
                        column(SUpply_VIN_Sales_Invoice_Line; "Sales Invoice Line"."Supply VIN")
                        {
                            Description = '<INC,PA041023 >';
                        }
                        column(SalesInvoiceLine_ReferenceLicenseNo; "Sales Invoice Line"."Reference License No.")
                        {
                            Description = 'PA041023.87225';
                        }
                        column(Show_VIN_Boolean; ShowVING)
                        {
                            Description = 'PA041023';
                        }
                        column(VATpercent_SIL; "Sales Invoice Line"."VAT %")
                        {
                        }
                        column(VATpercentCpn_SIL; "Sales Invoice Line".FIELDCAPTION("VAT %"))
                        {
                        }
                        column(SupplyVINLbl; SupplyVINLbl)
                        {
                        }
                        column(ReferenceLicenseNoLbl; ReferenceLicenseNoLbl)
                        {
                        }
                        dataitem(EUTireData; "Integer")
                        {
                            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1));
                            column(EUTireInformationG; EUTireInformationG)
                            {
                            }
                            column(HideEUTireDataBody1; RDLHideOutputAsInteger(1))
                            {
                                Description = 'PA033336';
                            }
                            column(EUTireData_Number; Number)
                            {
                            }

                            trigger OnPreDataItem()
                            var
                                EUTireSetupL: Record "EU Tire Setup";
                            begin
                                // Start PA033765
                                CLEAR(EUTireInformationG);
                                EUTireInformationG := EUTireSetupL.GetTireInformation("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item,
                                  "Sales Invoice Line"."EU Tire Data Code");
                                IF EUTireInformationG = '' THEN BEGIN
                                    CurrReport.BREAK;
                                END;
                                // Stop PA033765
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Invoice Line";
                            T113Fnc: Codeunit "ET111,112,113,114,115,6661";
                        begin
                            //Start API.1.0.2
                            T113Fnc.T113_CalcPrintVATAmtLines("Sales Invoice Line", VATAmountLineG, VATPctG, ExchTaxPctG);
                            /*
                            VATAmountLineG.INIT;
                            // Start PA037665
                            VATAmountLineG."VAT Clause Code" := "VAT Clause Code";
                            // Stop PA037665
                            // Start PA033011.5983155
                            VATAmountLineG."VAT Identifier" := FORMAT("VAT %");
                            VATAmountLineG."Sales Amount" := Amount;
                            // Stop PA033011.5983155
                            VATAmountLineG."VAT %" := "VAT %";
                            IF ("VAT %" <> 0) AND (Quantity <> 0) THEN
                              VATPctG := "VAT %";
                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."VAT Base" := "VAT Base Amount";
                            // Start PA032441
                            // Stop PA032441
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                              ExchTaxPctG := "Exch. Parts VAT %";
                            
                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            //vapa
                                VATAmountLineG.SetInsertLineWithoutVAT(
                                  ("VAT Doc. Letter No." = '') AND "Prepayment Line" AND ("Amount Including VAT" <> 0));
                            
                            VATAmountLineG.InsertLine;
                            */

                            //To use exch.parts amount in VATCounter2 totals table
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                                ExchPartsTaxAmountSumG += "Exch. Parts Tax Amount";
                            //Stop API.1.0.2

                            NoPropertyG := '';
                            // Start PA033336
                            // Start PA041187.92784
                            IF "Additional Item" = "Additional Item"::Deposit THEN BEGIN
                                // Stop PA041187.92784
                                NoPropertyG := C_INC016;
                                ExchangePartG := C_INC017;
                            END;
                            // Stop PA033336
                            IF Type = Type::Item THEN
                                SumItemG := SumItemG + Amount + "Inv. Discount Amount"
                            ELSE
                                SumOtherG := SumOtherG + Amount + "Inv. Discount Amount";
                            IF (Quantity <> 0) AND ("Additional Item" = "Additional Item"::Deposit) THEN BEGIN
                                MARK(TRUE);
                            END;

                            IF ConsolidateNegativePosG THEN BEGIN
                                IF (Type <> Type::" ") AND ((Amount <> 0) OR ("Amount Including VAT" <> 0)) THEN BEGIN
                                    TotalsLineL.RESET;
                                    TotalsLineL.SETCURRENTKEY("Document No.", Type, "No.", Description);
                                    TotalsLineL.SETRANGE("Document No.", "Document No.");
                                    TotalsLineL.SETRANGE(Type, Type);
                                    TotalsLineL.SETRANGE("No.", "No.");
                                    TotalsLineL.SETRANGE(Description, Description);
                                    TotalsLineL.SETRANGE("Unit Price", "Unit Price");
                                    TotalsLineL.CALCSUMS(Amount, "Amount Including VAT");
                                    IF (TotalsLineL.Amount = 0) AND (TotalsLineL."Amount Including VAT" = 0) THEN
                                        CurrReport.SKIP;
                                END;
                            END;

                            // Start PA033042
                            IF ("VAT Identifier" <> '') AND (Quantity <> 0) THEN
                                IF NOT VATIdentifierTempG.GET("VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := "VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042
                            // Start PA035597
                            SalesInvTypeG := Type;
                            IF ("Line Discount Amount" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                "Unit Price" := (Amount + "Inv. Discount Amount") / Quantity;
                                "Line Discount %" := 0;
                            END;
                            // Stop PA035597

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            //CREATETOTALS not supported on client report definition (RDLC) report layouts:
                            // CurrReport.CREATETOTALS("Line Discount Amount",Amount,"Amount Including VAT","Inv. Discount Amount","Exch. Parts Tax Amount",
                            //  "Exch. Parts Tax Base","VAT Base Amount");

                            VATPctG := 0;
                            ExchTaxPctG := 0;
                            // Start PA033336
                            ExchangePartG := '';
                            // Stop PA033336
                        end;
                    }
                    dataitem(SalesInvoiceAdvance; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE("Prepayment Line" = CONST(true), "Letter No." = FILTER(<> ''));
                        column(Count_SILAdv; SalesInvoiceAdvanceCountG)
                        {
                        }
                        column(LetterNoCpn_SILAdv; FIELDCAPTION("Letter No."))
                        {
                        }
                        column(LetterNo_SILAdv; "Letter No.")
                        {
                        }
                        column(AmountIncludingVAT_SILAdv; "Amount Including VAT")
                        {
                        }
                        column(VATDocLetterNoCpn_SILAdv; FIELDCAPTION("VAT Doc. Letter No."))
                        {
                        }
                        column(VATDocLetterNo_SILAdv; "VAT Doc. Letter No.")
                        {
                        }
                        column(PostingDate_SIHAdv; SalesInvHeader."Posting Date")
                        {
                        }
                        column(PostingDateCpn_SIHAdv; SalesInvHeader.FIELDCAPTION("Posting Date"))
                        {
                        }
                        column(AmountIncludingVATCpn_SIHAdv; SalesInvoiceAdvance.FIELDCAPTION("Amount Including VAT"))
                        {
                        }
                        column(VATAmountLetter; VATAmountLetterG)
                        {
                        }
                        column(SumAdvancePaymentsLbl; SumAdvancePaymentsLbl)
                        {
                        }
                        column(RestToPayLbl; RestToPayLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //API.1.0.2
                            IF "VAT Doc. Letter No." <> '' THEN
                                IF NOT SalesInvHeader.GET("VAT Doc. Letter No.") THEN
                                    SalesInvHeader.INIT;
                            SalesInvHeader.CALCFIELDS("Amount Including VAT", Amount);
                            //When document has more then one line then "VAT Doc. Letter No." can have the same value
                            //and thus also VATAmountLetterG is shown more then once
                            IF PreviousVATDocLetterNoG = "VAT Doc. Letter No." THEN BEGIN
                                VATAmountLetterG := 0;
                            END
                            ELSE BEGIN
                                PreviousVATDocLetterNoG := "VAT Doc. Letter No.";
                                VATAmountLetterG := SalesInvHeader.Amount;
                            END;
                        end;

                        trigger OnPreDataItem()
                        var
                            SalesInvoiceLineL: Record "Sales Invoice Line";
                            SumAmountIncludingVATL: Decimal;
                        begin
                            //API.1.0.2
                            PreviousVATDocLetterNoG := '';

                            // Start API.1.0.4
                            SumAmountIncludingVATL := 0;
                            SalesInvoiceLineL.SETCURRENTKEY("Document No.", "Line No.");
                            SalesInvoiceLineL.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            SalesInvoiceLineL.SETRANGE("Prepayment Line", TRUE);
                            SalesInvoiceLineL.SETFILTER("Letter No.", '<>%1', '');
                            IF SalesInvoiceLineL.FINDSET THEN
                                REPEAT
                                    SumAmountIncludingVATL := SumAmountIncludingVATL + SalesInvoiceLineL."Amount Including VAT";
                                UNTIL SalesInvoiceLineL.NEXT = 0;

                            IF SumAmountIncludingVATL = 0 THEN
                                SalesInvoiceAdvanceCountG := 0
                            ELSE
                                SalesInvoiceAdvanceCountG := SalesInvoiceAdvance.COUNT;
                            // Stop API.1.0.4
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(AmountIncludingVAT_VAL; TempVATAmountLineG."Amount Including VAT")
                        {
                        }
                        column(AmountIncludingVATCpn_VAL; TempVATAmountLineG.FIELDCAPTION("Amount Including VAT"))
                        {
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLineG."VAT Identifier")
                        {
                        }
                        column(VATAmtLineVATBase; TempVATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; TempVATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmtLineVATBaseLCY; TempVATAmountLineG."VAT Base (LCY)")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtLCY; TempVATAmountLineG."VAT Amount (LCY)")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATLCY_VAL; TempVATAmountLineG."Amount Including VAT (LCY)")
                        {
                        }
                        column(VATIdentLbl; VATIdentLbl)
                        {
                        }
                        column(VATPercentLbl; VATPercentLbl)
                        {
                        }
                        column(VATBaseLbl; VATBaseLbl)
                        {
                        }
                        column(VATAmtLbl; VATAmtLbl)
                        {
                        }
                        column(TotalLbl; TotalLbl)
                        {
                        }
                        column(Number_VATC; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //API.1.0.2
                            TempVATAmountLineG.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            //API.1.0.2
                            //TempVATAmountLineG filled within header onaftergetrecord
                            SETRANGE(Number, 1, TempVATAmountLineG.COUNT);
                        end;
                    }
                    dataitem(VATCounter2; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVAT_VAL2; VATAmountLineG."Amount Including VAT")
                        {
                        }
                        column(VATAmountLineVATPer; VATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmtLineVATIdentifier2; VATAmountLineG."VAT Identifier")
                        {
                        }
                        column(COUNT_VAL; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(ExchTaxPct_VATC; ExchTaxPctG)
                        {
                        }
                        column(ExchPartsTaxAmountSum; ExchPartsTaxAmountSumG)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(StarLbl; C_INC016)
                        {
                        }
                        column(TotalInclVATText_VATC; TotalInclVATTextG)
                        {
                        }
                        column(TotalLbl_VATC; TotallCaptionLbl)
                        {
                        }
                        column(VATofLbl; VAT_ofCaption_Control150Lbl)
                        {
                        }
                        column(ExchTaxfromLbl; Exch__Tax_fromCaption_Control148Lbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            //Start API.1.0.2
                            //original VATCounter renamed to VATCounter2
                            // IF VATAmountLineG.COUNT <= 1 THEN
                            //  CurrReport.BREAK;
                            //Stop API.1.0.2
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            //CREATETOTALS not supported on client report definition (RDLC) report layouts.
                            // // Start PA032441
                            // CurrReport.CREATETOTALS(VATAmountLineG."VAT Base",VATAmountLineG."VAT Amount");
                            // // Stop PA032441
                        end;
                    }
                    dataitem("Footer Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Footer));
                        column(Footer_Text_Text; Text)
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
                    }
                    dataitem(ShipmentFooter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        dataitem(ShipmentFooter2; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(C_INC036_________FORMAT_DATE2DMY_FirstDateG_2___________FORMAT_DATE2DMY_FirstDateG_3_________; C_INC036 + ' ' + FORMAT(DATE2DMY(FirstDateG, 2)) + '/' + FORMAT(DATE2DMY(FirstDateG, 3)) + ' :')
                            {
                            }
                            column(Text1G___Text2G; TextG + Text2G)
                            {
                            }
                            column(ShipmentFooter2_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                TextG := StanTextG.Description;
                                Text2G := StanText2G.Description;
                                StanTextG.NEXT;
                                StanText2G.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                StanTextG.RESET;
                                StanTextG.SETRANGE(StanTextG.Code, '10000', '19999');
                                StanText2G.SETRANGE(StanText2G.Code, '20000', '29999');
                                IF StanTextG.FIND('-') THEN
                                    SETRANGE(Number, 1, SlNoG)
                                ELSE
                                    SETRANGE(Number, 1, 0);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF LastDateG = 0D THEN
                                FirstDateG := CALCDATE('<CM + 1D - 1M>', FirstShipDateG)
                            ELSE
                                FirstDateG := CALCDATE('<CM + 1D>', LastDateG);
                            LastDateG := CALCDATE('<CM>', FirstDateG);

                            StanTextG.RESET;
                            StanTextG.DELETEALL;
                            StanText2G.RESET;
                            StanText2G.DELETEALL;
                            DescriptionG := '';

                            IF NOT ((DATE2DMY(LastDateG, 2) = DATE2DMY("Sales Invoice Header"."Main Shipment Date", 2)) AND
                               (DATE2DMY(LastDateG, 3) = DATE2DMY("Sales Invoice Header"."Main Shipment Date", 3)))
                            THEN BEGIN
                                SalesShpLineTG.RESET;
                                SalesShpLineTG.SETCURRENTKEY("Posting Date", "Document No.", "Line No.");
                                SalesShpLineTG.SETFILTER("Posting Date", '%1..%2', FirstDateG, LastDateG);

                                SalesShpLineT2G.RESET;
                                SalesShpLineT2G.DELETEALL;
                                IF SalesShpLineTG.FIND('-') THEN
                                    REPEAT
                                        SalesShpLineT2G.RESET;
                                        SalesShpLineT2G.SETCURRENTKEY(Type, "No.");
                                        SalesShpLineT2G.SETRANGE(SalesShpLineT2G.Type, SalesShpLineTG.Type);
                                        SalesShpLineT2G.SETRANGE(SalesShpLineT2G."No.", SalesShpLineTG."No.");
                                        IF SalesShpLineT2G.FIND('-') THEN BEGIN
                                            SalesShpLineT2G."Closing Invoiced Quantity" := SalesShpLineT2G."Closing Invoiced Quantity" +
                                              SalesShpLineTG."Closing Invoiced Quantity";
                                            SalesShpLineT2G.MODIFY;
                                        END ELSE BEGIN
                                            SalesShpLineT2G.RESET;
                                            SalesShpLineT2G.INIT;
                                            SalesShpLineT2G.TRANSFERFIELDS(SalesShpLineTG);
                                            SalesShpLineT2G.INSERT;
                                        END;
                                    UNTIL SalesShpLineTG.NEXT = 0;

                                SlNoG := 0;
                                IF SalesShpLineT2G.FIND('-') THEN
                                    REPEAT
                                        IF DescriptionG = '' THEN
                                            DescriptionG := FORMAT(SalesShpLineT2G.Type) + ' ' + SalesShpLineT2G."No." + ' ' +
                                              SalesShpLineT2G."Unit of Measure Code" + ' ' + FORMAT(SalesShpLineT2G."Closing Invoiced Quantity")
                                        ELSE
                                            DescriptionG := ' / ' + FORMAT(SalesShpLineT2G.Type) + ' ' + SalesShpLineT2G."No." + ' ' +
                                              SalesShpLineT2G."Unit of Measure Code" + ' ' + FORMAT(SalesShpLineT2G."Closing Invoiced Quantity");
                                        StanTextG.RESET;
                                        StanTextG.SETRANGE(StanTextG.Code, '10000', '19999');
                                        StanText2G.RESET;
                                        StanText2G.SETRANGE(StanText2G.Code, '20000', '29999');
                                        IF StanTextG.FINDLAST THEN BEGIN
                                            StanText2G.FINDLAST;
                                            IF (STRLEN(StanTextG.Description) + STRLEN(StanText2G.Description) + STRLEN(DescriptionG)) <= MaxNoCharsPerLineG THEN BEGIN
                                                IF STRLEN(StanTextG.Description + DescriptionG) <= 50 THEN BEGIN
                                                    StanTextG.Description := StanTextG.Description + DescriptionG;
                                                    StanTextG.MODIFY;
                                                END ELSE
                                                    IF STRLEN(StanTextG.Description) = 50 THEN BEGIN
                                                        StanText2G.Description := StanText2G.Description + DescriptionG;
                                                        StanText2G.MODIFY;
                                                    END ELSE BEGIN
                                                        StanText2G.Description := StanText2G.Description + COPYSTR(DescriptionG, 50 - STRLEN(StanTextG.Description) + 1);
                                                        StanTextG.Description := StanTextG.Description + COPYSTR(DescriptionG, 1, 50 - STRLEN(StanTextG.Description));
                                                        StanTextG.MODIFY;
                                                        StanText2G.MODIFY;
                                                    END;
                                            END ELSE BEGIN
                                                InsertNewLine;
                                            END;
                                        END ELSE BEGIN
                                            InsertNewLine;
                                        END;
                                    UNTIL SalesShpLineT2G.NEXT = 0;
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            LastDateG := 0D;
                            CountG := 0;
                            MaxNoCharsPerLineG := 59;
                            IF ("Sales Invoice Header"."Main Shipment Date" = 0D) OR
                               (FirstShipDateG = 0D) OR
                               (LastShipDateG = 0D)
                            THEN BEGIN
                                SETRANGE(Number, 1, CountG);
                                EXIT;
                            END;

                            REPEAT
                                IF LastDateG = 0D THEN
                                    FirstDateG := CALCDATE('<CM + 1D - 1M>', FirstShipDateG)
                                ELSE
                                    FirstDateG := CALCDATE('<CM + 1D>', LastDateG);
                                LastDateG := CALCDATE('<CM>', FirstDateG);
                                CountG := CountG + 1;
                            UNTIL LastDateG >= LastShipDateG;

                            SETRANGE(Number, 1, CountG);
                            LastDateG := 0D;
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
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("No.") WHERE("Type of Document to be Printed" = CONST("Sales Invoice"));
                        column(Posted_Cash_Register_Header__Payment__In_Out__;
                        "Payment (In/Out)")
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
                            column(Posted_Cash_Register_Line__Currency_Code_; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Line_Amount; Amount)
                            {
                            }
                            column(Posted_Cash_Register_Line__Means_of_Payment_Code_; "Means of Payment Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Currency_Code__Control133; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Change_Money_; "Posted Cash Register Header"."Change Money")
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_; "Posted Cash Register Header"."Amount Given")
                            {
                            }
                            column(Posted_Cash_Register_Header___Currency_Code__Control138; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(RemainingAmountTextG; RemainingAmountTextG)
                            {
                            }
                            column(RemainingStatusTextG; RemainingStatusTextG)
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_to_Pay__LCY__Caption; Posted_Cash_Register_Header___Amount_to_Pay__LCY__CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Header___Change_Money_Caption; Posted_Cash_Register_Header___Change_Money_CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_Caption; Posted_Cash_Register_Header___Amount_Given_CaptionLbl)
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
                            // Start PA033086.6570305
                            RemainingStatusTextG := '';
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
                            // Stop PA033086.6570305
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT PmtMethodG.GET("Sales Invoice Header"."Payment Method Code") OR NOT PmtMethodG."Cash Payment" THEN BEGIN
                                CurrReport.BREAK;
                            END;
                        end;
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
                    dataitem(VATText; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        dataitem(VATTextLine; "VAT Text Line")
                        {
                            DataItemTableView = SORTING("VAT Identifier Code", "Language Code", "Line No.");
                            column(VATTextLine_Text; Text)
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(VATLegendsG; VATLegendsG)
                            {
                                Description = 'PA032651';
                            }
                            column(VATTextLine_VAT_Identifier_Code; "VAT Identifier Code")
                            {
                            }
                            column(VATTextLine_Language_Code; "Language Code")
                            {
                            }
                            column(VATTextLine_Line_No_; "Line No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start PA035597
                                VATLegendsG := '';
                                IF IncrG = 1 THEN
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC040;
                                IncrG := IncrG + 1;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                // Start PA033042
                                SETRANGE("VAT Identifier Code", VATIdentifierTempG.Code);
                                SETRANGE("Language Code", VATTextHdrG.GetLanguageCode(VATIdentifierTempG.Code, "Sales Invoice Header"."Language Code"));
                                // Stop PA033042
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033042
                            IF Number = 1 THEN
                                VATIdentifierTempG.FINDFIRST
                            ELSE
                                VATIdentifierTempG.NEXT;
                            // Stop PA033042

                            // Start PA032651
                            IncrG := 1;
                            // Stop PA032651
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA033042
                            SETRANGE(Number, 1, VATIdentifierTempG.COUNT);
                            // Stop PA033042
                        end;
                    }
                    dataitem(VATClauseCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATClauseVATIdentifier; C_VAT + VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseCode; VATClauseG.Code)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseDescription; VATClauseG.Description)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseDescription2; VATClauseG."Description 2")
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                            Description = 'PA037665';
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentifierCap)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                            Description = 'PA037665';
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA037665
                            VATAmountLineG.GetLine(Number);
                            IF NOT VATClauseG.GET(VATAmountLineG."VAT Clause Code") THEN
                                CurrReport.SKIP;
                            VATClauseG.TranslateDescription("Sales Invoice Header"."Language Code");
                            // Stop PA037665
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA037665
                            CLEAR(VATClauseG);
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            //CREATETOTALS not supported on client report definition (RDLC) report layouts.
                            // CurrReport.CREATETOTALS(VATAmountLineG."VAT Amount");
                            // Stop PA037665
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // Start PA035597
                        IF PrintFooterLineG THEN
                            PageLoopFooterG := 1;
                        // Stop PA035597
                    end;

                    trigger OnPreDataItem()
                    begin
                        // Start PA035395.18593
                        VatAmLineVATBaseFormatText := C_VATBaseFormatText;
                        // Stop PA035395.18593
                    end;
                }
                dataitem(Deposit; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    trigger OnAfterGetRecord()
                    var
                        DepositReportL: Report "Deposit Ticket";
                    begin
                        IF PrintDepositTicketsG THEN BEGIN
                            "Sales Invoice Line".MARKEDONLY(TRUE);
                            IF "Sales Invoice Line".FIND('-') THEN BEGIN
                                REPEAT
                                    IF ("Sales Invoice Line"."Printed Deposit Tickets" > 0) OR
                                       (DepositReportL.SalInvoiceLinePrintQty("Sales Invoice Line") > 0)
                                    THEN BEGIN
                                        // Start PA035484.20145
                                        UserSessionG.SetUsage(ReportSelectionG.Usage::"Deposit Ticket");
                                        DepositReportL.DefParameters("Sales Invoice Line".TABLECAPTION, CopyTextG,
                                          CopyLoop.Number - 1, 0);
                                        // Stop PA035484.20145
                                        DepositReportL.SETTABLEVIEW("Sales Invoice Line");
                                        DepositReportL.RUNMODAL();
                                        "Sales Invoice Line".FINDLAST;
                                    END;
                                UNTIL "Sales Invoice Line".NEXT = 0;
                            END;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    END;

                    ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    IF ("Sales Invoice Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        // Start PA035395.18593
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC001
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV
                         // Stop PA035395.18593
                         // Stop PA033336

                    CurrReport.PAGENO := 1;

                    SumItemG := 0;
                    SumOtherG := 0;
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        SalesInvCountPrintedG.RUN("Sales Invoice Header");
                    // Stop PA032727
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA032727
                    // Start PA043099
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    // Stop PA043099
                    IF NoOfLoopsG <= 0 THEN
                        NoOfLoopsG := 1;
                    // Stop PA032727
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
                bankAccountL: Record "Bank Account";
                salesInvLineL: Record "Sales Invoice Line";
                T113Fnc: Codeunit "ET111,112,113,114,115,6661";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA035395.18593
                // Stop PA035395.18593
                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"Parts Sales Invoice CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593
                // Start PA035484.20145
                // Start PA039225.51475
                // Stop PA039225.51475
                // Stop PA035484.20145

                // Start PA032727
                // Stop PA032727

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Invoice Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Invoice Header"."User ID");

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                "Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                AmountIncludingVAT_SIH := "Sales Invoice Header"."Amount Including VAT";

                salesInvLineL.SETRANGE("Document No.", "No.");
                salesInvLineL.SETFILTER("Letter No.", '%1', '');
                salesInvLineL.CALCSUMS(Amount, "Amount Including VAT");
                AmountWithoutLetterG := salesInvLineL.Amount;
                "Amount Including VAT" := salesInvLineL."Amount Including VAT";
                salesInvLineL.SETFILTER("Letter No.", '<>%1', '');
                salesInvLineL.CALCSUMS("Amount Including VAT");
                LetterAmountG := salesInvLineL."Amount Including VAT";

                TempVATAmountLineG.DELETEALL;
                T113Fnc.T113_CalcVATAmountLines("Sales Invoice Header", TempVATAmountLineG);
                //Stop API.1      01.03.18 PV

                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                CurrReport.LANGUAGE := BillToCustG.PrintDocInCustLanguage();
                CLEAR(ShowAppTextG);
                CustLedgEntrG.RESET;
                CustLedgEntrG.SETCURRENTKEY("Applies-to Doc. No.", "Applies-to Doc. Type");
                CustLedgEntrG.SETFILTER("Applies-to Doc. Type", '%1', CustLedgEntrG."Applies-to Doc. Type"::Invoice);
                CustLedgEntrG.SETFILTER("Applies-to Doc. No.", "No.");
                IF CustLedgEntrG.FIND('+') THEN
                    ShowAppTextG := COPYSTR(STRSUBSTNO(C_INC032, FORMAT(CustLedgEntrG."Document Type"), CustLedgEntrG."Document No."), 1, 50);

                IF CurrReport.PREVIEW THEN
                    PrintDepositTicketsG := FALSE;
                PrintWithoutDiscG := NOT "Sales Invoice Header"."Show Discount";

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
                // Start PA041187.93192
                // Stop PA041187.93192

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
                IF bankAccountL.GET("Sales Invoice Header"."Bank Account Code") THEN BEGIN
                    BankNameG := bankAccountL.Name;
                    BankBranchNoG := bankAccountL."Bank Branch No."; //not used on layout
                                                                     //vapa??
                                                                     //  IF BankAccountNoG = '' THEN BEGIN
                                                                     //    BankAccountNoG := bankAccountL."Bank Account No.";
                                                                     //    BankIbanG:= bankAccountL.IBAN;
                                                                     //    BankSwiftG := bankAccountL."SWIFT Code";
                                                                     //  END;
                END;
                // // Start PA033041
                // IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                //   OwnBanksG.GET(IntCustG, LocationG."Bank Code")
                // THEN
                //  BEGIN // Start API.1      01.03.18 PV
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // Stop API.1      01.03.18 PV
                //    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No." +
                //      C_INC037 + OwnBanksG."SWIFT-BIC" + C_INC038 + OwnBanksG.IBAN;
                //  END // Start API.1      01.03.18 PV
                // ELSE
                //  BEGIN
                //    BankNameG := CompanyInfoG."Bank Name";
                //    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                //    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                //    BankIbanG := CompanyInfoG.IBAN;
                //    BankAccountNoG := CompanyInfoG."Bank Account No.";
                //    // Stop API.1      01.03.18 PV
                //    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No." +
                //      C_INC037 + CompanyInfoG."SWIFT-BIC" + C_INC038 + CompanyInfoG.IBAN;
                //  END; // API.1      01.03.18 PV
                // // Stop PA033041
                // Stop API.1.0.1  09.05.18 PV

                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE
                    ShowCurrencyG := "Currency Code";
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);

                // Start PA039784.45749
                FormatAddrG.SetCustNo("Sales Invoice Header"."Bill-to Customer No.");
                // Stop PA039784.45749
                FormatAddrG.SalesInvBillTo(CustAddrG, "Sales Invoice Header");
                // Start PA039784.45749
                FormatAddrG.SetCustNo('');
                // Stop PA039784.45749

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Invoice Header"."Payment Method Code") THEN
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

                // API.1      01.03.18 PV note: original does not use shipto variables on layout
                FormatAddrG.SalesInvShipTo(ShipToAddrG, "Sales Invoice Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                IF NOT CustG.GET("Bill-to Customer No.") THEN
                    IF NOT CustG.GET("Sell-to Customer No.") THEN
                        CustG."No." := "Sell-to Customer No.";

                CLEAR(OrderCustAddrG); //API.1.0.1  09.05.18 PV
                IF "Sales Invoice Header"."Sell-to Customer No." <> "Sales Invoice Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesInvCust(OrderCustAddrG, "Sales Invoice Header");
                    //OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005); //API.1.0.1  09.05.18 PV
                    OrderCustAddrLineG := FormatAddrG.GetWindowAddress(C_INC005); //API.1.0.1  09.05.18 PV
                END ELSE
                    OrderCustAddrLineG := '';

                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscCheckSalInvLineG.SETRANGE("Document No.", "No.");
                    DiscCheckSalInvLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckSalInvLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(4) <> '';
                    IF LogInteractionG THEN
                        SegMgntG.LogDocument(
                          4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.",
                          "Salesperson Code", '', "Posting Description");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipTextG := C_INC034
                ELSE
                    ShipTextG := C_INC035;
                SalesShpLineTG.RESET;
                SalesShpLineTG.DELETEALL;

                SalesInvLineG.RESET;
                SalesInvLineG.SETRANGE("Document No.", "No.");
                IF SalesInvLineG.FIND('-') THEN
                    REPEAT
                        IF SalesInvLineG."Shipment No. not Closed" <> '' THEN BEGIN
                            SalesShpLineG.RESET;
                            SalesShpLineG.SETRANGE(SalesShpLineG."Document No.", SalesInvLineG."Shipment No. not Closed");
                            SalesShpLineG.SETRANGE("Order No.", SalesInvLineG."Order No.");
                            SalesShpLineG.SETRANGE("Order Line No.", SalesInvLineG."Order Line No.");
                            IF SalesShpLineG.FIND('-') THEN BEGIN
                                SalesShpLineTG.INIT;
                                SalesShpLineTG.TRANSFERFIELDS(SalesShpLineG);
                                SalesShpLineTG."Closed by Invoice No." := SalesInvLineG."Document No.";
                                SalesShpLineTG."Closing Invoiced Quantity" := SalesInvLineG."Remaining Qty on Shipment";
                                SalesShpLineTG.INSERT;
                            END;
                        END;
                    UNTIL SalesInvLineG.NEXT = 0;

                SalesShpLineG.RESET;
                SalesShpLineG.SETCURRENTKEY("Closed by Invoice No.");

                SalesShpLineG.SETRANGE("Closed by Invoice No.", SalesInvLineG."Document No.");
                IF SalesShpLineG.FIND('-') THEN
                    REPEAT
                        SalesShpLineTG.INIT;
                        SalesShpLineTG.TRANSFERFIELDS(SalesShpLineG);
                        SalesShpLineTG.INSERT;
                    UNTIL SalesShpLineG.NEXT = 0;

                FirstShipDateG := "Sales Invoice Header"."First Shipment Date";
                LastShipDateG := "Sales Invoice Header"."Last Shipment Date";
                IF (FirstShipDateG = 0D) OR (LastShipDateG = 0D) THEN
                    IF SalesShpLineTG.FIND('-') THEN
                        REPEAT
                            IF (FirstShipDateG = 0D) OR (SalesShpLineTG."Posting Date" < FirstShipDateG) THEN
                                FirstShipDateG := SalesShpLineTG."Posting Date";
                            IF (LastShipDateG = 0D) OR (SalesShpLineTG."Posting Date" > LastShipDateG) THEN
                                LastShipDateG := SalesShpLineTG."Posting Date";
                        UNTIL SalesShpLineTG.NEXT = 0;
                IF "Main Shipment Date" <> 0D THEN
                    ShipDateTextG := FORMAT(DATE2DMY("Main Shipment Date", 2)) + '/' + FORMAT(DATE2DMY("Main Shipment Date", 3))
                ELSE
                    ShipDateTextG := '';

                // Start DAFCZ.1
                CLEAR(ExchRateText);
                IF "Currency Factor" <> 0 THEN
                    ExchRateText := STRSUBSTNO(ExchangeRateTextConst, "Currency Code", 1 / "Currency Factor");
                // Stop DAFCZ.1
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
                group(Options)
                {
                    Caption = 'Options';
                    field("No. of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                    }
                    field("Print Subtotals"; PrintSubtotalsG)
                    {
                        Caption = 'Print Subtotals';
                    }
                    field("Blind out Zero Positions"; ConsolidateNegativePosG)
                    {
                        Caption = 'Blind out Zero Positions';
                    }
                    field("Print Deposit Tickets"; PrintDepositTicketsG)
                    {
                        Caption = 'Print Deposit Tickets';
                    }
                    field("Print Address Block"; PrintAddrBlockG)
                    {
                        Caption = 'Print Address Block';
                    }
                    field("Print Footer Line"; PrintFooterLineG)
                    {
                        Caption = 'Print Footer Line';
                    }
                    field("Re-print Original Invoice"; RePrintOriginalInvG)
                    {
                        Caption = 'Re-print Original Invoice';
                    }
                    field("Print VIN"; ShowVING)
                    {
                        Caption = 'Print VIN/License No';
                        Description = 'PA041023.87225';
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
            IF InvtSetupG.GET THEN
                PrintDepositTicketsG := InvtSetupG."Print Deposit Tickets"
            ELSE
                PrintDepositTicketsG := FALSE;
            // Start PA039225.51475
            GetReportSelection();
            // Stop PA039225.51475
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
            ConsolidateNegativePosG := TRUE;

            RePrintOriginalInvG := FALSE;
            // Stop PA033336
        end;
    }

    labels
    {
        Supply_VIN_Caption = 'Reference VIN';
        Reference_License_No_Caption = 'Reference License No.';
    }

    trigger OnInitReport()
    begin

        GLSetupG.GET;
        // Start PA033336
        // Start PA039225.51457
        // Stop PA033336
        // Start PA032727
        // Start PA035597
        // Stop PA035597
        GetReportSelection();
        // Stop PA039225.51457
        IF InvtSetupG.GET THEN
            PrintDepositTicketsG := InvtSetupG."Print Deposit Tickets"
        ELSE
            PrintDepositTicketsG := FALSE;
        ConsolidateNegativePosG := TRUE;
        // Stop PA032727
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA035597
        GetReportSelection(); //API.1.0.2
    end;

    var
        ReportSelectionsG: Record "Report Selection";
        CustG: Record Customer;
        CustLedgEntrG: Record "Cust. Ledger Entry";
        PrinterSelectionG: Record "Printer Selection";
        OwnDelivAddressG: Record "Ship-to Address";
        OwnBanksG: Record "Customer Bank Account";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        InvtSetupG: Record "Inventory Setup";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        DiscCheckSalInvLineG: Record "Sales Invoice Line";
        BillToCustG: Record Customer;
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        SalesInvLineG: Record "Sales Invoice Line";
        SalesShpLineG: Record "Sales Shipment Line";
        SalesShpLineTG: Record "Sales Shipment Line" temporary;
        SalesShpLineT2G: Record "Sales Shipment Line" temporary;
        StanTextG: Record "Standard Text" temporary;
        StanText2G: Record "Standard Text" temporary;
        UserSetupG: Record "User Setup";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Report Selection";
        VATClauseG: Record "VAT Clause";
        SalesInvCountPrintedG: Codeunit "Sales Inv.-Printed";
        FormatAddrG: Codeunit "Format Address";
        RTCMgmtG: Codeunit "RTC Management";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
        UserSessionG: Codeunit "User Session Unit";
        IntCustG: Code[20];
        ShowCurrencyG: Text[30];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        ShowAppTextG: Text[50];
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
        CopyTextG: Text[30];
        ShipToAddrG: array[8] of Text[50];
        NoPropertyG: Text[30];
        DiscTextG: Text[30];
        TotalInclVATTextG: Text[50];
        DescriptionG: Text[60];
        ShipDateTextG: Text[10];
        TextG: Text[50];
        Text2G: Text[50];
        ShipTextG: Text[20];
        DuplicateTextG: Text[30];
        VATLegendsG: Text[15];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        ExchangePartG: Text[30];
        VatAmLineVATBaseFormatText: Text[30];
        ReportTitleG: Text[250];
        ExchTaxPctG: Decimal;
        AmountMinusDiscG: Decimal;
        SumItemG: Decimal;
        SumOtherG: Decimal;
        VATPctG: Decimal;
        CountG: Integer;
        MaxNoCharsPerLineG: Integer;
        SlNoG: Integer;
        [InDataSet]
        OutputNoG: Integer;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IncrG: Integer;
        IG: Integer;
        SalesInvTypeG: Integer;
        PageLoopFooterG: Integer;
        FirstShipDateG: Date;
        LastShipDateG: Date;
        FirstDateG: Date;
        LastDateG: Date;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        PrintDepositTicketsG: Boolean;
        ShowShippingAddrG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No:';
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC009: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC017: Label '* = Exchange part';
        C_INC029: Label 'Copy of';
        C_INC031: Label 'Total %1 Incl. VAT';
        [InDataSet]
        PrintSubtotalsG: Boolean;
        C_INC032: Label 'Applied to %1 %2';
        C_INC033: Label 'Tax No.';
        ConsolidateNegativePosG: Boolean;
        LogInteractionG: Boolean;
        C_INC034: Label 'Shipment Date';
        C_INC035: Label 'Dispatch Date';
        C_INC036: Label 'Differing Shipment';
        RePrintOriginalInvG: Boolean;
        C_INC001: Label 'D U P L I C A T E';
        C_INC037: Label '- SWIFT-BIC:';
        C_INC038: Label ' - IBAN:';
        C_INC039: Label 'Parts Sales Invoice';
        C_INC040: Label ' =';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        IsRepSelectionSetupAvailableG: Boolean;
        EUTireInformationG: Text[1024];
        C_VATBaseFormatText: Label '#,##0.00';
        Sales_Invoice_Header___No__CaptionLbl: Label 'Document No.';
        Sales_Invoice_Header___Document_Date_CaptionLbl: Label 'Document Date';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        SalesPurch_NameCaptionLbl: Label 'Salesperson';
        Sales_Invoice_Header___Order_No__CaptionLbl: Label 'Order No.';
        Sales_Invoice_Header___Order_Date_CaptionLbl: Label 'Due Date';
        Payments_to_CaptionLbl: Label 'Payments to:';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        VAT_IdentifierCaptionLbl: Label 'VAT Identifier';
        Amount____Inv__Discount_Amount_CaptionLbl: Label 'Continued';
        Amount____Inv__Discount_Amount__Control125CaptionLbl: Label 'Sum carried forward';
        SumItemCaptionLbl: Label 'Sum Item';
        SumOtherCaptionLbl: Label 'Sum Other';
        Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        TotallCaptionLbl: Label 'Total';
        VAT_ofCaptionLbl: Label '% VAT of';
        Exch__Tax_fromCaptionLbl: Label '% Exch. Tax from';
        TotallCaption_Control122Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        VAT_ofCaption_Control150Lbl: Label '% VAT of';
        ContinuedCaption_Control109Lbl: Label 'Continued';
        Exch__Tax_fromCaption_Control148Lbl: Label '% Exch. Tax from';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        Cash_Reg__Add_Disc_Split_Post___Posting_Date_CaptionLbl: Label 'Date';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_CaptionLbl: Label 'Type';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__CaptionLbl: Label 'Document Number';
        Cash_Reg__Add_Disc_Split_Post___Currency_Code_CaptionLbl: Label 'Currency';
        Cash_Reg__Add_Disc_Split_Post___Remaining_Amount_CaptionLbl: Label 'Remaining Amount';
        Cash_Reg__Add_Disc_Split_Post___Pmt__Discount_Total_CaptionLbl: Label 'PmtDisc';
        AmountMinusDiscountCaptionLbl: Label 'Amount';
        Posted_Cash_Register_Header___Amount_to_Pay__LCY__CaptionLbl: Label 'Amount to Pay';
        Posted_Cash_Register_Header___Change_Money_CaptionLbl: Label 'Change Money';
        Posted_Cash_Register_Header___Amount_Given_CaptionLbl: Label 'Amount given';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATClausesCap: Label 'VAT Clause';
        VATIdentifierCap: Label 'VAT Identifier';
        C_VAT: Label 'VAT';
        ShowVING: Boolean;
        __API_vars: Integer;
        BankNameG: Text[50];
        BankBranchNoG: Text[20];
        BankSwiftG: Code[20];
        BankIbanG: Code[50];
        BankAccountNoG: Text[34];
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
        PaymentMethodG: Record "Payment Method";
        BankAccountNoLbl: Label 'Account No.';
        PhoneLbl: Label 'Phone';
        SwiftLbl: Label 'SWIFT';
        PrintDocTitleAndNoUpG: Boolean;
        TitleTextLeftG: Text;
        TitleTextCenterG: Text;
        TitleTextRightG: Text;
        ShowDuplicateImageG: Boolean;
        EmployeeFullNameG: Text;
        LanguageG: Record Language;
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        ShowTaxNoG: Boolean;
        AmountWithoutLetterG: Decimal;
        LetterAmountG: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        PaymentsLbl: Label 'Payments List';
        VATAmountLetterG: Decimal;
        PreviousVATDocLetterNoG: Code[20];
        AmountIncludingVAT_SIH: Decimal;
        VATIdentLbl: Label 'VAT Recapitulation';
        VATPercentLbl: Label 'VAT %';
        VATBaseLbl: Label 'VAT Base';
        VATAmtLbl: Label 'VAT Amount';
        TotalLbl: Label 'total';
        VATLbl: Label 'VAT';
        ExchRateText: Text[50];
        CalculatedExchRate: Decimal;
        ToDateLbl: Label 'to date';
        SumAdvancePaymentsLbl: Label 'Sum Advance Payments';
        RestToPayLbl: Label 'Rest to pay';
        SupplyVINLbl: Label 'Reference VIN';
        ReferenceLicenseNoLbl: Label 'Reference License No.';
        TempVATAmountLineG: Record "VAT Amount Line" temporary;
        ExchPartsTaxAmountSumG: Decimal;
        WithoutVATLbl: Label 'without VAT';
        SalesInvoiceAdvanceCountG: Integer;
        ExchangeRateTextConst: Label 'Exchange Rate %1: %2';

    [Scope('Internal')]
    procedure InsertNewLine()
    var
        SpacePosL: Integer;
        TempDescL: Text[100];
    begin
        StanTextG.INIT;
        StanTextG.Code := FORMAT(10000 + SlNoG);
        StanText2G.INIT;
        StanText2G.Code := FORMAT(20000 + SlNoG);
        WHILE STRLEN(DescriptionG) > MaxNoCharsPerLineG DO BEGIN
            SpacePosL := MaxNoCharsPerLineG + 1;
            WHILE DescriptionG[SpacePosL] <> ' ' DO
                SpacePosL := SpacePosL - 1;
            TempDescL := COPYSTR(DescriptionG, 1, SpacePosL - 1);
            StanTextG.Description := COPYSTR(TempDescL, 1, 50);
            StanText2G.Description := COPYSTR(TempDescL, 51, MaxNoCharsPerLineG);
            StanTextG.INSERT;
            StanText2G.INSERT;
            SlNoG := SlNoG + 1;
            StanTextG.INIT;
            StanTextG.Code := FORMAT(10000 + SlNoG);
            StanText2G.INIT;
            StanText2G.Code := FORMAT(20000 + SlNoG);
            DescriptionG := COPYSTR(DescriptionG, STRLEN(TempDescL) + 1);
            WHILE DescriptionG[1] = ' ' DO
                DescriptionG := COPYSTR(DescriptionG, 2);
        END;
        StanTextG.Description := COPYSTR(DescriptionG, 1, 50);
        StanText2G.Description := COPYSTR(DescriptionG, 51, MaxNoCharsPerLineG);
        StanTextG.INSERT;
        StanText2G.INSERT;
        SlNoG := SlNoG + 1;
    end;

    [Scope('Internal')]
    procedure RDLHideOutputAsInteger(DummyIntegerP: Integer): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility with a dummy integer
        // @ Send different numbers to create new dataset fields
        // @ param DummyIntegerP - Integer
        // @ retval - Boolean
        // Start PA033765
        EXIT(FALSE);
        // Stop PA033765
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
    procedure GetReportSelection()
    var
        RecordRefL: RecordRef;
        ReportIDTextL: Text;
        ReportIDL: Integer;
    begin
        // @ This function sets request page filters from Report Selection setup through User Session Unit.
        // Start PA039225.51457
        ReportSelectionsG."Print Sent-From Line" := TRUE;
        ReportSelectionsG."Print Address Block" := TRUE;
        ReportSelectionsG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC039;
        UserSessionG.GetRecordRef(RecordRefL);
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionsG);
            IF ReportSelectionsG."Print Report Title" THEN
                ReportTitleG := ReportSelectionsG."Report Title"
            ELSE BEGIN
                ReportSelectionsG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionsG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;

        // Start PA041187.93192
        // Stop PA041187.93192
        // API.1      01.03.18 PV note: PrintAddrBlockG is used to (not)show just for some data ("VAT Registration No.") in layout
        //    and (not) fill email, fax and phone - usage is not consistent
        PrintAddrBlockG := ReportSelectionsG."Print Address Block";
        PrintFooterLineG := ReportSelectionsG."Print Footer Line";
        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        // Stop PA039225.51457
    end;

    [Scope('Internal')]
    procedure AddNoOfCopiesFromCust()
    var
        CustL: Record Customer;
        SalesInvHdrL: Record "Sales Invoice Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        SalesInvHdrL.SETRANGE(SalesInvHdrL."No.", "Sales Invoice Header".GETFILTER("No."));
        IF SalesInvHdrL.FindFirst() THEN BEGIN
            IF NOT CustL.GET(SalesInvHdrL."Bill-to Customer No.") THEN
                IF NOT CustL.GET(SalesInvHdrL."Sell-to Customer No.") THEN
                    CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
        END;
        // Stop PA043099
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
                TitleTextRightG := "Sales Invoice Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Invoice Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Invoice Header"."No.";
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


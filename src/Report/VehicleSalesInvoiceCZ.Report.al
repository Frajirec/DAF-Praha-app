report 80038 "DPG Vehicle Sales Invoice CZ" // 1057603 "Vehicle Sales Invoice CZ"
{
    // // @ Area VehicleSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   05.08.10 Changes made to print original/duplicate invoices.
    // PA032071   21.09.10 Remove of ETP Enhancement from PA023275
    // PA033041   03.03.11 PR Added code to display 'SWIFT-BIC' and 'IBAN' details.
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footers for pageloop dataitem
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
    // PA032651   27.07.11 PR 4242265: Corrected the text format error in C_INC006.
    // PA033041   21.12.11 PR 5913469: Added new text constant 'C_INC042'.
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   28.03.12 GB 6570305: Add functionality for Rem. Amount from Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
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
    //                        - Layout 1 and Layout 2 Concepts
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Sales Invoice Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (5) - OnPreSection()", "PageLoop, Footer (6) - OnPreSection()"
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   30.11.12 GB 9430554: Bug correction RTC - move "OrderCustAddrLineG" to Header
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033765   21.12.12 GC EUTireData Dataitem added
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035395   27.12.13 GD 18593 Fixed FooterLines and Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   17.01.13 GF 20145 Added code to set Usage & parameters for printing Deposit Ticket report.
    // PA035484   01.04.14 GF 20754 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA036090   15.07.14 GI 24375 RDLC layout corrections and adjustments.
    // PA036547   17.11.14 GJ Merge N.6.1.4 to N.7.1.0 - PA035395.18593, PA035484.20145, PA035484.20754
    // PA036549   09.01.15 GN 32375 RDLC Layout Fixed
    // PA037665   12.05.15 GI VAT Clause section added to the report.
    // PA037665   18.05.15 GI 37684 Removed the extra page at the end of the report.
    //                        -Added "VAT" string in front of the VAT value.
    // PA038229   10.07.15 GJ Added Header information.
    //                        Added Footer functionality.
    //                        Added detailed information for the Model/Vehicle.
    // PA038229   22.07.15 GK 41906 RDLC Layout Fixes
    // PA038218   18.09.15 IS 44878 "Sales Person" field left indented and size of text box is extended in header.
    // PA040038   11.02.16 KR Calculating TotalCurrVatAmtG irrespective of DoNotShowVATG and Modified the RDLC to display Total Pay.
    // PA040039   11.02.16 KR Merge of PA040038.
    // PA039784   22.02.16 GV 45749 Do not display two times Bill-to Customer Name when the Sell-to Contact has the same value
    // PA040293   30.03.16 KR 57855 Code changed to make the trade-in amount rounded according to the rounding setup.
    // PA040294   30.03.16 KR Merge of PA040293.57855.
    // PA040256   08.04.16 GV 57127 Get Amount Rounding Precision from Currency table
    //                        Change Format of TotalCurrVatAmtG
    // PA040757   23.05.16 PT Added VAT info for Manufacturer Option
    // PA040757   01.06.16 PT 61962 VAT identifier added instead of VAT% for maunfacturer option
    // PA040758   06.06.16 JS Merge of PA040757.61962
    // PA041125   18.07.16 GV 66289 RDLC Layout Modifications
    // PA041125   20.07.16 GV 66289 RDLC Layout Modifications
    // PA041125   21.07.16 GQ 66289 RDLC Layout Modifications
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457
    // PA041125   12.08.16 GV 68104 RDLC Layout corrections
    // PA041187   19.10.16 GQ 72605 Removed function call GetPrinterTray()
    // PA042665   18.01.17 JV 86105 Added dataitem Postd Emissn. Rel. Legal Txt and added a table to display Emission Relevant Legal Text in layout
    // PA042846   31.01.17 JM Added change which takes Value from Table:"Posted Sales Trade-In" if the purchase order/invoice is not yet posted
    // PA041187   13.02.17 JM 87656 "Posted Sales Trade-In" OnAfterGetRecord modified to also filter PurchInvLine by Line No.
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   06.03.17 GW Merge of PA043099.
    // PA041187   16.03.17 GI 89643 RDLC Layout corrections.
    // PA044794   02.10.17 JV Modified Code to display Vehicle Information in case of Own Option
    // PA044854   10.10.17 JS Passing "Sales Invoice Header"."Due Date" to RDLC without formatting to display the date properly.
    // --- 7.2.0 ---
    // EU.0001175 11.10.17 JV 6041 Merge of PA044794
    // EU.0001175 13.10.17 JS 7443 Merge of PA044854
    // --- NAVCZ ---
    // API.1      20.03.18 KV New object created as a copy of Report 5025406 Vehicle Sales Invoice
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, put VAT% instead of VAT identifier
    //                        Final design of header, Bank source, SK legislation,
    //                        Advance Letter Payments, VAT Specification
    // API.1.0.3  07.08.18 PV RDLC Layout changed - VAT recap. table column size
    // API.1.0.4  30.10.18 DV Exclude unposted advance
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/VehicleSalesInvoiceCZ.rdlc';

    Caption = 'Vehicle Sales Invoice';
    Permissions = TableData "Sales Shipment Line" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Order Type" = CONST("Vehicle Sales & Purchases"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
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
                    column(CustAddr_2_; CustAddrG[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                    }
                    column(CustAddr_5_; CustAddrG[5])
                    {
                    }
                    column(Sales_Invoice_Header___Document_Date_; "Sales Invoice Header"."Document Date")
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Invoice_Header___Order_Date_; "Sales Invoice Header"."Order Date")
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Invoice_Header___Order_Date_Caption; "Sales Invoice Header".FIELDCAPTION("Order Date"))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Invoice_Header___Due_Date_; "Sales Invoice Header"."Due Date")
                    {
                        Description = 'PA038229,PA041125.66289,PA044854';
                    }
                    column(Sales_Invoice_Header___Due_Date_Caption; "Sales Invoice Header".FIELDCAPTION("Due Date"))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Invoice_Header___Order_No_; "Sales Invoice Header"."Order No.")
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Invoice_Header___Order_No_Caption; "Sales Invoice Header".FIELDCAPTION("Order No."))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Invoice_Header___Shipment_Date_; "Sales Invoice Header"."Shipment Date")
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Invoice_Header___Shipment_Date_Caption; "Sales Invoice Header".FIELDCAPTION("Shipment Date"))
                    {
                        Description = 'PA038229';
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
                    {
                    }
                    column(Cust__No__; CustG."No.")
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
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA041125.66289';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.66289';
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
                    column(DataItem219; CollectiveG.TextShowOutput("Sales Invoice Header".FIELDCAPTION("VAT Registration No."), "Sales Invoice Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Sales_Invoice_Header___VAT_Registration_No__; "Sales Invoice Header"."VAT Registration No.")
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
                    column(ShipDateTextG; ShipDateTextG)
                    {
                    }
                    column(ShipTextG; ShipTextG)
                    {
                    }
                    column(RePrintOriginalInvG; RePrintOriginalInvG)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA031550';
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA035484.20145';
                    }
                    column(OutputNo; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(ShowDiscPctG; ShowDiscPctG)
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
                    column(PrintSentFromLine; FORMAT(PrintSentFromLineG))
                    {
                        Description = 'PA033336';
                    }
                    column(TradeInExtra; TradeInExtraG)
                    {
                        Description = 'PA033336';
                    }
                    column(DoNotShowVAT; DoNotShowVATG)
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
                        Description = 'PA035395.18593';
                    }
                    column(PrintSentFromLineG_; RDLHideOutput(PrintSentFromLineG))
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
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Right".HASVALUE))
                    {
                        Description = 'PA038229';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Left".HASVALUE))
                    {
                        Description = 'PA038229';
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField43; RDLHideOutput(PrintFooterLineG AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'PA036547';
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
                        Description = 'PA036547';
                    }
                    column(sep1; FORMAT('-----------------------------------------------------------------------------------------'))
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
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.66289';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
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
                    column(Sales_Invoice_Header___No__Caption; Sales_Invoice_Header___No__CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Document_Date_Caption; Sales_Invoice_Header___Document_Date_CaptionLbl)
                    {
                    }
                    column(PageLbl; PageLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
                    {
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(ShowManyVehiclesG; ShowManyVehiclesG)
                    {
                    }
                    column(HideVehicleMainInfoG; HideVehicleMainInfoG)
                    {
                        Description = 'PA038229.41906';
                    }
                    column(Vehicle_VIN_Hdr; SalesInvLine3G.VIN)
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_VIN_HdrCaption; SalesInvLine3G.FIELDCAPTION(VIN))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__Make_Code_; SalesInvLine3G."Shortcut Dimension 2 Code")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__Make_Code_Caption; SalesInvLine3G.FIELDCAPTION("Shortcut Dimension 2 Code"))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Model; VehicleG.Model)
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_ModelCaption; VehicleG.FIELDCAPTION(Model))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__Model_No__; VehicleG."Model No.")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__Model_No__Caption; VehicleG.FIELDCAPTION("Model No."))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Inv__Line__Book_No_; SalesInvLine3G."Book No.")
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Inv__Line__Book_No_Caption; SalesInvLine3G.FIELDCAPTION("Book No."))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Inv__Line__Vehicle_Status_; FORMAT(SalesInvLine3G."Vehicle Status"))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Inv__Line__Vehicle_Status_Caption; SalesInvLine3G.FIELDCAPTION("Vehicle Status"))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Initial_Registration_; VehicleG."Initial Registration")
                    {
                        Description = 'PA038229,PA041125.66289';
                    }
                    column(Vehicle_Initial_Registration_Caption; VehicleG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Registration_Certificate; VehicleG."Registration Certificate")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Registration_CertificateCaption; VehicleRegistrationCertificateLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__License_No__; VehicleG."License No.")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__License_No__Caption; VehicleG.FIELDCAPTION("License No."))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Mileage; FORMAT(VehicleG.Mileage))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_MileageCaption; VehicleG.FIELDCAPTION(Mileage))
                    {
                        Description = 'PA038229';
                    }
                    column(FORMAT_MainNextAppDateG_; MainNextAppDateG)
                    {
                        Description = 'PA038229';
                    }
                    column(MainNextAppDateGCaption; MainNextAppDateGLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(FORMAT_EmissionNextAppDateG_; EmissionNextAppDateG)
                    {
                        Description = 'PA038229';
                    }
                    column(FORMAT_EmissionNextAppDateGCaption; EmissionNextAppDateGLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(PurchaseDocumentCaption; PurchaseDocumentLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(oflbl; ofLbl)
                    {
                        Description = 'PA041125.66289';
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
                    column(ShowVehicleInfo; ShowVehicleInfoG)
                    {
                    }
                    dataitem(HeaderHeaderText; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Header));
                        column(HeaderHeaderText_Text; Text)
                        {
                        }
                        column(Header_Footer; "Header/Footer")
                        {
                            Description = 'PA033336';
                        }
                        column(HeaderHeaderText_Document_Type; "Document Type")
                        {
                        }
                        column(HeaderHeaderText_Document_No_; "Document No.")
                        {
                        }
                        column(HeaderHeaderText_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem(SalesLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(Collective_TextShowOutput__Sales_Invoice_Line__FIELDCAPTION__Unit_of_Measure___ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesInvLine2G.FIELDCAPTION("Unit of Measure"), ShowUnitsofMeasureG))
                        {
                        }
                        column(Collective_TextShowOutput_C_INC009_ShowDiscPctG_; CollectiveG.TextShowOutput(C_INC009, ShowDiscPctG))
                        {
                        }
                        column(Vehicle3_Model; Vehicle3G.Model)
                        {
                        }
                        column(Vehicle3__Model_No__; Vehicle3G."Model No.")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(Sales_Invoice_Line__VIN; SalesInvLine2G.VIN)
                        {
                        }
                        column(Sales_Invoice_Line___License_No__; SalesInvLine2G."License No.")
                        {
                        }
                        column(Sales_Invoice_Line__Mileage; SalesInvLine2G.Mileage)
                        {
                        }
                        column(Vehicle3__Registration_Certificate_; Vehicle3G."Registration Certificate")
                        {
                        }
                        column(RegisText; RegisTextG)
                        {
                        }
                        column(FORMAT__Sales_Invoice_Line___Vehicle_Status__; FORMAT(SalesInvLine2G."Vehicle Status"))
                        {
                        }
                        column(CurrentVehicle; CurrentVehicleG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalVeh; TotalVehG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_InvoiceLine___Unit_Price_; SalesInvLine2G."Unit Price")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_InvoiceLine__VIN_Control1101338953; SalesInvLine2G.VIN)
                        {
                            Description = 'PA033336';
                        }
                        column(VINOld; VINOldG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_InvoiceLine__Type; SalesInvLine2G.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesInvoiceLineTypeG; SalesInvLineTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(SaleInvoiceLineItemTypeG; SaleInvLineItemTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_InvoiceLine___Line_No__; SalesInvLine2G."Line No.")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line__Description; SalesInvLine2G.Description)
                        {
                        }
                        column(OptionFound; OptionFoundG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintOption; PrintOption2G)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesTypeG; SalesTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesItemTypeG; SalesItemTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line__Description_Control58; SalesInvLine2G.Description)
                        {
                        }
                        column(Sales_Invoice_Line__Quantity; SalesInvLine2G.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG_; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(DspAmount; DspAmountG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput__Sales_Invoice_Line___Unit_of_Measure__ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesInvLine2G."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Invoice_Line___VAT_Identifier_; SalesInvLine2G."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_InvoiceLine___Line_Discount___; SalesInvLine2G."Line Discount %")
                        {
                            Description = 'PA033336';
                        }
                        column(PrintOptionHelpG; PrintOptionHelpG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintUnitPriceHelp; PrintUnitPriceHelpG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintOptionPufferG; PrintOptionPufferG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line__Quantity_Control1109400018; SalesInvLine2G.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Invoice_Line__Description_Control1109400019; SalesInvLine2G.Description)
                        {
                        }
                        column(Collective_TextShowOutput__Sales_Invoice_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400023; CollectiveG.TextShowOutput(SalesInvLine2G."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_InvoiceLine__Description_1G; SalesInvLine2G.Description)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line___Description_2_; SalesInvLine2G."Description 2")
                        {
                        }
                        column(Sales_Invoice_Line___No__; SalesInvLine2G."No.")
                        {
                        }
                        column(Sales_Invoice_Line__Description_Control65; SalesInvLine2G.Description)
                        {
                        }
                        column(Sales_Invoice_Line__Quantity_Control66; SalesInvLine2G.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice_Control68; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control69; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(DspAmount_Control70; DspAmountG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput__Sales_Invoice_Line___Unit_of_Measure__ShowUnitsofMeasure__Control67; CollectiveG.TextShowOutput(SalesInvLine2G."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Invoice_Line___VAT_Identifier__Control1109400026; SalesInvLine2G."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Invoice_Line__Quantity_Control1109400020; SalesInvLine2G.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Invoice_Line___No___Control1109400021; SalesInvLine2G."No.")
                        {
                        }
                        column(Sales_Invoice_Line__Description_Control1109400022; SalesInvLine2G.Description)
                        {
                        }
                        column(Collective_TextShowOutput__Sales_Invoice_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400027; CollectiveG.TextShowOutput(SalesInvLine2G."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control1109400000; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(DspAmount_Control1109400004; DspAmountG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Quantity_Control1109400007; SalesInvLine2G.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice_Control1109400008; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput__Sales_Invoice_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400009; CollectiveG.TextShowOutput(SalesInvLine2G."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Invoice_Line__Description_Control1109400010; SalesInvLine2G.Description)
                        {
                        }
                        column(Sales_Invoice_Line___No___Control1109400011; SalesInvLine2G."No.")
                        {
                        }
                        column(Sales_Invoice_Line___VAT_Identifier__Control1109400029; SalesInvLine2G."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Invoice_Line__Quantity_Control1109400028; SalesInvLine2G.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Collective_TextShowOutput__Sales_Invoice_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400032; CollectiveG.TextShowOutput(SalesInvLine2G."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Invoice_Line__Description_Control1109400033; SalesInvLine2G.Description)
                        {
                        }
                        column(Sales_Invoice_Line___No___Control1109400034; SalesInvLine2G."No.")
                        {
                        }
                        column(Sales_Invoice_Line___Description_2__Control206; SalesInvLine2G."Description 2")
                        {
                        }
                        column(VehicleDescription; VehicleDescriptionG)
                        {
                        }
                        column(ShowSalPrice_Control143; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control145; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(DspAmount_Control146; DspAmountG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line___No___Control147; SalesInvLine2G."No.")
                        {
                        }
                        column(Sales_Invoice_Line___VAT_Identifier__Control1109400030; SalesInvLine2G."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(CurrentVehicle_Control22; CurrentVehicleG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalVeh_Control100; TotalVehG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumVehicle; SumVehicleG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumMfgOpt; SumMfgOptG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumOwnOpt; SumOwnOptG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumTransferFees; SumTransferFeesG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumChargeItems; SumChargeItemsG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalSum; SumVehicleG + SumMfgOptG + SumOwnOptG + SumTransferFeesG + SumChargeItemsG + SumOtherG - TotalInvDiscAmtG)
                        {
                        }
                        column(TotalSumPlusVAT; SumVehicleG + SumMfgOptG + SumOwnOptG + SumTransferFeesG + SumChargeItemsG + SumOtherG - TotalInvDiscAmtG + NormalVATTotalG)
                        {
                        }
                        column(Sales_Invoice_Line___Inv__Discount_Amount_; -SalesInvLine2G."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmtG; -TotalInvDiscAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line__Amount; SalesInvLine2G.Amount)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLineG.VATAmountText)
                        {
                        }
                        column(ShowCurrency_SIL; ShowCurrencyG)
                        {
                        }
                        column(Sales_Invoice_Line___Amount_Including_VAT_____Sales_Invoice_Line__Amount; SalesInvLine2G."Amount Including VAT" - SalesInvLine2G.Amount)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Invoice_Line___Amount_Including_VAT_; SalesInvLine2G."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
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
                        column(DoNotShowVAT_Control1101233840; DoNotShowVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine_VATIdentifier; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(SumOnlyDiffTaxationG; SumOnlyDiffTaxationG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_TurnoverTaxAmountText; VATAmountLineG.TurnoverTaxAmountText)
                        {
                        }
                        column(TotalInclVATText_Control250; TotalInclVATTextG)
                        {
                        }
                        column(ShowCurrency_Control252; ShowCurrencyG)
                        {
                        }
                        column(SumwithDiffTaxationG; SumwithDiffTaxationG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NormalVATTotalG; NormalVATTotalG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line___Amount_Including_VAT__Control255; SalesInvLine2G."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control10; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Invoice_Line___Amount_Including_VAT__Control13; SalesInvLine2G."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Nr_Caption; Nr_CaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
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
                        column(UoM; UoMLbl)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line__MileageCaption; Sales_Invoice_Line__MileageCaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line___License_No__Caption; Sales_Invoice_Line___License_No__CaptionLbl)
                        {
                        }
                        column(Vehicle3__Registration_Certificate_Caption; Vehicle3__Registration_Certificate_CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line__VINCaption; Sales_Invoice_Line__VINCaptionLbl)
                        {
                        }
                        column(FORMAT__Sales_Invoice_Line___Vehicle_Status__Caption; FORMAT__Sales_Invoice_Line___Vehicle_Status__CaptionLbl)
                        {
                        }
                        column(RegisTextCaption; RegisTextCaptionLbl)
                        {
                        }
                        column(CurrentVehicleCaption; CurrentVehicleCaptionLbl)
                        {
                        }
                        column(TotalVehCaption; TotalVehCaptionLbl)
                        {
                        }
                        column(CurrentVehicle_Control22Caption; CurrentVehicle_Control22CaptionLbl)
                        {
                        }
                        column(TotalVeh_Control100Caption; TotalVeh_Control100CaptionLbl)
                        {
                        }
                        column(SumVehicleCaption; SumVehicleCaptionLbl)
                        {
                        }
                        column(SumMfgOptCaption; SumMfgOptCaptionLbl)
                        {
                        }
                        column(SumOwnOptCaption; SumOwnOptCaptionLbl)
                        {
                        }
                        column(SumTransferFeesCaption; SumTransferFeesCaptionLbl)
                        {
                        }
                        column(Sum_Charge_ItemsCaption; Sum_Charge_ItemsCaptionLbl)
                        {
                        }
                        column(SumOtherCaption; SumOtherCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountLbl; InvDiscountAmountLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(davon_Differenzbesteuerung_Caption; davon_Differenzbesteuerung_CaptionLbl)
                        {
                        }
                        column(SummeCaption_Control251; SummeCaption_Control251Lbl)
                        {
                        }
                        column(SalesLine_Number; Number)
                        {
                        }
                        column(VATpercent_SL; SalesInvLine2G."VAT %")
                        {
                        }
                        column(VATpercentCpn_SL; SalesInvLine2G.FIELDCAPTION("VAT %"))
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
                                EUTireInformationG := EUTireSetupL.GetTireInformation(
                                  (SalesInvLine2G.Type = SalesInvLine2G.Type::Item) AND (SalesInvLine2G."Item Type" = SalesInvLine2G."Item Type"::Item),
                                  SalesInvLine2G."EU Tire Data Code");
                                IF EUTireInformationG = '' THEN BEGIN
                                    CurrReport.BREAK;
                                END;
                                // Stop PA033765
                            end;
                        }
                        dataitem(Vehicle; Vehicle)
                        {
                            DataItemTableView = SORTING(VIN);
                            column(Sales_Invoice_Line__VIN_Control83; SalesInvLine2G.VIN)
                            {
                            }
                            column(Sales_Invoice_Line___License_No___Control106; SalesInvLine2G."License No.")
                            {
                            }
                            column(Sales_Invoice_Line__Mileage_Control114; SalesInvLine2G.Mileage)
                            {
                            }
                            column(Vehicle__Registration_Certificate_; "Registration Certificate")
                            {
                            }
                            column(RegisText_Control89; RegisTextG)
                            {
                            }
                            column(FORMAT__Sales_Invoice_Line___Vehicle_Status___Control207; FORMAT(SalesInvLine2G."Vehicle Status"))
                            {
                            }
                            column(RegisText_Control89Caption; RegisText_Control89CaptionLbl)
                            {
                            }
                            column(Sales_Invoice_Line__Mileage_Control114Caption; Sales_Invoice_Line__Mileage_Control114CaptionLbl)
                            {
                            }
                            column(Sales_Invoice_Line___License_No___Control106Caption; Sales_Invoice_Line___License_No___Control106CaptionLbl)
                            {
                            }
                            column(Vehicle__Registration_Certificate_Caption; Vehicle__Registration_Certificate_CaptionLbl)
                            {
                            }
                            column(Sales_Invoice_Line__VIN_Control83Caption; Sales_Invoice_Line__VIN_Control83CaptionLbl)
                            {
                            }
                            column(FORMAT__Sales_Invoice_Line___Vehicle_Status___Control207Caption; FORMAT__Sales_Invoice_Line___Vehicle_Status___Control207CaptionLbl)
                            {
                            }
                            column(Vehicle_VIN; VIN)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF "Initial Registration" = 0D THEN
                                    InitialRegisTextG := ' -- '
                                ELSE
                                    InitialRegisTextG := FORMAT("Initial Registration");

                                IF SalesInvLine2G."Registration Date" = 0D THEN
                                    CustRegisTextG := ' -- '
                                ELSE
                                    CustRegisTextG := FORMAT(SalesInvLine2G."Registration Date");
                                RegisTextG := InitialRegisTextG + ' / ' + CustRegisTextG;

                                // Start PA035597
                                PrintOptionHelpG := (PrintOption2G <> PrintOption2G::"Print no lines");
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(VIN, SalesInvLine2G.VIN);
                            end;
                        }
                        dataitem("Optn Var. Vehicle"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(1), Type = CONST(Vehicle));
                            column(Sales_Invoice_Line___No___Control1109400001; SalesInvLine2G."No.")
                            {
                            }
                            column(VehicleDescription_Control1109400002; VehicleDescriptionG)
                            {
                            }
                            column(ShowSalPrice_Control1109400005; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 2;
                            }
                            column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control1109400006; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                            {
                            }
                            column(Sales_Invoice_Line__Quantity_Control1109400003; SalesInvLine2G.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(Sales_Invoice_Line___VAT_Identifier__Control1109400031; SalesInvLine2G."VAT Identifier")
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(OptVariantTypeG; OptVariantTypeG)
                            {
                                Description = 'PA033336';
                            }
                            column(VehicleDescription_Control133; VehicleDescriptionG)
                            {
                            }
                            column(Optn_Var__Vehicle_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control141; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control148; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                            {
                            }
                            column(DspAmount_Control149; DspAmountG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(Sales_Invoice_Line___No___Control153; SalesInvLine2G."No.")
                            {
                            }
                            column(Collective_TextShowOutput__Sales_Invoice_Line___Unit_of_Measure__ShowUnitsofMeasure__Control190; CollectiveG.TextShowOutput(SalesInvLine2G."Unit of Measure", ShowUnitsofMeasureG))
                            {
                            }
                            column(Sales_Invoice_Line___VAT_Identifier__Control1109400035; SalesInvLine2G."VAT Identifier")
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(Sales_Invoice_Line___License_No___Control115; SalesInvLine2G."License No.")
                            {
                            }
                            column(Sales_Invoice_Line__Mileage_Control116; SalesInvLine2G.Mileage)
                            {
                            }
                            column(RegisText_Control117; RegisTextG)
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121; Vehicle."Registration Certificate")
                            {
                            }
                            column(Sales_Invoice_Line__VIN_Control122; SalesInvLine2G.VIN)
                            {
                            }
                            column(FORMAT__Sales_Invoice_Line___Vehicle_Status___Control209; FORMAT(SalesInvLine2G."Vehicle Status"))
                            {
                            }
                            column(Sales_Invoice_Line__VIN_Control122Caption; Sales_Invoice_Line__VIN_Control122CaptionLbl)
                            {
                            }
                            column(Sales_Invoice_Line___License_No___Control115Caption; Sales_Invoice_Line___License_No___Control115CaptionLbl)
                            {
                            }
                            column(Sales_Invoice_Line__Mileage_Control116Caption; Sales_Invoice_Line__Mileage_Control116CaptionLbl)
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121Caption; Vehicle__Registration_Certificate__Control121CaptionLbl)
                            {
                            }
                            column(RegisText_Control117Caption; RegisText_Control117CaptionLbl)
                            {
                            }
                            column(FORMAT__Sales_Invoice_Line___Vehicle_Status___Control209Caption; FORMAT__Sales_Invoice_Line___Vehicle_Status___Control209CaptionLbl)
                            {
                            }
                            column(Optn_Var__Vehicle_Area; Area)
                            {
                            }
                            column(Optn_Var__Vehicle_Document_Type; "Document Type")
                            {
                            }
                            column(Optn_Var__Vehicle_Document_No_; "Document No.")
                            {
                            }
                            column(Optn_Var__Vehicle_Document_Line_No_; "Document Line No.")
                            {
                            }
                            column(Optn_Var__Vehicle_Type; Type)
                            {
                            }
                            column(Optn_Var__Vehicle_Make_Code; "Make Code")
                            {
                            }
                            column(Optn_Var__Vehicle_Model_Code; "Model Code")
                            {
                            }
                            column(Optn_Var__Vehicle_Option_Code; "Option Code")
                            {
                            }
                            column(Optn_Var__Vehicle_Internal_Code; "Internal Code")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start PA033336
                                // Start PA035597
                                PrintOptionHelpG := (PrintOption2G <> PrintOption2G::"Print no lines");
                                PrintUnitPriceHelpG := (PrintUnitPrice2G <> PrintUnitPrice2G::"Print no prices");

                                ShowSalPriceG := 0;
                                ShowLineDiscPctG := 0;
                                CASE SalesInvLine2G."VAT Calculation Type" OF
                                    SalesInvLine2G."VAT Calculation Type"::"Differential Tax":
                                        DspAmountG := getSalPrice(SalesInvLine2G, 1);
                                    ELSE BEGIN
                                            IF DoNotShowVATG THEN
                                                DspAmountG := getSalPrice(SalesInvLine2G, 1)
                                            ELSE
                                                DspAmountG := getSalPrice(SalesInvLine2G, 2);
                                            ;
                                            IF PrintDiscG THEN BEGIN
                                                ShowSalPriceG := getSalPrice(SalesInvLine2G, 0);
                                                ShowLineDiscPctG := getLineDiscPct(SalesInvLine2G, 0);
                                                IF (ShowSalPriceG <> 0) THEN BEGIN
                                                    IF DoNotShowVATG THEN
                                                        DspAmountG := getSalPrice(SalesInvLine2G, 1) + getLineDiscPct(SalesInvLine2G, 1);
                                                    ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                                END;
                                            END;
                                        END;
                                END;


                                VehicleDescriptionG := SalesInvLine2G."Shortcut Dimension 2 Code" + ' ' + SalesInvLine2G.Description;
                                // Stop PA035597
                                OptVariantTypeG := Type;
                                // Stop PA033336
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesInvLine2G."Document No.");
                                SETRANGE("Document Line No.", SalesInvLine2G."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Color"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(1));
                            column(Optn_Var__Color_Description; Description)
                            {
                            }
                            column(Optn_Var__Color_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control142; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 2;
                            }
                            column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control144; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                            {
                            }
                            column(DspAmount_Control157; DspAmountG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(Optn_Var__Color__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Optn_Var__Color__Type; "Optn Var. Color".Type)
                            {
                                Description = 'PA033336';
                            }
                            column(OptVariantType2G; OptVariantType2G)
                            {
                                Description = 'PA033336';
                            }
                            column(Optn_Var__Color__Description_2_; "Description 2")
                            {
                            }
                            column(Optn_Var__Color_Description_Control183; Description)
                            {
                            }
                            column(Optn_Var__Color_Quantity_Control184; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(Optn_Var__Color__Option_Code__Control185; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Collective_TextShowOutput_C_INC028__Series_Option__; CollectiveG.TextShowOutput(C_INC028, "Series Option"))
                            {
                            }
                            column(Optn_Var__Color__Description_2__Control215; "Description 2")
                            {
                            }
                            column(CurrentVehicle_Control91; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CurrentVehicle_Control91Caption; CurrentVehicle_Control91CaptionLbl)
                            {
                            }
                            column(Optn_Var__Color_Area; Area)
                            {
                            }
                            column(Optn_Var__Color_Document_Type; "Document Type")
                            {
                            }
                            column(Optn_Var__Color_Document_No_; "Document No.")
                            {
                            }
                            column(Optn_Var__Color_Document_Line_No_; "Document Line No.")
                            {
                            }
                            column(Optn_Var__Color_Make_Code; "Make Code")
                            {
                            }
                            column(Optn_Var__Color_Model_Code; "Model Code")
                            {
                            }
                            column(Optn_Var__Color_Internal_Code; "Internal Code")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Type = Type::"Manuf. Option" THEN BEGIN
                                    IF (DoNotShowVATG) OR
                                       (SalesInvLine2G."VAT Calculation Type" = SalesInvLine2G."VAT Calculation Type"::"Differential Tax")
                                    THEN BEGIN
                                        SumVehicleG -= "Amount Including VAT";
                                        IF SalesInvLine2G.Quantity > 0 THEN
                                            SumMfgOptG += "Amount Including VAT";
                                    END ELSE BEGIN
                                        SumVehicleG -= Amount;
                                        IF SalesInvLine2G.Quantity > 0 THEN
                                            SumMfgOptG += Amount;
                                    END;
                                END;

                                // Start PA035597
                                PrintOptionHelpG := (PrintOption2G = PrintOption2G::"Print all lines") OR
                                  ((PrintOption2G = PrintOption2G::"Print selected lines") AND "Optn Var. Color"."Print Option Line");
                                PrintUnitPriceHelpG := FunctionPrintUnitPriceOVC;

                                CalcValues("Optn Var. Color");

                                IF NOT PrintUnitPriceHelpG THEN
                                    DspAmountG := 0;
                                OptVariantType2G := Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Option Type", "Option Type"::Color, "Option Type"::Upholstery);
                                SETRANGE("Document No.", SalesInvLine2G."Document No.");
                                SETRANGE("Document Line No.", SalesInvLine2G."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Series"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(1), "Series Option" = CONST(true), "Option Type" = CONST(Option));
                            column(Optn_Var__Series_Description; Description)
                            {
                            }
                            column(Optn_Var__Series_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(Optn_Var__Series__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Optn_Var__Series__Series_Option_; "Series Option")
                            {
                                Description = 'PA033336';
                            }
                            column(OptVariantType3G; OptVariantType3G)
                            {
                                Description = 'PA033336';
                            }
                            column(Optn_Var__Series__Description_2_; "Description 2")
                            {
                            }
                            column(CurrentVehicle_Control60; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CurrentVehicle_Control60Caption; CurrentVehicle_Control60CaptionLbl)
                            {
                            }
                            column(Optn_Var__Series_Area; Area)
                            {
                            }
                            column(Optn_Var__Series_Document_Type; "Document Type")
                            {
                            }
                            column(Optn_Var__Series_Document_No_; "Document No.")
                            {
                            }
                            column(Optn_Var__Series_Document_Line_No_; "Document Line No.")
                            {
                            }
                            column(Optn_Var__Series_Type; Type)
                            {
                            }
                            column(Optn_Var__Series_Make_Code; "Make Code")
                            {
                            }
                            column(Optn_Var__Series_Model_Code; "Model Code")
                            {
                            }
                            column(Optn_Var__Series_Internal_Code; "Internal Code")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start PA035597
                                PrintOptionHelpG := (PrintOption2G = PrintOption2G::"Print all lines") OR
                                  ((PrintOption2G = PrintOption2G::"Print selected lines") AND "Optn Var. Series"."Print Option Line");
                                OptVariantType3G := Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesInvLine2G."Document No.");
                                SETRANGE("Document Line No.", SalesInvLine2G."Line No.");
                            end;
                        }
                        dataitem("Option Variant"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(1), "Series Option" = CONST(false), "Option Type" = CONST(Option));
                            column(Option_Variant_Description; Description)
                            {
                            }
                            column(Option_Variant_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control171; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 2;
                            }
                            column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control172; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                            {
                            }
                            column(DspAmount_Control175; DspAmountG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(Option_Variant__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(OptVariantType4G; OptVariantType4G)
                            {
                                Description = 'PA033336';
                            }
                            column(Option_Variant__Description_2_; "Description 2")
                            {
                            }
                            column(CurrentVehicle_Control42; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CurrentVehicle_Control42Caption; CurrentVehicle_Control42CaptionLbl)
                            {
                            }
                            column(Option_Variant_Area; Area)
                            {
                            }
                            column(Option_Variant_Document_Type; "Document Type")
                            {
                            }
                            column(Option_Variant_Document_No_; "Document No.")
                            {
                            }
                            column(Option_Variant_Document_Line_No_; "Document Line No.")
                            {
                            }
                            column(Option_Variant_Type; Type)
                            {
                            }
                            column(Option_Variant_Make_Code; "Make Code")
                            {
                            }
                            column(Option_Variant_Model_Code; "Model Code")
                            {
                            }
                            column(Option_Variant_Internal_Code; "Internal Code")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Type = Type::"Manuf. Option" THEN BEGIN
                                    IF (DoNotShowVATG) OR
                                       (SalesInvLine2G."VAT Calculation Type" = SalesInvLine2G."VAT Calculation Type"::"Differential Tax")
                                    THEN BEGIN
                                        SumVehicleG -= "Amount Including VAT";
                                        IF SalesInvLine2G.Quantity > 0 THEN
                                            SumMfgOptG += "Amount Including VAT";
                                    END ELSE BEGIN
                                        SumVehicleG -= Amount;
                                        IF SalesInvLine2G.Quantity > 0 THEN
                                            SumMfgOptG += Amount;
                                    END;
                                END;

                                // Start PA035597
                                PrintOptionHelpG := (PrintOption2G = PrintOption2G::"Print all lines") OR
                                  ((PrintOption2G = PrintOption2G::"Print selected lines") AND "Option Variant"."Print Option Line");
                                PrintUnitPriceHelpG := FunctionPrintUnitPriceOV;
                                CalcValues("Option Variant");
                                OptVariantType4G := Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesInvLine2G."Document No.");
                                SETRANGE("Document Line No.", SalesInvLine2G."Line No.");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Invoice Line";
                            T113Fnc: Codeunit "ET111,112,113,114,115,6661";
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT SalesInvLine2G.FIND('-') THEN BEGIN
                                    SalesInvLine2G.SETRANGE("Item Type", SalesInvLine2G."Item Type"::Item);
                                    SalesInvLine2G.FIND('-');
                                END;
                                VINOldG := SalesInvLine2G.VIN;
                            END ELSE
                                IF SalesInvLine2G.NEXT = 0 THEN BEGIN
                                    SalesInvLine2G.SETRANGE("Item Type", SalesInvLine2G."Item Type"::Item);
                                    SalesInvLine2G.FIND('-');
                                END;

                            // Check if Option is available
                            PostedOptionVariantsG.SETRANGE(Area, PostedOptionVariantsG.Area::Sale);
                            PostedOptionVariantsG.SETRANGE("Document Type", PostedOptionVariantsG."Document Type"::"1");
                            PostedOptionVariantsG.SETRANGE("Document No.", SalesInvLine2G."Document No.");
                            PostedOptionVariantsG.SETRANGE("Document Line No.", SalesInvLine2G."Line No.");
                            OptionFoundG := PostedOptionVariantsG.FIND('-');
                            IF SalesInvLine2G."VAT Calculation Type" <> SalesInvLine2G."VAT Calculation Type"::"Differential Tax" THEN BEGIN
                                //Start API.1.0.2
                                T113Fnc.T113_CalcPrintVATAmtLines(SalesInvLine2G, VATAmountLineG, VATPctG, ExchTaxPctG);
                                /*
                                  VATAmountLineG.INIT;
                                // Start PA033011.5983155
                                  VATAmountLineG."VAT Identifier" := FORMAT(SalesInvLine2G."VAT %");
                                  VATAmountLineG."Sales Amount" := SalesInvLine2G.Amount;
                                // Stop PA033011.5983155
                                  VATAmountLineG."VAT %" := SalesInvLine2G."VAT %";
                                  VATAmountLineG."VAT Base" := SalesInvLine2G.Amount;
                                  VATAmountLineG."Amount Including VAT" := SalesInvLine2G."Amount Including VAT";
                                // Start PA037665
                                  VATAmountLineG."VAT Clause Code" := SalesInvLine2G."VAT Clause Code";
                                // Stop PA037665
                                  VATAmountLineG.InsertLine();
                                */
                                //Stop API.1.0.2
                            END;
                            // Start PA040038
                            TotalCurrVatAmtG := TotalCurrVatAmtG + SalesInvLine2G."Amount Including VAT";
                            // Stop PA040038
                            //IF DoNotShowVAT THEN BEGIN
                            IF DoNotShowVATG OR
                               (SalesInvLine2G."VAT Calculation Type" = SalesInvLine2G."VAT Calculation Type"::"Differential Tax")
                            THEN BEGIN
                                // Start PA033336
                                // Start PA040038
                                // Stop PA040038
                                TotalInvDiscAmtG := TotalInvDiscAmtG + SalesInvLine2G."Inv. Discount Amount";
                                // Stop PA033336

                                IF SalesInvLine2G.Type = SalesInvLine2G.Type::Item THEN BEGIN
                                    CASE SalesInvLine2G."Item Type" OF
                                        SalesInvLine2G."Item Type"::Item:
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
                                               (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                               SalesInvLine2G."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"Print no lines")
                                            THEN
                                                SumOtherG += SalesInvLine2G."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesInvLine2G."Amount Including VAT";
                                        SalesInvLine2G."Item Type"::Vehicle:
                                            SumVehicleG += SalesInvLine2G."Amount Including VAT";
                                        SalesInvLine2G."Item Type"::"Own Option":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
                                               (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                               SalesInvLine2G."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"Print no lines")
                                            THEN
                                                SumOwnOptG += SalesInvLine2G."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesInvLine2G."Amount Including VAT";
                                        SalesInvLine2G."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
                                               (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                               SalesInvLine2G."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"Print no lines")
                                            THEN
                                                SumTransferFeesG += SalesInvLine2G."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesInvLine2G."Amount Including VAT";
                                    END;
                                END ELSE
                                    IF (SalesInvLine2G.Type = SalesInvLine2G.Type::"Account (G/L)") OR
                                       (SalesInvLine2G.Type = SalesInvLine2G.Type::"Charge (Item)")
                                    THEN
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                           SalesInvLine2G."Print Option Line" OR
                                           (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                           ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                           (PrintOption2G <> PrintOption2G::"Print no lines")
                                        THEN
                                            SumOtherG += SalesInvLine2G."Amount Including VAT"
                                        ELSE
                                            SumVehicleG += SalesInvLine2G."Amount Including VAT"
                            END ELSE BEGIN
                                IF SalesInvLine2G.Type = SalesInvLine2G.Type::Item THEN BEGIN
                                    CASE SalesInvLine2G."Item Type" OF
                                        SalesInvLine2G."Item Type"::Item:
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
                                               (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                               SalesInvLine2G."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"Print no lines")
                                            THEN
                                                SumOtherG += SalesInvLine2G.Amount
                                            ELSE BEGIN
                                                SumVehicleG += SalesInvLine2G.Amount;
                                            END;
                                        SalesInvLine2G."Item Type"::Vehicle:
                                            BEGIN
                                                SumVehicleG += SalesInvLine2G.Amount;
                                            END;
                                        SalesInvLine2G."Item Type"::"Own Option":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
                                               (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                               SalesInvLine2G."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"Print no lines")
                                            THEN
                                                SumOwnOptG += SalesInvLine2G.Amount
                                            ELSE
                                                SumVehicleG += SalesInvLine2G.Amount;
                                        SalesInvLine2G."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
                                               (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                               SalesInvLine2G."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"Print no lines")
                                            THEN
                                                SumTransferFeesG += SalesInvLine2G.Amount
                                            ELSE
                                                SumVehicleG += SalesInvLine2G.Amount;
                                    END;
                                END ELSE
                                    IF (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print selected lines") AND
                                       SalesInvLine2G."Print Option Line" OR
                                       (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND (PrintOption2G = PrintOption2G::"Print all lines") OR
                                       ((PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND SalesInvLine2G."Print Unit Price") AND
                                       (PrintOption2G <> PrintOption2G::"Print no lines")
                                    THEN
                                        SumOtherG += SalesInvLine2G.Amount
                                    ELSE
                                        SumVehicleG += SalesInvLine2G.Amount;
                            END;

                            IF (SalesInvLine2G.Type <> SalesInvLine2G.Type::" ") AND
                               ((SalesInvLine2G.Amount <> 0) OR (SalesInvLine2G."Amount Including VAT" <> 0))
                            THEN BEGIN
                                TotalsLineL.RESET;
                                TotalsLineL.SETCURRENTKEY("Document No.", Type, "No.");
                                TotalsLineL.SETRANGE("Document No.", SalesInvLine2G."Document No.");
                                TotalsLineL.SETRANGE(Type, SalesInvLine2G.Type);
                                TotalsLineL.SETRANGE("No.", SalesInvLine2G."No.");
                                TotalsLineL.CALCSUMS(Amount, "Amount Including VAT");
                                IF (TotalsLineL.Amount = 0) AND (TotalsLineL."Amount Including VAT" = 0) THEN
                                    CurrReport.SKIP;
                            END;
                            // Start PA033042
                            IF SalesInvLine2G."VAT Identifier" <> '' THEN
                                IF NOT VATIdentifierTempG.GET(SalesInvLine2G."VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := SalesInvLine2G."VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042
                            // Start PA035484.20145
                            IF (SalesInvLine2G.Quantity <> 0) AND (SalesInvLine2G."Additional Item" = SalesInvLine2G."Additional Item"::Deposit) THEN
                                SalesInvLine2G.MARK(TRUE);
                            // Stop PA035484.20145
                            // Start PA035597
                            SaleInvLineItemTypeG := SalesInvLine2G."Item Type";
                            SalesInvLineTypeG := SalesInvLine2G.Type;

                            PrintOptionHelpG := (PrintOption2G = PrintOption2G::"Print all lines") OR
                              ((PrintOption2G = PrintOption2G::"Print selected lines") AND SalesInvLine2G."Print Option Line");
                            PrintUnitPriceHelpG := FunctionPrintUnitPrice;

                            ShowSalPriceG := 0;
                            ShowLineDiscPctG := 0;
                            CASE SalesInvLine2G."VAT Calculation Type" OF
                                SalesInvLine2G."VAT Calculation Type"::"Differential Tax":
                                    DspAmountG := getSalPrice(SalesInvLine2G, 1);
                                ELSE BEGIN
                                        IF DoNotShowVATG THEN
                                            DspAmountG := getSalPrice(SalesInvLine2G, 1)
                                        ELSE
                                            DspAmountG := getSalPrice(SalesInvLine2G, 2) + getLineDiscPct(SalesInvLine2G, 2);
                                        IF PrintDiscG THEN BEGIN
                                            ShowSalPriceG := SalesInvLine2G."Unit Price";
                                            ShowLineDiscPctG := SalesInvLine2G."Line Discount %";
                                            IF (ShowSalPriceG <> 0) THEN BEGIN
                                                IF DoNotShowVATG THEN
                                                    DspAmountG := getSalPrice(SalesInvLine2G, 1) + getLineDiscPct(SalesInvLine2G, 1);
                                                ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                            END;
                                        END;
                                    END;
                            END;

                            VehicleDescriptionG := SalesInvLine2G."Shortcut Dimension 2 Code" + ' ' + SalesInvLine2G.Description;

                            IF PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices" THEN BEGIN
                                SumVehicleG := SumVehicleG + SumMfgOptG;
                                SumMfgOptG := 0;
                            END;
                            // Stop PA035597

                        end;

                        trigger OnPostDataItem()
                        var
                            TotalL: Decimal;
                            ArrayL: array[6] of Decimal;
                            IL: Integer;
                            MaxL: Decimal;
                            xL: Integer;
                            TotalVehicleL: Decimal;
                        begin
                            // Start PA035597
                            IF DoNotShowVATG THEN BEGIN
                                TotalL := 0;
                                // Start PA040256.57127
                                TotalL := TotalL + ROUND(SumVehicleG, AmountRoundPrecisionG);
                                TotalL := TotalL + ROUND(SumMfgOptG, AmountRoundPrecisionG);
                                TotalL := TotalL + ROUND(SumOwnOptG, AmountRoundPrecisionG);
                                TotalL := TotalL + ROUND(SumTransferFeesG, AmountRoundPrecisionG);
                                TotalL := TotalL + ROUND(SumChargeItemsG, AmountRoundPrecisionG);
                                TotalL := TotalL + ROUND(SumOtherG, AmountRoundPrecisionG);
                                TotalVehicleL := ROUND(TotalVehG, AmountRoundPrecisionG);
                                // Stop PA040256.57127
                                IF TotalVehicleL <> TotalL THEN BEGIN
                                    ArrayL[1] := SumVehicleG;
                                    ArrayL[2] := SumMfgOptG;
                                    ArrayL[3] := SumOwnOptG;
                                    ArrayL[4] := SumTransferFeesG;
                                    ArrayL[5] := SumChargeItemsG;
                                    ArrayL[6] := SumOtherG;
                                    MaxL := 0;
                                    FOR IL := 1 TO 6 DO BEGIN
                                        IF ArrayL[IL] > MaxL THEN BEGIN
                                            MaxL := ArrayL[IL];
                                            xL := IL;
                                        END;
                                    END;

                                    ArrayL[xL] := ArrayL[xL] + (TotalVehicleL - TotalL);
                                    SumVehicleG := ArrayL[1];
                                    SumMfgOptG := ArrayL[2];
                                    SumOwnOptG := ArrayL[3];
                                    SumTransferFeesG := ArrayL[4];
                                    SumTransferFeesG := ArrayL[5];
                                    SumOtherG := ArrayL[6];
                                END;
                            END;
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        var
                            SalesInvLineL: Record "Sales Invoice Line";
                        begin
                            VATAmountLineG.DELETEALL;
                            TotalVehG := 0;
                            SalesInvLine2G.RESET;
                            SalesInvLine2G.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            //Start API.1.0.2
                            //to show rows without advanced paymt rows
                            SalesInvLine2G.SETRANGE("Prepayment Line", FALSE);
                            //Stop API.1.0.2
                            MoreLinesG := SalesInvLine2G.FINDLAST;
                            WHILE MoreLinesG AND (SalesInvLine2G.Description = '') AND
                               (SalesInvLine2G."No." = '') AND (SalesInvLine2G.Quantity = 0) AND
                               (SalesInvLine2G.Amount = 0)
                            DO
                                MoreLinesG := SalesInvLine2G.NEXT(-1) <> 0;

                            IF NOT MoreLinesG THEN
                                CurrReport.BREAK;

                            SalesInvLine2G.SETRANGE("Line No.", 0, SalesInvLine2G."Line No.");

                            SETRANGE(Number, 1, SalesInvLine2G.COUNT);

                            SalesInvLine2G.SETFILTER("Item Type", '<>%1', SalesInvLine2G."Item Type"::Item);
                            //API.1.0.2 CurrReport.CREATETOTALS(SalesInvLine2G.Amount,SalesInvLine2G."Amount Including VAT");
                            SalesInvLineL.RESET;
                            SalesInvLineL.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            //Start API.1.0.2
                            //to show rows without advanced paymt rows
                            SalesInvLineL.SETRANGE("Prepayment Line", FALSE);
                            //Stop API.1.0.2
                            NormalVATTotalG := 0;
                            SumwithDiffTaxationG := 0;
                            SumOnlyDiffTaxationG := 0;
                            IF SalesInvLineL.FIND('-') THEN
                                REPEAT
                                    IF SalesInvLineL."VAT Calculation Type" = SalesInvLineL."VAT Calculation Type"::"Differential Tax" THEN BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesInvLineL."Amount Including VAT";
                                        SumOnlyDiffTaxationG := SumOnlyDiffTaxationG + SalesInvLineL."Amount Including VAT";
                                    END ELSE BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesInvLineL.Amount;
                                        NormalVATTotalG := NormalVATTotalG + (SalesInvLineL."Amount Including VAT" - SalesInvLineL.Amount);
                                    END;
                                UNTIL SalesInvLineL.NEXT = 0;
                            // Start PA033336
                            CLEAR(SaleInvLineItemTypeG);
                            TotalCurrVatAmtG := 0;
                            TotalInvDiscAmtG := 0;
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
                        column(ShowCurrency_VATC; ShowCurrencyG)
                        {
                        }
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
                            SETRANGE(Number, 1, TempVATAmountLineG.COUNT);
                        end;
                    }
                    dataitem(VATCounter2; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TotalCaptionLbl; TotalCaptionLbl)
                        {
                        }
                        column(TotalInclVATText_VATC2; TotalInclVATTextG)
                        {
                        }
                        column(VATAmountLineVATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineAmountIncludingVAT_VATBase; VATAmountLineG."Amount Including VAT" - VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATPer; VATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmountLineVATIdentifier; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(PercVATOnLbl; PercVATOfLbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                        end;

                        trigger OnPostDataItem()
                        begin
                            // Start PA035597
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLineG.COUNT <= 1 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            //CurrReport.CREATETOTALS(VATAmountLineG."VAT Base",VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Posted Sales Trade-In"; "Posted Sales Trade-In")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.") WHERE("Document Type" = FILTER(Invoice | Order | "Credit Memo"));
                        column(SumVehicle1G; SumVehicleG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumTransferFees2G; SumTransferFeesG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumMfgOpt1G; SumMfgOptG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumOther1G; SumOtherG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalInvDiscAmt1G; TotalInvDiscAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(DoNotShowVAT2G; DoNotShowVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumOwnOpt1G; SumOwnOptG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumChargeItems1G; SumChargeItemsG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalCurrVatAmt2G; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumTransferFees1G; SumTransferFeesG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalTradeIn; TotalTradeInG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line___Amount_Including_VAT____TotalTradeIn; SalesInvLine2G."Amount Including VAT" - TotalTradeInG)
                        {
                            AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ShowCurrency_Control75; ShowCurrencyG)
                        {
                        }
                        column(Trade_Ins_Caption; Trade_Ins_CaptionLbl)
                        {
                        }
                        column(TotalTradeInCaption; TotalTradeInCaptionLbl)
                        {
                        }
                        column(PayableCaption; PayableCaptionLbl)
                        {
                        }
                        column(Posted_Sales_Trade_In_Document_Type; "Document Type")
                        {
                        }
                        column(Posted_Sales_Trade_In_Document_No_; "Document No.")
                        {
                        }
                        column(Posted_Sales_Trade_In_Document_Line_No_; "Document Line No.")
                        {
                        }
                        column(Posted_Sales_Trade_In_Line_No_; "Line No.")
                        {
                        }
                        column(Posted_Sales_Trade_In_VIN; VIN)
                        {
                        }
                        dataitem(Vehicle2; Vehicle)
                        {
                            DataItemLink = VIN = FIELD(VIN);
                            DataItemTableView = SORTING(VIN);
                            column(Vehicle2_VIN; VIN)
                            {
                            }
                            column(Vehicle2__Make_Code_; "Make Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Vehicle2_Mileage; Mileage)
                            {
                            }
                            column(Posted_Sales_Trade_In__Description; "Posted Sales Trade-In".Description)
                            {
                            }
                            column(Posted_Sales_Trade_In___Unit_Cost_Incl__VAT_; VINTotalTradeInG)
                            {
                                AutoFormatExpression = SalesInvLine2G.GetCurrencyCode;
                                AutoFormatType = 1;
                                Description = 'PA040293.57855';
                            }
                            column(MileageCaption; MileageCaptionLbl)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        var
                            PurchInvHdrL: Record "Purch. Invoice Header";
                            PurchInvLineL: Record "Purch. Invoice Line";
                            PurchCrMemoHdrL: Record "Purch. Credit Memo Header";
                        begin
                            IF TradeInExtraG AND NOT CurrReport.PREVIEW THEN BEGIN
                                IF "Posted Purch. Invoice No." <> '' THEN BEGIN
                                    PurchInvHdrL.SETRANGE("No.", "Posted Purch. Invoice No.");
                                    PurchInvHdrL.PrintVehicleRecords(FALSE);
                                END;
                                IF "Posted Purch. Cr. Memo No." <> '' THEN BEGIN
                                    PurchCrMemoHdrL.SETRANGE("No.", "Posted Purch. Cr. Memo No.");
                                    PurchCrMemoHdrL.PrintVehicleRecords(FALSE);
                                END;
                            END;
                            // Start PA040293.57855
                            PurchInvLineL.RESET;
                            PurchInvLineL.SETRANGE("Document No.", "Posted Purch. Invoice No.");
                            // Start PA041187.87656
                            PurchInvLineL.SETRANGE("Line No.", "Posted Sales Trade-In"."Posted Purch. Invoice Line No.");
                            // Stop PA041187.87656

                            // Start PA042846
                            IF PurchInvLineL.FINDFIRST THEN BEGIN
                                // Stop PA042846
                                // Start PA040293.57855
                                // Stop PA040293.57855
                                VINTotalTradeInG := PurchInvLineL."Amount Including VAT";
                                // Start PA042846
                            END ELSE
                                VINTotalTradeInG := "Posted Sales Trade-In"."Unit Cost Incl. VAT (LCY)";
                            // Stop PA042846
                            // Stop PA040293.57855
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS("Unit Cost Incl. VAT (LCY)");
                            // Stop PA040293.57855
                            VINTotalTradeInG := 0;
                            // Stop PA040293.57855
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
                    dataitem(DiffTaxText; "Posted Sales Doc DiffTaxText")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Entry No.") WHERE("Document Type" = CONST(1));
                        column(DiffTaxText_Text; Text)
                        {
                        }
                        column(DiffTaxExistsG; DiffTaxExistsG)
                        {
                            Description = 'PA033336';
                        }
                        column(DiffTaxText_Document_Type; "Document Type")
                        {
                        }
                        column(DiffTaxText_Document_No_; "Document No.")
                        {
                        }
                        column(DiffTaxText_Entry_No_; "Entry No.")
                        {
                        }
                    }
                    dataitem(PostdEmissionRelText; "Posted Emissions Related Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Entry No.") WHERE("Document Type" = CONST(1));
                        column(PostdEmissionRelText_Text; PostdEmissionRelText.Text)
                        {
                            Description = 'PA042665.86105';
                        }
                        column(EmissionRelatedTextLbl; EmissionRelatedTextLbl)
                        {
                            Description = 'PA042665.86105';
                        }
                    }
                    dataitem(HeaderFooterText; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Footer));
                        column(HeaderFooterText_Text; Text)
                        {
                        }
                        column(PrintFooterLine; PrintFooterLineG)
                        {
                            Description = 'PA033336';
                        }
                        column(Header_Footer_1; "Header/Footer")
                        {
                            Description = 'PA033336';
                        }
                        column(HeaderFooterText_Document_Type; "Document Type")
                        {
                        }
                        column(HeaderFooterText_Document_No_; "Document No.")
                        {
                        }
                        column(HeaderFooterText_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem(ShipmentFooter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        dataitem(ShipmentFooter2; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            dataitem(ShipmentFooter3; "Integer")
                            {
                                DataItemTableView = SORTING(Number);
                                column(DataItem1109400015; C_INC036 + ' ' + FORMAT(DATE2DMY(FirstDateG, 2)) + '/' + FORMAT(DATE2DMY(FirstDateG, 3)) + ' ' + C_INC037 + ' ' + VINTextG + ' :')
                                {
                                }
                                column(Text1G___Text2G; TextG + Text2G)
                                {
                                }
                                column(ShipmentFooter3_Number; Number)
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
                                SlNoG := 0;
                                VINTextG := SalesShpLineT2G.VIN;
                                SalesShpLineTG.RESET;
                                SalesShpLineTG.SETCURRENTKEY("Posting Date", "Document No.", "Line No.");
                                SalesShpLineTG.SETFILTER("Posting Date", '%1..%2', FirstDateG, LastDateG);
                                SalesShpLineTG.SETRANGE(VIN, SalesShpLineT2G.VIN);
                                SalesShpLineT3G.RESET;
                                SalesShpLineT3G.DELETEALL;

                                IF SalesShpLineTG.FIND('-') THEN
                                    REPEAT
                                        SalesShpLineT3G.RESET;
                                        SalesShpLineT3G.SETRANGE(SalesShpLineT3G."Item Type", SalesShpLineTG."Item Type");
                                        SalesShpLineT3G.SETRANGE(SalesShpLineT3G."No.", SalesShpLineTG."No.");
                                        IF SalesShpLineT3G.FIND('-') THEN BEGIN
                                            SalesShpLineT3G."Closing Invoiced Quantity" := SalesShpLineT3G."Closing Invoiced Quantity" +
                                              SalesShpLineTG."Closing Invoiced Quantity";
                                            SalesShpLineT3G.MODIFY;
                                        END ELSE BEGIN
                                            SalesShpLineT3G.RESET;
                                            SalesShpLineT3G.INIT;
                                            SalesShpLineT3G.TRANSFERFIELDS(SalesShpLineTG);
                                            SalesShpLineT3G.INSERT;
                                        END;
                                    UNTIL SalesShpLineTG.NEXT = 0;

                                StanTextG.RESET;
                                StanTextG.DELETEALL;
                                StanText2G.RESET;
                                StanText2G.DELETEALL;
                                DescriptionG := '';


                                IF SalesShpLineT3G.FIND('-') THEN
                                    REPEAT
                                        IF DescriptionG = '' THEN
                                            DescriptionG := FORMAT(SalesShpLineT3G."Item Type") + ' ' + SalesShpLineT3G."No." + ' ' +
                                              SalesShpLineT3G."Unit of Measure Code" + ' ' + FORMAT(SalesShpLineT3G."Closing Invoiced Quantity")
                                        ELSE
                                            DescriptionG := ' / ' + FORMAT(SalesShpLineT3G."Item Type") + ' ' + SalesShpLineT3G."No." + ' ' +
                                              SalesShpLineT3G."Unit of Measure Code" + ' ' + FORMAT(SalesShpLineT3G."Closing Invoiced Quantity");
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
                                    UNTIL SalesShpLineT3G.NEXT = 0;

                                SalesShpLineT2G.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SalesShpLineT2G.RESET;
                                SalesShpLineT2G.DELETEALL;
                                IF NOT ((DATE2DMY(LastDateG, 2) = DATE2DMY("Sales Invoice Header"."Main Shipment Date", 2)) AND
                                   (DATE2DMY(LastDateG, 3) = DATE2DMY("Sales Invoice Header"."Main Shipment Date", 3)))
                                THEN BEGIN
                                    IF SalesShpLineTG.FIND('-') THEN
                                        REPEAT
                                            SalesShpLineT2G.RESET;
                                            SalesShpLineT2G.SETRANGE(VIN, SalesShpLineTG.VIN);
                                            IF NOT SalesShpLineT2G.FIND('-') THEN BEGIN
                                                SalesShpLineT2G.RESET;
                                                SalesShpLineT2G.INIT;
                                                SalesShpLineT2G.TRANSFERFIELDS(SalesShpLineTG);
                                                SalesShpLineT2G.INSERT;
                                            END;
                                        UNTIL SalesShpLineTG.NEXT = 0;
                                END;
                                IF SalesShpLineT2G.FIND('-') THEN
                                    SETRANGE(Number, 1, SalesShpLineT2G.COUNT)
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
                                SalesShpLineTG.SETFILTER("Posting Date", '%1..%2', FirstDateG, LastDateG);
                            END ELSE BEGIN
                                EXIT;
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
                                    FirstDateG := CALCDATE('<CM + 1D - 1M>', "Sales Invoice Header"."First Shipment Date")
                                ELSE
                                    FirstDateG := CALCDATE('<CM + 1D>', LastDateG);
                                LastDateG := CALCDATE('<CM>', FirstDateG);
                                CountG := CountG + 1;
                            UNTIL LastDateG >= LastShipDateG;

                            SETRANGE(Number, 1, CountG);
                            LastDateG := 0D;
                        end;
                    }
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("No.") WHERE("Type of Document to be Printed" = CONST("Sales Invoice"));
                        column(Posted_Cash_Register_Header__Payment__In_Out__; "Payment (In/Out)")
                        {
                        }
                        column(PurchInvHdrCashRegRcptNoG; "Sales Invoice Header"."Cash Register Receipt")
                        {
                            Description = 'PA033336';
                        }
                        column(PostedCashRegHdrNoG; "Posted Cash Register Header"."No.")
                        {
                            Description = 'PA033336';
                        }
                        dataitem("Cash Reg. Add Disc Split Post."; "Cash Reg. Add Disc Split Post.")
                        {
                            DataItemLink = "Applies-to ID" = FIELD("No.");
                            DataItemTableView = SORTING("Source Type", "Source No.", "Applies-to ID");
                            column(ApptoIDG; "Cash Reg. Add Disc Split Post."."Applies-to ID")
                            {
                                Description = 'PA033336';
                            }
                            column(PurchInvHdrCashRegRcptNoG1; "Sales Invoice Header"."Cash Register Receipt")
                            {
                                Description = 'PA033336';
                            }
                            column(AmountMinusDiscount; AmountMinusDiscG)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Pmt__Discount_Total_; "Pmt. Discount Total")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Remaining_Amount_; "Remaining Amount")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Currency_Code_; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__; "Appl.-to Document No.")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_; "Appl.-to Document Type")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Posting_Date_; FORMAT("Posting Date"))
                            {
                                Description = 'PA033336';
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
                            column(PostCashRegLineDocNoG; "Posted Cash Register Line"."Document No.")
                            {
                                Description = 'PA033336';
                            }
                            column(PurchInvHdrCashRegRcptNoG2; "Sales Invoice Header"."Cash Register Receipt")
                            {
                                Description = 'PA033336';
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
                            column(Posted_Cash_Register_Header___Currency_Code__Control198; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_; "Posted Cash Register Header"."Amount Given")
                            {
                            }
                            column(Posted_Cash_Register_Header___Currency_Code__Control200; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Change_Money_; "Posted Cash Register Header"."Change Money")
                            {
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
                            column(Posted_Cash_Register_Header___Amount_Given_Caption; Posted_Cash_Register_Header___Amount_Given_CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Header___Change_Money_Caption; Posted_Cash_Register_Header___Change_Money_CaptionLbl)
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
                            IF NOT PmtMethodG.GET("Sales Invoice Header"."Payment Method Code") OR NOT PmtMethodG."Cash Payment" THEN
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
                                // Start PA033336
                                VATLegendsG := '';
                                IF IncrG = 1 THEN
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC041;
                                IncrG := IncrG + 1;
                                // Stop PA033336
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
                        column(VATClauseVATIdentifier; C_INC_VAT + VATAmountLineG."VAT Identifier")
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
                            //API.1.0.2 CurrReport.CREATETOTALS(VATAmountLineG."VAT Amount");
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
                }
                dataitem(Deposit; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    trigger OnAfterGetRecord()
                    var
                        DepositReportL: Report "Deposit Ticket";
                    begin
                        IF PrintDepositTicketsG THEN BEGIN
                            SalesInvLine2G.MARKEDONLY(TRUE);
                            IF SalesInvLine2G.FIND('-') THEN
                                REPEAT
                                    IF (SalesInvLine2G."Printed Deposit Tickets" > 0) OR
                                       (DepositReportL.SalInvoiceLinePrintQty(SalesInvLine2G) > 0)
                                    THEN BEGIN
                                        // Start PA035484.20145
                                        UserSessionG.SetUsage(VehicleReportSelectionG.Usage::"Deposit Ticket");
                                        DepositReportL.DefParameters(SalesInvLine2G.TABLECAPTION, CopyTextG,
                                          // Start PA041187.72605
                                          CopyLoop.Number - 1, 0);
                                        // Stop PA041187.72605
                                        // Stop PA035484.20145
                                        DepositReportL.SETTABLEVIEW(SalesInvLine2G);
                                        DepositReportL.RUNMODAL();
                                        SalesInvLine2G.FINDLAST;
                                    END;
                                UNTIL SalesInvLine2G.NEXT = 0;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    // Start PA033336
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    END;

                    ShowDuplicateImageG := FALSE; //  API.1      20.03.18 KV
                    IF ("Sales Invoice Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC038
                        ELSE // Start API.1      20.03.18 KV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      20.03.18 KV

                    // Stop PA033336
                    TotalVehG := 0;
                    SumVehicleG := 0;
                    SumTotVehicleG := 0;
                    SumOwnOptG := 0;
                    SumMfgOptG := 0;
                    SumTransferFeesG := 0;
                    SumOtherG := 0;
                    TotalTradeInG := 0;
                    CurrentVehicleG := 0;
                    CurrReport.PAGENO := 1;
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
                InteractionLogL: Record "Interaction Log Entry";
                IntCustL: Code[20];
                bankAccountL: Record "Bank Account";
                salesInvLineL: Record "Sales Invoice Line";
                T113Fnc: Codeunit "ET111,112,113,114,115,6661";
            begin
                //Start API.1      20.03.18 KV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      20.03.18 KV

                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := VehicleReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Vehicle Sales Invoice CZ"); //API.1      20.03.18 KV
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593
                // Start PA035484.20145
                // Start PA039225.51457
                // Stop PA039225.51457
                // Stop PA035484.20145

                //Start API.1      20.03.18 KV
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
                //Stop API.1      20.03.18 KV

                // Start PA040256.57127
                AmountRoundPrecisionG := CurrencyG.GetAmountRoundingPrecision("Currency Code");
                // Stop PA040256.57127

                PrintOption2G := PrintOptionPufferG;
                PrintUnitPrice2G := PrintUnitPricePufferG;
                IF MixedTaxation("Sales Invoice Header"."No.") THEN BEGIN
                    PrintOption2G := PrintOption2G::"Print all lines";
                    PrintUnitPrice2G := PrintUnitPrice2G::"Print all prices";
                END;
                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                CurrReport.LANGUAGE := BillToCustG.PrintDocInCustLanguage();
                CustLedgEntrG.RESET;
                CustLedgEntrG.SETCURRENTKEY("Applies-to Doc. No.", "Applies-to Doc. Type");
                CustLedgEntrG.SETFILTER("Applies-to Doc. No.", "No.");
                CustLedgEntrG.SETFILTER("Applies-to Doc. Type", '%1', CustLedgEntrG."Applies-to Doc. Type"::Invoice);
                IF NOT CustLedgEntrG.FINDLAST THEN BEGIN
                    CLEAR(ShowAppTextG);
                END ELSE
                    ShowAppTextG := COPYSTR(C_INC032 + ' ' + FORMAT(CustLedgEntrG."Document Type") + ' ' + CustLedgEntrG."Document No.", 1, 50);

                IF CurrReport.PREVIEW THEN
                    PrintDepositTicketsG := FALSE;
                PrintDiscG := "Sales Invoice Header"."Show Discount";

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

                //Start API.1.0.2  07.06.18 PV
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
                //   OwnBanksG.GET(IntCustL, LocationG."Bank Code")
                // THEN
                // BEGIN // Start API.1      20.03.18 KV
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // Stop API.1      20.03.18 KV
                //  BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No." +
                //    C_INC039 + OwnBanksG."SWIFT-BIC" + C_INC040 + OwnBanksG.IBAN
                // END // Start API.1      20.03.18 KV
                // ELSE BEGIN
                //  BankNameG := CompanyInfoG."Bank Name";
                //  BankBranchNoG := CompanyInfoG."Bank Branch No.";
                //  BankSwiftG := CompanyInfoG."SWIFT-BIC";
                //  BankIbanG := CompanyInfoG.IBAN;
                //  BankAccountNoG := CompanyInfoG."Bank Account No.";
                //  // Stop API.1    20.03.18 KV
                //  BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No." +
                //    C_INC039 + CompanyInfoG."SWIFT-BIC" + C_INC040 + CompanyInfoG.IBAN;
                // END; // API.1      20.03.18 PV
                //Stop API.1.0.2  07.06.18 PV
                // Stop PA033041

                // Start PA038229
                SalesInvLine3G.RESET;
                SalesInvLine3G.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                // Start PA044794
                SalesInvLine4G.RESET;
                SalesInvLine4G.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine4G.SETFILTER("From Veh. Option Inv. Doc. No.", '<> %1', '');
                IF NOT SalesInvLine4G.ISEMPTY THEN
                    SalesInvLine3G.SETRANGE("Item Type", SalesInvLine3G."Item Type"::"G/L Account")
                ELSE
                    SalesInvLine3G.SETRANGE("Item Type", SalesInvLine3G."Item Type"::Vehicle);
                // Stop PA044794
                // Start PA038229.41906
                HideVehicleMainInfoG := SalesInvLine3G.ISEMPTY;
                // Stop PA038229.41906
                // Start PA044794
                ShowManyVehiclesG := SalesInvLine3G.COUNT >= 1;

                // Stop PA044794
                CLEAR(MainNextAppDateG);
                CLEAR(EmissionNextAppDateG);
                // Start PA044794
                IF ShowManyVehiclesG AND SalesInvLine3G.FINDFIRST THEN BEGIN
                    // Stop PA044794
                    IF VehicleG.GET(SalesInvLine3G.VIN) THEN BEGIN
                        MainNextAppDateG := GetNextApptDate(1, "Sales Invoice Header"."Document Date");
                        EmissionNextAppDateG := GetNextApptDate(2, "Sales Invoice Header"."Document Date");
                        //Start API.1.0.2
                        //this var will be used to (not)show vehicle info in layout instead of original
                        // layout condition for values visibility, ie. Hidden:
                        //  IIF((Fields!ShowManyVehiclesG.Value Or Fields!HideVehicleMainInfoG.Value), True, False)
                        ShowVehicleInfoG := SalesInvLine3G.COUNT = 1;
                        //Stop API.1.0.2
                    END;
                END;
                // Stop PA038229

                SalesInvLine2G.RESET;
                SalesInvLine2G.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine2G.SETRANGE("VAT Calculation Type", SalesInvLine2G."VAT Calculation Type"::"Differential Tax");
                IF SalesInvLine2G.FIND('-') THEN BEGIN
                    DiffTaxExistsG := TRUE;
                END ELSE
                    DiffTaxExistsG := FALSE;

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
                IF DiffTaxExistsG THEN
                    TotalInclVATTextG := STRSUBSTNO(C_INC010, ShowCurrencyG)
                ELSE
                    TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);

                // Start PA039784.45749
                FormatAddrG.SetCustNo("Sales Invoice Header"."Bill-to Customer No.");
                // Stop PA039784.45749
                FormatAddrG.SalesInvBillTo(CustAddrG, "Sales Invoice Header");
                // Start PA039784.45749
                FormatAddrG.SetCustNo('');
                // Stop PA039784.45749
                IF CustG.GET("Bill-to Customer No.") THEN
                    ;

                // Start API.1      20.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Invoice Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // Stop API.1      20.03.18 PV

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipMethodG.INIT
                ELSE
                    ShipMethodG.GET("Shipment Method Code");

                // API.1      20.03.18 KV note: original does not use shipto variables on layout
                FormatAddrG.SalesInvShipTo(ShipToAddrG, "Sales Invoice Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                IF AddressSalutationG.GET("Sales Invoice Header"."Bill-to Salutation Code") THEN
                    SalesAddrSaluationG := AddressSalutationG."Document Salutation";
                SeparatorG := '';
                Separator2G := '';
                Separator3G := '';
                Separator4G := '';

                CLEAR(OrderCustAddrG); //API.1.0.1
                IF "Sales Invoice Header"."Sell-to Customer No." <> "Sales Invoice Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesInvCust(OrderCustAddrG, "Sales Invoice Header");
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
                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(29) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::VeSaleInv,
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
                        IF SalesInvLineG."Shipment No. not Closed" <> '' THEN
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
                IF (FirstShipDateG = 0D) OR (LastShipDateG = 0D) THEN BEGIN
                    IF SalesShpLineTG.FIND('-') THEN
                        REPEAT
                            IF (FirstShipDateG = 0D) OR (SalesShpLineTG."Posting Date" < FirstShipDateG) THEN
                                FirstShipDateG := SalesShpLineTG."Posting Date";
                            IF (LastShipDateG = 0D) OR (SalesShpLineTG."Posting Date" > LastShipDateG) THEN
                                LastShipDateG := SalesShpLineTG."Posting Date";
                            ERROR('%1 %2', FirstShipDateG, LastShipDateG);
                        UNTIL SalesShpLineTG.NEXT = 0;
                END;
                IF "Main Shipment Date" <> 0D THEN
                    ShipDateTextG := FORMAT(DATE2DMY("Main Shipment Date", 2)) + '/' + FORMAT(DATE2DMY("Main Shipment Date", 3))
                ELSE
                    ShipDateTextG := '';
            end;

            trigger OnPreDataItem()
            var
                EntryCreatedL: Boolean;
                OptionInvNoL: array[100] of Code[20];
                CurEntryL: Integer;
                NumEntriesL: Integer;
                NoStringL: Text[250];
            begin
                PrintOptionPufferG := PrintOption2G;
                PrintUnitPricePufferG := PrintUnitPrice2G;
                CompanyInfoG.GET;

                IF OutputSepInvG THEN BEGIN
                    CLEAR(OptionInvNoL);
                    PostedVehOptionInvG.RESET;
                    PostedVehOptionInvG.SETRANGE("Document Type", PostedVehOptionInvG."Document Type"::"Posted Invoice");
                    NoStringL := "Sales Invoice Header".GETFILTER("No.");
                    PostedVehOptionInvG.SETFILTER("Document No.", '%1', NoStringL);
                    PostedVehOptionInvG.SETRANGE("Avail. in Separate Posted Inv.", TRUE);
                    IF PostedVehOptionInvG.FIND('-') THEN BEGIN
                        NumEntriesL := 0;
                        REPEAT
                            PostedVehOptionInvG.CALCFIELDS("Posted Own Invoice No.");
                            EntryCreatedL := FALSE;
                            CurEntryL := 1;
                            REPEAT
                                IF OptionInvNoL[CurEntryL] = PostedVehOptionInvG."Posted Own Invoice No." THEN
                                    EntryCreatedL := TRUE;
                                IF OptionInvNoL[CurEntryL] = '' THEN BEGIN
                                    OptionInvNoL[CurEntryL] := PostedVehOptionInvG."Posted Own Invoice No.";
                                    EntryCreatedL := TRUE;
                                    NumEntriesL := NumEntriesL + 1;
                                END;
                                CurEntryL := CurEntryL + 1;
                                IF CurEntryL = 100 THEN
                                    ERROR(C_INC013);
                            UNTIL (CurEntryL = 100) OR EntryCreatedL;
                        UNTIL PostedVehOptionInvG.NEXT = 0;
                        IF NumEntriesL > 0 THEN
                            FOR IG := 1 TO NumEntriesL DO BEGIN
                                NoStringL := "Sales Invoice Header".GETFILTER("No.");
                                IF NoStringL <> '' THEN
                                    NoStringL := NoStringL + '|';
                                NoStringL := NoStringL + OptionInvNoL[IG];
                                "Sales Invoice Header".SETFILTER("No.", NoStringL);
                            END;
                    END;
                END;
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
                    field(PrintOption2G; PrintOption2G)
                    {
                        Caption = 'Print Option';
                    }
                    field(PrintUnitPrice2G; PrintUnitPrice2G)
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
                    field(TradeInExtraG; TradeInExtraG)
                    {
                        Caption = 'Trade-In on own invoice';
                    }
                    field(PrintDepositTicketsG; PrintDepositTicketsG)
                    {
                        Caption = 'Print Deposit Tickets';
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
                    field(OutputSepInvG; OutputSepInvG)
                    {
                        Caption = 'Print separate\option invoice';
                    }
                    field(ShowDiscPctG; ShowDiscPctG)
                    {
                        Caption = 'Print Discount %';
                        MultiLine = true;
                    }
                    field(RePrintOriginalInvG; RePrintOriginalInvG)
                    {
                        Caption = 'Re-print Original Invoice';
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
            OutputSepInvG := FALSE;
            IF InvtSetupG.GET THEN
                PrintDepositTicketsG := InvtSetupG."Print Deposit Tickets"
            ELSE
                PrintDepositTicketsG := FALSE;
            // Start PA039225.51457
            PrintOption2G := PrintOption2G::"Print selected lines";
            PrintUnitPrice2G := PrintUnitPrice2G::"Print selected prices";

            PrintDiscG := TRUE;
            // Start PA033336
            // Stop PA033336
            // Start PA033336
            // Stop PA033336
            GetReportSelection();
            // Stop PA039225.51457
            RePrintOriginalInvG := FALSE;

            IF UserSetupG.GET(USERID) THEN
                ReqRePrintControlG := UserSetupG."Re-print Original Invoice"
            ELSE
                ReqRePrintControlG := FALSE;
            // Stop PA033336
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
        end;
    }

    labels
    {
        MakeLbl = 'Make';
        TradeDescrLbl = 'Trade-in Description';
        VINLbl = 'VIN';
        KmMHrsLbl = 'Km/M/Hours';
        TradeAmountLbl = 'Trade-in Amount';
    }

    trigger OnInitReport()
    begin
        GLSetupG.GET;
        // Start PA032727
        // Start PA039225.51457
        // Start PA035597
        // Stop PA035597
        PrintOption2G := PrintOption2G::"Print selected lines";
        PrintUnitPrice2G := PrintUnitPrice2G::"Print selected prices";
        // Start PA033336
        // Stop PA033336
        PrintDiscG := TRUE;
        // Start PA035484.20754
        // Stop PA035484.20754
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        GetReportSelection();
        // Stop PA039225.51457
        IF InvtSetupG.GET THEN
            PrintDepositTicketsG := InvtSetupG."Print Deposit Tickets"
        ELSE
            PrintDepositTicketsG := FALSE;
        // Stop PA032727
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA03597
    end;

    var
        SalesInvLineG: Record "Sales Invoice Line";
        SalesShpLineG: Record "Sales Shipment Line";
        SalesShpLineTG: Record "Sales Shipment Line" temporary;
        SalesShpLineT2G: Record "Sales Shipment Line" temporary;
        SalesShpLineT3G: Record "Sales Shipment Line" temporary;
        StanTextG: Record "Standard Text" temporary;
        StanText2G: Record "Standard Text" temporary;
        UserSetupG: Record "User Setup";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Vehicle Sales Rep. Selection";
        AddressSalutationG: Record "Address Salutation";
        VehicleReportSelectionG: Record "Vehicle Sales Rep. Selection";
        SalesAndReceivSetupG: Record "Sales & Receivables Setup";
        CustLedgEntrG: Record "Cust. Ledger Entry";
        PrinterSelectionG: Record "Printer Selection";
        CustG: Record Customer;
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        PostedVehOptionInvG: Record "Posted Vehicle Option Invoice";
        PostedOptionVariantsG: Record "Posted Option Variant";
        InvtSetupG: Record "Inventory Setup";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        BillToCustG: Record Customer;
        SalesInvLine2G: Record "Sales Invoice Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        Vehicle3G: Record Vehicle;
        VATClauseG: Record "VAT Clause";
        LanguageG: Record Language;
        SalesInvLine3G: Record "Sales Invoice Line";
        VehicleG: Record Vehicle;
        CurrencyG: Record Currency;
        SalesInvLine4G: Record "Sales Invoice Line";
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        SalesInvCountPrintedG: Codeunit "Sales Inv.-Printed";
        SegMgntG: Codeunit SegManagement;
        RTCMgmtG: Codeunit "RTC Management";
        UserSessionG: Codeunit "User Session Unit";
        DescriptionG: Text[100];
        ShipTextG: Text[30];
        TextG: Text[50];
        Text2G: Text[50];
        ShipDateTextG: Text[10];
        VINTextG: Text[30];
        VATLegendsG: Text[15];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        ShowCurrencyG: Text[30];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        ShowAppTextG: Text[50];
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
        InitialRegisTextG: Text[30];
        VehicleDescriptionG: Text[100];
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
        ReferenceTextG: Text[30];
        TotalInclVATTextG: Text[50];
        SalesAddrSaluationG: Text[30];
        CustRegisTextG: Text[30];
        RegisTextG: Text[100];
        DuplicateTextG: Text[30];
        _INCADEA_: Boolean;
        LogInteractionG: Boolean;
        PrintOptionHelpG: Boolean;
        PrintUnitPriceHelpG: Boolean;
        DiffTaxExistsG: Boolean;
        ShowDiscPctG: Boolean;
        RePrintOriginalInvG: Boolean;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        OptionFoundG: Boolean;
        OutputSepInvG: Boolean;
        ShowUnitsofMeasureG: Boolean;
        PrintFooterLineG: Boolean;
        TradeInExtraG: Boolean;
        PrintDepositTicketsG: Boolean;
        ShowShippingAddrG: Boolean;
        MoreLinesG: Boolean;
        DoNotShowVATG: Boolean;
        PrintDiscG: Boolean;
        ReqRePrintControlG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        ShowManyVehiclesG: Boolean;
        HideVehicleMainInfoG: Boolean;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        OutputNoG: Integer;
        IncrG: Integer;
        SalesItemTypeG: Integer;
        SalesTypeG: Integer;
        SaleInvLineItemTypeG: Integer;
        SalesInvLineTypeG: Integer;
        OptVariantTypeG: Integer;
        OptVariantType2G: Integer;
        OptVariantType3G: Integer;
        OptVariantType4G: Integer;
        NormalVATTotalG: Decimal;
        SumwithDiffTaxationG: Decimal;
        SumOnlyDiffTaxationG: Decimal;
        ShowSalPriceG: Decimal;
        ShowLineDiscPctG: Decimal;
        DspAmountG: Decimal;
        CountTransAmountOldG: Decimal;
        CurrentVehicleG: Decimal;
        AmountMinusDiscG: Decimal;
        TotalVehG: Decimal;
        TotalTradeInG: Decimal;
        SumOwnOptG: Decimal;
        SumVehicleG: Decimal;
        SumTotVehicleG: Decimal;
        SumMfgOptG: Decimal;
        SumOtherG: Decimal;
        SumChargeItemsG: Decimal;
        SumTransferFeesG: Decimal;
        TotalCurrVatAmtG: Decimal;
        TotalInvDiscAmtG: Decimal;
        VINTotalTradeInG: Decimal;
        AmountRoundPrecisionG: Decimal;
        CountG: Integer;
        MaxNoCharsPerLineG: Integer;
        SlNoG: Integer;
        PageLoopFooterG: Integer;
        VINOldG: Code[20];
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No:';
        C_INC008: Label 'Order Customer:';
        C_INC009: Label 'Disc. %';
        C_INC010: Label 'Ending Total %1';
        C_INC013: Label 'Cancel because there would be more than 100 separate option invoices';
        C_INC028: Label 'Series';
        C_INC029: Label 'Copy of';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Vehicle Sales Invoice';
        C_INC033: Label 'Tax No.';
        PrintOption2G: Option "Print selected lines","Print all lines","Print no lines";
        PrintOptionPufferG: Option "0","1","2";
        PrintUnitPrice2G: Option "Print selected prices","Print all prices","Print no prices","3";
        PrintUnitPricePufferG: Option "0","1","2";
        FirstShipDateG: Date;
        LastShipDateG: Date;
        FirstDateG: Date;
        LastDateG: Date;
        C_INC034: Label 'Shipment Date';
        C_INC035: Label 'Dispatch Date';
        C_INC036: Label 'Differing Shipment';
        C_INC037: Label 'for vehicle';
        C_INC038: Label 'D U P L I C A T E';
        C_INC039: Label ' - SWIFT-BIC:';
        C_INC040: Label ' - IBAN:';
        C_INC041: Label ' =';
        C_INC042: Label 'Vehicle Invoice';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        EUTireInformationG: Text[1024];
        ReportTitleG: Text[250];
        Sales_Invoice_Header___No__CaptionLbl: Label 'Document No.';
        Sales_Invoice_Header___Document_Date_CaptionLbl: Label 'Document Date';
        PageLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        SalesPurch_NameCaptionLbl: Label 'Salesperson';
        Payments_to_CaptionLbl: Label 'Payments to:';
        Nr_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        VAT_IdentifierCaptionLbl: Label 'VAT Identifier';
        UoMLbl: Label 'UoM';
        Sales_Invoice_Line__MileageCaptionLbl: Label 'Mileage:';
        Sales_Invoice_Line___License_No__CaptionLbl: Label 'License No.:';
        Vehicle3__Registration_Certificate_CaptionLbl: Label 'Vehicle Paper Number:';
        Sales_Invoice_Line__VINCaptionLbl: Label 'VIN:';
        FORMAT__Sales_Invoice_Line___Vehicle_Status__CaptionLbl: Label 'Vehicle Status:';
        RegisTextCaptionLbl: Label 'Initial/Customer Registration:';
        CurrentVehicleCaptionLbl: Label 'Continued';
        TotalVehCaptionLbl: Label 'Vehicle Total';
        CurrentVehicle_Control22CaptionLbl: Label 'Sum carried forward';
        TotalVeh_Control100CaptionLbl: Label 'Vehicle Total';
        SumVehicleCaptionLbl: Label 'Sum Vehicle';
        SumMfgOptCaptionLbl: Label 'Sum Mgr Option';
        SumOwnOptCaptionLbl: Label 'Sum Own Option';
        SumTransferFeesCaptionLbl: Label 'Sum Transfer Fees';
        Sum_Charge_ItemsCaptionLbl: Label 'Sum Charge Items';
        SumOtherCaptionLbl: Label 'Sum Other';
        InvDiscountAmountLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        davon_Differenzbesteuerung_CaptionLbl: Label '(of these diff. taxation)';
        SummeCaption_Control251Lbl: Label 'Total';
        RegisText_Control89CaptionLbl: Label 'Initial/Customer Registration:';
        Sales_Invoice_Line__Mileage_Control114CaptionLbl: Label 'Mileage:';
        Sales_Invoice_Line___License_No___Control106CaptionLbl: Label 'License No.:';
        Vehicle__Registration_Certificate_CaptionLbl: Label 'Vehicle Paper Number:';
        Sales_Invoice_Line__VIN_Control83CaptionLbl: Label 'VIN:';
        FORMAT__Sales_Invoice_Line___Vehicle_Status___Control207CaptionLbl: Label 'Vehicle Status:';
        Sales_Invoice_Line__VIN_Control122CaptionLbl: Label 'VIN:';
        Sales_Invoice_Line___License_No___Control115CaptionLbl: Label 'License No.:';
        Sales_Invoice_Line__Mileage_Control116CaptionLbl: Label 'Mileage:';
        Vehicle__Registration_Certificate__Control121CaptionLbl: Label 'Vehicle Paper Number:';
        RegisText_Control117CaptionLbl: Label 'Initial/Customer Registration:';
        FORMAT__Sales_Invoice_Line___Vehicle_Status___Control209CaptionLbl: Label 'Vehicle Status:';
        CurrentVehicle_Control91CaptionLbl: Label 'Sum carried forward';
        CurrentVehicle_Control60CaptionLbl: Label 'Sum carried forward';
        CurrentVehicle_Control42CaptionLbl: Label 'Sum carried forward';
        FortsetzungCaptionLbl: Label 'Continued';
        PercVATOfLbl: Label '% VAT of';
        FortsetzungCaption_Control111Lbl: Label 'Continued';
        davon_Differenzbesteuerung_Caption_Control239Lbl: Label '(of these diff. taxation)';
        Trade_Ins_CaptionLbl: Label 'Trade-Ins:';
        TotalTradeInCaptionLbl: Label 'Sum Trade-In';
        PayableCaptionLbl: Label 'Payable';
        MileageCaptionLbl: Label 'Mileage';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
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
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATClausesCap: Label 'VAT Clause';
        VATIdentifierCap: Label 'VAT Identifier';
        C_INC_VAT: Label 'VAT';
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        MainNextAppDateGLbl: Label 'Inspection Date';
        EmissionNextAppDateGLbl: Label 'Emission Date';
        PurchaseDocumentLbl: Label 'Purchase Document';
        VehicleRegistrationCertificateLbl: Label 'Registration Certificate';
        ofLbl: Label ' of';
        EmissionRelatedTextLbl: Label 'Emissions Related Text';
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
        ShowVING: Boolean;
        ShowTaxNoG: Boolean;
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
        WithoutVATLbl: Label 'without VAT';
        ShowVehicleInfoG: Boolean;
        SalesInvoiceAdvanceCountG: Integer;

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
    procedure getSalPrice(SalesLineP: Record "Sales Invoice Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Invoice Line";
        PostedOptionVariantL: Record "Posted Option Variant";
        SalesPriceL: Decimal;
    begin
        PostedOptionVariantL.RESET;
        PostedOptionVariantL.SETRANGE(Area, PostedOptionVariantL.Area::Sale);
        PostedOptionVariantL.SETRANGE("Document Type", PostedOptionVariantL."Document Type"::"1");
        PostedOptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        PostedOptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        PostedOptionVariantL.SETRANGE(Type, PostedOptionVariantL.Type::Vehicle);
        IF PostedOptionVariantL.FIND('-') THEN
            CASE ValueTypeP OF
                0:
                    SalesPriceL := PostedOptionVariantL."Unit Price";
                1:
                    SalesPriceL := PostedOptionVariantL."Amount Including VAT";
                2:
                    SalesPriceL := PostedOptionVariantL.Amount;
            END
        ELSE
            SalesPriceL := 0;

        IF (PrintOption2G <> PrintOption2G::"Print all lines") OR (PrintUnitPrice2G <> PrintUnitPrice2G::"Print all prices") THEN BEGIN
            IF (PrintOption2G = PrintOption2G::"Print selected lines") OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")) OR
               (PrintOption2G = PrintOption2G::"Print no lines")
            THEN BEGIN
                PostedOptionVariantL.RESET;
                PostedOptionVariantL.SETRANGE(Area, PostedOptionVariantL.Area::Sale);
                PostedOptionVariantL.SETRANGE("Document Type", PostedOptionVariantL."Document Type"::"1");
                PostedOptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                PostedOptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                PostedOptionVariantL.SETFILTER(Type, '<>%1', PostedOptionVariantL.Type::Vehicle);
                IF (PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"3") THEN
                    PostedOptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"Print selected lines") AND
                   (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices"))
                THEN
                    PostedOptionVariantL.SETRANGE("Print Unit Price", FALSE);
                IF PostedOptionVariantL.FIND('-') THEN
                    REPEAT
                        IF NOT ((PrintOption2G = PrintOption2G::"Print selected lines") AND
                           (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
                           (PostedOptionVariantL."Print Option Line"))
                        THEN BEGIN
                            CASE ValueTypeP OF
                                0:
                                    SalesPriceL += PostedOptionVariantL."Unit Price";
                                1:
                                    SalesPriceL += PostedOptionVariantL."Amount Including VAT";
                                2:
                                    SalesPriceL += PostedOptionVariantL.Amount;
                            END;
                        END;
                    UNTIL (PostedOptionVariantL.NEXT = 0);
            END;

            IF (PrintOption2G = PrintOption2G::"Print selected lines") AND
               (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")
            THEN BEGIN
                PostedOptionVariantL.RESET;
                PostedOptionVariantL.SETRANGE(Area, PostedOptionVariantL.Area::Sale);
                PostedOptionVariantL.SETRANGE("Document Type", PostedOptionVariantL."Document Type"::"1");
                PostedOptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                PostedOptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                PostedOptionVariantL.SETFILTER(Type, '<>%1', PostedOptionVariantL.Type::Vehicle);
                PostedOptionVariantL.SETRANGE("Print Option Line", FALSE);
                PostedOptionVariantL.SETRANGE("Print Unit Price", TRUE);
                IF PostedOptionVariantL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                SalesPriceL += PostedOptionVariantL."Unit Price";
                            1:
                                SalesPriceL += PostedOptionVariantL."Amount Including VAT";
                            2:
                                SalesPriceL += PostedOptionVariantL.Amount;
                        END;
                    UNTIL (PostedOptionVariantL.NEXT = 0);
            END;

            IF (PrintOption2G = PrintOption2G::"Print selected lines") OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")) OR
               (PrintOption2G = PrintOption2G::"Print no lines")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"Print selected lines") AND
                   (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices"))
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

            IF (PrintOption2G = PrintOption2G::"Print selected lines") AND
               (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")
            THEN BEGIN
                SalesLineL.RESET;
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
    procedure getLineDiscPct(SalesLineP: Record "Sales Invoice Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        PostedOptionVariantL: Record "Posted Option Variant";
        LineDiscPctL: Decimal;
    begin
        PostedOptionVariantL.RESET;
        PostedOptionVariantL.SETRANGE(Area, PostedOptionVariantL.Area::Sale);
        PostedOptionVariantL.SETRANGE("Document Type", PostedOptionVariantL."Document Type"::"1");
        PostedOptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        PostedOptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        PostedOptionVariantL.SETRANGE(Type, PostedOptionVariantL.Type::Vehicle);
        IF PostedOptionVariantL.FIND('-') THEN
            CASE ValueTypeP OF
                0:
                    IF (PrintUnitPrice2G <> PrintUnitPrice2G::"Print no prices") THEN
                        LineDiscPctL := PostedOptionVariantL."Line Discount %"
                    ELSE
                        LineDiscPctL := SalesLineP."Line Discount %";
                2:
                    LineDiscPctL := 0;
            END
        ELSE
            LineDiscPctL := 0;

        IF (PrintOption2G <> PrintOption2G::"Print all lines") OR (PrintUnitPrice2G <> PrintUnitPrice2G::"Print all prices") THEN BEGIN
            IF (PrintOption2G = PrintOption2G::"Print selected lines") OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")) OR
               (PrintOption2G = PrintOption2G::"Print no lines")
            THEN BEGIN
                PostedOptionVariantL.RESET;
                PostedOptionVariantL.SETRANGE(Area, PostedOptionVariantL.Area::Sale);
                PostedOptionVariantL.SETRANGE("Document Type", PostedOptionVariantL."Document Type"::"1");
                PostedOptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                PostedOptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                PostedOptionVariantL.SETFILTER(Type, '<>%1', PostedOptionVariantL.Type::Vehicle);
                IF (PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") THEN
                    PostedOptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"Print selected lines") AND
                    (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices"))
                THEN
                    PostedOptionVariantL.SETRANGE("Print Unit Price", FALSE);
                IF PostedOptionVariantL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += PostedOptionVariantL."Line Discount %";
                            2:
                                LineDiscPctL += PostedOptionVariantL."Line Discount Amount";
                        END;
                    UNTIL (PostedOptionVariantL.NEXT = 0);
            END;
            IF (PrintOption2G = PrintOption2G::"Print selected lines") AND
               (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")
            THEN BEGIN
                PostedOptionVariantL.RESET;
                PostedOptionVariantL.SETRANGE(Area, PostedOptionVariantL.Area::Sale);
                PostedOptionVariantL.SETRANGE("Document Type", PostedOptionVariantL."Document Type"::"1");
                PostedOptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                PostedOptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                PostedOptionVariantL.SETFILTER(Type, '<>%1', PostedOptionVariantL.Type::Vehicle);
                PostedOptionVariantL.SETRANGE("Print Option Line", FALSE);
                PostedOptionVariantL.SETRANGE("Print Unit Price", TRUE);
                IF PostedOptionVariantL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += PostedOptionVariantL."Line Discount %";
                            2:
                                LineDiscPctL += PostedOptionVariantL."Line Discount Amount";
                        END;
                    UNTIL (PostedOptionVariantL.NEXT = 0);
            END;

            IF (PrintOption2G = PrintOption2G::"Print selected lines") OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
               ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")) OR
               (PrintOption2G = PrintOption2G::"Print no lines")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"Print selected lines") AND
                    (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print all lines") AND
                    (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print all lines") AND
                    (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")) OR
                   ((PrintOption2G = PrintOption2G::"Print selected lines") AND
                    (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices"))
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

            IF (PrintOption2G = PrintOption2G::"Print selected lines") AND
               (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices")
            THEN BEGIN
                SalesLineL.RESET;
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
    procedure FunctionPrintUnitPrice(): Boolean
    begin
        IF ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           SalesInvLine2G."Print Option Line" AND NOT SalesInvLine2G."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT SalesInvLine2G."Print Option Line" AND SalesInvLine2G."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT SalesInvLine2G."Print Option Line" AND NOT SalesInvLine2G."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
           NOT SalesInvLine2G."Print Option Line" AND SalesInvLine2G."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
           NOT SalesInvLine2G."Print Option Line" AND NOT SalesInvLine2G."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           SalesInvLine2G."Print Option Line" AND NOT SalesInvLine2G."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT SalesInvLine2G."Print Option Line" AND NOT SalesInvLine2G."Print Unit Price") OR
           (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPriceOVC(): Boolean
    begin
        IF ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPriceOV(): Boolean
    begin
        IF ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT "Option Variant"."Print Option Line" AND "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
           NOT "Option Variant"."Print Option Line" AND "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print selected lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print all prices") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"Print all lines") AND (PrintUnitPrice2G = PrintUnitPrice2G::"Print selected prices") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           (PrintUnitPrice2G = PrintUnitPrice2G::"Print no prices")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure MixedTaxation(SalesInvNoP: Code[20]): Boolean
    var
        SalesInvLineL: Record "Sales Invoice Line";
    begin
        SalesInvLineL.SETRANGE("Document No.", SalesInvNoP);
        IF SalesInvLineL.FIND('-') THEN BEGIN
            IF SalesInvLineL."VAT Calculation Type" = SalesInvLineL."VAT Calculation Type"::"Differential Tax" THEN
                SalesInvLineL.SETFILTER("VAT Calculation Type", '<>%1', SalesInvLineL."VAT Calculation Type"::"Differential Tax")
            ELSE
                SalesInvLineL.SETFILTER("VAT Calculation Type", '=%1', SalesInvLineL."VAT Calculation Type"::"Differential Tax");
            EXIT(SalesInvLineL.FIND('-'));
        END;
        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure CalcValues(OptionVariantP: Record "Posted Option Variant")
    begin
        // Start PA033336
        ShowSalPriceG := 0;
        ShowLineDiscPctG := 0;
        IF PrintDiscG AND PrintUnitPriceHelpG AND
          NOT (SalesInvLine2G."VAT Calculation Type" = SalesInvLine2G."VAT Calculation Type"::"Differential Tax")
        THEN BEGIN
            ShowSalPriceG := OptionVariantP."Unit Price";
            ShowLineDiscPctG := OptionVariantP."Line Discount %";
        END;

        IF DoNotShowVATG OR
          (SalesInvLine2G."VAT Calculation Type" = SalesInvLine2G."VAT Calculation Type"::"Differential Tax")
        THEN
            DspAmountG := OptionVariantP."Amount Including VAT"
        ELSE
            DspAmountG := OptionVariantP.Amount;
        // Stop PA033336
    end;

    [Scope('Internal')]
    procedure GetNextApptDate(IndexP: Integer; DocumentDateP: Date) NextApptDateR: Date
    var
        VehApptL: Record "Vehicle Appointment";
        VehApptTempL: Record "Vehicle Appointment" temporary;
        VehApptTypeL: Record "Vehicle Appointment Type";
    begin
        // @ GetNextApptDate - Return the Next Appointment Date for Inspection Type Main or Emission Inspection.
        // @ param IndexP - Integer - Used to select Inspection Type.
        // @ param DocumentDateP - Date - Used to filter Next Appointment Dates closed to Document Date.
        // @ retval NextApptDateR - Date - Return Next Appointment Date

        // Start PA038229
        VehApptL.SETRANGE(VIN, VehicleG.VIN);
        VehApptL.SETFILTER(Status, '%1|%2|%3', VehApptL.Status::Recurring,
          VehApptL.Status::New,
          VehApptL.Status::Prepared);
        IF VehApptL.FINDSET THEN
            REPEAT
                VehApptTypeL.RESET;
                VehApptTypeL.SETRANGE(Code, VehApptL."Appointment Type");
                IF IndexP = 1 THEN
                    VehApptTypeL.SETRANGE("Inspection Type", VehApptTypeL."Inspection Type"::"Main Inspection")
                ELSE
                    VehApptTypeL.SETRANGE("Inspection Type", VehApptTypeL."Inspection Type"::"Emission Inspection");
                IF VehApptTypeL.FINDFIRST THEN BEGIN
                    VehApptTempL.INIT;
                    VehApptTempL.COPY(VehApptL);
                    VehApptTempL.INSERT;
                END;
            UNTIL VehApptL.NEXT = 0;

        IF NOT VehApptTempL.ISEMPTY THEN BEGIN
            VehApptTempL.RESET;
            VehApptTempL.SETCURRENTKEY(VIN, "Next Appointment Date");
            VehApptTempL.SETFILTER("Next Appointment Date", '>=%1', DocumentDateP);
            IF VehApptTempL.FINDFIRST THEN
                NextApptDateR := VehApptTempL."Next Appointment Date";
        END;
        // Stop PA038229
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

        // Stop PA039225.51457
        VehicleReportSelectionG."Print Sent-From Line" := TRUE;
        VehicleReportSelectionG."Print Address Block" := TRUE;
        VehicleReportSelectionG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC032;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(VehicleReportSelectionG);
            IF VehicleReportSelectionG."Print Report Title" THEN
                ReportTitleG := VehicleReportSelectionG."Report Title"
            ELSE BEGIN
                VehicleReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(VehicleReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        PrintSentFromLineG := VehicleReportSelectionG."Print Sent-From Line";

        // API.1      20.03.18 PV note: PrintAddrBlockG is used to (not)show just for some data ("VAT Registration No.") in layout
        PrintAddrBlockG := VehicleReportSelectionG."Print Address Block";
        PrintFooterLineG := VehicleReportSelectionG."Print Footer Line";
        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        // Start PA039225.51457
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
        IF SalesInvHdrL.FINDSET THEN BEGIN
            IF NOT CustL.GET(SalesInvHdrL."Bill-to Customer No.") THEN
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
        // Start API.1      20.03.18 KV
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
        // Stop API.1      20.03.18 KV
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


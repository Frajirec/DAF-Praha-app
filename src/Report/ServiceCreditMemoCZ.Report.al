report 80027 "DPG Service Credit Memo CZ" // 1057609 "Service Credit Memo CZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   05.08.10 Changes made to print original/duplicate invoices.
    // PA032178   27.10.10 DD 1798176 docu trigger and version list corrected.
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added code to print the report title from 'Report Selection' setup.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                                        Moved the VATTextLoop, VATTextLine Dataitem position as last footer.
    //                                        Increased width of 'VAT Identifier' control.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   28.03.12 GB 6570305: Add functionality for Rem. Amount from Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6225441: Layout Changes for Vat
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   21.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Section Code is moved to body code trigger.
    //                        - Layout 1, Layout 2 and Layout 3 concept incorporated.
    // PA033336   28.09.12 8787481: Provided space between the 'Qty.' and 'UoM' column.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Sales Cr. Memo Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (4) - OnPreSection()"
    // PA033336   29.09.12 SS 8719075:
    //                        - Added Text Constant C_INC037 "* = Exchange Part".
    //                        - Code changes in "Sales Cr.Memo Line - OnPreDataItem()"
    //                        - Code changes in "Sales Cr.Memo Line - OnAfterGetRecord()"
    //                        - New Section Total, Body (1) to print Exchange Part footer Note.
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033988   10.05.13 SM Reason Code field is promoted on a header of the printout.
    // PA033988   28.05.13 SM I001011: Print Reason Code field is is set to TRUE by default.
    // PA035179   15.10.13 GF Modified RDL Layout so that the Labor lines are printed.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA035395   27.12.13 GD 18593 Fixed Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   01.04.14 GF 20765 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   14.01.15 GK 32514 RDLC issues fixed :
    //                        - Print Subtotals functionality fixed
    //                        - Print Reason Code Fixed, Fixed Print Footer Line functionality
    //                        - Footer Fields visibility fixed
    //                        - Header Fields alignment issues fixed
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035484.20765
    // PA038228   07.08.15 GN Added Header information.
    //                        Added detailed Service information
    // PA038228   24.08.15 GN 43671 Changed Footer functionality
    // PA037047   02.09.15 LR 44285 Correct Filterts in RDLC
    //                        Correct allignement in the RDLC
    // PA040669   23.05.16 GV RDLC layout redisgn modifications
    // PA040669   01.06.16 GV 61683 RDLC layout modifications
    //                        Add format() to date fields
    //                        Rename value of Copy text constant
    //                        RDLC layout corrections
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA041125   16.08.16 GV 68179 RDLC Layout corrections
    // PA041187   13.02.17 MS 87564 Modifications to consider Service Job fixed price possible rounding line on 'Other' subtotal.
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   09.03.17 GV 89231 Fix group of table which dislpay the SubTotals.
    // --- 7.1.6 ---
    // EU.0000011 30.05.17 DR "Job Details Text Block" print enabled.
    //                        - 2 new lines in the RDLC added to print a Title and a Text Block.
    //                        - Use ReportSelectionG.INIT to set the preferred default Boolean values in the report selection.
    //                        - New Parameter "Print Job Detailed Descript." shown in the Report Request Page.
    //                        - Global variables PrintSentFromLineG, PrintAddrBlockG and PrintFooterLineG removed.
    //                        - Use the Report selection table fields for "Print Sent-From Line", "Print Address Block" and "Print Footer Line"
    //                          directly as source fields in the Report Request Page.
    //                        - All single changed in which a SETFILTER can be replaced by a SETRANGE
    //                        - All Data Items which are not in used in the Report RDLC have been removed.
    //                        - Use Table.FIELDCAPTION(Fieldname) command for all report captions which exists as table fields.
    // --- 7.2.0 ---
    // EU.0005442 30.08.17 EG 5454 RDLC layout change: Break Page After set to false.
    // EU.0006767 29.09.17 GN 209  DetermineColumnVisibility() added and corresponding boolean variables to set columns visibility
    // EU.0005636 19.10.17 MS Adjustments on report and RDLC to proper printing of Service Job Fixed Price
    // EU.0009764 28.11.17 MS 9813 Downmerge of EU.0005636 from N730
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5025605 Service Credit Memo
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed, translation
    //                        Final design of vehicle/contract info part of header
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, Bank source, Final header design
    //                        SK legislation,
    // API.1.0.3  07.08.18 PV If blank then ReportTitle filled with "Credit Memo Type"
    //                        RDLC Layout changed - VAT recap. table column size, Line description enabled to grow
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceCreditMemoCZ.rdlc';

    Caption = 'Service Credit Memo CZ';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Credit Memo Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Order Type" = CONST(Service));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Service Order';
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            column(Sales_Cr_Memo_Header_Cash_Register_Receipt; "Cash Register Receipt")
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
                        Description = 'PA040669.61683';
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
                        Description = 'PA040669.61683';
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                        Description = 'PA040669.61683';
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                        Description = 'PA040669.61683';
                    }
                    column(Sales_Cr_Memo_Header___Document_Date_; FORMAT("Sales Cr.Memo Header"."Document Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Cr_Memo_Header___No__; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Service_Order_No__; "Sales Cr.Memo Header"."Service Order No.")
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Service_Header___Order_Date_; FORMAT(ServHdrG."Order Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
                    {
                    }
                    column(Cust__No__; CustG."No.")
                    {
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
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
                        Description = 'PA040669.61683';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669.61683';
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
                    column(Service_Header___License_No__; ServHdrG."License No.")
                    {
                    }
                    column(Make_Name; MakeG.Name)
                    {
                    }
                    column(Service_Header__Model; ServHdrG.Model)
                    {
                    }
                    column(Service_Header__VIN; ServHdrG.VIN)
                    {
                    }
                    column(Service_Header___Initial_Registration_; FORMAT(ServHdrG."Initial Registration"))
                    {
                        Description = 'PA033336';
                    }
                    column(Service_Header__Mileage; ServHdrG.Mileage)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(Service_Advisor_; ServAdvisorG)
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(SalesPurch_Name_Control80; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Applies_to_Doc__No__; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___VAT_Registration_No__; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(DataItem115; CollectiveG.TextShowOutput("Sales Cr.Memo Header".FIELDCAPTION("VAT Registration No."), "Sales Cr.Memo Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo_FIELDCAPTION__VAT_Registration_No_____PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Collective_TextShowOutput_CompanyInfo__VAT_Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA031550';
                    }
                    column(DataItem1115000005; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(OutputNoG; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Duplicate_Graphic1; ReportLayoutSetupG."Duplicate Graphic")
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Credit_Memo_Header___Reason_Code__; "Sales Cr.Memo Header"."Reason Code")
                    {
                    }
                    column(Print_Reason_Code; FORMAT(PrintReasonCodeG, 0, 2))
                    {
                        Description = 'PA033988';
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvG))
                    {
                    }
                    column(NoPrinted_; RDLHideOutput("Sales Cr.Memo Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(BankText; BankTextG)
                    {
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField43; RDLHideOutput(ReportSelectionG."Print Footer Line" AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'PA035395.18593,EU.0000011';
                    }
                    column(HdrInfo2; ServHdrG."Make Code")
                    {
                    }
                    column(HdrInfo4; ServHdrG.Model)
                    {
                    }
                    column(HdrInfo6; ServHdrG."Vehicle Category Code")
                    {
                    }
                    column(HdrInfo8; ServHdrG.VIN)
                    {
                    }
                    column(HdrInfo10; ServHdrG."License No.")
                    {
                    }
                    column(HdrInfo12; FORMAT(ServHdrG."Initial Registration"))
                    {
                        Description = 'PA040669.61683';
                    }
                    column(HdrInfo14; FORMAT(ServHdrG.Mileage) + ' /  ' + FORMAT(ServHdrG."Running Time"))
                    {
                    }
                    column(HdrInfo16; ServHdrG."Driver Name")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(HdrInfo18; "Sales Cr.Memo Header"."Your Reference")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(HdrInfo20; ServHdrG."Fuel Level")
                    {
                    }
                    column(HdrInfo22; ServAdvisorG)
                    {
                    }
                    column(HdrInfo24; VehicleCustomerG."Contract No.")
                    {
                    }
                    column(HdrInfo26; FORMAT(ServHdrG."Order Date") + ' / ' + FORMAT(ServHdrG."Time of Order"))
                    {
                    }
                    column(HdrInfo28; ServHdrG."Pickup DateTime")
                    {
                    }
                    column(HdrInfo30; ServHdrG."Order Limit")
                    {
                        Description = 'PA028449';
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
                    column(ReportLayoutSetupG__Footer_4_5_; ReportLayoutSetupG."Footer 4-5")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_4_6_; ReportLayoutSetupG."Footer 4-6")
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
                    column(sep1; FORMAT('-----------------------------------------------------------------------------------------'))
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61683';
                    }
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(Sales_Cr_Memo_Header___No__Caption; "Sales Cr.Memo Line".FIELDCAPTION("Document No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Sales_Cr_Memo_Header___Document_Date_Caption; "Sales Cr.Memo Header".FIELDCAPTION("Document Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(Service_Header___License_No__Caption; ServHdrG.FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MakeCaption; ServHdrG.FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Model_DescriptionCaption; ServHdrG.FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header__VINCaption; ServHdrG.FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Initial_Registration_Caption; ServHdrG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
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
                    column(SalesPurch_Name_Control80Caption; SalesPurch_Name_Control80CaptionLbl)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Service_Order_No__Caption; "Sales Cr.Memo Line".FIELDCAPTION("Order No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Order_Date_Caption; ServHdrG.FIELDCAPTION("Order Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Application_forCaption; ApplicationToLbl)
                    {
                    }
                    column(Sales_Credit_Memo_Header___Reason_Code__Caption; "Sales Cr.Memo Header".FIELDCAPTION("Reason Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(HdrInfo1; ServHdrG.FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo3; ServHdrG.FIELDCAPTION(Model))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo5; ServHdrG.FIELDCAPTION("Vehicle Category Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo7; ServHdrG.FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo9; ServHdrG.FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo11; ServHdrG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo13; MileageCaptionLbl)
                    {
                    }
                    column(HdrInfo15; ServHdrG.FIELDCAPTION("Driver Name"))
                    {
                    }
                    column(HdrInfo17; "Sales Cr.Memo Header".FIELDCAPTION("Your Reference"))
                    {
                    }
                    column(HdrInfo19; ServHdrG.FIELDCAPTION("Fuel Level"))
                    {
                    }
                    column(HdrInfo21; Service_AdvisorCaptionLbl)
                    {
                    }
                    column(HdrInfo23; Service_ContractLbl)
                    {
                    }
                    column(HdrInfo25; Appointment_DateLbl)
                    {
                    }
                    column(HdrInfo27; ServHdrG.FIELDCAPTION("Pickup DateTime"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo29; ServHdrG.FIELDCAPTION("Order Limit"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Due_Date_; "Sales Cr.Memo Header"."Due Date")
                    {
                        Description = 'PA040669.61683';
                        IncludeCaption = true;
                    }
                    column(PrintReasonCodeG; PrintReasonCodeG)
                    {
                        Description = 'PA041125.68179';
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
                    column(PaymentMethodCode_SCH; "Sales Cr.Memo Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SCH; "Sales Cr.Memo Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SCH; "Sales Cr.Memo Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SCH; "Sales Cr.Memo Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SCH; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SCH; "Sales Cr.Memo Header"."Tax Registration No.")
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
                    column(DueDateCpn_SCH; "Sales Cr.Memo Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SCH; "Sales Cr.Memo Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SCH; "Sales Cr.Memo Header".FIELDCAPTION("Variable Symbol"))
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
                    column(PostingDate_SCH; "Sales Cr.Memo Header"."Posting Date")
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
                    column(ExchRateText; ExchRateText)
                    {
                    }
                    column(ToDateLbl; ToDateLbl)
                    {
                    }
                    column(LCYCode_GLS; GLSetupG."LCY Code")
                    {
                    }
                    column(CurrencyCode_SCH; "Sales Cr.Memo Header"."Currency Code")
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
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Header));
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
                    dataitem("Sales Cr.Memo Line"; "Sales Credit Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(TextBlockHeadlineText; TextBlockG."Headline Text")
                        {
                            Description = 'EU.0000011';
                        }
                        column(TextBlockContentG; TextBlockContentG)
                        {
                            Description = 'EU.0000011';
                        }
                        column(DiscText; DiscTextG)
                        {
                        }
                        column(Service_Line__Type; ServLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(ServCustPrintG; ServCustPrintG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalNet; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Description__________Description_2_; Description + ' ' + "Description 2")
                        {
                        }
                        column(PrintSubtotals; PrintSubtotalsG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line__Sales_Cr_Memo_Line__Type; "Sales Cr.Memo Line".Type)
                        {
                            Description = 'PA033336';
                        }
                        column(Description__________Description_2__Control62; Description + ' ' + "Description 2")
                        {
                        }
                        column(Sales_Cr_Memo_Line_Subtotal; Subtotal)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line_Description; '  ' + Description)
                        {
                        }
                        column(SalesCrLine_TypeG; ("Sales Cr.Memo Line".Type + 0))
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(Sales_Cr_Memo_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Cr_Memo_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 2;
                        }
                        column(Sales_Cr_Memo_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoText; NoTextG)
                        {
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Sales_Cr_Memo_Line__VAT_Identifier_; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(ServCustomer__Print_Fixed_Unit_Price_; ServCustG."Print Fixed Unit Price")
                        {
                            Description = 'PA033336';
                        }
                        column(FixedPriceLab; FixedPriceLabG)
                        {
                            Description = 'PA033336';
                        }
                        column(Amount____Inv__Discount_Amount__Control39; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line_Quantity_Control82; Quantity)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Description_Control87; Description)
                        {
                        }
                        column(NoText_Control81; NoTextG)
                        {
                        }
                        column(NoProperty_Control138; NoPropertyG)
                        {
                        }
                        column(Sales_Cr_Memo_Line__VAT_Identifier__Control1109400004; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Amount____Inv__Discount_Amount__Control89; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line_Description_Control141; Description)
                        {
                        }
                        column(NoText_Control71; NoTextG)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Description_Control73; Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Sales_Cr_Memo_Line__Unit_Price__Control84; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 2;
                        }
                        column(Sales_Cr_Memo_Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control86; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoProperty_Control139; NoPropertyG)
                        {
                        }
                        column(Sales_Cr_Memo_Line__VAT_Identifier__Control1109400005; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Cr_Memo_Line__Description_2_; "Description 2")
                        {
                        }
                        column(TotalNet_Control125; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumLabor; SumLaborG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumExtServ; SumExtServG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalTextG)
                        {
                        }
                        column(VATAmountLine_VATAmountText___C_INC018; VATAmountLineG.VATAmountText + C_INC018)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Sales_Cr_Memo_Line__Amount; "Sales Cr.Memo Line".Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT_____Sales_Cr_Memo_Line__Amount____Exch__Parts_Tax_Amount_; "Sales Cr.Memo Line"."Amount Including VAT" - "Sales Cr.Memo Line".Amount - "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line__Sales_Cr_Memo_Line___VAT_Base_Amount_; "Sales Cr.Memo Line"."VAT Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line__Exch__Parts_Tax_Amount_; "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_ExchTaxAmountText___C_INC018; VATAmountLineG.ExchTaxAmountText + C_INC018)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Exch__Parts_Tax_Base_; "Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Sales_Cr_Memo_Line___Amount_Including_VAT_; "Sales Cr.Memo Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(No_Caption; No_CaptionLbl)
                        {
                        }
                        column(DescriptionCaption; "Sales Cr.Memo Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
                        {
                        }
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; "Sales Cr.Memo Line".FIELDCAPTION("Unit Price"))
                        {
                        }
                        column(AmountCaption; "Sales Cr.Memo Line".FIELDCAPTION(Amount))
                        {
                        }
                        column(VAT_IdentifierCaption; VAT_IdentifierCaptionLbl)
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(TotalNetCaption; ContinuedCaptionLbl)
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
                        column(Inv__Discount_Amount_Caption; Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Cr_Memo_Line_Line_No_; "Line No.")
                        {
                        }
                        column(PrintFixedPriceG; PrintFixedPriceG)
                        {
                            Description = 'EU.0006767.209';
                        }
                        column(HidePrintJobHeader; RDLHideOutput(("Serv. Preview Line Type" = "Serv. Preview Line Type"::Job) AND ("Service Job No." <> 0)))
                        {
                        }
                        column(HidePrintSubtotal; RDLHideOutput(EvalHidePrintSubtotal()))
                        {
                            Description = 'EU.0006767.209';
                        }
                        column(HideQty; RDLHideOutput(ShowQtyG))
                        {
                            Description = 'EU.0006767.209';
                        }
                        column(HideUOM; RDLHideOutput(ShowUOMG))
                        {
                            Description = 'EU.0006767.209';
                        }
                        column(HideUnitPrice; RDLHideOutput(ShowUnitPriceG))
                        {
                            Description = 'EU.0006767.209';
                        }
                        column(HideDiscount; RDLHideOutput(ShowDiscountG))
                        {
                            Description = 'EU.0006767.209';
                        }
                        column(HideAmount; RDLHideOutput(ShowAmountG))
                        {
                            Description = 'EU.0006767.209';
                        }
                        column(VATpercent_SCL; "Sales Cr.Memo Line"."VAT %")
                        {
                        }
                        column(VATpercentCpn_SCL; "Sales Cr.Memo Line".FIELDCAPTION("VAT %"))
                        {
                        }
                        column(Unit_PriceLbl; Unit_PriceCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Credit Memo Line";
                            ServJobLineL: Record "Service Job Line";
                            T115FncL: Codeunit "ET111,112,113,114,115,6661";
                        begin
                            //Start API.1.0.2
                            T115FncL.T115_CalcPrintVATAmtLines("Sales Cr.Memo Line", VATAmountLineG, VATPctG, ExchTaxPctG);
                            // // Start PA037047.44285
                            // // Stop PA037047.44285
                            // VATAmountLineG.INIT;
                            // // Start PA033011.5983155
                            // VATAmountLineG."VAT Identifier" := FORMAT("VAT %");
                            // VATAmountLineG."Sales Amount" := Amount;
                            // // Stop PA033011.5983155
                            // VATAmountLineG."VAT %" := "VAT %";
                            // // Start PA032441
                            // // Stop PA032441
                            // VATAmountLineG."VAT Base" := "VAT Base Amount";
                            // // Start PA032441
                            // // Stop PA032441
                            // VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            // VATAmountLineG.InsertLine();
                            //Stop API.1.0.2

                            NoPropertyG := '';
                            NoTextG := '';
                            // Start EU.0000011
                            TextBlockContentG := '';
                            // Stop EU.0000011
                            IF Type = Type::Item THEN BEGIN
                                NoTextG := "No.";
                                // Start PA033336
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
                                    NoPropertyG := C_INC016;
                                    ExchangePartG := TRUE;
                                END;
                                // Stop PA033336
                            END;

                            FixedPriceLabG := FALSE;
                            CLEAR(ServLineG);
                            IF NOT ServLineG.GET(ServHdrG."Document Type", ServHdrG."No.", "Service Order Line No.") THEN BEGIN
                                IF ArchServLineG.GET(ServHdrG."Document Type", ServHdrG."No.", "Service Order Line No.") THEN
                                    ServLineG.TRANSFERFIELDS(ArchServLineG);
                            END;

                            // Start EU.0005636
                            // Stop EU.0005636

                            IF ServLineG.Type >= ServLineG.Type::Labor THEN
                                NoTextG := ServLineG."No.";
                            IF (ServLineG.Type = ServLineG.Type::Labor) AND (ServLineG."Fixed Price" <> 0) THEN
                                FixedPriceLabG := TRUE;

                            IF ConsolidateNegativePosG THEN BEGIN
                                // Start EU.0000011
                                IF (Type <> Type::" ") AND
                                   ((Amount <> 0) OR ("Amount Including VAT" <> 0))
                                // Stop EU.0000011
                                THEN BEGIN
                                    TotalsLineL.RESET;
                                    TotalsLineL.SETCURRENTKEY("Document No.", Type, "No.", Description);
                                    // Start EU.0000011
                                    TotalsLineL.SETRANGE("Document No.", "Document No.");
                                    TotalsLineL.SETRANGE(Type, Type);
                                    TotalsLineL.SETRANGE("No.", "No.");
                                    TotalsLineL.SETRANGE(Description, Description);
                                    TotalsLineL.SETRANGE("Unit Price", "Unit Price");
                                    // Stop EU.0000011
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
                            // Start PA033336
                            // Start EU.0000011
                            // Stop EU.0000011
                            ServCustPrintG := ServCustG."Print Fixed Unit Price";

                            // Start EU.0006767.209
                            // Start EU.0005636
                            PrintFixedPriceG := FALSE;
                            IF GetServJobLine(ServHdrG."Document Type", ServHdrG."No.", "Service Job No.", ServJobLineL) THEN
                                PrintFixedPriceG := ServJobLineL."Includes Fixed Price";
                            // Stop EU.0005636
                            DetermineColumnVisibility();
                            // Stop EU.0006767.209

                            // Start PA035597
                            // Start EU.0000011
                            IF (Type = Type::"Account (G/L)") AND
                              ((NOT FixedPriceLabG) OR ((FixedPriceLabG) AND
                              (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity + Price per Unit")))
                            THEN BEGIN
                                IF ((PrintWithoutDiscG) OR (("Line Discount Amount" < 0) AND (Quantity > 0)) OR
                                   (("Line Discount Amount" > 0) AND (Quantity < 0)))
                                // Stop EU.0000011
                                THEN BEGIN
                                    "Unit Price" := Amount / Quantity;
                                    "Line Discount %" := 0;
                                END;
                                "Unit Price" := ROUND("Unit Price");
                            END;
                            // Start EU.0000011
                            IF (Type = Type::Item) OR
                               (Type = Type::Resource)
                            // Stop EU.0000011
                            THEN BEGIN
                                IF ((PrintWithoutDiscG) OR (("Line Discount Amount" < 0) AND (Quantity > 0)) OR
                                   (("Line Discount Amount" > 0) AND (Quantity < 0)))
                                THEN BEGIN
                                    "Unit Price" := Amount / Quantity;
                                    "Line Discount %" := 0;
                                END;
                                "Unit Price" := ROUND("Unit Price");
                            END;
                            CreateTotals();
                            // Stop PA035597
                            // Start EU.0000011
                            IF Type = Type::" " THEN BEGIN
                                IF "Job Details Text Block" > 0 THEN BEGIN
                                    IF NOT ReportSelectionG."Print Job Detailed Descript." THEN
                                        CurrReport.SKIP;
                                    IF NOT TextBlockG.GET("Job Details Text Block") THEN
                                        CurrReport.SKIP;
                                    TextBlockContentG := TextBlockG.GetTextBlock();
                                    Description := '';
                                    TextBlockG."Headline Text" := '';
                                    "Description 2" := '          '; // Add a Blank line in the end
                                END;
                            END;
                            // Stop EU.0000011
                            // Stop PA033336
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            //CurrReport.CREATETOTALS("Line Discount Amount",Amount,"Amount Including VAT","Inv. Discount Amount","Exch. Parts Tax Amount",
                            //  "Exch. Parts Tax Base","VAT Base Amount");

                            // Start PA033336
                            // Start EU.0000011
                            // Stop EU.0000011
                            ExchangePartG := FALSE;
                            // Stop PA033336
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
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; TempVATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmtLineVATBaseLCY; TempVATAmountLineG."VAT Base (LCY)")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtLCY; TempVATAmountLineG."VAT Amount (LCY)")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATLCY_VAL; TempVATAmountLineG."Amount Including VAT (LCY)")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
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
                        column(TotalText_Control37; TotalTextG)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Amount; "Sales Cr.Memo Line".Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control106; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control107; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATText; VATTextG)
                        {
                        }
                        column(VATAmountLine__VAT___; VATAmountLineG."VAT %")
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Identifier_; FORMAT(VATAmountLineG."VAT %"))
                        {
                            Description = 'PA033336';
                        }
                        column(VATText1; VATText2G)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base__Control110; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_ExchTaxAmountText___C_INC018_Control61; VATAmountLineG.ExchTaxAmountText + C_INC018)
                        {
                        }
                        column(Sales_Cr_Memo_Line___Exch__Parts_Tax_Amount_; "Sales Cr.Memo Line"."Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line___Exch__Parts_Tax_Base_; "Sales Cr.Memo Line"."Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(C_INC016_Control142; C_INC016)
                        {
                        }
                        column(TotalInclVATText_Control44; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT_; "Sales Cr.Memo Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control109; ContinuedCaptionLbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                            VATTextG := C_INC001;
                            // Start PA035597
                            VATTextG := STRSUBSTNO('%1%2', VATAmountLineG."VAT %", C_INC001);
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
                    dataitem("Footer Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Footer));
                        column(Footer_Text_Text; Text)
                        {
                        }
                        column(Header_Footer_1; "Header/Footer")
                        {
                            Description = 'PA033336';
                        }
                        column(Footer_Text_Document_Type; "Document Type")
                        {
                        }
                        column(Footer_Text_Document_No_; "Document No.")
                        {
                        }
                        column(Footer_Text_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(ExchangePartG; C_INC037)
                        {
                        }
                        column(PaymentTerms_Description; PaymentTermsG.Description)
                        {
                        }
                        column(Total_Total_Number; Total.Number)
                        {
                            Description = 'PA033336';
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                    }
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("No.") WHERE("Type of Document to be Printed" = CONST("Sales Cr. Memo"));
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
                            column(Cash_Reg__Add_Disc_Split_Post___Posting_Date_; "Posting Date")
                            {
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
                            column(ABS__Remaining_Amount__; ABS("Remaining Amount"))
                            {
                            }
                            column(ABS__Pmt__Discount_Total__; ABS("Pmt. Discount Total"))
                            {
                            }
                            column(ABS_AmountMinusDiscount_; ABS(AmountMinusDiscG))
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
                            column(ABS__Remaining_Amount__Caption; ABS__Remaining_Amount__CaptionLbl)
                            {
                            }
                            column(ABS__Pmt__Discount_Total__Caption; ABS__Pmt__Discount_Total__CaptionLbl)
                            {
                            }
                            column(ABS_AmountMinusDiscount_Caption; "Sales Cr.Memo Line".FIELDCAPTION(Amount))
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
                            column(Posted_Cash_Register_Line__Posted_Cash_Register_Line___Document_No__; "Posted Cash Register Line"."Document No.")
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
                            column(Posted_Cash_Register_Header___Change_Money_; "Posted Cash Register Header"."Change Money")
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_; "Posted Cash Register Header"."Amount Given")
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
                            IF NOT PmtMethodG.GET("Sales Cr.Memo Header"."Payment Method Code") OR
                               NOT PmtMethodG."Cash Payment"
                            THEN BEGIN
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
                    dataitem(VATTextLoop; "Integer")
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
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC034;
                                IncrG := IncrG + 1;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                // Start PA033042
                                SETRANGE("VAT Identifier Code", VATIdentifierTempG.Code);
                                SETRANGE("Language Code", VATTextHdrG.GetLanguageCode(VATIdentifierTempG.Code, "Sales Cr.Memo Header"."Language Code"));
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

                    trigger OnAfterGetRecord()
                    begin
                        // Start PA035597
                        // Start EU.0000011
                        IF ReportSelectionG."Print Footer Line" THEN
                            // Stop EU.0000011
                            PageLoopFooterG := 1;
                        // Stop PA035597
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                        // Start PA033336
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    END;

                    ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    IF ("Sales Cr.Memo Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC032
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV
                    // Stop PA033336

                    CurrReport.PAGENO := 1;

                    OldServJobNoG := 0;
                    SumLaborG := 0;
                    SumItemG := 0;
                    SumExtServG := 0;
                    SumOtherG := 0;
                    TotalNetG := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrintedG.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA043099
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    // Stop PA043099
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
                salesInvoiceHeaderL: Record "Sales Invoice Header";
                T115Fnc: Codeunit "ET111,112,113,114,115,6661";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA040669
                IF NOT ServHdrG.GET(ServHdrG."Document Type"::Order, "Service Order No.") THEN BEGIN
                    IF NOT ArchServHdrG.GET(ServHdrG."Document Type"::Order, "Service Order No.") THEN
                        CLEAR(ArchServHdrG);
                    ServHdrG.TRANSFERFIELDS(ArchServHdrG);
                END;
                // Stop PA040669
                // Start PA041187.87564
                IF ArchServHdrG."No." = '' THEN
                    ServHdrG.CALCFIELDS("Includes Fixed Price")
                ELSE BEGIN
                    ArchServHdrG.CALCFIELDS("Includes Fixed Price");
                    ServHdrG."Includes Fixed Price" := ArchServHdrG."Includes Fixed Price";
                END;
                // Stop PA041187.87564

                // Start PA038228
                CLEAR(MainNextAppDateG);
                CLEAR(EmissionNextAppDateG);
                MainNextAppDateG := GetNextApptDate(1, ServHdrG."Document Date");
                EmissionNextAppDateG := GetNextApptDate(2, ServHdrG."Document Date");

                CLEAR(VehicleCustomerG);
                VehicleCustomerG.SETRANGE(VIN, ServHdrG.VIN);
                VehicleCustomerG.SETRANGE(Type, VehicleCustomerG.Type::"Service Contract");
                VehicleCustomerG.SETFILTER("Beginning of Contract", '<=%1', ServHdrG."Order Date");
                VehicleCustomerG.SETFILTER("Expiration of Contract", '>=%1', ServHdrG."Order Date");
                IF VehicleCustomerG.FINDFIRST THEN
                    ;
                // Stop PA038228


                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Service Credit Memo CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593

                //Start API.1      01.03.18 PV
                IF ReportTitleG = '' THEN
                    ReportTitleG := FORMAT("Sales Cr.Memo Header"."Credit Memo Type");
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Cr.Memo Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Cr.Memo Header"."User ID");

                IF ReasonCodeG.GET("Sales Cr.Memo Header"."Reason Code") THEN;

                IF salesInvoiceHeaderL.GET("Sales Cr.Memo Header"."Applies-to Doc. No.") THEN
                    //OrderNoG := salesInvoiceHeaderL."Applies-to Doc. No."
                    //OrderNoG := salesInvoiceHeaderL."Order No."
                    OrderNoG := salesInvoiceHeaderL."Service Order No."
                ELSE
                    OrderNoG := '';
                ServHdrG.CALCFIELDS("Driver Name");

                TempVATAmountLineG.DELETEALL;
                T115Fnc.T115_CalcVATAmountLines("Sales Cr.Memo Header", TempVATAmountLineG);
                //Stop API.1      01.03.18 PV

                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                CurrReport.LANGUAGE := BillToCustG.PrintDocInCustLanguage();
                PrintWithoutDiscG := NOT "Sales Cr.Memo Header"."Show Discount";

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
                // Start EU.0000011
                IF ReportSelectionG."Print Sent-From Line" THEN
                    CompAddrG := FormatAddrG.GetWindowAddress(C_INC005);

                IF ReportSelectionG."Print Address Block" THEN BEGIN
                    // Stop EU.0000011
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
                IF bankAccountL.GET("Sales Cr.Memo Header"."Bank Account Code") THEN BEGIN
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
                //   OwnBanksG.GET(IntCustG, LocationG."Bank Code") THEN
                //  BEGIN // Start API.1      01.03.18 PV
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // Stop API.1      01.03.18 PV
                //    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                //  END // Start API.1      01.03.18 PV
                // ELSE
                //  BEGIN
                //    BankNameG := CompanyInfoG."Bank Name";
                //    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                //    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                //    BankIbanG := CompanyInfoG.IBAN;
                //    BankAccountNoG := CompanyInfoG."Bank Account No.";
                //    // Stop API.1      01.03.18 PV
                //    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                //  END; // API.1      01.03.18 PV
                // Stop API.1.0.1  09.05.18 PV

                IF "Your Reference" = '' THEN
                    ReferenceTextG := ''
                ELSE
                    ReferenceTextG := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoTextG := ''
                ELSE
                    VATNoTextG := FIELDCAPTION("VAT Registration No.");
                // Start API.1.0.2
                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                    //  TotalTextG := STRSUBSTNO(C_INC030,GLSetupG."LCY Code");
                    //  TotalInclVATTextG := STRSUBSTNO(C_INC031,GLSetupG."LCY Code");
                END ELSE BEGIN
                    ShowCurrencyG := "Currency Code";
                    //  TotalTextG := STRSUBSTNO(C_INC030,"Currency Code");
                    //  TotalInclVATTextG := STRSUBSTNO(C_INC031,"Currency Code");
                END;
                TotalTextG := STRSUBSTNO(C_INC030, ShowCurrencyG);
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);
                // Stop API.1.0.2

                FormatAddrG.SalesCrMemoBillTo(CustAddrG, "Sales Cr.Memo Header");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Cr.Memo Header"."Payment Method Code") THEN
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

                FormatAddrG.SalesCrMemoShipTo(ShipToAddrG, "Sales Cr.Memo Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                // Start PA040669
                // Stop PA040669

                IF ServHdrG."Service Advisor No." <> '' THEN BEGIN
                    EmployeeG.GET(ServHdrG."Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                END ELSE
                    ServAdvisorG := '';

                // Start EU.0005636
                // Stop EU.0005636

                CredMemoLineG.RESET;
                CredMemoLineG.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                CredMemoLineG.SETFILTER("Line Discount %", '>%1', 0);
                IF (CredMemoLineG.COUNT <> 0) AND (NOT PrintWithoutDiscG) THEN
                    DiscTextG := C_INC014
                ELSE
                    DiscTextG := '';

                // Start AH

                IF "Shortcut Dimension 2 Code" <> '' THEN
                    MakeG.GET("Shortcut Dimension 2 Code")
                ELSE
                    MakeG.INIT;
                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                IF NOT CustG.GET("Bill-to Customer No.") THEN
                    IF NOT CustG.GET("Sell-to Customer No.") THEN
                        CustG."No." := "Sell-to Customer No.";
                // Stop AH

                IF "Sales Cr.Memo Header"."Sell-to Customer No." <> "Sales Cr.Memo Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesCrMemoCust(OrderCustAddrG, "Sales Cr.Memo Header");
                    //OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);  //API.1.0.1  09.05.18 PV
                    OrderCustAddrLineG := FormatAddrG.GetWindowAddress(C_INC005);  //API.1.0.1  09.05.18 PV
                END ELSE
                    OrderCustAddrLineG := '';

                CLEAR(ServCustG);
                IF NOT ServCustG.GET(ServHdrG."Document Type", ServHdrG."No.", "Sales Cr.Memo Header"."Bill-to Customer No.") THEN
                    IF ArchServCustG.GET(ServHdrG."Document Type", ServHdrG."No.", "Sales Cr.Memo Header"."Bill-to Customer No.") THEN
                        ServCustG.TRANSFERFIELDS(ArchServCustG);
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
                group(Option)
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
                    field("Consolidate Negative Positions"; ConsolidateNegativePosG)
                    {
                        Caption = 'Consolidate Negative Positions';
                    }
                    field("Print Sent-From Line"; ReportSelectionG."Print Sent-From Line")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Sent-From Line");
                    }
                    field("Print Address Block"; ReportSelectionG."Print Address Block")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Address Block");
                    }
                    field("Print Footer Line"; ReportSelectionG."Print Footer Line")
                    {
                    }
                    field("Re-print Original Invoice"; RePrintOriginalInvG)
                    {
                        Caption = 'Re-print Original Invoice';
                        Editable = ReqRePrintControlG;
                    }
                    field("Print Reason Code"; PrintReasonCodeG)
                    {
                        Caption = 'Print Reason Code';
                    }
                    field("Print Job Detailed Descript."; ReportSelectionG."Print Job Detailed Descript.")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Job Detailed Descript.");
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start EU.0000011
            GetReportSelection();
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
            ConsolidateNegativePosG := TRUE;
            RePrintOriginalInvG := FALSE;
            IF UserSetupG.GET(USERID) THEN
                ReqRePrintControlG := UserSetupG."Re-print Original Invoice"
            ELSE
                ReqRePrintControlG := FALSE;
            PrintReasonCodeG := TRUE;
            // Stop EU.0000011
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        // Start EU.0000011
        GLSetupG.GET;
        GetReportSelection();
        // Stop EU.0000011
        ConsolidateNegativePosG := TRUE;
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA035597
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        ServSetupG: Record "Service Setup";
        UserSetupG: Record "User Setup";
        ReportSelectionG: Record "Service Manag. Rep. Selection";
        ReportLayoutSetupG: Record "Report Layout Setup";
        ArchServHdrG: Record "Archived Service Header";
        ArchServLineG: Record "Archived Service Line";
        ArchServCustG: Record "Archived Service Customer";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        CompanyInfoG: Record "Company Information";
        CredMemoLineG: Record "Sales Credit Memo Line";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        MakeG: Record Make;
        EmployeeG: Record Employee;
        VATAmountLineG: Record "VAT Amount Line" temporary;
        BillToCustG: Record Customer;
        SalesPurchG: Record "Salesperson/Purchaser";
        ServHdrG: Record "Service Header";
        ServLineG: Record "Service Line";
        ServCustG: Record "Service Customer";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        VehicleCustomerG: Record "Vehicle Customer";
        TextBlockG: Record "Text Block";
        FormatAddrG: Codeunit "Format Address";
        SalesCrMemoCountPrintedG: Codeunit "Sales Cr. Memo-Printed";
        RTCMgmtG: Codeunit "RTC Management";
        CollectiveG: Codeunit "Collection Unit";
        UserSessionG: Codeunit "User Session Unit";
        TextBlockContentG: Text;
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        CoEmailG: Text[80];
        CoEmailTextG: Text[80];
        CoFaxG: Text[30];
        CoFaxTextG: Text[30];
        CoTelephoneG: Text[30];
        CoTelephoneTextG: Text[30];
        CopyTextG: Text[30];
        ShipToAddrG: array[8] of Text[50];
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        VATTextG: Text[50];
        NoPropertyG: Text[30];
        NoTextG: Text[30];
        DiscTextG: Text[20];
        ReferenceTextG: Text[30];
        ServAdvisorG: Text[50];
        TotalInclVATTextG: Text[50];
        TotalTextG: Text[50];
        DuplicateTextG: Text[30];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        VATLegendsG: Text[15];
        VATText2G: Text[50];
        ReportTitleG: Text[100];
        IntCustG: Code[20];
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        OldServJobNoG: Integer;
        OutputNoG: Integer;
        IncrG: Integer;
        [InDataSet]
        ServCustPrintG: Integer;
        PageLoopFooterG: Integer;
        AmountMinusDiscG: Decimal;
        TotalNetG: Decimal;
        SumLaborG: Decimal;
        SumItemG: Decimal;
        SumExtServG: Decimal;
        SumOtherG: Decimal;
        C_INC001: Label '% VAT of';
        FixedPriceLabG: Boolean;
        ShowShippingAddrG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC014: Label 'Disc. %';
        C_INC015: Label 'SalesPerson';
        C_INC018: Label ' of';
        C_INC016: Label '*';
        PrintSubtotalsG: Boolean;
        C_INC029: Label 'Copy of';
        C_INC030: Label 'Total %1';
        C_INC031: Label 'Total %1 Incl. VAT';
        ConsolidateNegativePosG: Boolean;
        [InDataSet]
        ReqRePrintControlG: Boolean;
        RePrintOriginalInvG: Boolean;
        C_INC032: Label 'D U P L I C A T E';
        C_INC033: Label 'Service Credit Memo';
        C_INC034: Label ' =';
        C_INC037: Label '* = Exchange Part';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        ExchangePartG: Boolean;
        PrintReasonCodeG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        MileageCaptionLbl: Label 'Mileage / Running Time';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_Name_Control80CaptionLbl: Label 'Salesperson';
        ApplicationToLbl: Label 'Applied to';
        Payments_to_CaptionLbl: Label 'Payments to:';
        No_CaptionLbl: Label 'No.';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        VAT_IdentifierCaptionLbl: Label 'VAT Identifier';
        TotalNet_Control125CaptionLbl: Label 'Sum carried forward';
        SumLaborCaptionLbl: Label 'Sum Labor';
        SumItemCaptionLbl: Label 'Sum Item';
        SumExtServCaptionLbl: Label 'Sum External Services';
        SumOtherCaptionLbl: Label 'Sum Other';
        Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        ContinuedCaptionLbl: Label 'Continued';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        Cash_Reg__Add_Disc_Split_Post___Posting_Date_CaptionLbl: Label 'Date';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_CaptionLbl: Label 'Type';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__CaptionLbl: Label 'Document Number';
        Cash_Reg__Add_Disc_Split_Post___Currency_Code_CaptionLbl: Label 'Currency';
        ABS__Remaining_Amount__CaptionLbl: Label 'Remaining Amount';
        ABS__Pmt__Discount_Total__CaptionLbl: Label 'PmtDisc';
        Posted_Cash_Register_Header___Amount_to_Pay__LCY__CaptionLbl: Label 'Amount to Pay';
        Posted_Cash_Register_Header___Amount_Given_CaptionLbl: Label 'Amount given';
        Posted_Cash_Register_Header___Change_Money_CaptionLbl: Label 'Change Money';
        PrintFixedPriceG: Boolean;
        ShowQtyG: Boolean;
        ShowUOMG: Boolean;
        ShowUnitPriceG: Boolean;
        ShowDiscountG: Boolean;
        ShowAmountG: Boolean;
        ShowLineSubTotalsG: Boolean;
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        Inspection_DateLbl: Label 'Inspection Date';
        Emission_DateLbl: Label 'Emission Date';
        Appt_Service_AdvisorLbl: Label 'Appt. Service Advisor';
        Pickup_Service_AdvisorLbl: Label 'Pickup Service Advisor';
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
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
        ShowTaxNoG: Boolean;
        ReasonCodeG: Record "Reason Code";
        OrderNoG: Code[20];
        VendorLbl: Label 'Vendor';
        OrderNoLbl: Label 'Order No.';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        TempVATAmountLineG: Record "VAT Amount Line" temporary;
        ExchPartsTaxAmountSumG: Decimal;
        VATPctG: Decimal;
        ExchTaxPctG: Decimal;
        ExchRateText: Text[50];
        VATIdentLbl: Label 'VAT Recapitulation';
        VATPercentLbl: Label 'VAT %';
        VATBaseLbl: Label 'VAT Base';
        VATAmtLbl: Label 'VAT Amount';
        TotalLbl: Label 'total';
        VATLbl: Label 'VAT';
        ToDateLbl: Label 'to date';
        WithoutVATLbl: Label 'without VAT';
        ShowCurrencyG: Text[30];

    [Scope('Internal')]
    procedure CreateTotals()
    begin
        // CreateTotals
        WITH "Sales Cr.Memo Line" DO BEGIN
            CASE ServLineG.Type OF
                ServLineG.Type::Item:
                    SumItemG := SumItemG + Amount + "Inv. Discount Amount";
                ServLineG.Type::"Ext. Service":
                    IF ServSetupG."Output Ext. Service" THEN
                        SumExtServG := SumExtServG + Amount + "Inv. Discount Amount"
                    ELSE
                        SumLaborG := SumLaborG + Amount + "Inv. Discount Amount";
                ServLineG.Type::Labor:
                    SumLaborG := SumLaborG + Amount + "Inv. Discount Amount";
                ELSE
                    SumOtherG := SumOtherG + Amount + "Inv. Discount Amount"
            END;
            TotalNetG := TotalNetG + Amount + "Inv. Discount Amount";
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

        // Start PA038228
        VehApptL.SETRANGE(VIN, ServHdrG.VIN);
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
                IF NOT VehApptTypeL.ISEMPTY THEN BEGIN
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
        // Stop PA038228
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
        ReportSelectionG.INIT;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC033;
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
        SalesCrMemoHdrL: Record "Sales Credit Memo Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        SalesCrMemoHdrL.SETRANGE(SalesCrMemoHdrL."No.", "Sales Cr.Memo Header".GETFILTER("No."));
        IF SalesCrMemoHdrL.FINDSET THEN BEGIN
            IF NOT CustL.GET(SalesCrMemoHdrL."Bill-to Customer No.") THEN
                IF NOT CustL.GET(SalesCrMemoHdrL."Sell-to Customer No.") THEN
                    CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
        END;
        // Stop PA043099
    end;

    /*
    local procedure GetServCust(DocumentTypeP: Integer; DocumentNoP: Code[20]; BilltoCustomerNoP: Code[20]): Boolean
    begin
        // @ Gets Service Customer
        // @ param DocumentTypeP - Integer
        // @ param DocumentNoP - Code 20
        // @ param BilltoCustomerNoP - Code 20
        // @ retval - Boolean

        // Start EU.0006767.209
        IF NOT ServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
            IF NOT ArchServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
                EXIT(FALSE)
            ELSE
                ServCustG.TRANSFERFIELDS(ArchServCustG);
        EXIT(TRUE);
        // Stop EU.0006767.209
    end;
    */

    [Scope('Internal')]
    procedure GetServJobLine(DocumentTypeP: Integer; DocumentNoP: Code[20]; ServJobNoP: Integer; var ServJobLineP: Record "Service Job Line"): Boolean
    var
        ArchServJobLineL: Record "Archived Service Job Line";
    begin
        // @ Gets Service Job Line
        // @ param DocumentTypeP - Integer
        // @ param DocumentNoP - Code 20
        // @ param ServJobNoP - Code 20
        // @ param ServJobLineP - Record Service Job Line ByVAR
        // @ retval - Boolean

        // Start EU.0006767.209
        IF NOT ServJobLineP.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
            IF NOT ArchServJobLineL.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
                EXIT(FALSE)
            ELSE
                ServJobLineP.TRANSFERFIELDS(ArchServJobLineL);
        EXIT(TRUE);
        // Stop EU.0006767.209
    end;

    [Scope('Internal')]
    procedure DetermineColumnVisibility()
    begin
        // @ Determines Column Visibility based on Print Service Job Fixed Price value of the current Service Customer
        // @ Applies only to Fixed Price related lines.

        // Start EU.0006767.209
        // Start EU.0005636
        // Stop EU.0005636
        IF NOT PrintFixedPriceG THEN BEGIN
            ShowQtyG := TRUE;
            ShowUOMG := TRUE;
            ShowUnitPriceG := TRUE;
            ShowDiscountG := TRUE;
            ShowAmountG := TRUE;
            ShowLineSubTotalsG := TRUE;
            EXIT;
        END;

        CASE ServCustG."Print Service Job Fixed Price" OF
            ServCustG."Print Service Job Fixed Price"::"Fixed Price Only":
                BEGIN
                    ShowQtyG := FALSE;
                    ShowUOMG := FALSE;
                    ShowUnitPriceG := FALSE;
                    ShowDiscountG := FALSE;
                    ShowAmountG := FALSE;
                    ShowLineSubTotalsG := FALSE;
                    IF "Sales Cr.Memo Line"."Serv. Preview Total Line Level" = "Sales Cr.Memo Line"."Serv. Preview Total Line Level"::"Job End" THEN
                        ShowLineSubTotalsG := TRUE;
                END;
            ServCustG."Print Service Job Fixed Price"::"Quantity Only":
                BEGIN
                    ShowQtyG := TRUE;
                    ShowUOMG := TRUE;
                    ShowUnitPriceG := FALSE;
                    ShowDiscountG := FALSE;
                    ShowAmountG := FALSE;
                    ShowLineSubTotalsG := FALSE;
                    IF "Sales Cr.Memo Line"."Serv. Preview Total Line Level" = "Sales Cr.Memo Line"."Serv. Preview Total Line Level"::"Job End" THEN
                        ShowLineSubTotalsG := TRUE;
                END;
            ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit":
                BEGIN
                    ShowQtyG := TRUE;
                    ShowUOMG := TRUE;
                    ShowUnitPriceG := TRUE;
                    ShowDiscountG := TRUE;
                    ShowAmountG := TRUE;
                    ShowLineSubTotalsG := TRUE;
                END;
        END;
        // Stop EU.0006767.209
    end;

    [Scope('Internal')]
    procedure EvalHidePrintSubtotal() ValueR: Boolean
    begin
        // @ Evaluates Sum Line Visibility
        // @ retval ValueR - Boolean

        // Start EU.0005636
        ValueR := ("Sales Cr.Memo Line"."Serv. Preview Line Type" = "Sales Cr.Memo Line"."Serv. Preview Line Type"::Sum) AND PrintSubtotalsG AND ShowLineSubTotalsG;
        // Stop EU.0005636
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
                TitleTextRightG := "Sales Cr.Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Cr.Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Cr.Memo Header"."No.";
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


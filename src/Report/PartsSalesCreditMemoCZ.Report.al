report 80021 "DPG Parts Sales Credit Memo CZ" // 1057618 "Parts Sales Credit Memo CZ"
{
    // // @ Area PartsSales
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
    //                        Added new footer for pageloop dataitem
    //                        Added code to print the report title from 'Report Selection' setup.
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                                        Moved the VATText, VATTextLine Dataitem position as last footer.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032651   27.07.11 PR 4262653: Increased width of 'VAT Identifier' control.
    // PA032443   11.11.11 SS Print PDF Document: Added Code in OnPreReport() trigger
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   28.03.12 GB 6570305: Add functionality for Rem. Amount from Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6222797: Layout Changes for Vat
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   21.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Layout 1, Layout2 and Layout 3 concepts incorporated.
    // PA033336   01.10.12 8785185: "Description" control width is increased and 'cangrow' property is enabled.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage, "Sales Credit Memo Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (4) - OnPreSection()", "PageLoop, Footer (5) - OnPreSection()"
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033997   20.03.13 GX I000004:In the RDLC, changed the Visibility Settings of TableRow2, TableRow3 and TableRow7
    //                        so that Sales Invoice Lines of Type Header, Begin-Total, End-Total and Charge(Item)
    //                        are correctly displayed
    // PA033988   08.05.13 SM Reason Code field is promoted on a header of the printout.
    // PA033988   28.05.13 SM I001007: Print Reason Code field is is set to TRUE by default.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA035395   27.12.13 GD 18593 Fixed FooterLines and Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   01.04.14 GF 20892 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   20.01.15 GJ 32696 Fix Report Layout issues, Duplicate image and Reason Code visibility.
    // PA037341   22.01.15 GJ Merge N.6.1.4 to N.7.1.0 of PA035395.18593,PA035484.20892
    // PA036549   23.01.15 GK 32696 Footer Line funtionality moved to OnOpenPage trigger
    // PA037665   12.05.15 GI Added VAT Clause section.
    // PA037665   18.05.15 GI 37661 Added the "VAT" string in front of the VAT number is the VAT Clause section.
    // PA038227   12.08.15 GN Changed Header information.
    // PA038227   24.08.15 GN 43677 Changed Footer functionality
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457
    // PA042487   16.06.17 PT 99438 Added the textbox to print Duplicate
    // --- 7.1.5 ---
    // PA041125   20.07.16 GV 66650 RDLC Layout Modifications
    // PA041125   21.07.16 GQ 66650 RDLC Layout Modifications
    // PA041125   12.08.16 GV 68120 RDLC Layout Modifications
    // PA041023   28.11.16 KB Report modified to Show VIN field.
    // PA041023   03.02.17 SV 87225 Report Modified to Show "Refernece License No." information and Caption change of "Refernece VIN"
    // PA041187   04.04.17 GD 92781 Modification in "Sum Other" row visibility to not be shown when it's equal to 0.
    // PA041187   04.04.17 GD 92784 Modified Additional Item determination from "VAT Calculation Type"::"Exch. Parts Tax"
    //                        to "Additional Item"::"Additional Item".
    // PA041187   10.04.17 GL 93196 Remove option "Print Footer Line" from Request page and related logic. Provide missing logic for "Print Footer Line" option.
    // --- 7.1.6 ---
    // EU.0002138 28.06.17 AK 2101 Merge of PA042487.99438
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5028806 Parts Sales Credit Memo
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  09.05.18 PV RDLC Layout changed - put VAT% instead of VAT identifier
    //                         -source for company bank info changed
    // API.1.0.2  07.06.18 PV RDLC Layout changed, bank source
    // API.1.0.3  07.08.18 PV If blank then ReportTitle filled with "Credit Memo Type"
    //                        RDLC Layout changed - VAT recap. table column size
    // --- API Customization ---
    // 
    // --- DAF ---
    // --- DAF ---
    // FJC       29.5.2020 FJC VAT date added
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsSalesCreditMemoCZ.rdlc';

    Caption = 'Parts Sales Credit Memo';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Credit Memo Header"; "Sales Credit Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Parts Sales Credit Memo';
            column(Sales_Credit_Memo_Header_No_; "No.")
            {
            }
            column(Sales_Credit_Memo_Header_Cash_Register_Receipt; "Cash Register Receipt")
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
                        Description = 'PA041125.66650';
                    }
                    column(CustAddr_3_; CustAddrG[3])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CustAddr_4_; CustAddrG[4])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CustAddr_5_; CustAddrG[5])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CustAddr_6_; CustAddrG[6])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CompanyAddr_1_; CompanyAddrG[1])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddrG[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.66650';
                    }
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(CoFax; CoFaxG)
                    {
                    }
                    column(Sales_Credit_Memo_Header___Document_Date_; "Sales Credit Memo Header"."Document Date")
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Credit_Memo_Header___No__; "Sales Credit Memo Header"."No.")
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
                    {
                    }
                    column(Cust__No__; CustG."No.")
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
                    column(Sales_Credit_Memo_Header___Applies_to_Doc__No__; "Sales Credit Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(DataItem32; CollectiveG.TextShowOutput("Sales Credit Memo Header".FIELDCAPTION("VAT Registration No."), "Sales Credit Memo Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Sales_Credit_Memo_Header___VAT_Registration_No__; "Sales Credit Memo Header"."VAT Registration No.")
                    {
                    }
                    column(Sales_Credit_Memo_Header_Due_date; "Sales Credit Memo Header"."Due Date")
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
                    column(DataItem1115000010; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
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
                    column(Sales_Credit_Memo_Header___Reason_Code__; "Sales Credit Memo Header"."Reason Code")
                    {
                    }
                    column(Print_Reason_Code; PrintReasonCodeG)
                    {
                        Description = 'PA036549.32696';
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvG))
                    {
                    }
                    column(NoPrinted_; RDLHideOutput("Sales Credit Memo Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
                    {
                    }
                    column(BankText; BankTextG)
                    {
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
                    column(sep1; FORMAT('-----------------------------------------------------------------------------------------'))
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA041125.66650';
                    }
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(Sales_Credit_Memo_Header___No__Caption; Sales_Credit_Memo_Header___No__CaptionLbl)
                    {
                    }
                    column(Sales_Credit_Memo_Header___Document_Date_Caption; Sales_Credit_Memo_Header___Document_Date_CaptionLbl)
                    {
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(Sales_Credit_Memo_Header___Applies_to_Doc__No__Caption; Sales_Credit_Memo_Header___Applies_to_Doc__No__CaptionLbl)
                    {
                    }
                    column(Due_Date_Caption; Due_DateLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
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
                    column(Show_VIN_Boolean_Header; ShowVING)
                    {
                        Description = 'PA041023';
                    }
                    column(Sales_Credit_Moemo_Header_VIN; "Sales Credit Memo Header"."Supply VIN")
                    {
                        Description = 'PA041023';
                    }
                    column(Sales_Credit_Moemo_Header_Reference_License_No; "Sales Credit Memo Header"."Reference License No.")
                    {
                        Description = 'PA041023.87225';
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
                    column(VATDate; "Sales Credit Memo Header"."VAT Date")
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
                    column(CurrencyCode_SCH; "Sales Credit Memo Header"."Currency Code")
                    {
                    }
                    column(WithoutVATLbl; WithoutVATLbl)
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
                        column(DiscText; DiscTextG)
                        {
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Credit_Memo_Line_Description; Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Type; "Sales Credit Memo Line".Type)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintSubtotals; PrintSubtotalsG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesTypeG; SalesTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Credit_Memo_Line_Description_Control62; Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line_Subtotal; Subtotal)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Credit_Memo_Line_Description_Control64; Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Credit_Memo_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Credit_Memo_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control70; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Credit_Memo_Line__VAT_Identifier_; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Credit_Memo_Line__No__; "No.")
                        {
                        }
                        column(Sales_Credit_Memo_Line_Description_Control73; Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Sales_Credit_Memo_Line__Unit_Price__Control84; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Credit_Memo_Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control86; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Sales_Credit_Memo_Line__VAT_Identifier__Control1109400014; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Amount____Inv__Discount_Amount__Control1109400000; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Credit_Memo_Line__Unit_Price__Control1109400001; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Credit_Memo_Line__Line_Discount____Control1109400002; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Credit_Memo_Line_Quantity_Control1109400003; Quantity)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Unit_of_Measure__Control1109400004; "Unit of Measure")
                        {
                        }
                        column(Sales_Credit_Memo_Line_Description_Control1109400005; Description)
                        {
                        }
                        column(Sales_Credit_Memo_Line__No___Control1109400006; "No.")
                        {
                        }
                        column(Sales_Credit_Memo_Line__VAT_Identifier__Control1109400015; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Credit_Memo_Line__Description_2_; "Description 2")
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Credit_Memo_Line__Inv__Discount_Amount_; "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                            Description = 'PA033336';
                        }
                        column(TotalInvDiscAmountG; TotalInvDiscAmountG)
                        {
                            Description = 'PA033336';
                        }
                        column(ShowCurrency; ShowCurrencyG)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line__Amount; "Sales Credit Memo Line".Amount)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Credit_Memo_Line___Amount_Including_VAT_____Sales_Credit_Memo_Line__Amount____Exch__Parts_Tax_Amount_; "Sales Credit Memo Line"."Amount Including VAT" - "Sales Credit Memo Line".Amount - "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPct; VATPctG)
                        {
                        }
                        column(Sales_Credit_Memo_Line__VAT_Base_Amount_; "VAT Base Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC017; C_INC017)
                        {
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Credit_Memo_Line__Exch__Parts_Tax_Amount_; "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct; ExchTaxPctG)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Exch__Parts_Tax_Base_; "Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Sales_Credit_Memo_Line___Amount_Including_VAT_; "Sales Credit Memo Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(No_Caption; No_CaptionLbl)
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
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(VAT_ofCaption; VAT_ofCaptionLbl)
                        {
                        }
                        column(Exch__Tax_fromCaption; Exch__Tax_fromCaptionLbl)
                        {
                        }
                        column(Sales_Credit_Memo_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Credit_Memo_Line_Line_No_; "Line No.")
                        {
                        }
                        column(Show_VIN_Boolean; ShowVING)
                        {
                            Description = 'PA041023';
                        }
                        column(Supply_VIN_SalesCreditMemo; "Sales Credit Memo Line"."Supply VIN")
                        {
                            Description = 'PA041023';
                        }
                        column(Reference_License_No_SalesCreditMemo; "Sales Credit Memo Line"."Reference License No.")
                        {
                            Description = 'PA041023.87225';
                        }
                        column(VATpercent_SCL; "Sales Credit Memo Line"."VAT %")
                        {
                        }
                        column(VATpercentCpn_SCL; "Sales Credit Memo Line".FIELDCAPTION("VAT %"))
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Credit Memo Line";
                            T115FncL: Codeunit "ET111,112,113,114,115,6661";
                        begin
                            //Start API.1.0.2
                            T115FncL.T115_CalcPrintVATAmtLines("Sales Credit Memo Line", VATAmountLineG, VATPctG, ExchTaxPctG);

                            // VATAmountLineG.INIT;
                            // // Start PA037665
                            // VATAmountLineG."VAT Clause Code" := "VAT Clause Code";
                            // // Stop PA037665
                            // // Start PA033011.5983155
                            // VATAmountLineG."VAT Identifier" := FORMAT("VAT %");
                            // VATAmountLineG."Sales Amount" := Amount;
                            // // Stop PA033011.5983155
                            // VATAmountLineG."VAT %" := "VAT %";
                            // IF ("VAT %" <> 0) AND (Quantity <> 0) THEN
                            //  VATPctG := "VAT %";
                            // // Start PA032441
                            // // Stop PA032441
                            // VATAmountLineG."VAT Base" := "VAT Base Amount";
                            // // Start PA032441
                            // // Stop PA032441
                            // IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                            //  ExchTaxPctG := "Exch. Parts VAT %";
                            //
                            // // Start PA032441
                            // // Stop PA032441
                            // VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            // VATAmountLineG.InsertLine;
                            //Stop API.1.0.2

                            NoPropertyG := '';
                            // Start PA041187.92784
                            IF "Additional Item" = "Additional Item"::Deposit THEN
                                NoPropertyG := C_INC016;
                            // Stop PA041187.92784

                            IF Type = Type::Item THEN
                                SumItemG := SumItemG + Amount + "Inv. Discount Amount"
                            ELSE
                                SumOtherG := SumOtherG + Amount + "Inv. Discount Amount";

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
                            SalesTypeG := Type;
                            IF Type = Type::Item THEN
                                TotalInvDiscAmountG := TotalInvDiscAmountG + "Inv. Discount Amount"
                            ELSE
                                TotalInvDiscAmountG := TotalInvDiscAmountG + "Inv. Discount Amount";

                            IF ("Line Discount Amount" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                "Unit Price" := (Amount + "Inv. Discount Amount") / Quantity;
                                "Line Discount %" := 0;
                            END;
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            // CurrReport.CREATETOTALS("Line Discount Amount",Amount,"Amount Including VAT","Inv. Discount Amount","Exch. Parts Tax Amount",
                            //  "Exch. Parts Tax Base","VAT Base Amount");

                            VATPctG := 0;
                            ExchTaxPctG := 0;

                            // Start PA033336
                            CLEAR(TotalInvDiscAmountG);
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
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; TempVATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmtLineVATBaseLCY; TempVATAmountLineG."VAT Base (LCY)")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtLCY; TempVATAmountLineG."VAT Amount (LCY)")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATLCY_VAL; TempVATAmountLineG."Amount Including VAT (LCY)")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
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
                        column(ShowCurrency_Control37; ShowCurrencyG)
                        {
                        }
                        column(Sales_Credit_Memo_Line__Amount; "Sales Credit Memo Line".Amount)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLineG."VAT %")
                        {
                            DecimalPlaces = 0 : 2;
                            Description = 'PA041125.66650';
                        }
                        column(VATAmountLine__VAT_Base__Control106; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control107; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_COUNT_Control1101360903; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base__Control110; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct_Control94; ExchTaxPctG)
                        {
                        }
                        column(Sales_Credit_Memo_Line___Exch__Parts_Tax_Amount_; "Sales Credit Memo Line"."Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(C_INC016_Control99; C_INC016)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(TotalInclVATText_Control44; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Credit_Memo_Line___Amount_Including_VAT_; "Sales Credit Memo Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control108; TotalCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control109; ContinuedCaption_Control109Lbl)
                        {
                        }
                        column(VAT_ofCaption_Control114; VAT_ofCaption_Control114Lbl)
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
                            // Start PA032441
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                            // Stop PA032441
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

                            IF NOT ((DATE2DMY(LastDateG, 2) = DATE2DMY("Sales Credit Memo Header"."Main Shipment Date", 2)) AND
                               (DATE2DMY(LastDateG, 3) = DATE2DMY("Sales Credit Memo Header"."Main Shipment Date", 3)))
                            THEN BEGIN
                                RetRcptLineTG.RESET;
                                RetRcptLineTG.SETFILTER("Posting Date", '%1..%2', FirstDateG, LastDateG);

                                RetRcptLineT2G.RESET;
                                RetRcptLineT2G.DELETEALL;
                                IF RetRcptLineTG.FIND('-') THEN
                                    REPEAT
                                        RetRcptLineT2G.RESET;
                                        RetRcptLineT2G.SETRANGE(RetRcptLineT2G.Type, RetRcptLineTG.Type);
                                        RetRcptLineT2G.SETRANGE(RetRcptLineT2G."No.", RetRcptLineTG."No.");
                                        IF RetRcptLineT2G.FIND('-') THEN BEGIN
                                            RetRcptLineT2G."Closing Credited Quantity" := RetRcptLineT2G."Closing Credited Quantity" +
                                              RetRcptLineTG."Closing Credited Quantity";
                                            RetRcptLineT2G.MODIFY;
                                        END ELSE BEGIN
                                            RetRcptLineT2G.RESET;
                                            RetRcptLineT2G.INIT;
                                            RetRcptLineT2G.TRANSFERFIELDS(RetRcptLineTG);
                                            RetRcptLineT2G.INSERT;
                                        END;
                                    UNTIL RetRcptLineTG.NEXT = 0;

                                SlNoG := 0;
                                IF RetRcptLineT2G.FIND('-') THEN
                                    REPEAT
                                        IF DescriptionG = '' THEN
                                            DescriptionG := FORMAT(RetRcptLineT2G.Type) + ' ' + RetRcptLineT2G."No." + ' ' +
                                              RetRcptLineT2G."Unit of Measure Code" + ' ' + FORMAT(RetRcptLineT2G."Closing Credited Quantity")
                                        ELSE
                                            DescriptionG := ' / ' + FORMAT(RetRcptLineT2G.Type) + ' ' + RetRcptLineT2G."No." + ' ' +
                                              RetRcptLineT2G."Unit of Measure Code" + ' ' + FORMAT(RetRcptLineT2G."Closing Credited Quantity");
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
                                    UNTIL RetRcptLineT2G.NEXT = 0;
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            LastDateG := 0D;
                            CountG := 0;
                            MaxNoCharsPerLineG := 59;
                            IF ("Sales Credit Memo Header"."Main Shipment Date" = 0D) OR ("Sales Credit Memo Header"."Return Order No." = '') OR
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
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt");
                        DataItemLinkReference = "Sales Credit Memo Header";
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
                                AmountMinusDiscG := "Cash Reg. Add Disc Split Post."."Remaining Amount" - "Cash Reg. Add Disc Split Post."."Pmt. Discount Total";
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
                            column(Posted_Cash_Register_Header___Currency_Code__Control134; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Currency_Code__Control135; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
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
                            IF NOT PmtMethodG.GET("Sales Credit Memo Header"."Payment Method Code") OR
                               NOT PmtMethodG."Cash Payment"
                            THEN BEGIN
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
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC038;
                                IncrG := IncrG + 1;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                // Start PA033042
                                SETRANGE("VAT Identifier Code", VATIdentifierTempG.Code);
                                SETRANGE("Language Code", VATTextHdrG.GetLanguageCode(VATIdentifierTempG.Code, "Sales Credit Memo Header"."Language Code"));
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
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
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
                            VATClauseG.TranslateDescription("Sales Credit Memo Header"."Language Code");
                            // Stop PA037665
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA037665
                            CLEAR(VATClauseG);
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Amount");
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
                    IF ("Sales Credit Memo Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
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
                    //Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrintedG.RUN("Sales Credit Memo Header");
                    //Stop PA032727
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
                bankAccountL: Record "Bank Account";
                salesInvoiceHeaderL: Record "Sales Invoice Header";
                T115FncL: Codeunit "ET111,112,113,114,115,6661";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Parts Sales Credit Memo CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593

                //Start API.1      01.03.18 PV
                IF ReportTitleG = '' THEN
                    ReportTitleG := FORMAT("Sales Credit Memo Header"."Credit Memo Type");
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Credit Memo Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Credit Memo Header"."User ID");
                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                IF ReasonCodeG.GET("Sales Credit Memo Header"."Reason Code") THEN;

                IF salesInvoiceHeaderL.GET("Sales Credit Memo Header"."Applies-to Doc. No.") THEN
                    //OrderNoG := salesInvoiceHeaderL."Applies-to Doc. No."
                    OrderNoG := salesInvoiceHeaderL."Order No."
                ELSE
                    OrderNoG := '';

                TempVATAmountLineG.DELETEALL;
                T115FncL.T115_CalcVATAmountLines("Sales Credit Memo Header", TempVATAmountLineG);
                //Stop API.1      01.03.18 PV

                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                CurrReport.LANGUAGE := BillToCustG.PrintDocInCustLanguage();
                PrintWithoutDiscG := NOT "Show Discount";

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
                // Start PA041187.93196
                // Stop PA041187.93196

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
                //
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

                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE BEGIN
                    ShowCurrencyG := "Currency Code";
                END;
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);

                FormatAddrG.SalesCrMemoBillTo(CustAddrG, "Sales Credit Memo Header");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Credit Memo Header"."Payment Method Code") THEN
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

                FormatAddrG.SalesCrMemoShipTo(ShipToAddrG, "Sales Credit Memo Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                IF NOT CustG.GET("Bill-to Customer No.") THEN
                    IF NOT CustG.GET("Sell-to Customer No.") THEN
                        CustG."No." := "Sell-to Customer No.";

                IF "Sell-to Customer No." <> "Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesCrMemoCust(OrderCustAddrG, "Sales Credit Memo Header");
                    OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';

                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscCheckSalCrMemoLineG.SETRANGE("Document No.", "No.");
                    DiscCheckSalCrMemoLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckSalCrMemoLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(6) <> '';
                    IF LogInteractionG THEN
                        SegMgntG.LogDocument(
                          6, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.",
                          "Salesperson Code", '', "Posting Description");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipTextG := C_INC034
                ELSE
                    ShipTextG := C_INC035;

                IF "Return Order No." <> '' THEN BEGIN
                    RetRcptLineTG.RESET;
                    RetRcptLineTG.DELETEALL;

                    SalCrMemoLineG.RESET;
                    SalCrMemoLineG.SETRANGE("Document No.", "No.");
                    IF SalCrMemoLineG.FIND('-') THEN
                        REPEAT
                            IF SalCrMemoLineG."Ret. Rcpt. No. not Closed" <> '' THEN BEGIN
                                RetRcptLineG.RESET;
                                RetRcptLineG.SETRANGE(RetRcptLineG."Document No.", SalCrMemoLineG."Ret. Rcpt. No. not Closed");
                                RetRcptLineG.SETRANGE("Return Order No.", SalCrMemoLineG."Return Order No.");
                                RetRcptLineG.SETRANGE("Return Order Line No.", SalCrMemoLineG."Return Order Line No.");
                                IF RetRcptLineG.FIND('-') THEN BEGIN
                                    RetRcptLineTG.INIT;
                                    RetRcptLineTG.TRANSFERFIELDS(RetRcptLineG);
                                    RetRcptLineTG."Closed by Credit Memo No." := SalCrMemoLineG."Document No.";
                                    RetRcptLineTG."Closing Credited Quantity" := SalCrMemoLineG."Remaining Qty on Ret. Rcpt.";
                                    RetRcptLineTG.INSERT;
                                END;
                            END;
                        UNTIL SalCrMemoLineG.NEXT = 0;

                    RetRcptLineG.RESET;
                    RetRcptLineG.SETRANGE("Closed by Credit Memo No.", SalCrMemoLineG."Document No.");
                    IF RetRcptLineG.FIND('-') THEN
                        REPEAT
                            RetRcptLineTG.INIT;
                            RetRcptLineTG.TRANSFERFIELDS(RetRcptLineG);
                            RetRcptLineTG.INSERT;
                        UNTIL RetRcptLineG.NEXT = 0;
                END;

                FirstShipDateG := "Sales Credit Memo Header"."First Shipment Date";
                LastShipDateG := "Sales Credit Memo Header"."Last Shipment Date";
                IF ((FirstShipDateG = 0D) OR (LastShipDateG = 0D)) AND (SalCrMemoLineG."Return Order No." <> '') THEN BEGIN
                    IF RetRcptLineTG.FIND('-') THEN
                        REPEAT
                            IF (FirstShipDateG = 0D) OR (RetRcptLineTG."Posting Date" < FirstShipDateG) THEN
                                FirstShipDateG := RetRcptLineTG."Posting Date";
                            IF (LastShipDateG = 0D) OR (RetRcptLineTG."Posting Date" > LastShipDateG) THEN
                                LastShipDateG := RetRcptLineTG."Posting Date";
                        UNTIL RetRcptLineTG.NEXT = 0;
                END;
                IF "Main Shipment Date" <> 0D THEN
                    ShipDateTextG := FORMAT(DATE2DMY("Main Shipment Date", 2)) + '/' + FORMAT(DATE2DMY("Main Shipment Date", 3))
                ELSE
                    ShipDateTextG := '';
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
                    field(PrintSubtotalsG; PrintSubtotalsG)
                    {
                        Caption = 'Print Subtotals';
                    }
                    field(ConsolidateNegativePosG; ConsolidateNegativePosG)
                    {
                        Caption = 'Blind out Zero Positions';
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
                        Editable = true;
                    }
                    field(PrintReasonCodeG; PrintReasonCodeG)
                    {
                        Caption = 'Print Reason Code';
                        Description = 'PA033988';
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
            // Start PA039225.51457
            // Start PA036549.32696
            // Stop PA036549.32696
            // Start PA033336
            // Stop PA033336
            // Start PA033336
            // Stop PA033336
            GetReportSelection();
            // Stop PA039225.51457
            ConsolidateNegativePosG := TRUE;

            RePrintOriginalInvG := FALSE;
            // Stop PA033336

            // Start PA033988.I001007
            PrintReasonCodeG := TRUE;
            // Stop PA033988.I001007
        end;
    }

    labels
    {
        Supply_VIN_Caption = 'Reference VIN';
        Reference_License_No_Caption = 'Reference License No.';
    }

    trigger OnInitReport()
    begin
        // Start PA033336
        // Start PA039225.51457
        // Stop PA033336
        // Start PA032727
        // Start PA035597
        // Stop PA035597
        // Start PA035484.20892
        // Stop PA035484.20892
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        GetReportSelection();
        // Stop PA039225.51457
        GLSetupG.GET;

        ConsolidateNegativePosG := TRUE;
        // Stop PA032727
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA035597
    end;

    var
        ReportSelectionsG: Record "Report Selection";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnDelivAddressG: Record "Ship-to Address";
        OwnBanksG: Record "Customer Bank Account";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        DiscCheckSalCrMemoLineG: Record "Sales Credit Memo Line";
        BillToCustG: Record Customer;
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        RetRcptLineG: Record "Return Receipt Line";
        RetRcptLineTG: Record "Return Receipt Line" temporary;
        RetRcptLineT2G: Record "Return Receipt Line" temporary;
        SalCrMemoLineG: Record "Sales Credit Memo Line";
        StanTextG: Record "Standard Text" temporary;
        StanText2G: Record "Standard Text" temporary;
        UserSetupG: Record "User Setup";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Report Selection";
        VATClauseG: Record "VAT Clause";
        SalesCrMemoCountPrintedG: Codeunit "Sales Cr. Memo-Printed";
        FormatAddrG: Codeunit "Format Address";
        RTCMgmtG: Codeunit "RTC Management";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
        IntCustG: Code[20];
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
        CopyTextG: Text[30];
        ShipToAddrG: array[8] of Text[50];
        NoPropertyG: Text[30];
        DiscTextG: Text[30];
        TotalInclVATTextG: Text[50];
        ShipTextG: Text[30];
        DescriptionG: Text[100];
        TextG: Text[50];
        Text2G: Text[50];
        ShipDateTextG: Text[10];
        DuplicateTextG: Text[30];
        VATLegendsG: Text[15];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        ExchTaxPctG: Decimal;
        AmountMinusDiscG: Decimal;
        SumItemG: Decimal;
        SumOtherG: Decimal;
        VATPctG: Decimal;
        TotalInvDiscAmountG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        CountG: Integer;
        MaxNoCharsPerLineG: Integer;
        SlNoG: Integer;
        IncrG: Integer;
        [InDataSet]
        OutputNoG: Integer;
        SalesTypeG: Integer;
        PageLoopFooterG: Integer;
        FirstShipDateG: Date;
        LastShipDateG: Date;
        FirstDateG: Date;
        LastDateG: Date;
        PrintSubtotalsG: Boolean;
        ShowShippingAddrG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        C_INC001: Label 'D U P L I C A T E';
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC009: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC017: Label '* = Exchange part';
        C_INC029: Label 'Copy of';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC033: Label 'Tax No.';
        ConsolidateNegativePosG: Boolean;
        LogInteractionG: Boolean;
        C_INC034: Label 'Shipment Date';
        C_INC035: Label 'Dispatch Date';
        C_INC036: Label 'Differing Shipment';
        RePrintOriginalInvG: Boolean;
        C_INC037: Label 'Parts Sales Credit Memo';
        C_INC038: Label ' =';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        PrintReasonCodeG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        Sales_Credit_Memo_Header___No__CaptionLbl: Label 'Document No.';
        Sales_Credit_Memo_Header___Document_Date_CaptionLbl: Label 'Document Date';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        Sales_Credit_Memo_Header___Applies_to_Doc__No__CaptionLbl: Label 'Applied to';
        SalesPurch_NameCaptionLbl: Label 'Salesperson';
        Sales_Credit_Memo_Header___Reason_Code__CaptionLbl: Label 'Reason Code';
        Payments_to_CaptionLbl: Label 'Payments to:';
        DescriptionCaptionLbl: Label 'Description';
        No_CaptionLbl: Label 'No.';
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
        TotalCaptionLbl: Label 'Total';
        VAT_ofCaptionLbl: Label '% VAT of';
        Exch__Tax_fromCaptionLbl: Label '% Exch. Tax from';
        TotalCaption_Control108Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control109Lbl: Label 'Continued';
        VAT_ofCaption_Control114Lbl: Label '% VAT of';
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
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATClausesCap: Label 'VAT Clause';
        VATIdentifierCap: Label 'VAT Identifier';
        C_INC_VAT: Label 'VAT';
        Due_DateLbl: Label 'Due Date';
        UserSessionG: Codeunit "User Session Unit";
        ReportTitleG: Text[100];
        ShowVING: Boolean;
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
        ShowTaxNoG: Boolean;
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        ReasonCodeG: Record "Reason Code";
        OrderNoG: Code[20];
        OrderNoLbl: Label 'Order No.';
        TempVATAmountLineG: Record "VAT Amount Line" temporary;
        ExchPartsTaxAmountSumG: Decimal;
        ExchRateText: Text[50];
        VATIdentLbl: Label 'VAT Recapitulation';
        VATPercentLbl: Label 'VAT %';
        VATBaseLbl: Label 'VAT Base';
        VATAmtLbl: Label 'VAT Amount';
        TotalLbl: Label 'total';
        VATLbl: Label 'VAT';
        ToDateLbl: Label 'to date';
        WithoutVATLbl: Label 'without VAT';

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
        ReportTitleG := C_INC037;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionG);
            IF ReportSelectionG."Print Report Title" THEN
                ReportTitleG := ReportSelectionG."Report Title"
            ELSE BEGIN
                ReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        // Start PA041187.93196
        // Stop PA041187.93196
        PrintAddrBlockG := ReportSelectionsG."Print Address Block";
        PrintFooterLineG := ReportSelectionsG."Print Footer Line";
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


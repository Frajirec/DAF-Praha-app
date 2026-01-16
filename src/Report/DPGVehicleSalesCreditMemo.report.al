report 80000 "DPG Vehicle Sales Credit Memo" // 1057604 "Vehicle Sales Credit Memo CZ"
{
    // // @ Area VehicleSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   05.08.10 Changes made to print original/duplicate invoices.
    // PA032178   27.10.10 DD 1798176 docu trigger and version list corrected.
    //            05.01.11 PR 2305501: Added code to increment the "No. Printed" in "Sales Credit Memo Header"
    //                                        on printing the report.
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    //                        Added code to print the report title from 'Report Selection' setup.
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                                        and vice-versa.
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                                        Moved the VATText, VATTextLine Dataitem position as last footer.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032651   27.07.11 PR 4262653: Increased width of 'VAT Identifier' control.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   28.03.12 GB 6570305: Add functionality for Rem. Amount from Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6224040: Layout Changes for Vat
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   28.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Layout 1 and Layout 2 and Layout 3 Concepts
    // PA033336   04.10.12 8850667: Filter is applied in Header Text Footer Section and Body Section of RDLC layout.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Sales Credit Memo Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (5) - OnPreSection()", "PageLoop, Footer (6) - OnPreSection()"
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033988   08.05.13 SM Reason Code field is promoted on a header of the printout.
    // PA033988   28.05.13 SM I001010: Print Reason Code field is is set to TRUE by default.
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036090   10.07.14 GJ 24386 Modified RDL Layout to correct Header and Print.
    // PA035597   14.07.14 GL Remove PDf functionality
    // PA036090   18.07.14 GJ 24386 Header and print layout correction
    // PA035395   27.12.13 GD 18593 Fixed FooterLines and Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   01.04.14 GF 20755 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   13.01.14 GN 32385 Layout and visibility issues fixed
    // PA037341   21.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035484.20755
    // PA037665   12.05.15 GI Added VAT Clause section.
    // PA037665   18.05.15 GI 37703 VAT literal added in front of VAT value in the VAT Clause section.
    // PA038229   15.07.15 GK Added Header information.
    //                        Added Footer functionality.
    //                        Added detailed information for the Model/Vehicle.
    // PA038229   22.07.15 GK 41923 RDLC Layout Fixes
    // PA038218   18.09.15 IS 44878 "Sales Person" field left indented and size of text box is extended in header.
    // PA040293   30.03.16 KR 57855 Code changed to make the trade-in amount rounded according to the rounding setup and Calculating TotalCurrVatAmtG
    //                        irrespective of DoNotShowVATG and Modified the RDLC to display Total Pay.
    // PA040294   04.04.16 KR Merge of PA040293.57855.
    // PA040256   08.04.16 GV 57127 Get Amount Rounding Precision from Currency table
    // PA040757   23.05.16 PT Added VAT info for Manufacturer Option
    // PA040757   01.06.16 PT 61962 VAT identifier added instead of VAT% for maunfacturer option
    // PA040758   08.06.16 JS Merge of PA040757.61962
    // PA041125   19.07.16 GV 66551 RDLC Layout Modifications
    //                              Add format to date fields
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457
    // PA041125   09.08.16 GJ 68105 RDLC Layout Modifications
    // PA041125   12.08.16 GV 68105 RDLC Layout Modifications
    // PA042846   31.01.17 JM Added change which takes Value from Table: "Posted Sales Trade-In" if the return order is not yet posted
    // PA041187   13.02.17 JM 87656 "Posted Sales Trade-In" OnAfterGetRecord modified to also filter PurchCrMemoLine by Line No.
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // --- NAVCZ ---
    // API.1      22.03.18 KV New object created as a copy of Report 5025407 Vehicle Sales Credit Memo
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.2  07.06.18 PV RDLC Layout changed, Final header design, bank source
    //                        put VAT% instead of VAT identifier
    // API.1.0.3  07.08.18 PV If blank then ReportTitle filled with "Credit Memo Type"
    //                        RDLC Layout changed - VAT recap. table column size
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1    15.04.19 JJ DAFCZ.1 Print Exchange Rate
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/VehicleSalesCreditMemo.rdlc';

    Caption = 'Vehicle Sales Credit Memo';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Credit Memo Header"; "Sales Credit Memo Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Order Type" = CONST("Vehicle Sales & Purchases"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(Sales_Credit_Memo_Header_No_; "No.")
            {
            }
            column(Sales_Credit_Memo_Header_Cash_Register_Receipt; "Cash Register Receipt")
            {
            }
            column(PrintNoUnitPrice_G; PrintNoUnitPriceG)
            {
            }
            column(PrintReasonCodeG; PrintReasonCodeFieldG)
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
                    column(Sales_Credit_Memo_Header___Document_Date_; FORMAT("Sales Credit Memo Header"."Document Date"))
                    {
                        Description = 'PA031550';
                    }
                    column(Sales_Credit_Memo_Header___No__; "Sales Credit Memo Header"."No.")
                    {
                    }
                    column(CompAddr; CompAddrG)
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
                        Description = 'PA041125.66551';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.66551';
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
                    column(Print_Reason_Code; FORMAT(PrintReasonCodeFieldG, 0, 2))
                    {
                        Description = 'PA033988';
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
                    column(Sales_Credit_Memo_Header___Applies_to_Doc__No__; "Sales Credit Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(DataItem220; CollectiveG.TextShowOutput("Sales Credit Memo Header".FIELDCAPTION("VAT Registration No."), "Sales Credit Memo Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Sales_Credit_Memo_Header___VAT_Registration_No__; "Sales Credit Memo Header"."VAT Registration No.")
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo_FIELDCAPTION__VAT_Registration_No_____PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddressBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__VAT_Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddressBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_C_INC032__PrintAddrBlock_; CollectiveG.TextShowOutput(C_INC032, PrintAddressBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddressBlockG))
                    {
                    }
                    column(ShipDateTextG; ShipDateTextG)
                    {
                    }
                    column(ShipTextG; ShipTextG)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA031550';
                    }
                    column(DataItem1115000005; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(OutputNoG; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Duplicate_Graphic_; ReportLayoutSetupG."Duplicate Graphic")
                    {
                        Description = 'PA033336';
                    }
                    column(PrintFooterLineG_; PrintFooterLineBlockG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintAddrBlock; PrintAddressBlockG)
                    {
                        Description = 'PA033336';
                    }
                    column(ShowUnitsofMeasure; ShowUnitsOfMeasureFieldG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintSentFromLine; FORMAT(PrintSentFromLineBlockG))
                    {
                        Description = 'PA033336';
                    }
                    column(TradeInExtra; PrintTradeInExtraG)
                    {
                        Description = 'PA033336';
                    }
                    column(DoNotShowVAT; DoNotPrintVATG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintOption; PrintOption2G)
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Credit_Memo_Header___Reason_Code__; "Sales Credit Memo Header"."Reason Code")
                    {
                        Description = 'PA031550';
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvoiceG))
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
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField43; RDLHideOutput(PrintFooterLineBlockG AND (NOT IsRepSelectionSetupAvailableG)))
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
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA041125.66551';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA041125.66551';
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
                    column(PageLbl; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
                    {
                    }
                    column(Application_forCaption; Application_forCaptionLbl)
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
                    column(ShowManyVehiclesG; ShowManyVehiclesG)
                    {
                        Description = 'PA038229';
                    }
                    column(HideVehicleMainInfoG; HideVehicleMainInfoG)
                    {
                        Description = 'PA038229.41923';
                    }
                    column(Vehicle__Make_Code_; SalesCrMemoLine2G."Shortcut Dimension 2 Code")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__Make_Code_Caption; SalesCrMemoLine2G.FIELDCAPTION("Shortcut Dimension 2 Code"))
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
                    column(Vehicle_VIN_; SalesCrMemoLine2G.VIN)
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_VINCaption; SalesCrMemoLine2G.FIELDCAPTION(VIN))
                    {
                        Description = 'PA038229';
                    }
                    column(Purchase_Line__Book_No_; SalesCrMemoLine2G."Book No.")
                    {
                        Description = 'PA038229';
                    }
                    column(Purchase_Line__Book_No_Caption; SalesCrMemoLine2G.FIELDCAPTION("Book No."))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Satus; SalesCrMemoLine2G."Vehicle Status")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_StatusCaption; SalesCrMemoLine2G.FIELDCAPTION("Vehicle Status"))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Initial_Registration_; FORMAT(VehicleG."Initial Registration"))
                    {
                        Description = 'PA038229,PA041125.66551';
                    }
                    column(Vehicle_Initial_Registration_Caption; VehicleG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Reg_Certificate; VehicleG."Registration Certificate")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Reg_Certificate_Caption; VehicleG.FIELDCAPTION("Registration Certificate"))
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
                    column(Vehicle_Mileage; VehicleG.Mileage)
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_MileageCaption; VehicleG.FIELDCAPTION(Mileage))
                    {
                        Description = 'PA038229';
                    }
                    column(FORMAT_MainNextAppDateG_; FORMAT(MainNextAppDateG))
                    {
                        Description = 'PA038229';
                    }
                    column(MainNextAppDateGCaption; MainNextAppDateGLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(FORMAT_EmissionNextAppDateG_; FORMAT(EmissionNextAppDateG))
                    {
                        Description = 'PA038229';
                    }
                    column(FORMAT_EmissionNextAppDateGCaption; EmissionNextAppDateGLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(PurchaseDocument; SalesCrMemoLine2G."Line No.")
                    {
                    }
                    column(PurchaseDocumentCaption; PurchaseDocumentLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(OrderDate; "Sales Credit Memo Header"."Return Order No.")
                    {
                        Description = 'PA038229';
                    }
                    column(OrderDateCaption; OrderDateLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(ShipmentDate; FORMAT("Sales Credit Memo Header"."Shipment Date"))
                    {
                        Description = 'PA038229,PA041125.66551';
                    }
                    column(ShipmentDateCaption; "Sales Credit Memo Header".FIELDCAPTION("Shipment Date"))
                    {
                        Description = 'PA038229';
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
                    column(Sales_Credit_Memo_Header_Due_date; "Sales Credit Memo Header"."Due Date")
                    {
                    }
                    column(Sales_Credit_Moemo_Header_VIN; "Sales Credit Memo Header"."Supply VIN")
                    {
                        Description = 'PA041023';
                    }
                    column(Sales_Credit_Memo_Header___Applies_to_Doc__No__Caption; Sales_Credit_Memo_Header___Applies_to_Doc__No__CaptionLbl)
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
                    dataitem(HeaderHeaderText; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Credit Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Header));
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
                        column(Collective_TextShowOutput__Sales_Cr_Memo_Line__FIELDCAPTION__Unit_of_Measure___ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesCrMemoLineG.FIELDCAPTION("Unit of Measure"), ShowUnitsOfMeasureFieldG))
                        {
                        }
                        column(DiscText; DiscTextG)
                        {
                        }
                        column(CurrentVehicle; CurrentVehicleG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalVeh; TotalVehG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line__Description; SalesCrMemoLineG.Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line___Unit_Price_; SalesCrMemoLineG."Unit Price")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line___Item_Type_; SalesCrMemoLineG."Item Type")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line___Line_No__; SalesCrMemoLineG."Line No.")
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
                        column(OptionFound; OptionFoundG)
                        {
                            Description = 'PA033336';
                        }
                        column(VINOld; VINOldG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line__VIN_Control1101315991; SalesCrMemoLineG.VIN)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line__Type; SalesCrMemoLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_InvoiceLine___Line_Discount___; SalesCrMemoLineG."Line Discount %")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line___Unit_of_Measure_; SalesCrMemoLineG."Unit of Measure")
                        {
                            Description = 'PA033336';
                        }
                        column(SalesCrMemoLineTypeG; SalesCrMemoLineTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesCrMemoLineItemTypeG; SalesCrMemoLineItemTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line__Description_Control58; SalesCrMemoLineG.Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Quantity; SalesCrMemoLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPct; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmount; DspAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput__Sales_Cr_Memo_Line___Unit_of_Measure__ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesCrMemoLineG."Unit of Measure", ShowUnitsOfMeasureFieldG))
                        {
                        }
                        column(Sales_Cr_Memo_Line___VAT_Identifier_; SalesCrMemoLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Cr_Memo_Line__Description_Control1109420000; SalesCrMemoLineG.Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Quantity_Control1109420001; SalesCrMemoLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Collective_TextShowOutput__Sales_Cr_Memo_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109420002; CollectiveG.TextShowOutput(SalesCrMemoLineG."Unit of Measure", ShowUnitsOfMeasureFieldG))
                        {
                        }
                        column(Sales_Cr_Memo_Line___Description_2_; SalesCrMemoLineG."Description 2")
                        {
                        }
                        column(Sales_Cr_Memo_Line___No__; SalesCrMemoLineG."No.")
                        {
                        }
                        column(Sales_Cr_Memo_Line__Description_Control65; SalesCrMemoLineG.Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Quantity_Control66; SalesCrMemoLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice_Control68; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPct_Control69; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmount_Control70; DspAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput__Sales_Cr_Memo_Line___Unit_of_Measure__ShowUnitsofMeasure__Control67; CollectiveG.TextShowOutput(SalesCrMemoLineG."Unit of Measure", ShowUnitsOfMeasureFieldG))
                        {
                        }
                        column(Sales_Cr_Memo_Line___VAT_Identifier__Control1109400015; SalesCrMemoLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(DspAmount_Control1109400000; DspAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ShowLineDiscPct_Control1109400001; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Cr_Memo_Line__Quantity_Control1109400002; SalesCrMemoLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice_Control1109400003; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput__Sales_Cr_Memo_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400004; CollectiveG.TextShowOutput(SalesCrMemoLineG."Unit of Measure", ShowUnitsOfMeasureFieldG))
                        {
                        }
                        column(Sales_Cr_Memo_Line__Description_Control1109400005; SalesCrMemoLineG.Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line___No___Control1109400006; SalesCrMemoLineG."No.")
                        {
                        }
                        column(Sales_Cr_Memo_Line___VAT_Identifier__Control1109400016; SalesCrMemoLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Cr_Memo_Line___Description_2__Control156; SalesCrMemoLineG."Description 2")
                        {
                        }
                        column(VehicleDescription; VehicleDescriptionG)
                        {
                        }
                        column(ShowSalPrice_Control143; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPct_Control145; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmount_Control146; DspAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line___No___Control147; SalesCrMemoLineG."No.")
                        {
                        }
                        column(Sales_Cr_Memo_Line___VAT_Identifier__Control1109400017; SalesCrMemoLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(CurrentVehicle_Control22; CurrentVehicleG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalVeh_Control100; TotalVehG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumVehicle; SumVehicleG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumMfgOpt; SumMfgOptG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(DoNotShowVAT2G; DoNotPrintVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumOwnOpt; SumOwnOptG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumTransferFees; SumTransferFeesG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumChargeItems; SumChargeItemsG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line___Inv__Discount_Amount_; -SalesCrMemoLineG."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmtG; -TotalInvDiscAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Cr_Memo_Line__Amount; SalesCrMemoLineG.Amount)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLineG.VATAmountText + ' ' + ofLbl)
                        {
                            Description = 'PA041125.66551';
                        }
                        column(ShowCurrency; ShowCurrencyG)
                        {
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT_____Sales_Cr_Memo_Line__Amount; SalesCrMemoLineG."Amount Including VAT" - SalesCrMemoLineG.Amount)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT_; SalesCrMemoLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(DoNotShowVAT_Control1101233840; DoNotPrintVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine_VATIdentifier; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(TotalCurrVatAmtG; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(SumOnlyDiffTaxationG; SumOnlyDiffTaxationG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
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
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NormalVATTotalG; NormalVATTotalG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT__Control255; SalesCrMemoLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(DiffTaxExistsG; DiffTaxExistsG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalInclVATText_Control10; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT__Control13; SalesCrMemoLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
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
                        column(Sales_Cr_Memo_Line___Inv__Discount_Amount_Caption; Sales_Cr_Memo_Line___Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(of_these_diff__taxation_Caption; of_these_diff__taxation_CaptionLbl)
                        {
                        }
                        column(TotalCaption_Control251; TotalCaption_Control251Lbl)
                        {
                        }
                        column(SalesLine_Number; Number)
                        {
                        }
                        column(VATpercent_SL; SalesCrMemoLineG."VAT %")
                        {
                        }
                        column(VATpercentCpn_SL; SalesCrMemoLineG.FIELDCAPTION("VAT %"))
                        {
                        }
                        column(WithoutVATLbl; WithoutVATLbl)
                        {
                        }
                        dataitem(Vehicle; Vehicle)
                        {
                            DataItemTableView = SORTING(VIN);
                            column(Sales_Cr_Memo_Line__VIN; SalesCrMemoLineG.VIN)
                            {
                            }
                            column(Sales_Cr_Memo_Line___License_No__; SalesCrMemoLineG."License No.")
                            {
                            }
                            column(Sales_Cr_Memo_Line__Mileage; SalesCrMemoLineG.Mileage)
                            {
                            }
                            column(Vehicle__Registration_Certificate_; "Registration Certificate")
                            {
                            }
                            column(Sales_Cr_Memo_Line___Registration_Date_; FORMAT(SalesCrMemoLineG."Registration Date"))
                            {
                                Description = 'PA033336';
                            }
                            column(FORMAT__Sales_Cr_Memo_Line___Vehicle_Status__; FORMAT(SalesCrMemoLineG."Vehicle Status"))
                            {
                            }
                            column(Sales_Cr_Memo_Line__Type_Control1101360896; SalesCrMemoLineG.Type)
                            {
                                Description = 'PA033336';
                            }
                            column(OptionFound_Control1101360899; OptionFoundG)
                            {
                                Description = 'PA033336';
                            }
                            column(PrintOptionHelp; PrintOptionHelpG)
                            {
                                Description = 'PA033336';
                            }
                            column(Sales_Cr_Memo_Line___Item_Type__Control1101360903; SalesCrMemoLineG."Item Type")
                            {
                                Description = 'PA033336';
                            }
                            column(PrintOptionHelp6G; PrintOptionHelp6G)
                            {
                                Description = 'PA033336';
                            }
                            column(Cust__Regis__Date_Caption; Cust__Regis__Date_CaptionLbl)
                            {
                            }
                            column(Mileage_Caption; Mileage_CaptionLbl)
                            {
                            }
                            column(License_No__Caption; License_No__CaptionLbl)
                            {
                            }
                            column(Vehicle_Paper_Number_Caption; Vehicle_Paper_Number_CaptionLbl)
                            {
                            }
                            column(VIN_Caption; VIN_CaptionLbl)
                            {
                            }
                            column(Vehicle_Status_Caption; Vehicle_Status_CaptionLbl)
                            {
                            }
                            column(Vehicle_VIN; VIN)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start PA035597
                                PrintOptionHelp6G := (PrintOption2G <> PrintOption2G::"2");
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(VIN, SalesCrMemoLineG.VIN);
                            end;
                        }
                        dataitem("Optn Var. Vehicle"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(2), Type = CONST(Vehicle));
                            column(VehicleDescription_Control133; VehicleDescriptionG)
                            {
                            }
                            column(Optn_Var__Vehicle_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control141; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPct_Control148; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmount_Control149; DspAmountG)
                            {
                                AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(Sales_Cr_Memo_Line___No___Control153; SalesCrMemoLineG."No.")
                            {
                            }
                            column(Collective_TextShowOutput__Sales_Cr_Memo_Line___Unit_of_Measure__ShowUnitsofMeasure__Control190; CollectiveG.TextShowOutput(SalesCrMemoLineG."Unit of Measure", ShowUnitsOfMeasureFieldG))
                            {
                            }
                            column(Sales_Cr_Memo_Line___VAT_Identifier__Control1109400018; SalesCrMemoLineG."VAT Identifier")
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(OptVariantTypeG; OptVariantTypeG)
                            {
                                Description = 'PA033336';
                            }
                            column(Sales_Cr_Memo_Line___License_No___Control115; SalesCrMemoLineG."License No.")
                            {
                            }
                            column(Sales_Cr_Memo_Line__Mileage_Control116; SalesCrMemoLineG.Mileage)
                            {
                            }
                            column(Sales_Cr_Memo_Line___Registration_Date__Control117; FORMAT(SalesCrMemoLineG."Registration Date"))
                            {
                                Description = 'PA033336';
                            }
                            column(Vehicle__Registration_Certificate__Control121; Vehicle."Registration Certificate")
                            {
                            }
                            column(Sales_Cr_Memo_Line__VIN_Control122; SalesCrMemoLineG.VIN)
                            {
                            }
                            column(FORMAT__Sales_Cr_Memo_Line___Vehicle_Status___Control163; FORMAT(SalesCrMemoLineG."Vehicle Status"))
                            {
                            }
                            column(Type; Type)
                            {
                                Description = 'PA033336';
                            }
                            column(Sales_Cr_Memo_Line___Item_Type__Control1101360900; SalesCrMemoLineG."Item Type")
                            {
                                Description = 'PA033336';
                            }
                            column(Sales_Cr_Memo_Line__Type_Control1101360902; SalesCrMemoLineG.Type)
                            {
                                Description = 'PA033336';
                            }
                            column(PrintOptionHelp_Control1101360904; PrintOptionHelpG)
                            {
                                Description = 'PA033336';
                            }
                            column(PrintOptionHelp2G; PrintOptionHelp2G)
                            {
                                Description = 'PA033336';
                            }
                            column(VIN_Caption_Control123; VIN_Caption_Control123Lbl)
                            {
                            }
                            column(License_No__Caption_Control124; License_No__Caption_Control124Lbl)
                            {
                            }
                            column(Mileage_Caption_Control125; Mileage_Caption_Control125Lbl)
                            {
                            }
                            column(Vehicle_Paper_Number_Caption_Control126; Vehicle_Paper_Number_Caption_Control126Lbl)
                            {
                            }
                            column(Cust__Regis__Date_Caption_Control127; Cust__Regis__Date_Caption_Control127Lbl)
                            {
                            }
                            column(Vehicle_Status_Caption_Control165; Vehicle_Status_Caption_Control165Lbl)
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
                                // Start PA035597
                                PrintOptionHelp2G := (PrintOption2G <> PrintOption2G::"2");

                                ShowSalPriceG := 0;
                                ShowLineDiscPctG := 0;
                                CASE SalesCrMemoLineG."VAT Calculation Type" OF
                                    SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax":
                                        DspAmountG := getSalPrice(SalesCrMemoLineG, 1);
                                    ELSE BEGIN
                                        IF DoNotPrintVATG THEN
                                            DspAmountG := getSalPrice(SalesCrMemoLineG, 1)
                                        ELSE
                                            DspAmountG := getSalPrice(SalesCrMemoLineG, 2) + getLineDiscPct(SalesCrMemoLineG, 2);
                                        IF PrintDiscG THEN BEGIN
                                            ShowSalPriceG := getSalPrice(SalesCrMemoLineG, 0);
                                            ShowLineDiscPctG := getLineDiscPct(SalesCrMemoLineG, 0);
                                            IF (ShowSalPriceG <> 0) THEN BEGIN
                                                IF DoNotPrintVATG THEN
                                                    DspAmountG := getSalPrice(SalesCrMemoLineG, 1) + getLineDiscPct(SalesCrMemoLineG, 1);
                                                ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                            END;
                                        END;
                                    END;
                                END;

                                VehicleDescriptionG := SalesCrMemoLineG."Shortcut Dimension 2 Code" + ' ' + SalesCrMemoLineG.Description;
                                OptVariantTypeG := "Optn Var. Vehicle".Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesCrMemoLineG."Document No.");
                                SETRANGE("Document Line No.", SalesCrMemoLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Color"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(2));
                            column(Optn_Var__Color_Description; Description)
                            {
                            }
                            column(Optn_Var__Color_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control142; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPct_Control144; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmount_Control157; DspAmountG)
                            {
                                AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(Optn_Var__Color__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Optn_Var__Vehicle___Series_Option_; "Series Option")
                            {
                                Description = 'PA033336';
                            }
                            column(Optn_Var__Color__Type; "Optn Var. Color".Type)
                            {
                                Description = 'PA033336';
                            }
                            column(PrintOptionHelp3G; PrintOptionHelp3G)
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
                            column(Optn_Var__Color__Description_2__Control216; "Description 2")
                            {
                            }
                            column(CurrentVehicle_Control91; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
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
                                    IF (DoNotPrintVATG) OR
                                       (SalesCrMemoLineG."VAT Calculation Type" = SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax")
                                    THEN BEGIN
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                           ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOption2G <> PrintOption2G::"2")
                                        THEN BEGIN
                                            SumMfgOptG += "Amount Including VAT";
                                            SumVehicleG -= "Amount Including VAT";
                                        END ELSE
                                            SumMfgOptG += 0
                                    END ELSE BEGIN
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                           ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOption2G <> PrintOption2G::"2")
                                        THEN BEGIN
                                            SumMfgOptG += Amount;
                                            SumVehicleG -= Amount;
                                        END ELSE
                                            SumMfgOptG += 0
                                    END;
                                END;
                                // Start PA035597
                                PrintOptionHelp3G := (PrintOption2G = PrintOption2G::"1") OR
                                  ((PrintOption2G = PrintOption2G::"0") AND "Optn Var. Color"."Print Option Line");
                                PrintUnitPriceHelpG := FunctionPrintUnitPriceOVC;
                                CalcValues("Optn Var. Color");
                                IF NOT PrintUnitPriceHelpG THEN
                                    DspAmountG := 0;
                                OptVariantType2G := "Optn Var. Color".Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Option Type", "Option Type"::Color, "Option Type"::Upholstery);
                                SETRANGE("Document No.", SalesCrMemoLineG."Document No.");
                                SETRANGE("Document Line No.", SalesCrMemoLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Series"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(2), "Series Option" = CONST(true), "Option Type" = CONST(Option));
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
                            column(Optn_Var__Series_Type; Type)
                            {
                                Description = 'PA033336';
                            }
                            column(PrintOptionHelp4G; PrintOptionHelp4G)
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
                                AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
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
                                IF Type = Type::"Manuf. Option" THEN BEGIN
                                    IF DoNotPrintVATG THEN BEGIN
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                           ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOption2G <> PrintOption2G::"2")
                                        THEN BEGIN
                                            SumMfgOptG += "Amount Including VAT";
                                            SumVehicleG -= "Amount Including VAT";
                                        END ELSE
                                            SumMfgOptG += 0
                                    END ELSE
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                            ("Option Variant"."Print Option Line") OR
                                            (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                            ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND "Option Variant"."Print Unit Price") AND
                                            (PrintOption2G <> PrintOption2G::"2")
                                        THEN BEGIN
                                            SumMfgOptG += Amount;
                                            SumVehicleG -= Amount;
                                        END ELSE
                                            SumMfgOptG += 0
                                END;
                                // Start PA035597
                                PrintOptionHelp4G := (PrintOption2G = PrintOption2G::"1") OR
                                ((PrintOption2G = PrintOption2G::"0") AND "Optn Var. Series"."Print Option Line");
                                OptVariantType3G := "Optn Var. Series".Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesCrMemoLineG."Document No.");
                                SETRANGE("Document Line No.", SalesCrMemoLineG."Line No.");
                            end;
                        }
                        dataitem("Option Variant"; "Posted Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST(2), "Series Option" = CONST(false), "Option Type" = CONST(Option));
                            column(Option_Variant_Description; Description)
                            {
                            }
                            column(Option_Variant_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control171; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPct_Control172; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmount_Control175; DspAmountG)
                            {
                                AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(Option_Variant__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Option_Variant_Type; Type)
                            {
                                Description = 'PA033336';
                            }
                            column(PrintOptionHelp5G; PrintOptionHelp5G)
                            {
                                Description = 'PA033336';
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
                                AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
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
                                IF Type = Type::"Manuf. Option" THEN
                                    IF (DoNotPrintVATG) OR
                                       (SalesCrMemoLineG."VAT Calculation Type" = SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax")
                                    THEN BEGIN
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                           ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOption2G <> PrintOption2G::"2")
                                        THEN BEGIN
                                            SumMfgOptG += "Amount Including VAT";
                                            SumVehicleG -= "Amount Including VAT";
                                        END ELSE
                                            SumMfgOptG += 0
                                    END ELSE
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                           ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOption2G <> PrintOption2G::"2")
                                        THEN BEGIN
                                            SumMfgOptG += Amount;
                                            SumVehicleG -= Amount;
                                        END;
                                // Start PA035597
                                PrintOptionHelp5G := (PrintOption2G = PrintOption2G::"1") OR
                                  ((PrintOption2G = PrintOption2G::"0") AND "Option Variant"."Print Option Line");

                                PrintUnitPriceHelpG := FunctionPrintUnitPriceOVC;

                                CalcValues("Option Variant");

                                IF NOT PrintUnitPriceHelpG THEN
                                    DspAmountG := 0;
                                OptVariantType4G := "Option Variant".Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesCrMemoLineG."Document No.");
                                SETRANGE("Document Line No.", SalesCrMemoLineG."Line No.");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Credit Memo Line";
                            T115FncL: Codeunit "ET111,112,113,114,115,6661";
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT SalesCrMemoLineG.FIND('-') THEN BEGIN
                                    SalesCrMemoLineG.SETRANGE("Item Type", SalesCrMemoLineG."Item Type"::Item);
                                    SalesCrMemoLineG.FIND('-');
                                END;
                                VINOldG := SalesCrMemoLineG.VIN;
                            END ELSE
                                IF SalesCrMemoLineG.NEXT = 0 THEN BEGIN
                                    SalesCrMemoLineG.SETRANGE("Item Type", SalesCrMemoLineG."Item Type"::Item);
                                    SalesCrMemoLineG.FIND('-');
                                END;

                            // Check if Option is available
                            PostedOptionVariantsG.SETRANGE(Area, PostedOptionVariantsG.Area::Sale);
                            PostedOptionVariantsG.SETRANGE("Document Type", PostedOptionVariantsG."Document Type"::"2");
                            PostedOptionVariantsG.SETRANGE("Document No.", SalesCrMemoLineG."Document No.");
                            PostedOptionVariantsG.SETRANGE("Document Line No.", SalesCrMemoLineG."Line No.");
                            OptionFoundG := PostedOptionVariantsG.FIND('-');


                            IF SalesCrMemoLineG."VAT Calculation Type" <> SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax" THEN BEGIN
                                //Start API.1.0.2
                                T115FncL.T115_CalcPrintVATAmtLines(SalesCrMemoLineG, VATAmountLineG, VATPctG, ExchTaxPctG);
                                //  VATAmountLineG.INIT;
                                // // Start PA033011.5983155
                                //  VATAmountLineG."VAT Identifier" := FORMAT(SalesCrMemoLineG."VAT %");
                                //  VATAmountLineG."Sales Amount" := SalesCrMemoLineG.Amount;
                                // // Stop PA033011.5983155
                                //  VATAmountLineG."VAT %" := SalesCrMemoLineG."VAT %";
                                //  VATAmountLineG."VAT Base" := SalesCrMemoLineG.Amount;
                                //  VATAmountLineG."Amount Including VAT" := SalesCrMemoLineG."Amount Including VAT";
                                // // Start PA037665
                                //  VATAmountLineG."VAT Clause Code" := SalesCrMemoLineG."VAT Clause Code";
                                // // Stop PA037665
                                //  VATAmountLineG.InsertLine
                                //Stop API.1.0.2
                            END;
                            // Start PA040293.57855
                            TotalCurrVatAmtG := TotalCurrVatAmtG + SalesCrMemoLineG."Amount Including VAT";
                            // Stop PA040293.57855
                            IF (DoNotPrintVATG) OR
                               (SalesCrMemoLineG."VAT Calculation Type" = SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax")
                            THEN BEGIN
                                // Start PA033336
                                // Start PA040293.57855
                                // Stop PA040293.57855
                                TotalInvDiscAmtG := TotalInvDiscAmtG + SalesCrMemoLineG."Inv. Discount Amount";
                                // Stop PA033336
                                //Stop API.1.0.2 vapa?

                                IF SalesCrMemoLineG.Type = SalesCrMemoLineG.Type::Item THEN BEGIN
                                    CASE SalesCrMemoLineG."Item Type" OF
                                        SalesCrMemoLineG."Item Type"::Item:
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                               SalesCrMemoLineG."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"2")
                                            THEN
                                                SumOtherG += SalesCrMemoLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesCrMemoLineG."Amount Including VAT";
                                        SalesCrMemoLineG."Item Type"::Vehicle:
                                            SumVehicleG += SalesCrMemoLineG."Amount Including VAT";
                                        SalesCrMemoLineG."Item Type"::"Own Option":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                               SalesCrMemoLineG."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"2")
                                            THEN
                                                SumOwnOptG += SalesCrMemoLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesCrMemoLineG."Amount Including VAT";
                                        SalesCrMemoLineG."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                               SalesCrMemoLineG."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"2")
                                            THEN
                                                SumTransferFeesG += SalesCrMemoLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesCrMemoLineG."Amount Including VAT";
                                    END;
                                END ELSE
                                    IF (SalesCrMemoLineG.Type = SalesCrMemoLineG.Type::"Account (G/L)") OR
                                       (SalesCrMemoLineG.Type = SalesCrMemoLineG.Type::"Charge (Item)")
                                    THEN
                                        IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                           SalesCrMemoLineG."Print Option Line" OR
                                           (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                           ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                           (PrintOption2G <> PrintOption2G::"2")
                                        THEN
                                            SumOtherG += SalesCrMemoLineG."Amount Including VAT"
                                        ELSE
                                            SumVehicleG += SalesCrMemoLineG."Amount Including VAT"
                            END ELSE BEGIN
                                IF SalesCrMemoLineG.Type = SalesCrMemoLineG.Type::Item THEN BEGIN
                                    CASE SalesCrMemoLineG."Item Type" OF
                                        SalesCrMemoLineG."Item Type"::Item:
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                               SalesCrMemoLineG."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"2")
                                            THEN
                                                SumOtherG += SalesCrMemoLineG.Amount
                                            ELSE BEGIN
                                                SumVehicleG += SalesCrMemoLineG.Amount;
                                            END;
                                        SalesCrMemoLineG."Item Type"::Vehicle:
                                            BEGIN
                                                SumVehicleG += SalesCrMemoLineG.Amount + SalesCrMemoLineG."Inv. Discount Amount";
                                                IF SalesCrMemoLineG."VAT Calculation Type" =
                                                   SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax"
                                                THEN
                                                    SumOnlyDiffTaxationG += SalesCrMemoLineG.Amount;
                                            END;
                                        SalesCrMemoLineG."Item Type"::"Own Option":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                               SalesCrMemoLineG."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"2")
                                            THEN
                                                SumOwnOptG += SalesCrMemoLineG.Amount
                                            ELSE
                                                SumVehicleG += SalesCrMemoLineG.Amount;
                                        SalesCrMemoLineG."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                               SalesCrMemoLineG."Print Option Line" OR
                                               (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                               ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                               (PrintOption2G <> PrintOption2G::"2")
                                            THEN
                                                SumTransferFeesG += SalesCrMemoLineG.Amount
                                            ELSE
                                                SumVehicleG += SalesCrMemoLineG.Amount;
                                    END;
                                END ELSE
                                    IF (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"0") AND
                                       SalesCrMemoLineG."Print Option Line" OR
                                       (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND (PrintOption2G = PrintOption2G::"1") OR
                                       ((PrintUnitPrice2G = PrintUnitPrice2G::"0") AND SalesCrMemoLineG."Print Unit Price") AND
                                       (PrintOption2G <> PrintOption2G::"2")
                                    THEN
                                        SumOtherG += SalesCrMemoLineG.Amount
                                    ELSE
                                        SumVehicleG += SalesCrMemoLineG.Amount;
                                // Start PA033336
                                // Start PA040293.57855
                                // Stop PA040293.57855
                                TotalInvDiscAmtG := TotalInvDiscAmtG + SalesCrMemoLineG."Inv. Discount Amount";
                                // Stop PA033336
                            END;

                            IF (SalesCrMemoLineG.Type <> SalesCrMemoLineG.Type::" ") AND
                               ((SalesCrMemoLineG.Amount <> 0) OR (SalesCrMemoLineG."Amount Including VAT" <> 0))
                            THEN BEGIN
                                TotalsLineL.RESET;
                                TotalsLineL.SETCURRENTKEY("Document No.", Type, "No.");
                                TotalsLineL.SETRANGE("Document No.", SalesCrMemoLineG."Document No.");
                                TotalsLineL.SETRANGE(Type, SalesCrMemoLineG.Type);
                                TotalsLineL.SETRANGE("No.", SalesCrMemoLineG."No.");
                                TotalsLineL.CALCSUMS(Amount, "Amount Including VAT");
                                IF (TotalsLineL.Amount = 0) AND (TotalsLineL."Amount Including VAT" = 0) THEN
                                    CurrReport.SKIP;
                            END;
                            // Start PA033042
                            IF SalesCrMemoLineG."VAT Identifier" <> '' THEN
                                IF NOT VATIdentifierTempG.GET(SalesCrMemoLineG."VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := SalesCrMemoLineG."VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042

                            // Start PA035597
                            PrintOptionHelpG := (PrintOption2G = PrintOption2G::"1") OR
                              ((PrintOption2G = PrintOption2G::"0") AND SalesCrMemoLineG."Print Option Line");
                            PrintUnitPriceHelpG := FunctionPrintUnitPrice;

                            ShowSalPriceG := 0;
                            ShowLineDiscPctG := 0;
                            CASE SalesCrMemoLineG."VAT Calculation Type" OF
                                SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax":
                                    DspAmountG := getSalPrice(SalesCrMemoLineG, 1);
                                ELSE BEGIN
                                    IF DoNotPrintVATG THEN
                                        DspAmountG := getSalPrice(SalesCrMemoLineG, 1)
                                    ELSE
                                        DspAmountG := getSalPrice(SalesCrMemoLineG, 2) + getLineDiscPct(SalesCrMemoLineG, 2);
                                    IF PrintDiscG THEN BEGIN
                                        ShowSalPriceG := getSalPrice(SalesCrMemoLineG, 0);
                                        ShowLineDiscPctG := getLineDiscPct(SalesCrMemoLineG, 0);
                                        IF (ShowSalPriceG <> 0) THEN BEGIN
                                            IF DoNotPrintVATG THEN
                                                DspAmountG := getSalPrice(SalesCrMemoLineG, 1) + getLineDiscPct(SalesCrMemoLineG, 1);
                                            ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                        END;
                                    END;
                                END;
                            END;

                            VehicleDescriptionG := SalesCrMemoLineG."Shortcut Dimension 2 Code" + ' ' + SalesCrMemoLineG.Description;
                            SalesCrMemoLineTypeG := SalesCrMemoLineG.Type;
                            SalesCrMemoLineItemTypeG := SalesCrMemoLineG."Item Type";
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
                            IF DoNotPrintVATG THEN BEGIN
                                TotalL := 0;
                                // Start PA040256.57127
                                TotalL += ROUND(SumVehicleG, AmountRoundPrecisionG);
                                TotalL += ROUND(SumMfgOptG, AmountRoundPrecisionG);
                                TotalL += ROUND(SumOwnOptG, AmountRoundPrecisionG);
                                TotalL += ROUND(SumTransferFeesG, AmountRoundPrecisionG);
                                TotalL += ROUND(SumChargeItemsG, AmountRoundPrecisionG);
                                TotalL += ROUND(SumOtherG, AmountRoundPrecisionG);
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

                                    ArrayL[xL] += (TotalVehicleL - TotalL);

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
                            SalesCredMemoLineL: Record "Sales Credit Memo Line";
                        begin
                            VATAmountLineG.DELETEALL;

                            SalesCrMemoLineG.RESET;
                            SalesCrMemoLineG.SETRANGE("Document No.", "Sales Credit Memo Header"."No.");
                            MoreLinesG := SalesCrMemoLineG.FIND('+');
                            WHILE MoreLinesG AND (SalesCrMemoLineG.Description = '') AND
                               (SalesCrMemoLineG."No." = '') AND (SalesCrMemoLineG.Quantity = 0) AND
                               (SalesCrMemoLineG.Amount = 0)
                            DO
                                MoreLinesG := SalesCrMemoLineG.NEXT(-1) <> 0;

                            IF NOT MoreLinesG THEN
                                CurrReport.BREAK;

                            SalesCrMemoLineG.SETRANGE("Line No.", 0, SalesCrMemoLineG."Line No.");

                            SETRANGE(Number, 1, SalesCrMemoLineG.COUNT);

                            SalesCrMemoLineG.SETFILTER("Item Type", '<>%1', SalesCrMemoLineG."Item Type"::Item);
                            CurrReport.CREATETOTALS(SalesCrMemoLineG.Amount, SalesCrMemoLineG."Amount Including VAT");
                            SalesCredMemoLineL.RESET;
                            SalesCredMemoLineL.SETRANGE("Document No.", "Sales Credit Memo Header"."No.");
                            NormalVATTotalG := 0;
                            SumwithDiffTaxationG := 0;
                            SumOnlyDiffTaxationG := 0;
                            IF SalesCredMemoLineL.FIND('-') THEN
                                REPEAT
                                    IF SalesCredMemoLineL."VAT Calculation Type" = SalesCredMemoLineL."VAT Calculation Type"::"Differential Tax" THEN BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesCredMemoLineL."Amount Including VAT";
                                        SumOnlyDiffTaxationG := SumOnlyDiffTaxationG + SalesCredMemoLineL."Amount Including VAT";
                                    END ELSE BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesCredMemoLineL.Amount;
                                        NormalVATTotalG := NormalVATTotalG + (SalesCredMemoLineL."Amount Including VAT" - SalesCredMemoLineL.Amount)
                                    END;
                                UNTIL SalesCredMemoLineL.NEXT = 0;

                            // Start PA033336
                            TotalCurrVatAmtG := 0;
                            TotalInvDiscAmtG := 0;
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
                        column(ShowCurrency_Control38; ShowCurrencyG)
                        {
                        }
                        column(SumwithDiffTaxationG_Control44; SumwithDiffTaxationG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalCurrVatAmt1G; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(DoNotShowVAT_Control1101338963; DoNotPrintVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(ShowCurrency_Control1101338964; ShowCurrencyG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control108; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Amount_Including_VAT____VATAmountLine__VAT_Base_; VATAmountLineG."Amount Including VAT" - VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine_COUNT2G; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base__Control112; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control113; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control48; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT__Control51; SalesCrMemoLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SumOnlyDiffTaxationG_Control227; SumOnlyDiffTaxationG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control213; TotalCaption_Control213Lbl)
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
                        column(of_these_diff__taxation_Caption_Control226; of_these_diff__taxation_Caption_Control226Lbl)
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
                            //CurrReport.CREATETOTALS(VATAmountLineG."VAT Base",VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Posted Sales Trade-In"; "Posted Sales Trade-In")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Credit Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.") WHERE("Document Type" = FILTER(Invoice | Order | "Credit Memo"));
                        column(TotalCurrVatAmt2G; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumChargeItems1G; SumChargeItemsG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumOwnOpt1G; SumOwnOptG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalInvDiscAmt1G; TotalInvDiscAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumVehicle1G; SumVehicleG)
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
                        column(SumTransferFees2G; SumTransferFeesG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalTradeIn; TotalTradeInG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line___Amount_Including_VAT____TotalTradeIn; SalesCrMemoLineG."Amount Including VAT" - TotalTradeInG)
                        {
                            AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowCurrency_Control75; ShowCurrencyG)
                        {
                        }
                        column(Trade_Ins_Caption; Trade_Ins_CaptionLbl)
                        {
                        }
                        column(Sum_Trade_InCaption; Sum_Trade_InCaptionLbl)
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
                                AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
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
                            PurchCrMemoHdrL: Record "Purch. Credit Memo Header";
                            PurchCrMemoLineL: Record "Purch. Credit Memo Line";
                        begin
                            IF PrintTradeInExtraG AND
                               NOT CurrReport.PREVIEW
                            THEN BEGIN
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
                            PurchCrMemoLineL.RESET;
                            PurchCrMemoLineL.SETRANGE("Document No.", "Posted Purch. Cr. Memo No.");
                            // Start PA041187.87656
                            PurchCrMemoLineL.SETRANGE("Line No.", "Posted Purch. CM Line No.");
                            // Stop PA041187.87656
                            // Start PA042846
                            IF PurchCrMemoLineL.FINDFIRST THEN BEGIN
                                // Stop PA042846
                                // Start PA041187.87656
                                // Stop PA041187.87656
                                VINTotalTradeInG := PurchCrMemoLineL."Amount Including VAT";
                                // Start PA042846
                            END ELSE
                                VINTotalTradeInG := "Posted Sales Trade-In"."Unit Cost Incl. VAT (LCY)";
                            // Stop PA042846
                            // Stop PA040293.57855
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS("Unit Cost Incl. VAT (LCY)");
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
                    dataitem(ShipmentFooter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        dataitem(ShipmentFooter2; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            dataitem(ShipmentFooter3; "Integer")
                            {
                                DataItemTableView = SORTING(Number);
                                column(DataItem1109400011; C_INC035 + ' ' + FORMAT(DATE2DMY(FirstDateG, 2)) + '/' + FORMAT(DATE2DMY(FirstDateG, 3)) + ' ' + C_INC036 + ' ' + VINTextG + ' :')
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
                                VINTextG := RetRcptLineT2G.VIN;
                                RetRcptLineTG.RESET;
                                RetRcptLineTG.SETFILTER("Posting Date", '%1..%2', FirstDateG, LastDateG);
                                RetRcptLineTG.SETRANGE(VIN, RetRcptLineT2G.VIN);
                                RetRcptLineT3G.RESET;
                                RetRcptLineT3G.DELETEALL;

                                IF RetRcptLineTG.FIND('-') THEN
                                    REPEAT
                                        RetRcptLineT3G.RESET;
                                        RetRcptLineT3G.SETRANGE(RetRcptLineT3G."Item Type", RetRcptLineTG."Item Type");
                                        RetRcptLineT3G.SETRANGE(RetRcptLineT3G."No.", RetRcptLineTG."No.");
                                        IF RetRcptLineT3G.FIND('-') THEN BEGIN
                                            RetRcptLineT3G."Closing Credited Quantity" := RetRcptLineT3G."Closing Credited Quantity" +
                                              RetRcptLineTG."Closing Credited Quantity";
                                            RetRcptLineT3G.MODIFY;
                                        END ELSE BEGIN
                                            RetRcptLineT3G.RESET;
                                            RetRcptLineT3G.INIT;
                                            RetRcptLineT3G.TRANSFERFIELDS(RetRcptLineTG);
                                            RetRcptLineT3G.INSERT;
                                        END;
                                    UNTIL RetRcptLineTG.NEXT = 0;

                                StanTextG.RESET;
                                StanTextG.DELETEALL;
                                StanText2G.RESET;
                                StanText2G.DELETEALL;
                                DescriptionG := '';

                                IF RetRcptLineT3G.FIND('-') THEN
                                    REPEAT
                                        IF DescriptionG = '' THEN
                                            DescriptionG := FORMAT(RetRcptLineT3G."Item Type") + ' ' + RetRcptLineT3G."No." + ' ' +
                                              RetRcptLineT3G."Unit of Measure Code" + ' ' + FORMAT(RetRcptLineT3G."Closing Credited Quantity")
                                        ELSE
                                            DescriptionG := ' / ' + FORMAT(RetRcptLineT3G."Item Type") + ' ' + RetRcptLineT3G."No." + ' ' +
                                              RetRcptLineT3G."Unit of Measure Code" + ' ' + FORMAT(RetRcptLineT3G."Closing Credited Quantity");
                                        StanTextG.RESET;
                                        StanTextG.SETRANGE(StanTextG.Code, '10000', '19999');
                                        StanText2G.RESET;
                                        StanText2G.SETRANGE(StanText2G.Code, '20000', '29999');
                                        IF StanTextG.FIND('+') THEN BEGIN
                                            StanText2G.FIND('+');
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
                                    UNTIL RetRcptLineT3G.NEXT = 0;

                                RetRcptLineT2G.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                RetRcptLineT2G.RESET;
                                RetRcptLineT2G.DELETEALL;
                                IF NOT ((DATE2DMY(LastDateG, 2) = DATE2DMY("Sales Credit Memo Header"."Main Shipment Date", 2)) AND
                                   (DATE2DMY(LastDateG, 3) = DATE2DMY("Sales Credit Memo Header"."Main Shipment Date", 3)))
                                THEN BEGIN
                                    IF RetRcptLineTG.FIND('-') THEN
                                        REPEAT
                                            RetRcptLineT2G.RESET;
                                            RetRcptLineT2G.SETRANGE(VIN, RetRcptLineTG.VIN);
                                            IF NOT RetRcptLineT2G.FIND('-') THEN BEGIN
                                                RetRcptLineT2G.RESET;
                                                RetRcptLineT2G.INIT;
                                                RetRcptLineT2G.TRANSFERFIELDS(RetRcptLineTG);
                                                RetRcptLineT2G.INSERT;
                                            END;
                                        UNTIL RetRcptLineTG.NEXT = 0;
                                END;
                                IF RetRcptLineT2G.FIND('-') THEN
                                    SETRANGE(Number, 1, RetRcptLineT2G.COUNT)
                                ELSE
                                    SETRANGE(Number, 1, 0);
                                // StopPA023142
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

                            IF NOT ((DATE2DMY(LastDateG, 2) = DATE2DMY("Sales Credit Memo Header"."Main Shipment Date", 2))
                               AND (DATE2DMY(LastDateG, 3) = DATE2DMY("Sales Credit Memo Header"."Main Shipment Date", 3)))
                            THEN BEGIN
                                RetRcptLineTG.RESET;
                                RetRcptLineTG.SETFILTER("Posting Date", '%1..%2', FirstDateG, LastDateG);
                            END ELSE BEGIN
                                EXIT;
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
                                    FirstDateG := CALCDATE('<CM + 1D - 1M>', "Sales Credit Memo Header"."First Shipment Date")
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
                            column(Posted_Cash_Register_Header___Currency_Code__Control199; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Currency_Code__Control200; "Posted Cash Register Header"."Currency Code")
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
                            THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(DiffTaxText; "Posted Sales Doc DiffTaxText")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Credit Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Entry No.") WHERE("Document Type" = CONST(2));
                        column(DiffTaxText_Text; Text)
                        {
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
                    dataitem(HeaderFooterText; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Credit Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Footer));
                        column(HeaderFooterText_Text; Text)
                        {
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
                        IF PrintFooterLineBlockG THEN
                            PageLoopFooterG := 1;
                        // Stop PA035597
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

                    ShowDuplicateImageG := FALSE; //API.1.0.2  07.06.18 PV
                    IF ("Sales Credit Memo Header"."No. Printed" > 0) AND NOT RePrintOriginalInvoiceG THEN BEGIN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC001
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV
                    // Stop PA033336

                    TotalVehG := 0;
                    SumVehicleG := 0;
                    //SumTotVehicleG := 0;
                    SumOwnOptG := 0;
                    SumMfgOptG := 0;
                    SumTransferFeesG := 0;
                    SumOtherG := 0;
                    TotalTradeInG := 0;
                    CurrentVehicleG := 0;
                    // Start PA035597
                    // Stop PA035597
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032178
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrintedG.RUN("Sales Credit Memo Header");
                    // Stop PA032727
                    // Stop PA032178
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

                    // Start PA035597
                    OutputNoG := 1;
                    // Stop PA035597

                    SETRANGE(Number, 1, NoOfLoopsG);
                end;
            }

            trigger OnAfterGetRecord()
            var
                InteractionLogL: Record "Interaction Log Entry";
                IntCustL: Code[20];
                bankAccountL: Record "Bank Account";
                salesInvoiceHeaderL: Record "Sales Invoice Header";
                T115FncL: Codeunit "ET111,112,113,114,115,6661";
            begin
                //Start API.1      22.03.18 KV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1       22.03.18 KV

                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                CLEAR(VehicleReportSelectionG);
                IsRepSelectionSetupAvailableG := VehicleReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Vehicle Sales Credit Memo"); //API.1      20.03.18 KV
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN BEGIN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                END;
                // Stop PA035395.18593

                //Start API.1      22.03.18 KV
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
                //Stop API.1       22.03.18 KV

                // Start PA040256.57127
                AmountRoundPrecisionG := CurrencyG.GetAmountRoundingPrecision("Currency Code");
                // Stop PA040256.57127

                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                CurrReport.LANGUAGE := BillToCustG.PrintDocInCustLanguage();
                PrintDiscG := "Sales Credit Memo Header"."Show Discount";

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
                    FormatAddrG.OwnAddressLetterWindow(CoAddrSenderLineG, OwnDelivAddressG);
                END ELSE BEGIN
                    FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
                    FormatAddrG.CompanyLetterAddressWindow(CoAddrSenderLineG, CompanyInfoG);
                END;
                IF PrintSentFromLineBlockG THEN
                    CompAddrG := FormatAddrG.GetWindowAddress(C_INC005);

                IF PrintAddressBlockG THEN BEGIN
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
                //   OwnBanksG.GET(IntCustL, LocationG."Bank Code")
                // THEN BEGIN // Start API.1      22.03.18 KV
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // Stop API.1      22.03.18 KV
                //  BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                // END // Start API.1      22.03.18 KV
                // ELSE
                //  BEGIN
                //    BankNameG := CompanyInfoG."Bank Name";
                //    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                //    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                //    BankIbanG := CompanyInfoG.IBAN;
                //    BankAccountNoG := CompanyInfoG."Bank Account No.";
                //    // Stop API.1      22.03.18 KV
                //  BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                // END; // API.1      22.03.18 KV
                //Start API.1.0.2  07.06.18 PV

                // Start PA038229
                SalesCrMemoLine2G.RESET;
                SalesCrMemoLine2G.SETRANGE("Document No.", "Sales Credit Memo Header"."No.");
                SalesCrMemoLine2G.SETRANGE("Item Type", SalesCrMemoLine2G."Item Type"::Vehicle);
                // Start PA038229.41923
                HideVehicleMainInfoG := SalesCrMemoLine2G.ISEMPTY;
                // Stop PA038229.41923
                ShowManyVehiclesG := SalesCrMemoLine2G.COUNT > 1;
                CLEAR(MainNextAppDateG);
                CLEAR(EmissionNextAppDateG);
                IF NOT ShowManyVehiclesG AND SalesCrMemoLine2G.FINDFIRST THEN BEGIN
                    IF VehicleG.GET(SalesCrMemoLine2G.VIN) THEN BEGIN
                        MainNextAppDateG := GetNextApptDate(1, "Sales Credit Memo Header"."Document Date");
                        EmissionNextAppDateG := GetNextApptDate(2, "Sales Credit Memo Header"."Document Date");
                    END;
                END;
                // Stop PA038229

                SalesCrMemoLineG.RESET;
                SalesCrMemoLineG.SETRANGE("Document No.", "Sales Credit Memo Header"."No.");
                SalesCrMemoLineG.SETRANGE("VAT Calculation Type", SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax");
                IF SalesCrMemoLineG.FIND('-') THEN BEGIN
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
                FormatAddrG.SalesCrMemoBillTo(CustAddrG, "Sales Credit Memo Header");
                IF CustG.GET("Bill-to Customer No.") THEN
                    ;

                // Start API.1      22.03.18 KV
                IF NOT PaymentMethodG.GET("Sales Credit Memo Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // Stop API.1       22.03.18 KV

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipMethodG.INIT
                ELSE
                    ShipMethodG.GET("Shipment Method Code");

                FormatAddrG.SalesCrMemoShipTo(ShipToAddrG, "Sales Credit Memo Header");
                /*ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;*/

                IF AddressSalutationG.GET("Sales Credit Memo Header"."Bill-to Salutation Code") THEN
                    SalesAddrSaluationG := AddressSalutationG."Document Salutation";
                IF "Sales Credit Memo Header"."Sell-to Customer No." <> "Sales Credit Memo Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesCrMemoCust(OrderCustAddrG, "Sales Credit Memo Header");
                    OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';

                IF PrintDiscG THEN BEGIN
                    DiscCheckSalLineG.SETRANGE("Document No.", "No.");
                    DiscCheckSalLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckSalLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';
                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(31) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::VeSaleCrM,
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
                    ShipTextG := C_INC033
                ELSE
                    ShipTextG := C_INC034;

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
                    field("Print Option"; PrintOption2G)
                    {
                        Caption = 'Print Option';
                        OptionCaption = 'print selected lines,print all lines,print no lines';
                    }
                    field(PrintUnitPrice; PrintUnitPrice2G)
                    {
                        Caption = 'Print Unit Price';
                        OptionCaption = 'print selected prices,print all prices,print no prices,3';

                        trigger OnValidate()
                        begin
                            // Start PA036549.32385
                            PrintNoUnitPriceG := (PrintUnitPrice2G = PrintUnitPrice2G::"2");
                            // Stop PA036549.32385
                        end;
                    }
                    field(ShowUnitsofMeasureG; ShowUnitsOfMeasureFieldG)
                    {
                        Caption = 'Print UoM';
                    }
                    field(DoNotShowVATG; DoNotPrintVATG)
                    {
                        Caption = 'Do Not Show VAT';
                    }
                    field(TradeInExtraG; PrintTradeInExtraG)
                    {
                        Caption = 'Trade-In on own invoice';
                    }
                    field(PrintSentFromLineG; PrintSentFromLineBlockG)
                    {
                        Caption = 'Print Sent-From Line';
                    }
                    field(PrintAddrBlockG; PrintAddressBlockG)
                    {
                        Caption = 'Print Address Block';
                    }
                    field(PrintFooterLineG; PrintFooterLineBlockG)
                    {
                        Caption = 'Print Footer Line';
                    }
                    field(RePrintOriginalInvG; RePrintOriginalInvoiceG)
                    {
                        Caption = 'RePrint Original Invoice';
                    }
                    field(PrintReasonCodeG; PrintReasonCodeFieldG)
                    {
                        Caption = 'Print Reason Code';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA035395.18593
            NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(REPORT::"Vehicle Sales Credit Memo");
            PrintOption2G := PrintOption2G::"0";
            PrintUnitPrice2G := PrintUnitPrice2G::"0";
            PrintDiscG := TRUE;
            VehicleReportSelectionG.SETCURRENTKEY("Report ID");
            VehicleReportSelectionG.SETRANGE("Report ID", REPORT::"Vehicle Sales Credit Memo");
            IF VehicleReportSelectionG.FIND('-') THEN BEGIN
                PrintSentFromLineBlockG := VehicleReportSelectionG."Print Sent-From Line";
                PrintAddressBlockG := VehicleReportSelectionG."Print Address Block";
                // Start PA038229
                PrintFooterLineBlockG := VehicleReportSelectionG."Print Footer Line";
                // Stop PA038229
            END ELSE BEGIN
                PrintSentFromLineBlockG := TRUE;
                PrintAddressBlockG := TRUE;
            END;
            // Start PA039225.51457
            GetReportSelection();
            // Stop PA039225.51457
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
            RePrintOriginalInvoiceG := FALSE;
            // Stop PA035395.18593

            // Start PA033988.I001010
            PrintReasonCodeFieldG := TRUE;
            // Stop PA033988.I001010
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
        // Start PA035395.18593
        CLEARALL();
        // Stop PA035395.18593
        GLSetupG.GET;
        // Start PA032727
        // Start PA039225.51457
        // Start PA035597
        // Stop PA035597
        PrintOption2G := PrintOption2G::"0";
        PrintUnitPrice2G := PrintUnitPrice2G::"0";

        PrintDiscG := TRUE;
        // Start PA033336
        // Stop PA033336

        // Start PA036549.32385
        PrintNoUnitPriceG := FALSE;
        // Stop PA036549.32385

        // Start PA035484.20755
        // Stop PA035484.20755
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        // Stop PA032727
        GetReportSelection();
        // Stop PA039225.51457
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA035597
    end;

    var
        AddressSalutationG: Record "Address Salutation";
        VehicleReportSelectionG: Record "Vehicle Sales Rep. Selection";
        SalesAndReceivSetupG: Record "Sales & Receivables Setup";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        PostedOptionVariantsG: Record "Posted Option Variant";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        DiscCheckSalLineG: Record "Sales Credit Memo Line";
        BillToCustG: Record Customer;
        SalesCrMemoLineG: Record "Sales Credit Memo Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        RetRcptLineG: Record "Return Receipt Line";
        RetRcptLineTG: Record "Return Receipt Line" temporary;
        RetRcptLineT2G: Record "Return Receipt Line" temporary;
        RetRcptLineT3G: Record "Return Receipt Line" temporary;
        SalCrMemoLineG: Record "Sales Credit Memo Line";
        StanTextG: Record "Standard Text" temporary;
        UserSetupG: Record "User Setup";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Vehicle Sales Rep. Selection";
        StanText2G: Record "Standard Text" temporary;
        VATClauseG: Record "VAT Clause";
        VehicleG: Record Vehicle;
        SalesCrMemoLine2G: Record "Sales Credit Memo Line";
        CurrencyG: Record Currency;
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
        SalesCrMemoCountPrintedG: Codeunit "Sales Cr. Memo-Printed";
        RTCMgmtG: Codeunit "RTC Management";
        UserSessionG: Codeunit "User Session Unit";
        ShowCurrencyG: Text[30];
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        OrderCustAddrG: array[8] of Text[50];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        CopyTextG: Text[30];
        ShipToAddrG: array[8] of Text[50];
        CompAddrG: Text[250];
        OrderCustAddrLineG: Text[250];
        VATNoTextG: Text[30];
        DiscTextG: Text[30];
        ReferenceTextG: Text[30];
        TotalInclVATTextG: Text[50];
        SalesAddrSaluationG: Text[30];
        VehicleDescriptionG: Text[100];
        ShipTextG: Text[30];
        ShipDateTextG: Text[10];
        DescriptionG: Text[100];
        VINTextG: Text[30];
        TextG: Text[50];
        DuplicateTextG: Text[30];
        VATLegendsG: Text[15];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        Text2G: Text[50];
        ReportTitleG: Text[100];
        PrintOptionHelpG: Boolean;
        PrintUnitPriceHelpG: Boolean;
        LogInteractionG: Boolean;
        DiffTaxExistsG: Boolean;
        RePrintOriginalInvoiceG: Boolean;
        OptionFoundG: Boolean;
        ShowUnitsOfMeasureFieldG: Boolean;
        PrintTradeInExtraG: Boolean;
        //ShowShippingAddrG: Boolean;
        MoreLinesG: Boolean;
        PrintDiscG: Boolean;
        PrintSentFromLineBlockG: Boolean;
        PrintAddressBlockG: Boolean;
        PrintFooterLineBlockG: Boolean;
        DoNotPrintVATG: Boolean;
        PrintOptionHelp2G: Boolean;
        PrintOptionHelp3G: Boolean;
        PrintOptionHelp4G: Boolean;
        PrintOptionHelp5G: Boolean;
        PrintOptionHelp6G: Boolean;
        PrintReasonCodeFieldG: Boolean;
        [InDataSet]
        PrintNoUnitPriceG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        ShowManyVehiclesG: Boolean;
        HideVehicleMainInfoG: Boolean;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IncrG: Integer;
        [InDataSet]
        OutputNoG: Integer;
        IG: Integer;
        CountG: Integer;
        MaxNoCharsPerLineG: Integer;
        SlNoG: Integer;
        OptVariantTypeG: Integer;
        OptVariantType2G: Integer;
        OptVariantType3G: Integer;
        OptVariantType4G: Integer;
        SalesCrMemoLineTypeG: Integer;
        SalesCrMemoLineItemTypeG: Integer;
        PageLoopFooterG: Integer;
        DspAmountG: Decimal;
        ShowSalPriceG: Decimal;
        ShowLineDiscPctG: Decimal;
        CountTransAmountOldG: Decimal;
        CurrentVehicleG: Decimal;
        AmountMinusDiscG: Decimal;
        TotalVehG: Decimal;
        TotalTradeInG: Decimal;
        SumOwnOptG: Decimal;
        SumVehicleG: Decimal;
        //SumTotVehicleG: Decimal;
        SumMfgOptG: Decimal;
        SumOtherG: Decimal;
        SumChargeItemsG: Decimal;
        SumTransferFeesG: Decimal;
        NormalVATTotalG: Decimal;
        SumwithDiffTaxationG: Decimal;
        SumOnlyDiffTaxationG: Decimal;
        TotalInvDiscAmtG: Decimal;
        TotalCurrVatAmtG: Decimal;
        VINTotalTradeInG: Decimal;
        AmountRoundPrecisionG: Decimal;
        FirstShipDateG: Date;
        LastShipDateG: Date;
        FirstDateG: Date;
        LastDateG: Date;
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        VINOldG: Code[20];
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
        C_INC028: Label 'Series';
        C_INC029: Label 'Copy of';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Tax No.';
        PrintOption2G: Option "0","1","2";
        PrintUnitPrice2G: Option "0","1","2","3";
        C_INC033: Label 'Shipment Date';
        C_INC034: Label 'Dispatch Date';
        C_INC035: Label 'Differing Shipment';
        C_INC036: Label 'for vehicle';
        C_INC037: Label 'Vehicle Sales Credit Memo';
        C_INC038: Label ' =';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        Sales_Credit_Memo_Header___No__CaptionLbl: Label 'Document No.';
        Sales_Credit_Memo_Header___Document_Date_CaptionLbl: Label 'Document Date';
        Sales_Credit_Memo_Header___Applies_to_Doc__No__CaptionLbl: Label 'Applied to';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        SalesPurch_NameCaptionLbl: Label 'Salesperson';
        Application_forCaptionLbl: Label 'Applied to';
        Sales_Credit_Memo_Header___Reason_Code__CaptionLbl: Label 'Reason Code';
        Payments_to_CaptionLbl: Label 'Payments to:';
        DescriptionCaptionLbl: Label 'Description';
        No_CaptionLbl: Label 'No.';
        Qty_CaptionLbl: Label 'Qty.';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        VAT_IdentifierCaptionLbl: Label 'VAT Identifier';
        UoMLbl: Label 'UoM';
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
        Sales_Cr_Memo_Line___Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        of_these_diff__taxation_CaptionLbl: Label '(of these diff. taxation)';
        TotalCaption_Control251Lbl: Label 'Total';
        Cust__Regis__Date_CaptionLbl: Label 'Cust. Regis. Date:';
        Mileage_CaptionLbl: Label 'Mileage:';
        License_No__CaptionLbl: Label 'License No.:';
        Vehicle_Paper_Number_CaptionLbl: Label 'Vehicle Paper Number:';
        VIN_CaptionLbl: Label 'VIN:';
        Vehicle_Status_CaptionLbl: Label 'Vehicle Status:';
        VIN_Caption_Control123Lbl: Label 'VIN:';
        License_No__Caption_Control124Lbl: Label 'License No.:';
        Mileage_Caption_Control125Lbl: Label 'Mileage:';
        Vehicle_Paper_Number_Caption_Control126Lbl: Label 'Vehicle Paper Number:';
        Cust__Regis__Date_Caption_Control127Lbl: Label 'Cust. Regis. Date:';
        Vehicle_Status_Caption_Control165Lbl: Label 'Vehicle Status:';
        CurrentVehicle_Control91CaptionLbl: Label 'Sum carried forward';
        CurrentVehicle_Control60CaptionLbl: Label 'Sum carried forward';
        CurrentVehicle_Control42CaptionLbl: Label 'Sum carried forward';
        TotalCaption_Control213Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        VAT_onCaptionLbl: Label '% VAT of';
        ContinuedCaption_Control111Lbl: Label 'Continued';
        of_these_diff__taxation_Caption_Control226Lbl: Label '(of these diff. taxation)';
        Trade_Ins_CaptionLbl: Label 'Trade-Ins:';
        Sum_Trade_InCaptionLbl: Label 'Sum Trade-In';
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
        MainNextAppDateGLbl: Label 'Inspection Date';
        EmissionNextAppDateGLbl: Label 'Emission Date';
        PurchaseDocumentLbl: Label 'Purchase Document';
        OrderDateLbl: Label 'Order Date';
        ofLbl: Label 'of';
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
        DateOfIssueLbl: Label 'Date of Issue';
        ShowTaxNoG: Boolean;
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        OrderNoLbl: Label 'Order No.';
        MakeCaptionLbl: Label 'Make';
        ReasonCodeG: Record "Reason Code";
        OrderNoG: Code[20];
        TempVATAmountLineG: Record "VAT Amount Line" temporary;
        ExchPartsTaxAmountSumG: Decimal;
        VATPctG: Decimal;
        ExchTaxPctG: Decimal;
        VATIdentLbl: Label 'VAT Recapitulation';
        VATPercentLbl: Label 'VAT %';
        VATBaseLbl: Label 'VAT Base';
        VATAmtLbl: Label 'VAT Amount';
        TotalLbl: Label 'total';
        VATLbl: Label 'VAT';
        ToDateLbl: Label 'to date';
        WithoutVATLbl: Label 'without VAT';
        ExchRateText: Text[50];
        ExchangeRateTextConst: Label 'Exchange Rate %1: %2';

    [Scope('Internal')]
    procedure getSalPrice(SalesLineP: Record "Sales Credit Memo Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Credit Memo Line";
        OptionVariantL: Record "Posted Option Variant";
        SalesPriceL: Decimal;
    begin

        // 0 = "Unit Price"
        // 1 = "Amount Including VAT"
        // 2 = Amount
        // calculate value of vehicle
        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"2");
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

        IF (PrintOption2G <> PrintOption2G::"1") OR (PrintUnitPrice2G <> PrintUnitPrice2G::"1") THEN BEGIN
            // calculate value of options
            IF (PrintOption2G = PrintOption2G::"0") OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
               (PrintOption2G = PrintOption2G::"2")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"2");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"3") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1"))
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

            IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"2");
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

            // calculate value of Sales Lines
            IF (PrintOption2G = PrintOption2G::"0") OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
               (PrintOption2G = PrintOption2G::"2")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0"))
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

            IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") THEN BEGIN
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
    procedure getLineDiscPct(SalesLineP: Record "Sales Credit Memo Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Credit Memo Line";
        OptionVariantL: Record "Posted Option Variant";
        LineDiscPctL: Decimal;
    begin

        // 0 = "Line Discount %"
        // 2 = "Inv. Discount Amount"

        // Fahrzeug-Wert ermitteln
        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"2");
        OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        OptionVariantL.SETRANGE(Type, OptionVariantL.Type::Vehicle);
        IF OptionVariantL.FIND('-') THEN
            CASE ValueTypeP OF
                0:
                    IF (PrintUnitPrice2G <> PrintUnitPrice2G::"2") THEN
                        LineDiscPctL := OptionVariantL."Line Discount %"
                    ELSE
                        LineDiscPctL := SalesLineP."Line Discount %";
                2:
                    LineDiscPctL := 0;
            END
        ELSE
            LineDiscPctL := 0;

        IF (PrintOption2G <> PrintOption2G::"1") OR (PrintUnitPrice2G <> PrintUnitPrice2G::"1") THEN BEGIN

            // calculate values of options
            IF (PrintOption2G = PrintOption2G::"0") OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
               (PrintOption2G = PrintOption2G::"2")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"2");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1"))
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

            IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"2");
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

            // calculate values of Sales Lines
            IF (PrintOption2G = PrintOption2G::"0") OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
               (PrintOption2G = PrintOption2G::"2")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
                   ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0"))
                THEN
                    SalesLineL.SETRANGE("Print Unit Price", FALSE);
                IF SalesLineL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += SalesLineL."Line Discount %";
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;

            IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") THEN BEGIN
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
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;
        END;
        EXIT(LineDiscPctL);
    end;

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
    procedure FunctionPrintUnitPrice(): Boolean
    begin
        IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           SalesCrMemoLineG."Print Option Line" AND NOT SalesCrMemoLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT SalesCrMemoLineG."Print Option Line" AND SalesCrMemoLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT SalesCrMemoLineG."Print Option Line" AND NOT SalesCrMemoLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT SalesCrMemoLineG."Print Option Line" AND SalesCrMemoLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT SalesCrMemoLineG."Print Option Line" AND NOT SalesCrMemoLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           SalesCrMemoLineG."Print Option Line" AND NOT SalesCrMemoLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT SalesCrMemoLineG."Print Option Line" AND NOT SalesCrMemoLineG."Print Unit Price") OR
           (PrintUnitPrice2G = PrintUnitPrice2G::"2")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPriceOVC(): Boolean
    begin
        IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT "Optn Var. Color"."Print Option Line" AND "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT "Optn Var. Color"."Print Option Line" AND "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           (PrintUnitPrice2G = PrintUnitPrice2G::"2")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPriceOV(): Boolean
    begin
        IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT "Option Variant"."Print Option Line" AND "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT "Option Variant"."Print Option Line" AND "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           (PrintUnitPrice2G = PrintUnitPrice2G::"2")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure CalcValues(OptionVariantP: Record "Posted Option Variant")
    begin
        // Start PA033336
        ShowSalPriceG := 0;
        ShowLineDiscPctG := 0;
        IF PrintDiscG AND PrintUnitPriceHelpG AND
          NOT (SalesCrMemoLineG."VAT Calculation Type" = SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax")
        THEN BEGIN
            ShowSalPriceG := OptionVariantP."Unit Price";
            ShowLineDiscPctG := OptionVariantP."Line Discount %";
        END;

        IF DoNotPrintVATG OR
          (SalesCrMemoLineG."VAT Calculation Type" = SalesCrMemoLineG."VAT Calculation Type"::"Differential Tax")
        THEN
            DspAmountG := OptionVariantP."Amount Including VAT"
        ELSE
            DspAmountG := OptionVariantP.Amount;
        // Stop PA033336
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

        // Start PA038229;
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
                IF not VehApptTypeL.IsEmpty() THEN BEGIN
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
    procedure GetReportSelection()
    var
        RecordRefL: RecordRef;
        ReportIDTextL: Text;
        ReportIDL: Integer;
    begin
        // @ This function sets request page filters from Report Selection setup through User Session Unit.

        // Start PA039225.51457
        VehicleReportSelectionG."Print Sent-From Line" := TRUE;
        VehicleReportSelectionG."Print Address Block" := TRUE;
        VehicleReportSelectionG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC037;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(VehicleReportSelectionG);
            IF VehicleReportSelectionG."Print Report Title" THEN
                ReportTitleG := VehicleReportSelectionG."Report Title"
            ELSE BEGIN
                VehicleReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(VehicleReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        PrintSentFromLineBlockG := VehicleReportSelectionG."Print Sent-From Line";
        PrintAddressBlockG := VehicleReportSelectionG."Print Address Block";
        PrintFooterLineBlockG := VehicleReportSelectionG."Print Footer Line";
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
        SalesCrMemoHdrL.SETRANGE(SalesCrMemoHdrL."No.", "Sales Credit Memo Header".GETFILTER("No."));
        IF SalesCrMemoHdrL.FindFirst() THEN BEGIN
            IF NOT CustL.GET(SalesCrMemoHdrL."Bill-to Customer No.") THEN
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
        // Start API.1      22.03.18 KV
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
        // Stop API.1      22.03.18 KV
    end;

    local procedure GetUserIDFullName(UserIDP: Code[50]) FullNameR: Text
    var
        userSetupL: Record "User Setup";
        employeeL: Record Employee;
    begin
        // @ This function get fullname from Employee table of passed user id
        // @ param UserIDP - Code[50]
        // @ retval FullNameR - Text
        // Start API.1      22.03.18 KV
        FullNameR := '';
        IF userSetupL.GET(UserIDP) THEN BEGIN
            IF employeeL.GET(userSetupL."Employee No.") THEN
                FullNameR := employeeL.FullName;
        END;
        EXIT(FullNameR);
        // Stop API.1      22.03.18 KV
    end;
}


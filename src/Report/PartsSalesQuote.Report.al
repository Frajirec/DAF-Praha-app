report 80023 "DPG Parts Sales Quote" // 5028808 "Parts Sales Quote"
{
    // // @ Area PartsSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    //                        Added code to print the report title from 'Report Selection' setup.
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                        Moved the VATText, VATTextLine Dataitem position as last footer.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032651   27.07.11 PR 4262653: Increased width of 'VAT Identifier' control.
    // PA033011   07.02.12 GC 5983155: VAT legend is not printed correctly
    // PA032651   21.03.12 DR 2559014: All incorrect spelling variants of Caption "To-Dos" or "To-Do" corrected.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6220440: Layout Changes for Vat
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   21.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Logos are not incorporated in RDLC layout due to alignment with the new Report Layout Concept.
    //                          Layout 1 and Layout 2 Concepts
    //                        - Added a new Text(1101306302) control in the Pageloop Header(2) section to show report title.
    //                        - Pageloop Header (2) Section
    //                          added pictureBox control 1101306301 & 1101306303 with visible property 'No" for Graphic Header Left & Right
    //                        - Pageloop Footer(3) Section
    //                          added pictureBox control 1101306304 & 1101306305 with visible property 'No" for Graphic Footer Left & Right
    //                        - Report Layout Setup Global Variable taken for calculating "Header Graphic Left", "Header Graphic Right",
    //                          "Footer Graphic Left" and "Footer Graphic Right" Logos.
    //                        - "Removed the fourth parameter from "Report selections".GetReportTitle function in PageHeader(2)
    //                          section to display the Report Title based on Conditions.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, "Sales Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (4) - OnPreSection()", "PageLoop, Footer (5) - OnPreSection()"
    // PA033336   06.11.12 SS 8719075:
    //                        - Code changes in "Sales Line - OnPreDataItem()"
    //                        - Code changes in "Sales Line - OnAfterGetRecord()"
    //                        - New Section Total, Body (1) to print Exchange Part footer Note.
    //                        - Added "Order Type" filter in "Sales Header".
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033765   21.12.12 GC EUTireData Dataitem added
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA035597   09.04.14 GF NAV 2013 R2 Technical Upgrade
    // PA036090   12.09.14 GF 28413 RDL layout corrections.
    // PA035395   27.12.13 GD 18593 Fixed FooterLines visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   03.04.14 GF 22032 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   15.01.15 GK 32565 RDL Layout Corrections
    //                        - Filter added to main table displaying Quote Lines
    //                        - Header images size changed in order that header fields are displayed correctly
    // PA037341   22.01.15 GJ Merge N.6.1.4 to N.7.1.0 of PA035395.18593,PA035484.22032
    // PA036549   02.02.15 GP 33368 Report Selection Layout functionality corrected
    //                        RDLC Layout Corrections
    // PA037562   21.05.15 GQ 37790 RDLC Layout Corrections for column VAT Identifier
    // PA038227   12.08.15 GN Changed Header information.
    // PA038227   24.08.15 GN 43673 Changed Footer functionality
    // PA041125   20.07.16 GQ 66651 RDLC layout modifications
    // PA041125   21.07.16 GQ 66651 RDLC layout modifications
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA041125   12.08.16 GV 68123 RDLC layout modifications
    // PA041187   04.04.17 GD 92784 Modified Additional Item determination from "VAT Calculation Type"::"Exch. Parts Tax"
    //                        to "Additional Item"::"Additional Item".
    // PA041187   10.04.17 MS 93181 Remove option "Print Sent-From Line" from Request page and related logic. Provide missing logic for "Print Footer Line" option.
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsSalesQuote.rdlc';

    Caption = 'Parts Sales Quote';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote), "Order Type" = CONST("Parts Sales & Purchases"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Parts Sales Quote';
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
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(CustAddr_5_; CustAddrG[5])
                    {
                    }
                    column(CoFax; CoFaxG)
                    {
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(Sales_Header___Document_Date_; FORMAT("Sales Header"."Document Date"))
                    {
                        Description = 'PA041125.66651';
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
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
                    column(Sales_Header___VAT_Registration_No__; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(DataItem40; CollectiveG.TextShowOutput("Sales Header".FIELDCAPTION("VAT Registration No."), "Sales Header"."VAT Registration No." <> ''))
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
                    column(DataItem1115000005; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(OutputNo; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintSubtotals; PrintSubtotalsG)
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
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Customer_No_Caption; Customer_No_CaptionLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
                    {
                    }
                    column(Sales_Header___No__Caption; Sales_Header___No__CaptionLbl)
                    {
                    }
                    column(Sales_Header___Document_Date_Caption; Sales_Header___Document_Date_CaptionLbl)
                    {
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA041125.66651';
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                        Description = 'PA041125.66651';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.66651';
                    }
                    dataitem("Header Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Quote), "Header/Footer" = CONST(Header));
                        column(Header_Text_Text; Text)
                        {
                        }
                        column(Header_Text__Document_Type_; "Document Type")
                        {
                            Description = 'PA033336';
                        }
                        column(Header_Text__Header_Footer_; "Header/Footer")
                        {
                            Description = 'PA033336';
                        }
                        column(Header_Text_Document_No_; "Document No.")
                        {
                        }
                        column(Header_Text_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Quote));
                        column(DiscText; DiscTextG)
                        {
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line_Description; Description)
                        {
                        }
                        column(SalesLineType; "Sales Line".Type)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesTypeG; SalesTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line_Description_Control62; Description)
                        {
                        }
                        column(Sales_Line_Subtotal; Subtotal)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line_Description_Control64; Description)
                        {
                        }
                        column(Sales_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control70; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__VAT_Identifier_; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Line__No__; "No.")
                        {
                        }
                        column(Sales_Line_Description_Control73; Description)
                        {
                        }
                        column(Sales_Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Sales_Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Sales_Line__Unit_Price__Control84; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control86; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Sales_Line__VAT_Identifier__Control1109400012; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Amount____Inv__Discount_Amount__Control1109400000; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__Line_Discount____Control1109400001; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Line__Unit_of_Measure__Control1109400002; "Unit of Measure")
                        {
                        }
                        column(Sales_Line__Unit_Price__Control1109400003; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line_Quantity_Control1109400004; Quantity)
                        {
                        }
                        column(Sales_Line_Description_Control1109400005; Description)
                        {
                        }
                        column(Sales_Line__No___Control1109400006; "No.")
                        {
                        }
                        column(Sales_Line__VAT_Identifier__Control1109400013; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Sales_Line__Description_2_; "Description 2")
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowCurrency; ShowCurrencyG)
                        {
                        }
                        column(Sales_Line__Sales_Line__Amount; "Sales Line".Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___Amount_Including_VAT_____Sales_Line__Amount____Exch__Parts_Tax_Amount_; "Sales Line"."Amount Including VAT" - "Sales Line".Amount - "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPct; VATPctG)
                        {
                        }
                        column(Sales_Line__VAT_Base_Amount_; "VAT Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line__Exch__Parts_Tax_Amount_; "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct; ExchTaxPctG)
                        {
                        }
                        column(Sales_Line__Exch__Parts_Tax_Base_; "Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Line__Sales_Line___Amount_Including_VAT_; "Sales Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
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
                        column(VAT_IdentifierCaption; VAT_IdentifierCaptionLbl)
                        {
                            Description = 'PA033042,PA032651';
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
                        column(Sales_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
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
                                EUTireInformationG := EUTireSetupL.GetTireInformation("Sales Line".Type = "Sales Line".Type::Item,
                                  "Sales Line"."EU Tire Data Code");
                                IF EUTireInformationG = '' THEN BEGIN
                                    CurrReport.BREAK;
                                END;
                                // Stop PA033765
                            end;
                        }

                        trigger OnAfterGetRecord()
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
                            // Start PA033336
                            NoPropertyG := '';
                            // Start PA041187.92784
                            IF "Additional Item" = "Additional Item"::Deposit THEN BEGIN
                                // Stop PA041187.92784
                                ExchTaxPctG := "Exch. Parts VAT %";
                                NoPropertyG := C_INC016;
                                ExchangePartG := C_INC017;
                            END;
                            VATAmountLineG."Exch. Parts Tax Amount" := "Exch. Parts Tax Amount";
                            VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLineG.InsertLine;
                            // Stop PA033336

                            IF Type = Type::Item THEN
                                SumItemG := SumItemG + Amount + "Inv. Discount Amount"
                            ELSE
                                SumOtherG := SumOtherG + Amount + "Inv. Discount Amount";

                            // Start PA032651
                            // Start PA033042
                            IF "VAT Identifier" <> '' THEN
                                IF NOT VATIdentifierTempG.GET("VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := "VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042
                            // Stop PA032651
                            // Start PA035597
                            SalesTypeG := Type;
                            IF ("Line Discount Amount" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                "Unit Price" := (Amount + "Inv. Discount Amount") / Quantity;
                                "Line Discount %" := 0;
                            END;
                            SalesAmtG := SalesAmtG + "Sales Line".Amount;
                            SalesAmtIncVATG := SalesAmtIncVATG + "Sales Line"."Amount Including VAT";
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            CurrReport.CREATETOTALS("Line Discount Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Exch. Parts Tax Amount",
                              "Exch. Parts Tax Base", "VAT Base Amount");

                            VATPctG := 0;
                            ExchTaxPctG := 0;
                            // Start PA033336
                            ExchangePartG := '';
                            // Stop PA033336
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrency_Control37; ShowCurrencyG)
                        {
                        }
                        column(Sales_Line__Amount; "Sales Line".Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesAmtG; SalesAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesAmtIncVATG; SalesAmtIncVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
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
                        column(VATAmountLine__VAT_Base__Control106; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control107; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control110; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct_Control94; ExchTaxPctG)
                        {
                        }
                        column(Sales_Line___Exch__Parts_Tax_Amount_; "Sales Line"."Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016_Control98; C_INC016)
                        {
                        }
                        column(TotalInclVATText_Control44; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Line___Amount_Including_VAT_; "Sales Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control99; TotalCaption_Control99Lbl)
                        {
                        }
                        column(ContinuedCaption_Control101; ContinuedCaption_Control101Lbl)
                        {
                        }
                        column(VAT_ofCaption_Control104; VAT_ofCaption_Control104Lbl)
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
                            // Start PA032441
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                            // Stop PA032441
                        end;
                    }
                    dataitem("Footer Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Quote), "Header/Footer" = CONST(Footer));
                        column(Footer_Text_Text; Text)
                        {
                        }
                        column(Footer_Text__Document_Type_; "Document Type")
                        {
                            Description = 'PA033336';
                        }
                        column(Footer_Text__Header_Footer_; "Header/Footer")
                        {
                            Description = 'PA033336';
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
                        column(ExchangePartG; ExchangePartG)
                        {
                        }
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
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC036;
                                IncrG := IncrG + 1;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                // Start PA033042
                                SETRANGE("VAT Identifier Code", VATIdentifierTempG.Code);
                                SETRANGE("Language Code", VATTextHdrG.GetLanguageCode(VATIdentifierTempG.Code, "Sales Header"."Language Code"));
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
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                        SalesAmtG := 0;
                        SalesAmtIncVATG := 0;
                        // Stop PA033336
                    END;
                    CurrReport.PAGENO := 1;

                    SumItemG := 0;
                    SumOtherG := 0;
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrintedG.RUN("Sales Header");
                    // Stop PA032727
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    CopyTextG := '';
                    SETRANGE(Number, 1, NoOfLoopsG);
                    // Start PA035597
                    OutputNoG := 1;
                    // Stop PA035597
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Start PA033336
                SalesAmtG := 0;
                SalesAmtIncVATG := 0;
                // Stop PA033336
                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Parts Sales Quote");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");

                // Stop PA035395.18593
                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.")
                ELSE
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();
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
                // Start PA041187.93181
                // Stop PA041187.93181

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

                IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                   OwnBanksG.GET(IntCustG, LocationG."Bank Code")
                THEN
                    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                ELSE
                    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";

                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE BEGIN
                    ShowCurrencyG := "Currency Code";
                END;
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);

                FormatAddrG.SalesHeaderBillTo(CustAddrG, "Sales Header");

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

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                IF "Sales Header"."Sell-to Customer No." <> "Sales Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesHeaderCust(OrderCustAddrG, "Sales Header");
                    OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';

                IF NOT PrintWithoutDiscG THEN BEGIN
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
                    LogInteractionG := SegMgntG.FindInteractTmplCode(1) <> '';
                    IF LogInteractionG THEN
                        IF "Bill-to Customer No." <> '' THEN
                            SegMgntG.LogDocument(
                              1, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", '', "Posting Description")
                        ELSE
                            SegMgntG.LogDocument(
                              1, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", '', "Posting Description")
                END;
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
                group(Control1101233825)
                {
                    ShowCaption = false;
                    field(NoOfCopiesG; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(PrintSubtotalsG; PrintSubtotalsG)
                    {
                        Caption = 'Print Subtotals';
                    }
                    field(PrintAddrBlockG; PrintAddrBlockG)
                    {
                        Caption = 'Print Address Block';
                    }
                    field(PrintFooterLineG; PrintFooterLineG)
                    {
                        Caption = 'Print Footer Line';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA036549.33368
            // Start PA039225.51457
            GetReportSelection();
            // Stop PA039225.51457
            // Stop PA036549.33368
        end;
    }

    labels
    {
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
        // Start PA035484.22032
        // Stop PA035484.22032
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        // Stop PA032727
        GetReportSelection();
        // Stop PA039225.51457
    end;

    trigger OnPostReport()
    begin
        IF NOT CurrReport.PREVIEW THEN
            IF RMSetupG.GET THEN BEGIN
                WindowG.OPEN('#1#################################\\' + C_INC034);
                IF RMSetupG."Create To-Do when Printing" THEN
                    IF ("Sales Header"."Document Type" = "Sales Header"."Document Type"::Quote) THEN BEGIN
                        ContMgtCreateActivitiesG.SetParameter(TRUE);
                        ContMgtCreateActivitiesG.RUN("Sales Header");
                    END;
                WindowG.CLOSE;
            END;
    end;

    var
        ReportSelectionsG: Record "Report Selection";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnDelivAddressG: Record "Ship-to Address";
        OwnBanksG: Record "Customer Bank Account";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        ShipMethodG: Record "Shipment Method";
        LocationG: Record Location;
        VATAmountLineG: Record "VAT Amount Line" temporary;
        DiscCheckSalLineG: Record "Sales Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Report Selection";
        RMSetupG: Record "Marketing Setup";
        SalesCountPrintedG: Codeunit "Sales-Printed";
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
        ContMgtCreateActivitiesG: Codeunit "Create To-Do -Print Sale Quote";
        UserSessionG: Codeunit "User Session Unit";
        IntCustG: Code[20];
        ShowCurrencyG: Text[30];
        CustAddrG: array[8] of Text[50];
        ShipToAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        VATLegendsG: Text[15];
        OrderCustAddrG: array[8] of Text[50];
        TotalInclVATTextG: Text[50];
        OrderCustAddrLineG: Text[250];
        BankTextG: Text[250];
        CopyTextG: Text[30];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        DiscTextG: Text[30];
        NoPropertyG: Text[30];
        ExchangePartG: Text[30];
        SumItemG: Decimal;
        SumOtherG: Decimal;
        VATPctG: Decimal;
        ExchTaxPctG: Decimal;
        SalesAmtG: Decimal;
        SalesAmtIncVATG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        C_INC008: Label 'Order Customer:';
        C_INC009: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC017: Label '* = Exchange Part';
        C_INC029: Label 'Copy of';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC033: Label 'Tax No.';
        C_INC034: Label 'Automatic creation of To-Dos...';
        C_INC035: Label 'Parts Sales Quote';
        IncrG: Integer;
        OutputNoG: Integer;
        SalesTypeG: Integer;
        PageLoopFooterG: Integer;
        WindowG: Dialog;
        PrintSubtotalsG: Boolean;
        ShowShippingAddrG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        PrintWithoutDiscG: Boolean;
        LogInteractionG: Boolean;
        C_INC036: Label ' =';
        IsRepSelectionSetupAvailableG: Boolean;
        EUTireInformationG: Text[1024];
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Customer_No_CaptionLbl: Label 'Customer No.';
        SalesPurch_NameCaptionLbl: Label 'Salesperson';
        Sales_Header___No__CaptionLbl: Label 'Document No.';
        Sales_Header___Document_Date_CaptionLbl: Label 'Document Date';
        Payments_to_CaptionLbl: Label 'Payments to:';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        VAT_IdentifierCaptionLbl: Label 'VAT Identifier';
        ContinuedCaptionLbl: Label 'Continued';
        Amount____Inv__Discount_Amount__Control125CaptionLbl: Label 'Sum carried forward';
        SumItemCaptionLbl: Label 'Sum Item';
        SumOtherCaptionLbl: Label 'Sum Other';
        Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        VAT_ofCaptionLbl: Label '% VAT of';
        Exch__Tax_fromCaptionLbl: Label '% Exch. Tax from';
        TotalCaption_Control99Lbl: Label 'Total';
        ContinuedCaption_Control101Lbl: Label 'Continued';
        VAT_ofCaption_Control104Lbl: Label '% VAT of';
        ContinuedCaption_Control109Lbl: Label 'Continued';
        Exch__Tax_fromCaption_Control108Lbl: Label '% Exch. Tax from';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        ReportTitleG: Text[100];

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
        ReportTitleG := C_INC035;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionG);
            IF ReportSelectionG."Print Report Title" THEN
                ReportTitleG := ReportSelectionG."Report Title"
            ELSE BEGIN
                ReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        // Start PA041187.93181
        // Stop PA041187.93181
        PrintAddrBlockG := ReportSelectionsG."Print Address Block";
        PrintFooterLineG := ReportSelectionsG."Print Footer Line";
        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        // Stop PA039225.51457
    end;
}


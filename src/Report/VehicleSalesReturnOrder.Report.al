report 80040 "DPG Vehicle Sales Return Order" // report 1057625 "Vehicle Sales Return Order CZ"
{
    // // @ Area PartsSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code to print the report title from 'Report Selection' setup.
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                                        Moved the VATTextLoop, VATTextLine Dataitem position as last footer.
    //                                        Increased width of 'VAT Identifier' control and right aligned.
    // PA033011   07.02.12 GC 5983155: VAT legend is not printed correctly
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incades styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033890   09.11.12 GC 9272400: RDL Layout Created
    // PA033890   11.01.13 GC 9869792: RDL Layout modified
    // PA033890   11.01.13 GC 9869792: RDL CanGrow functionality used for Description Textboxes
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA035484   02.04.14 GF 20973 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   15.01.14 GD 32580 Fixed Do not Show VAT option option functionality.
    //                        Fixed Dangerous Goods display of all items.
    //                        Removed unnecessary page break in RDL Layout.
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035484.20973
    //                        Increased length of some Header textboxes. Added code for Report Title.
    //                        Fixed Print Sent-From Line functionality.
    // PA036549   09.02.15 GN 33398 Multiple Layout Fixes
    // PA038218   18.09.15 IS 44878 "Sales Person" field left indented and size of text box is extended in header.
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA044433   04.08.17 PT 102716 Added the code to increment the value of "No. Printed"
    // --- 7.2.0 ---
    // EU.0005215 20.08.17 PT 4330 Merge of PA044433.102716
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5045504 Vehicle Sales Return Order
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed
    // 
    // !vapa-nejsou data, potřebuju danger.goods data pro rozumné dořešení
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/VehicleSalesReturnOrder.rdlc';

    Caption = 'Vehicle Sales - Return Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST("Return Order"), "Order Type" = CONST("Vehicle Sales & Purchases"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Return Order';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(FooterField03; RDLHideOutput(PrintFooterLineRDLG))
                {
                }
                column(CopyLoopDocumentPageNo; Number)
                {
                }
                column(CopyLoopNo; CopyLoopNoG)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CopyTextG; CopyTextG)
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
                    column(CompAddrG; CompAddrG)
                    {
                    }
                    column(CoTelephoneTextG; CoTelephoneTextG)
                    {
                    }
                    column(CoFaxTextG; CoFaxTextG)
                    {
                    }
                    column(CoEmailTextG; CoEmailTextG)
                    {
                    }
                    column(CoTelephoneG; CoTelephoneG)
                    {
                    }
                    column(CoFaxG; CoFaxG)
                    {
                    }
                    column(CoEmailG; CoEmailG)
                    {
                    }
                    column(No_CustG; CustG."No.")
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
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                    }
                    column(No_SH; "Sales Header"."No.")
                    {
                    }
                    column(DocumentDate1_SH; FORMAT("Sales Header"."Document Date"))
                    {
                    }
                    column(Name_SalPurch; SalesPurchG.Name)
                    {
                    }
                    column(VATRegistrationNo1_SH; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(VATRegistrationNoCpn1_SH; CollectiveG.TextShowOutput("Sales Header".FIELDCAPTION("VAT Registration No."), "Sales Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(VATRegistrationNoCpn1_Comp; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(VATRegistrationNo1_Comp; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(TaxRegistrationNoCpn1; CollectiveG.TextShowOutput(C_INC032, PrintAddrBlockG))
                    {
                    }
                    column(RegistrationNo1_Comp; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(OrderCustAddrLineG; OrderCustAddrLineG)
                    {
                    }
                    column(BankTextG; BankTextG)
                    {
                    }
                    column(OrderNoLbl; OrderNoLbl)
                    {
                    }
                    column(OrderDateLbl; OrderDateLbl)
                    {
                    }
                    column(PageLbl; PageLbl)
                    {
                    }
                    column(CustomerNoLbl; CustomerNoLbl)
                    {
                    }
                    column(SalespersonLbl; SalespersonLbl)
                    {
                    }
                    column(PaymentsToLbl; PaymentsToLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
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
                    column(DocumentDate_SH; "Sales Header"."Document Date")
                    {
                    }
                    column(DueDate_SH; "Sales Header"."Due Date")
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
                        column(HideHeaderHeaderTextBody1; RDLHideOutputAsInteger(1))
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
                    dataitem(SalesLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(CollectiveG_TextShowOutput_SalesLineG_FIELDCAPTION__Unit_of_Measure___ShowUnitsofMeasureG_; CollectiveG.TextShowOutput(SalesLineG.FIELDCAPTION("Unit of Measure"), ShowUnitsofMeasureG))
                        {
                        }
                        column(DiscTextG; DiscTextG)
                        {
                        }
                        column(HideSalesLineHeader1; RDLHideOutputAsInteger(2))
                        {
                        }
                        column(SalesLineNumber; SalesLine.Number)
                        {
                        }
                        column(CurrentVehicleG; CurrentVehicleG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineG_Description; SalesLineG.Description)
                        {
                        }
                        column(HideSalesLineBody3; RDLHideOutput(SalesLineG.Type = SalesLineG.Type::" "))
                        {
                        }
                        column(SalesLineG_Description_Control58; SalesLineG.Description)
                        {
                        }
                        column(SalesLineG_Quantity; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPriceG; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmountG; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CollectiveG_TextShowOutput_SalesLineG__Unit_of_Measure__ShowUnitsofMeasureG_; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(SalesLineG__VAT_Identifier_; SalesLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HideSalesLineBody4; RDLHideOutput((SalesLineG.Type = SalesLineG.Type::"Account (G/L)") AND ((PrintOption2G = PrintOption2G::"1") OR ((PrintOption2G = PrintOption2G::"0") AND SalesLineG."Print Option Line")) AND FunctionPrintUnitPrice))
                        {
                        }
                        column(SalesLineG_Description_Control1109420000; SalesLineG.Description)
                        {
                        }
                        column(SalesLineG_Quantity_Control1109420005; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(CollectiveG_TextShowOutput_SalesLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control1109420006; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(HideSalesLineBody5; RDLHideOutput((SalesLineG.Type = SalesLineG.Type::"Account (G/L)") AND ((PrintOption2G = PrintOption2G::"1") OR ((PrintOption2G = PrintOption2G::"0") AND SalesLineG."Print Option Line")) AND NOT FunctionPrintUnitPrice))
                        {
                        }
                        column(SalesLineG__Description_2_; SalesLineG."Description 2")
                        {
                        }
                        column(HideSalesLineBody6; RDLHideOutput(ShowOutputSalesLineBody6()))
                        {
                        }
                        column(SalesLineG__No__; SalesLineG."No.")
                        {
                        }
                        column(SalesLineG_Description_Control65; SalesLineG.Description)
                        {
                        }
                        column(SalesLineG_Quantity_Control66; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPriceG_Control68; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG_Control69; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmountG_Control70; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CollectiveG_TextShowOutput_SalesLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control67; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(SalesLineG__VAT_Identifier__Control1109400053; SalesLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HideSalesLineBody7; RDLHideOutput(ShowOutputSalesLineBody7()))
                        {
                        }
                        column(CollectiveG_TextShowOutput_SalesLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control1109420001; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(SalesLineG_Quantity_Control1109420002; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(SalesLineG_Description_Control1109420003; SalesLineG.Description)
                        {
                        }
                        column(SalesLineG__No___Control1109420004; SalesLineG."No.")
                        {
                        }
                        column(HideSalesLineBody8; RDLHideOutput(ShowOutputSalesLineBody8()))
                        {
                        }
                        column(DspAmountG_Control1109400000; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowSalPriceG_Control1109400001; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG_Control1109400002; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(CollectiveG_TextShowOutput_SalesLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control1109400003; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(SalesLineG_Description_Control1109400004; SalesLineG.Description)
                        {
                        }
                        column(SalesLineG_Quantity_Control1109400005; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(SalesLineG__No___Control1109400006; SalesLineG."No.")
                        {
                        }
                        column(SalesLineG__VAT_Identifier__Control1109400054; SalesLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HideSalesLineBody9; RDLHideOutput(SalesLineG.Type = SalesLineG.Type::"Charge (Item)"))
                        {
                        }
                        column(SalesLineG__Description_2__Control5025400; SalesLineG."Description 2")
                        {
                        }
                        column(HideSalesLineBody10; RDLHideOutput((SalesLineG.Type = SalesLineG.Type::Item) AND (SalesLineG."Item Type" <> SalesLineG."Item Type"::Vehicle) AND (SalesLineG."Description 2" <> '')))
                        {
                        }
                        column(VehicleDescriptionG; VehicleDescriptionG)
                        {
                        }
                        column(ShowSalPriceG_Control143; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG_Control145; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmountG_Control146; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineG__No___Control147; SalesLineG."No.")
                        {
                        }
                        column(SalesLineG_Quantity_Control1000000000; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(SalesLineG__VAT_Identifier__Control1109400055; SalesLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HideSalesLineBody11; RDLHideOutput((SalesLineG.Type = SalesLineG.Type::Item) AND (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND (NOT OptionFoundG)))
                        {
                        }
                        column(CurrentVehicleG_Control22; CurrentVehicleG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumVehicleG; SumVehicleG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumMfgOptG; SumMfgOptG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter15; RDLHideOutput(SumMfgOptG <> 0))
                        {
                        }
                        column(SumOwnOptG; SumOwnOptG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter16; RDLHideOutput(SumOwnOptG <> 0))
                        {
                        }
                        column(SumTransferFeesG; SumTransferFeesG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter17; RDLHideOutput(SumTransferFeesG <> 0))
                        {
                        }
                        column(SumChargeItemsG; SumChargeItemsG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter18; RDLHideOutput(SumChargeItemsG <> 0))
                        {
                        }
                        column(SumOtherG; SumOtherG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter19; RDLHideOutput(SumOtherG <> 0))
                        {
                        }
                        column(InvDiscountAmountTotalG; -InvDiscountAmountTotalG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter21; RDLHideOutput((InvDiscountAmountTotalG <> 0) AND (NOT DoNotShowVATG)))
                        {
                        }
                        column(AmountTotalG; AmountTotalG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG_VATAmountText; VATAmountLineG.VATAmountText)
                        {
                        }
                        column(ShowCurrencyG; ShowCurrencyG)
                        {
                        }
                        column(AmountIncludingVATTotalG___SalesLineG_Amount; AmountIncludingVATTotalG - AmountTotalG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATTextG; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter22; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND (NOT (DoNotShowVATG OR DiffTaxExistsG))))
                        {
                        }
                        column(HideDiffTax_2; RDLHideOutput(DiffTaxExistsG))
                        {
                        }
                        column(TotalInclVATTextG_Control10; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG_Control13; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter23; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND (DoNotShowVATG OR DiffTaxExistsG)))
                        {
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
                        column(CurrentVehicleGCaption; CurrentVehicleGCaptionLbl)
                        {
                        }
                        column(CurrentVehicleG_Control22Caption; CurrentVehicleG_Control22CaptionLbl)
                        {
                        }
                        column(SumVehicleGCaption; SumVehicleGCaptionLbl)
                        {
                        }
                        column(SumMfgOptGCaption; SumMfgOptGCaptionLbl)
                        {
                        }
                        column(SumOwnOptGCaption; SumOwnOptGCaptionLbl)
                        {
                        }
                        column(SumTransferFeesGCaption; SumTransferFeesGCaptionLbl)
                        {
                        }
                        column(Sum_Charge_ItemsCaption; Sum_Charge_ItemsCaptionLbl)
                        {
                        }
                        column(SumOtherGCaption; SumOtherGCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountTotalGCaption; InvDiscountAmountTotalGCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        dataitem(Vehicle; Vehicle)
                        {
                            DataItemTableView = SORTING(VIN);
                            column(SalesLineG_VIN; SalesLineG.VIN)
                            {
                            }
                            column(SalesLineG__License_No__; SalesLineG."License No.")
                            {
                            }
                            column(SalesLineG_Mileage; SalesLineG.Mileage)
                            {
                            }
                            column(Vehicle__Registration_Certificate_; "Registration Certificate")
                            {
                            }
                            column(RegisTextG; RegisTextG)
                            {
                            }
                            column(FORMAT_SalesLineG__Vehicle_Status__; FORMAT(SalesLineG."Vehicle Status"))
                            {
                            }
                            column(HideVehicleBody1; RDLHideOutput((SalesLineG.Type = SalesLineG.Type::Item) AND (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND ((PrintOption2G <> PrintOption2G::"2") AND NOT OptionFoundG)))
                            {
                            }
                            column(SalesLineG_MileageCaption; SalesLineG_MileageCaptionLbl)
                            {
                            }
                            column(SalesLineG__License_No__Caption; SalesLineG__License_No__CaptionLbl)
                            {
                            }
                            column(Vehicle__Registration_Certificate_Caption; Vehicle__Registration_Certificate_CaptionLbl)
                            {
                            }
                            column(SalesLineG_VINCaption; SalesLineG_VINCaptionLbl)
                            {
                            }
                            column(RegisTextGCaption; RegisTextGCaptionLbl)
                            {
                            }
                            column(FORMAT_SalesLineG__Vehicle_Status__Caption; FORMAT_SalesLineG__Vehicle_Status__CaptionLbl)
                            {
                            }
                            column(Vehicle_VIN; VIN)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start INC2.30
                                IF "Initial Registration" = 0D THEN
                                    InitialRegisTextG := ' -- '
                                ELSE
                                    InitialRegisTextG := FORMAT("Initial Registration");

                                IF SalesLineG."Registration Date" = 0D THEN
                                    CustRegisTextG := ' -- '
                                ELSE
                                    CustRegisTextG := FORMAT(SalesLineG."Registration Date");
                                RegisTextG := InitialRegisTextG + ' / ' + CustRegisTextG;
                                // Stop INC2.30
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(VIN, SalesLineG.VIN);
                            end;
                        }
                        dataitem("Optn Var. Vehicle"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Return Order"), Type = CONST(Vehicle));
                            column(VehicleDescriptionG_Control133; VehicleDescriptionG)
                            {
                            }
                            column(Optn_Var__Vehicle_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPriceG_Control141; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPctG_Control148; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmountG_Control149; DspAmountG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(SalesLineG__No___Control153; SalesLineG."No.")
                            {
                            }
                            column(CollectiveG_TextShowOutput_SalesLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control190; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                            {
                            }
                            column(SalesLineG__VAT_Identifier__Control1109400056; SalesLineG."VAT Identifier")
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(HideOptnVarVehicleBody1; RDLHideOutput((SalesLineG.Type = SalesLineG.Type::Item) AND (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND (Type = Type::Vehicle)))
                            {
                            }
                            column(SalesLineG__License_No___Control115; SalesLineG."License No.")
                            {
                            }
                            column(SalesLineG_Mileage_Control116; SalesLineG.Mileage)
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121; Vehicle."Registration Certificate")
                            {
                            }
                            column(SalesLineG_VIN_Control122; SalesLineG.VIN)
                            {
                            }
                            column(RegisTextG_Control155; RegisTextG)
                            {
                            }
                            column(FORMAT_SalesLineG__Vehicle_Status___Control160; FORMAT(SalesLineG."Vehicle Status"))
                            {
                            }
                            column(HideOptnVarVehicleBody2; RDLHideOutput((SalesLineG.Type = SalesLineG.Type::Item) AND (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND (PrintOption2G <> PrintOption2G::"2") AND (Type = Type::Vehicle)))
                            {
                            }
                            column(SalesLineG_VIN_Control122Caption; SalesLineG_VIN_Control122CaptionLbl)
                            {
                            }
                            column(SalesLineG__License_No___Control115Caption; SalesLineG__License_No___Control115CaptionLbl)
                            {
                            }
                            column(SalesLineG_Mileage_Control116Caption; SalesLineG_Mileage_Control116CaptionLbl)
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121Caption; Vehicle__Registration_Certificate__Control121CaptionLbl)
                            {
                            }
                            column(RegisTextG_Control155Caption; RegisTextG_Control155CaptionLbl)
                            {
                            }
                            column(FORMAT_SalesLineG__Vehicle_Status___Control160Caption; FORMAT_SalesLineG__Vehicle_Status___Control160CaptionLbl)
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
                                // Start PA033890.9272400
                                IF PrintDiscG AND
                                   NOT (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    ShowSalPriceG := getSalPrice(SalesLineG, 0);
                                    ShowLineDiscPctG := getLineDiscPct(SalesLineG, 0);
                                END ELSE BEGIN
                                    ShowSalPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF (DoNotShowVATG) OR
                                   (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN
                                    DspAmountG := getSalPrice(SalesLineG, 1)
                                ELSE
                                    DspAmountG := getSalPrice(SalesLineG, 2) +
                                      getLineDiscPct(SalesLineG, 2);
                                IF PrintDiscG AND (ShowSalPriceG <> 0) THEN
                                    IF DoNotShowVATG THEN BEGIN
                                        // Start PA036549.32580
                                        DspAmountG := getSalPrice(SalesLineG, 1) +
                                          // Stop PA036549.32580
                                          getLineDiscPct(SalesLineG, 2);
                                        ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                    END ELSE BEGIN
                                        ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                    END;
                                ShowLineDiscPctG := ShowLineDiscPctG * -1;
                                VehicleDescriptionG := SalesLineG."Shortcut Dimension 2 Code" + ' ' + SalesLineG.Description;
                                // Stop PA033890.9272400
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Color"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Return Order"));
                            column(Optn_Var__Color_Description; Description)
                            {
                            }
                            column(Optn_Var__Color_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPriceG_Control142; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPctG_Control144; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmountG_Control157; DspAmountG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Optn_Var__Color__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(HideOptnVarColorBody1; RDLHideOutput(ShowOutputOptnVarColorBody1()))
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
                            column(CollectiveG_TextShowOutput_C_INC028__Series_Option__; CollectiveG.TextShowOutput(C_INC028, "Series Option"))
                            {
                            }
                            column(HideOptnVarColorBody2; RDLHideOutput(ShowOutputOptnVarColorBody2()))
                            {
                            }
                            column(Optn_Var__Color__Description_2_; "Description 2")
                            {
                            }
                            column(HideOptnVarColorBody3; RDLHideOutput(ShowOutputOptnVarColorBody3()))
                            {
                            }
                            column(CurrentVehicleG_Control91; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CurrentVehicleG_Control91Caption; CurrentVehicleG_Control91CaptionLbl)
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
                            column(Optn_Var__Color_Type; Type)
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
                                       (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                    THEN BEGIN
                                        SumVehicleG -= "Amount Including VAT";
                                        SumMfgOptG += "Amount Including VAT";
                                    END ELSE BEGIN
                                        SumVehicleG -= Amount;
                                        SumMfgOptG += Amount;
                                    END;
                                END;
                                // Start PA033890.9272400
                                IF PrintDiscG AND FunctionPrintUnitPriceOVC AND
                                   NOT (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    ShowSalPriceG := "Unit Price";
                                    ShowLineDiscPctG := "Line Discount %";
                                END ELSE BEGIN
                                    ShowSalPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF (DoNotShowVATG) OR
                                   (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    DspAmountG := "Amount Including VAT";
                                END ELSE BEGIN
                                    DspAmountG := Amount;
                                END;
                                IF NOT FunctionPrintUnitPriceOVC THEN BEGIN
                                    DspAmountG := 0;
                                END;
                                // Stop PA033890.9272400
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Option Type",
                                  "Optn Var. Color"."Option Type"::Color,
                                  "Optn Var. Color"."Option Type"::Upholstery);
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Series"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Return Order"), "Series Option" = CONST(true), "Option Type" = CONST(Option));
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
                            column(HideOptnVarSeriesBody1; RDLHideOutput(ShowOutputOptnVarSeriesBody1()))
                            {
                            }
                            column(Optn_Var__Series__Description_2_; "Description 2")
                            {
                            }
                            column(HideOptnVarSeriesBody2; RDLHideOutput(ShowOutputOptnVarSeriesBody2()))
                            {
                            }
                            column(CurrentVehicleG_Control60; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CurrentVehicleG_Control60Caption; CurrentVehicleG_Control60CaptionLbl)
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

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }
                        dataitem("Option Variant"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Return Order"), "Series Option" = CONST(false), "Option Type" = CONST(Option));
                            column(Option_Variant_Description; Description)
                            {
                            }
                            column(Option_Variant_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPriceG_Control171; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPctG_Control172; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmountG_Control175; DspAmountG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Option_Variant__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(HideOptionVariantBody1; RDLHideOutput(ShowOutputOptionVariantBody1()))
                            {
                            }
                            column(Option_Variant__Description_2_; "Description 2")
                            {
                            }
                            column(HideOptionVariantBody2; RDLHideOutput(ShowOutputOptionVariantBody2()))
                            {
                            }
                            column(CurrentVehicleG_Control42; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CurrentVehicleG_Control42Caption; CurrentVehicleG_Control42CaptionLbl)
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
                                       (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                    THEN BEGIN
                                        SumVehicleG -= "Amount Including VAT";
                                        SumMfgOptG += "Amount Including VAT";
                                    END ELSE BEGIN
                                        SumVehicleG -= Amount;
                                        SumMfgOptG += Amount;
                                    END;
                                END;
                                // Start PA033890.9272400
                                IF PrintDiscG AND FunctionPrintUnitPriceOV AND
                                   NOT (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    ShowSalPriceG := "Unit Price";
                                    ShowLineDiscPctG := "Line Discount %";
                                END ELSE BEGIN
                                    ShowSalPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF (DoNotShowVATG) OR
                                   (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    DspAmountG := "Amount Including VAT";
                                END ELSE BEGIN
                                    DspAmountG := Amount;
                                END;
                                IF NOT FunctionPrintUnitPriceOV THEN BEGIN
                                    DspAmountG := 0;
                                END;
                                // Stop PA033890.9272400
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }
                        dataitem(VehicleTotal; "Integer")
                        {
                            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1));
                            column(TotalVehG; TotalVehG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(HideVehicleTotalBody1; RDLHideOutput(ShowVehicleTotalsBodyG))
                            {
                            }
                            column(TotalVehGCaption; TotalVehGCaptionLbl)
                            {
                            }
                            column(VehicleTotal_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                SalesLineL: Record "Sales Line";
                            begin
                                // Start PA033890.9272400
                                ShowVehicleTotalsBodyG := FALSE;
                                SalesLineL.RESET;
                                SalesLineL.COPY(SalesLineG);
                                SalesLineL.SETPOSITION(SalesLineG.GETPOSITION);
                                IF SalesLineL.FIND('=') THEN BEGIN
                                    IF SalesLineL.NEXT = 0 THEN BEGIN
                                        IF SalesLineG."Item Type" <> SalesLineG."Item Type"::Item THEN BEGIN
                                            SalesLineL.RESET;
                                            SalesLineL.SETRANGE("Document Type", SalesLineG."Document Type");
                                            SalesLineL.SETRANGE("Document No.", SalesLineG."Document No.");
                                            SalesLineL.SETRANGE("Item Type", SalesLineL."Item Type"::Item);
                                            SalesLineL.SETFILTER("Line No.", '<>%1', SalesLineG."Line No.");
                                            IF SalesLineL.FIND('-') THEN BEGIN
                                                ShowVehicleTotalsBodyG := SalesLineL.VIN <> SalesLineG.VIN;
                                            END ELSE BEGIN
                                                ShowVehicleTotalsBodyG := TRUE;
                                            END;
                                        END ELSE BEGIN
                                            ShowVehicleTotalsBodyG := TRUE;
                                        END;
                                    END ELSE BEGIN
                                        ShowVehicleTotalsBodyG := SalesLineL.VIN <> SalesLineG.VIN;
                                    END;
                                END;
                                IF (DoNotShowVATG) OR
                                   (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    TotalVehG += SalesLineG."Amount Including VAT"
                                END ELSE BEGIN
                                    TotalVehG += SalesLineG.Amount;
                                END;
                                // Stop PA033890.9272400
                            end;
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
                                // Start PA033890.9272400
                                ShowVehicleTotalsBodyG := FALSE;
                                TotalVehG := 0;
                                CurrentVehicleG := 0;
                            END ELSE BEGIN
                                // Stop PA033890.9272400
                                IF SalesLineG.NEXT = 0 THEN BEGIN
                                    SalesLineG.SETRANGE("Item Type", SalesLineG."Item Type"::Item);
                                    SalesLineG.FIND('-');
                                END;
                                // Start PA033890.9272400
                            END;
                            IF ShowVehicleTotalsBodyG THEN BEGIN
                                TotalVehG := 0;
                                CurrentVehicleG := 0;
                            END;
                            // Stop PA033890.9272400
                            // Check if Option is available
                            OptionVariantG.SETRANGE(Area, OptionVariantG.Area::Sale);
                            OptionVariantG.SETRANGE("Document Type", SalesLineG."Document Type");
                            OptionVariantG.SETRANGE("Document No.", SalesLineG."Document No.");
                            OptionVariantG.SETRANGE("Document Line No.", SalesLineG."Line No.");
                            OptionFoundG := OptionVariantG.FIND('-');
                            IF SalesLineG."VAT Calculation Type" <> SalesLineG."VAT Calculation Type"::"Differential Tax" THEN BEGIN
                                VATAmountLineG.INIT;
                                // Start PA033011.5983155
                                VATAmountLineG."VAT Identifier" := FORMAT(SalesLineG."VAT %");
                                VATAmountLineG."Sales Amount" := SalesLineG.Amount;
                                // Stop PA033011.5983155
                                VATAmountLineG."VAT %" := SalesLineG."VAT %";
                                VATAmountLineG."VAT Base" := SalesLineG.Amount;
                                VATAmountLineG."Amount Including VAT" := SalesLineG."Amount Including VAT";
                                VATAmountLineG.InsertLine();
                            END;
                            IF (DoNotShowVATG) OR
                               (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                            THEN BEGIN
                                IF SalesLineG.Type = SalesLineG.Type::Item THEN BEGIN
                                    CASE SalesLineG."Item Type" OF
                                        SalesLineG."Item Type"::Item:
                                            SumOtherG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::Vehicle:
                                            SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::"Own Option":
                                            SumOwnOptG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::"Veh. Transfer":
                                            SumTransferFeesG += SalesLineG."Amount Including VAT"
                                    END;
                                END ELSE
                                    SumOtherG += SalesLineG."Amount Including VAT";
                            END ELSE BEGIN
                                IF SalesLineG.Type = SalesLineG.Type::Item THEN BEGIN
                                    CASE SalesLineG."Item Type" OF
                                        SalesLineG."Item Type"::Item:
                                            SumOtherG += SalesLineG.Amount;
                                        SalesLineG."Item Type"::Vehicle:
                                            SumVehicleG += SalesLineG.Amount;
                                        SalesLineG."Item Type"::"Own Option":
                                            SumOwnOptG += SalesLineG.Amount;
                                        SalesLineG."Item Type"::"Veh. Transfer":
                                            SumTransferFeesG += SalesLineG.Amount;
                                    END;
                                END ELSE
                                    SumOtherG += SalesLineG.Amount;
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
                            // Start PA033042
                            IF (SalesLineG."VAT Identifier" <> '') AND (SalesLineG.Quantity <> 0) THEN
                                IF NOT VATIdentifierTempG.GET(SalesLineG."VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := SalesLineG."VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042
                            // Start PA033890.9272400
                            VehicleDescriptionG := '';
                            ShowSalPriceG := 0;
                            ShowLineDiscPctG := 0;
                            DspAmountG := 0;
                            PrintOptionHelpG := (PrintOption2G = PrintOption2G::"1") OR
                              ((PrintOption2G = PrintOption2G::"0") AND SalesLineG."Print Option Line");
                            PrintUnitPriceHelpG := FunctionPrintUnitPrice;
                            IF (((SalesLineG.Type = SalesLineG.Type::"Account (G/L)") AND PrintOptionHelpG AND PrintUnitPriceHelpG)) OR
                               (((SalesLineG.Type = SalesLineG.Type::Item) AND
                               (SalesLineG."Item Type" <> SalesLineG."Item Type"::Vehicle) AND
                               PrintOptionHelpG AND PrintUnitPriceHelpG)) OR
                               (SalesLineG.Type = SalesLineG.Type::"Charge (Item)")
                            THEN BEGIN
                                IF PrintDiscG AND PrintUnitPriceHelpG AND
                                   NOT (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    ShowSalPriceG := SalesLineG."Unit Price";
                                    ShowLineDiscPctG := SalesLineG."Line Discount %"
                                END ELSE BEGIN
                                    ShowSalPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF (DoNotShowVATG) OR
                                   (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN
                                    DspAmountG := SalesLineG."Amount Including VAT"
                                ELSE
                                    DspAmountG := SalesLineG.Amount;
                            END;
                            IF ((SalesLineG.Type = SalesLineG.Type::Item) AND
                               (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND OptionFoundG)
                            THEN BEGIN
                                IF PrintDiscG AND
                                   NOT (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    ShowSalPriceG := getSalPrice(SalesLineG, 0);
                                    ShowLineDiscPctG := getLineDiscPct(SalesLineG, 0);
                                END ELSE BEGIN
                                    ShowSalPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF (DoNotShowVATG) OR
                                   (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN
                                    DspAmountG := getSalPrice(SalesLineG, 1)
                                ELSE
                                    DspAmountG := getSalPrice(SalesLineG, 2) +
                                      getLineDiscPct(SalesLineG, 2);
                                IF PrintDiscG AND (ShowSalPriceG <> 0) THEN
                                    IF DoNotShowVATG THEN BEGIN
                                        DspAmountG := getSalPrice(SalesLineG, 2) +
                                          getLineDiscPct(SalesLineG, 2);
                                        ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                    END ELSE BEGIN
                                        ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                    END;
                                ShowLineDiscPctG := ShowLineDiscPctG * -1;

                                VehicleDescriptionG := SalesLineG."Shortcut Dimension 2 Code" + ' ' + SalesLineG.Description;
                            END;
                            InvDiscountAmountTotalG += SalesLineG."Inv. Discount Amount";
                            AmountTotalG += SalesLineG.Amount;
                            AmountIncludingVATTotalG += SalesLineG."Amount Including VAT";
                            // Stop PA033890.9272400
                        end;

                        trigger OnPreDataItem()
                        var
                            SalesLineL: Record "Sales Line";
                            ItemL: Record Item;
                            RefMasterL: Record "Reference Master";
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

                            SalesLineG.SETFILTER("Item Type", '<>%1', SalesLineG."Item Type"::Item);
                            CurrReport.CREATETOTALS(SalesLineG.Amount, SalesLineG."Amount Including VAT");
                            SalesLineL.RESET;
                            SalesLineL.SETRANGE("Document No.", "Sales Header"."No.");
                            NormalVATTotalG := 0;
                            SumwithDiffTaxationG := 0;
                            SumOnlyDiffTaxationG := 0;
                            IF SalesLineL.FIND('-') THEN
                                REPEAT
                                    IF SalesLineL."VAT Calculation Type" = SalesLineL."VAT Calculation Type"::"Differential Tax" THEN BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesLineL."Amount Including VAT";
                                        SumOnlyDiffTaxationG := SumOnlyDiffTaxationG + SalesLineL."Amount Including VAT";
                                    END ELSE BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesLineL.Amount;
                                        NormalVATTotalG := NormalVATTotalG + (SalesLineL."Amount Including VAT" - SalesLineL.Amount);
                                    END;
                                    // Start PA036549.32580
                                    IF (PrntDangerousGoodsListG) AND (SalesLineL."Item Type" = SalesLineL."Item Type"::Item) THEN BEGIN
                                        IF ItemL.GET(SalesLineL."No.") THEN BEGIN
                                            // Stop PA036549.32580
                                            IF ItemL."Dangerous Goods Code" <> '' THEN BEGIN
                                                DangerousGoodsListTG.INIT;
                                                DangerousGoodsListTG."Entry No." := DangerousGoodsListTG."Entry No." + 1;
                                                DangerousGoodsListTG."Code 01" := ItemL."No.";
                                                DangerousGoodsListTG."Text 01" := ItemL.Description;
                                                DangerousGoodsListTG."Value 1" := SalesLineG.Quantity;
                                                DangerousGoodsListTG."Code 02" := ItemL."Dangerous Goods Code";
                                                RefMasterL.SETRANGE("Make Code", ItemL."Make Code");
                                                RefMasterL.SETRANGE(Type, RefMasterL.Type::"Dangerous Goods Code");
                                                RefMasterL.SETRANGE(Code, ItemL."Dangerous Goods Code");
                                                IF RefMasterL.FIND('-') THEN
                                                    DangerousGoodsListTG."Text 02" := RefMasterL.Description;
                                                DangerousGoodsListTG.INSERT;
                                            END;
                                        END;
                                    END;
                                // Start PA036549.32580
                                UNTIL SalesLineL.NEXT = 0;
                            // Stop PA036549.32580
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrencyG_Control38; ShowCurrencyG)
                        {
                        }
                        column(SumwithDiffTaxationG; SumwithDiffTaxationG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT___; VATAmountLineG."VAT %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(VATAmountLineG__VAT_Base__Control108; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__Amount_Including_VAT____VATAmountLineG__VAT_Base_; VATAmountLineG."Amount Including VAT" - VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterBody3; RDLHideOutput(NOT DoNotShowVATG))
                        {
                        }
                        column(VATAmountLineG__VAT_Base__Control112; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount__Control113; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATTextG_Control48; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG_Control51; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control167; TotalCaption_Control167Lbl)
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
                    dataitem("Sales Trade-In"; "Sales Trade-In")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.");
                        column(TotalTradeInG; TotalTradeInG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATTotalG___TotalTradeInG; AmountIncludingVATTotalG - TotalTradeInG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowCurrencyG_Control75; ShowCurrencyG)
                        {
                        }
                        column(Trade_Ins_Caption; Trade_Ins_CaptionLbl)
                        {
                        }
                        column(TotalTradeInGCaption; TotalTradeInGCaptionLbl)
                        {
                        }
                        column(PayableCaption; PayableCaptionLbl)
                        {
                        }
                        column(Sales_Trade_In_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Trade_In_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Trade_In_Document_Line_No_; "Document Line No.")
                        {
                        }
                        column(Sales_Trade_In_Line_No_; "Line No.")
                        {
                        }
                        column(Sales_Trade_In_VIN; VIN)
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
                            column(Sales_Trade_In__Description; "Sales Trade-In".Description)
                            {
                            }
                            column(Sales_Trade_In___Unit_Cost_Incl__VAT_; "Sales Trade-In"."Unit Cost Incl. VAT")
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(HideVehicle2Body1; RDLHideOutput(NOT TradeInExtraG))
                            {
                            }
                            column(MileageCaption; MileageCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF "Initial Registration" = 0D THEN
                                    InitialRegisTextG := ' -- '
                                ELSE
                                    InitialRegisTextG := FORMAT("Initial Registration");

                                IF SalesLineG."Registration Date" = 0D THEN
                                    CustRegisTextG := ' -- '
                                ELSE
                                    CustRegisTextG := FORMAT(SalesLineG."Registration Date");
                                RegisTextG := InitialRegisTextG + ' / ' + CustRegisTextG;
                                // Start PA033890.9869792
                                IF NOT TradeInExtraG THEN BEGIN
                                    TotalTradeInG += "Sales Trade-In"."Unit Cost Incl. VAT";
                                END;
                                // Stop PA033890.9869792
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            PurchInvHdrL: Record "Purch. Invoice Header";
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
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS("Unit Cost Incl. VAT (LCY)");
                        end;
                    }
                    dataitem("Payment Terms"; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PaymentTermsG_Description; PaymentTermsG.Description)
                        {
                        }
                        column(HidePaymentTermsBody1; RDLHideOutputAsInteger(3))
                        {
                        }
                        column(PaymentTermsG_DescriptionCaption; PaymentTermsG_DescriptionCaptionLbl)
                        {
                        }
                        column(Payment_Terms_Number; Number)
                        {
                        }
                    }
                    dataitem(DiffTaxText; "Veh SalesDoc DiffTaxText")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Entry No.");
                        column(DiffTaxText_Text; Text)
                        {
                        }
                        column(HideDiffTaxTextBody1; RDLHideOutput(DiffTaxExistsG))
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
                    dataitem(HeaderFooterText; "Sales Document Text")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Header/Footer" = CONST(Footer));
                        column(HeaderFooterText_Text; Text)
                        {
                        }
                        column(HideHeaderFooterTextBody1; RDLHideOutputAsInteger(3))
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
                    dataitem(VATTextLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATTextLoopNumber; VATTextLoop.Number)
                        {
                        }
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
                            column(HideVATTextLineBody1; RDLHideOutputAsInteger(4))
                            {
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
                                // Start PA033890.9272400
                                VATLegendsG := '';
                                IF IncrG = 1 THEN
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC034;
                                IncrG := IncrG + 1;
                                // Stop PA033890.9272400
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
                }
                dataitem(DangerousGoods; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(CompAddrGD; CompAddrG)
                    {
                    }
                    column(CopyTextGD; CopyTextG)
                    {
                    }
                    column(CustAddr_1_D; CustAddrG[1])
                    {
                    }
                    column(CustAddr_2_D; CustAddrG[2])
                    {
                    }
                    column(CustAddr_3_D; CustAddrG[3])
                    {
                    }
                    column(CustAddr_4_D; CustAddrG[4])
                    {
                    }
                    column(CustAddr_5_D; CustAddrG[5])
                    {
                    }
                    column(CustAddr_6_D; CustAddrG[6])
                    {
                    }
                    column(CustAddr_7_D; CustAddrG[7])
                    {
                    }
                    column(CustAddr_8_D; CustAddrG[8])
                    {
                    }
                    column(CompanyAddr_1_D; CompanyAddrG[1])
                    {
                    }
                    column(CompanyAddr_2_D; CompanyAddrG[2])
                    {
                    }
                    column(CompanyAddr_3_D; CompanyAddrG[3])
                    {
                    }
                    column(CompanyAddr_4_D; CompanyAddrG[4])
                    {
                    }
                    column(CoTelephoneTextGD; CoTelephoneTextG)
                    {
                    }
                    column(CoFaxTextGD; CoFaxTextG)
                    {
                    }
                    column(CoEmailTextGD; CoEmailTextG)
                    {
                    }
                    column(VATRegistrationNoCpn_CompD; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(TaxNoLblD; CollectiveG.TextShowOutput(C_INC032, PrintAddrBlockG))
                    {
                    }
                    column(CoTelephoneGD; CoTelephoneG)
                    {
                    }
                    column(CoFaxGD; CoFaxG)
                    {
                    }
                    column(CoEmailGD; CoEmailG)
                    {
                    }
                    column(VATRegistrationNo_CompD; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(RegistrationNo_CompD; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(DocumentDate_SHD; FORMAT("Sales Header"."Document Date"))
                    {
                    }
                    column(No_SHD; "Sales Header"."No.")
                    {
                    }
                    column(No_CustGD; CustG."No.")
                    {
                    }
                    column(Name_SalesPurchGD; SalesPurchG.Name)
                    {
                    }
                    column(VATRegistrationNo_SHD; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(VATRegistrationNoCpn_SHD; CollectiveG.TextShowOutput("Sales Header".FIELDCAPTION("VAT Registration No."), "Sales Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(DangerousGoodsListTG__Text_02_; DangerousGoodsListTG."Text 02")
                    {
                    }
                    column(DangerousGoodsListTG__Code_02_; DangerousGoodsListTG."Code 02")
                    {
                    }
                    column(DangerousGoodsListTG__Value_1_; DangerousGoodsListTG."Value 1")
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(DangerousGoodsListTG__Text_01_; DangerousGoodsListTG."Text 01")
                    {
                    }
                    column(DangerousGoodsListTG__Code_01_; DangerousGoodsListTG."Code 01")
                    {
                    }
                    column(HideDangerousGoods; RDLHideOutput(PrintDangerousG))
                    {
                    }
                    column(DangerousGoodsLbl; DangerousGoodsLbl)
                    {
                    }
                    column(Qty_Lbl; Qty_Lbl)
                    {
                    }
                    column(OrderDateLblD; OrderDateLblD)
                    {
                    }
                    column(CustomerNoLblD; CustomerNoLblD)
                    {
                    }
                    column(SalespersonLblD; SalespersonLblD)
                    {
                    }
                    column(PageLblD; PageLblD)
                    {
                    }
                    column(NoLblD; NoLblD)
                    {
                    }
                    column(DescriptionLbl1D; DescriptionLbl1D)
                    {
                    }
                    column(Qty_Caption_D; Qty_CaptionLbl)
                    {
                    }
                    column(Dangerous_Goods_CodeCaption; Dangerous_Goods_CodeCaptionLbl)
                    {
                    }
                    column(DescriptionLblD; DescriptionLblD)
                    {
                    }
                    column(DangerousGoods_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF DangerousGoods.Number = 1 THEN
                            DangerousGoodsListTG.FIND('-')
                        ELSE
                            DangerousGoodsListTG.NEXT;
                    end;

                    trigger OnPostDataItem()
                    begin
                        // Start PA033890.9272400
                        PrintDangerousG := FALSE;
                        DangerousGoodsListTG.DELETEALL;
                        // Stop PA033890.9272400
                    end;

                    trigger OnPreDataItem()
                    begin
                        DangerousGoodsListTG.RESET;
                        SETRANGE(Number, 1, DangerousGoodsListTG.COUNT);
                        // Start PA033890.9272400
                        IF NOT DangerousGoods.ISEMPTY THEN BEGIN
                            PrintDangerousG := TRUE;
                            PrintFooterLineRDLG := FALSE;
                            CopyLoopNoG += 1;
                        END ELSE BEGIN
                            // Start PA035597
                            CurrReport.BREAK;
                            // Stop PA035597
                        END;
                        // Stop PA033890.9272400
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                    END;
                    TotalVehG := 0;
                    SumVehicleG := 0;
                    SumTotVehicleG := 0;
                    SumOwnOptG := 0;
                    SumMfgOptG := 0;
                    SumTransferFeesG := 0;
                    SumOtherG := 0;
                    TotalTradeInG := 0;
                    CurrentVehicleG := 0;
                    // Start PA035597
                    // Stop PA035597
                    // Start PA033890.9272400
                    CopyLoopNoG += 1;
                    InvDiscountAmountTotalG := 0;
                    AmountTotalG := 0;
                    AmountIncludingVATTotalG := 0;
                    // Stop PA033890.9272400
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA044433.102716
                    IF NOT CurrReport.PREVIEW THEN
                        SalesPrintCounterG.RUN("Sales Header");
                    // Stop PA044433.102716
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA043099
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    // Stop PA043099
                    IF NoOfLoopsG <= 0 THEN
                        NoOfLoopsG := 1;
                    CopyTextG := '';
                    SETRANGE(Number, 1, NoOfLoopsG);
                    // Start PA033890.9272400
                    CopyLoopNoG := 0;
                    // Stop PA033890.9272400
                end;
            }

            trigger OnAfterGetRecord()
            var
                InteractionLogL: Record "Interaction Log Entry";
                IntCustL: Code[20];
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA037341
                // Start PA039225.51457
                // Stop PA039225.51457
                // Stop PA037341

                //Start API.1      01.03.18 PV
                IsRepSelectionSetupAvailableG := VehicleReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"Parts Sales Invoice CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                //Stop API.1      01.03.18 PV

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName(USERID);
                //Stop API.1      01.03.18 PV

                // Start PA033890.9272400
                PrintFooterLineRDLG := PrintFooterLineG;
                // Stop PA033890.9272400
                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                DangerousGoodsListTG.DELETEALL;
                IF NOT CustG.GET("Bill-to Customer No.") THEN
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();
                PrintDiscG := "Sales Header"."Show Discount";

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
                // Start PA037341
                IF PrintSentFromLineG THEN
                    CompAddrG := FormatAddrG.GetWindowAddress(C_INC005);
                // Stop PA037341

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
                   OwnBanksG.GET(IntCustL, LocationG."Bank Code") THEN BEGIN // Start API.1      01.03.18 PV
                    BankNameG := OwnBanksG.Name;
                    BankBranchNoG := OwnBanksG."Bank Branch No.";
                    BankSwiftG := OwnBanksG."SWIFT-BIC";
                    BankIbanG := OwnBanksG.IBAN;
                    BankAccountNoG := OwnBanksG."Bank Account No.";
                    // Stop API.1      01.03.18 PV
                    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                END // Start API.1      01.03.18 PV
                ELSE BEGIN
                    BankNameG := CompanyInfoG."Bank Name";
                    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                    BankIbanG := CompanyInfoG.IBAN;
                    BankAccountNoG := CompanyInfoG."Bank Account No.";
                    // Stop API.1      01.03.18 PV
                    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                END; // API.1      01.03.18 PV

                SalesLineG.RESET;
                SalesLineG.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesLineG.SETRANGE("Document No.", "Sales Header"."No.");
                SalesLineG.SETRANGE("VAT Calculation Type", SalesLineG."VAT Calculation Type"::"Differential Tax");
                IF SalesLineG.FIND('-') THEN BEGIN
                    DiffTaxExistsG := TRUE;
                    DoNotShowVATG := TRUE;
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
                FormatAddrG.SalesHeaderBillTo(CustAddrG, "Sales Header");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Header"."Payment Method Code") THEN
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

                FormatAddrG.SalesHeaderShipTo(ShipToAddrG, "Sales Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                IF AddressSalutationG.GET("Sales Header"."Bill-to Salutation Code") THEN
                    SalesAddrSaluationG := AddressSalutationG."Document Salutation";
                IF "Sales Header"."Sell-to Customer No." <> "Sales Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesHeaderCust(OrderCustAddrG, "Sales Header");
                    OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
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
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(30) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::VeSaleRetOrd,
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
            end;
        }
    }

    requestpage
    {
        Caption = 'Vehicle Sales - Order';
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
                        OptionCaption = 'print selected lines,print all lines,print no lines';
                    }
                    field(PrintUnitPrice2G; PrintUnitPrice2G)
                    {
                        Caption = 'Print Unit Price';
                        OptionCaption = 'print selected prices,print all prices,print no prices';
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
                        Caption = 'Without Consideration of Trade In';
                        MultiLine = true;
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
                    field(PrntDangerousGoodsListG; PrntDangerousGoodsListG)
                    {
                        Caption = 'Print Dangerous Goods List';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA035484.20973
            // Start PA039225.51457
            // Stop PA035484.20973
            PrintDiscG := TRUE;
            PrintOption2G := PrintOption2G::"0";
            PrintUnitPrice2G := PrintUnitPrice2G::"0";
            // Start PA036549.33398
            // Stop PA036549.33398
            // Start PA035484.20973
            // Stop PA035484.20973
            // Start PA033336
            // Stop PA033336
            // Start PA036549.33398
            // Stop PA036549.33398
            // Start PA033336
            // Stop PA033336
            GetReportSelection();
            // Stop PA039225.51457
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
        // Start PA035484.20973
        // Start PA039225.51457
        // Stop PA035484.20973
        // Start PA035597
        // Stop PA035597
        GLSetupG.GET;
        PrintOption2G := PrintOption2G::"0";
        PrintUnitPrice2G := PrintUnitPrice2G::"0";

        PrintDiscG := TRUE;
        // Start PA035484.20973
        // Stop PA035484.20973
        // Start PA035484.20973
        // Stop PA035484.20973
        // Start PA035484.20973
        // Stop PA035484.20973
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        GetReportSelection();
        // Stop PA039225.51457
    end;

    var
        ReportLayoutSetupG: Record "Report Layout Setup";
        AddressSalutationG: Record "Address Salutation";
        VehicleReportSelectionG: Record "Vehicle Sales Rep. Selection";
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
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        UserSessionG: Codeunit "User Session Unit";
        SalesPrintCounterG: Codeunit "Sales-Printed";
        ShowCurrencyG: Text[30];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
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
        CustRegisTextG: Text[30];
        CopyTextG: Text[30];
        ShipToAddrG: array[8] of Text[50];
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        DiscTextG: Text[30];
        ReferenceTextG: Text[30];
        TotalInclVATTextG: Text[50];
        SalesAddrSaluationG: Text[30];
        RegisTextG: Text[100];
        OptionFoundG: Boolean;
        ShowUnitsofMeasureG: Boolean;
        TradeInExtraG: Boolean;
        ShowShippingAddrG: Boolean;
        MoreLinesG: Boolean;
        PrintDiscG: Boolean;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        DoNotShowVATG: Boolean;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        ShowSalPriceG: Decimal;
        ShowLineDiscPctG: Decimal;
        DspAmountG: Decimal;
        CountTransAmountOldG: Decimal;
        CurrentVehicleG: Decimal;
        TotalVehG: Decimal;
        TotalTradeInG: Decimal;
        SumOwnOptG: Decimal;
        SumVehicleG: Decimal;
        SumTotVehicleG: Decimal;
        SumMfgOptG: Decimal;
        SumOtherG: Decimal;
        SumChargeItemsG: Decimal;
        SumTransferFeesG: Decimal;
        PrintOption2G: Option "0","1","2";
        PrintUnitPrice2G: Option "0","1","2","3";
        PrintOptionHelpG: Boolean;
        PrintUnitPriceHelpG: Boolean;
        VINOldG: Code[20];
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
        C_INC029: Label 'Copy';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Tax No.';
        SegMgntG: Codeunit SegManagement;
        LogInteractionG: Boolean;
        NormalVATTotalG: Decimal;
        SumwithDiffTaxationG: Decimal;
        SumOnlyDiffTaxationG: Decimal;
        DiffTaxExistsG: Boolean;
        PrntDangerousGoodsListG: Boolean;
        DangerousGoodsListTG: Record "Temporary Statistics" temporary;
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        C_INC033: Label 'Vehicle Sales - Return Order';
        VATLegendsG: Text[15];
        IncrG: Integer;
        C_INC034: Label ' =';
        ShowVehicleTotalsBodyG: Boolean;
        InvDiscountAmountTotalG: Decimal;
        AmountIncludingVATTotalG: Decimal;
        AmountTotalG: Decimal;
        PrintDangerousG: Boolean;
        PrintFooterLineRDLG: Boolean;
        CopyLoopNoG: Integer;
        OrderNoLbl: Label 'Order No.';
        OrderDateLbl: Label 'Order Date';
        PageLbl: Label 'Page';
        CustomerNoLbl: Label 'Customer No.';
        SalespersonLbl: Label 'Salesperson';
        PaymentsToLbl: Label 'Payments to:';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        VAT_IdentifierCaptionLbl: Label 'VAT Identifier';
        CurrentVehicleGCaptionLbl: Label 'Continued';
        CurrentVehicleG_Control22CaptionLbl: Label 'Sum carried forward';
        SumVehicleGCaptionLbl: Label 'Sum Vehicle';
        SumMfgOptGCaptionLbl: Label 'Sum Mgr Option';
        SumOwnOptGCaptionLbl: Label 'Sum Own Option';
        SumTransferFeesGCaptionLbl: Label 'Sum Transfer Fees';
        Sum_Charge_ItemsCaptionLbl: Label 'Sum Charge Items';
        SumOtherGCaptionLbl: Label 'Sum Other';
        InvDiscountAmountTotalGCaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        SalesLineG_MileageCaptionLbl: Label 'Mileage:';
        SalesLineG__License_No__CaptionLbl: Label 'License No.:';
        Vehicle__Registration_Certificate_CaptionLbl: Label 'Vehicle Paper Number:';
        SalesLineG_VINCaptionLbl: Label 'VIN:';
        RegisTextGCaptionLbl: Label 'Initial/Customer Registration:';
        FORMAT_SalesLineG__Vehicle_Status__CaptionLbl: Label 'Vehicle Status:';
        SalesLineG_VIN_Control122CaptionLbl: Label 'VIN:';
        SalesLineG__License_No___Control115CaptionLbl: Label 'License No.:';
        SalesLineG_Mileage_Control116CaptionLbl: Label 'Mileage:';
        Vehicle__Registration_Certificate__Control121CaptionLbl: Label 'Vehicle Paper Number:';
        RegisTextG_Control155CaptionLbl: Label 'Initial/Customer Registration:';
        FORMAT_SalesLineG__Vehicle_Status___Control160CaptionLbl: Label 'Vehicle Status:';
        CurrentVehicleG_Control91CaptionLbl: Label 'Sum carried forward';
        CurrentVehicleG_Control60CaptionLbl: Label 'Sum carried forward';
        CurrentVehicleG_Control42CaptionLbl: Label 'Sum carried forward';
        TotalVehGCaptionLbl: Label 'Vehicle Total';
        TotalCaption_Control167Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        VAT_onCaptionLbl: Label '% VAT on';
        ContinuedCaption_Control111Lbl: Label 'Continued';
        Trade_Ins_CaptionLbl: Label 'Trade-Ins:';
        TotalTradeInGCaptionLbl: Label 'Sum Trade-In';
        PayableCaptionLbl: Label 'Payable';
        MileageCaptionLbl: Label 'Mileage';
        PaymentTermsG_DescriptionCaptionLbl: Label 'Payment Terms';
        DangerousGoodsLbl: Label 'Dangerous Goods';
        OrderNoLblD: Label 'Order No.';
        OrderDateLblD: Label 'Order Date';
        CustomerNoLblD: Label 'Customer No.';
        SalespersonLblD: Label 'Salesperson';
        PageLblD: Label 'Page';
        NoLblD: Label 'No.';
        DescriptionLbl1D: Label 'Description';
        Qty_Lbl: Label 'Qty.';
        Dangerous_Goods_CodeCaptionLbl: Label 'Dangerous Goods Code';
        DescriptionLblD: Label 'Description';
        ReportTitleG: Text[100];
        IsRepSelectionSetupAvailableG: Boolean;
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

    [Scope('Internal')]
    procedure SetVariables(LBoArcheL: Boolean; LNoofCopiesL: Integer; LPrintOptionL: Option "0","1","2"; LPrintUnitPriceL: Option "0","1","2"; LShowUnitsofMeasureL: Boolean; LDoNotShowVATL: Boolean; LTradeInExtraL: Boolean; LPrintSentFromLineL: Boolean; LPrintAddrBlockL: Boolean; LPrintFooterLineL: Boolean)
    begin
        NoOfCopiesG := LNoofCopiesL;
        PrintOption2G := LPrintOptionL;
        PrintUnitPrice2G := LPrintUnitPriceL;
        ShowUnitsofMeasureG := LShowUnitsofMeasureL;
        DoNotShowVATG := LDoNotShowVATL;
        TradeInExtraG := LTradeInExtraL;
        PrintSentFromLineG := LPrintSentFromLineL;
        PrintAddrBlockG := LPrintAddrBlockL;
        PrintFooterLineG := LPrintFooterLineL;
    end;

    [Scope('Internal')]
    procedure getSalPrice(SalesLineP: Record "Sales Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        OptionVariantL: Record "Option Variant";
        SalesPriceL: Decimal;
    begin
        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Return Order");
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
            IF (PrintOption2G = PrintOption2G::"0") OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
               (PrintOption2G = PrintOption2G::"2")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Return Order");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"3") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
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
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Return Order");
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
                   ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1"))
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
    procedure getLineDiscPct(SalesLineP: Record "Sales Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        OptionVariantL: Record "Option Variant";
        LineDiscPctL: Decimal;
    begin
        // 0 = "Line Discount %"
        // 2 = "Inv. Discount Amount"
        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Return Order");
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
            IF (PrintOption2G = PrintOption2G::"0") OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
               (PrintOption2G = PrintOption2G::"2")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Return Order");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
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
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Return Order");
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

            IF (PrintOption2G = PrintOption2G::"0") OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
               ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
               (PrintOption2G = PrintOption2G::"2")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0")) OR
                   ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"2")) OR
                   ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1"))
                THEN
                    SalesLineL.SETRANGE("Print Unit Price", FALSE);
                IF SalesLineL.FIND('-') THEN
                    REPEAT
                        CASE ValueTypeP OF
                            0:
                                LineDiscPctL += SalesLineL."Line Discount %";
                        //        2 : LineDiscPctL += SalesLineL."Inv. Discount Amount";
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;

            IF (PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") THEN BEGIN
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
                        //        2 : LineDiscPctL += SalesLineL."Inv. Discount Amount";
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;

        END;
        EXIT(LineDiscPctL);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPrice(): Boolean
    begin
        IF ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT SalesLineG."Print Option Line" AND SalesLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT SalesLineG."Print Option Line" AND SalesLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"0") AND (PrintUnitPrice2G = PrintUnitPrice2G::"1") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOption2G = PrintOption2G::"1") AND (PrintUnitPrice2G = PrintUnitPrice2G::"0") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           (PrintUnitPrice2G = PrintUnitPrice2G::"2")
        THEN
            EXIT(FALSE)
        ELSE
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
            EXIT(FALSE)
        ELSE
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
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT(NOT ShowOutputP);
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure RDLHideOutputAsInteger(DummyIntegerP: Integer): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility with a dummy integer
        // @ Send different numbers to create new dataset fields
        // @ param DummyIntegerP - Integer
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT(FALSE);
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputSalesLineBody6(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT(((SalesLineG.Type = SalesLineG.Type::" ") OR
          (SalesLineG.Type = SalesLineG.Type::"Account (G/L)")) AND
          ((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND SalesLineG."Print Option Line")) AND
          (SalesLineG."Description 2" <> ''));
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputSalesLineBody7(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" <> SalesLineG."Item Type"::Vehicle) AND
          ((PrintOption2G = PrintOption2G::"1") OR ((PrintOption2G = PrintOption2G::"0") AND
          SalesLineG."Print Option Line")) AND FunctionPrintUnitPrice);
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputSalesLineBody8(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" <> SalesLineG."Item Type"::Vehicle) AND
          ((PrintOption2G = PrintOption2G::"1") OR ((PrintOption2G = PrintOption2G::"0") AND
          SalesLineG."Print Option Line")) AND NOT FunctionPrintUnitPrice);
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputOptnVarColorBody1(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND
          (((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND "Optn Var. Color"."Print Option Line")) AND NOT "Optn Var. Color"."Series Option") AND
          ("Optn Var. Color".Type <> "Optn Var. Color".Type::Vehicle));
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputOptnVarColorBody2(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND
          (((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND "Optn Var. Color"."Print Option Line")) AND "Optn Var. Color"."Series Option") AND
          ("Optn Var. Color".Type <> "Optn Var. Color".Type::Vehicle));
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputOptnVarColorBody3(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND
          ((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND "Optn Var. Color"."Print Option Line")) AND
          ("Optn Var. Color".Type <> "Optn Var. Color".Type::Vehicle) AND
          ("Optn Var. Color"."Description 2" <> ''));
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputOptnVarSeriesBody1(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND
          ((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND "Optn Var. Series"."Print Option Line")) AND
          "Optn Var. Series"."Series Option" AND
          ("Optn Var. Series".Type <> "Optn Var. Series".Type::Vehicle));
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputOptnVarSeriesBody2(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND
          ((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND "Optn Var. Series"."Print Option Line")) AND
          "Optn Var. Series"."Series Option" AND
          ("Optn Var. Series".Type <> "Optn Var. Series".Type::Vehicle) AND ("Optn Var. Series"."Description 2" <> ''));
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputOptionVariantBody1(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND
          ((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND "Option Variant"."Print Option Line")) AND
          ("Option Variant".Type <> "Option Variant".Type::Vehicle));
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure ShowOutputOptionVariantBody2(): Boolean
    begin
        // @ Use this function to get the ShowOutput statement for Section and use it with RDLHideOutput function
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT((SalesLineG.Type = SalesLineG.Type::Item) AND
          (SalesLineG."Item Type" = SalesLineG."Item Type"::Vehicle) AND
          ((PrintOption2G = PrintOption2G::"1") OR
          ((PrintOption2G = PrintOption2G::"0") AND "Option Variant"."Print Option Line")) AND
          ("Option Variant".Type <> "Option Variant".Type::Vehicle) AND ("Option Variant"."Description 2" <> ''));
        // Stop PA033890.9272400
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
        ReportTitleG := C_INC033;
        UserSessionG.GetRecordRef(RecordRefL);
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
        PrintAddrBlockG := VehicleReportSelectionG."Print Address Block";
        PrintFooterLineG := VehicleReportSelectionG."Print Footer Line";
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
        SalesHdrL: Record "Sales Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        SalesHdrL.SETRANGE(SalesHdrL."No.", "Sales Header".GETFILTER("No."));
        IF SalesHdrL.FINDFIRST THEN BEGIN
            IF NOT CustL.GET(SalesHdrL."Bill-to Customer No.") THEN
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


report 80037 "DPG Vehicle Purch.Return Order" // 1057624 "Vehicle Purch. Return Order CZ"
{
    // // @ Area VehiclePurchase
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033011   07.02.12 GC 5983155: VAT legend is not printed correctly
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033336   09.11.12 GC 9200299: RDL Layout Created
    // PA033336   19.11.12 GC 9336600: RDL Layout Modifications
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036547   17.11.14 GF Merge N.6.1.4 to N.7.1.0
    //                        Increased length of some Header textboxes. Added code for Report Title.
    // PA036549   14.01.15 GN 32571 Fixed Sum Migration Totals
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA044433   04.08.17 PT 102716 Added the code to increment the value of "No. Printed"
    // --- 7.2.0 ---
    // EU.0005215 30.08.17 PT 4330 Merge of PA044433.102716
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5045503 Vehicle Purch. Return Order
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed
    // 
    // !vapa - nejsou žádná data, není doladěn, produkuje 2 stránky při žádném záznamu
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/VehiclePurchReturnOrder.rdlc';

    Caption = 'Vehicle Purch. - Return Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST("Return Order"), "Order Type" = CONST("Vehicle Sales & Purchases"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Return Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoopNo; Number)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                    column(VendAddr_1_; BuyFromAddrG[1])
                    {
                    }
                    column(VendAddr_2_; BuyFromAddrG[2])
                    {
                    }
                    column(VendAddr_3_; BuyFromAddrG[3])
                    {
                    }
                    column(VendAddr_4_; BuyFromAddrG[4])
                    {
                    }
                    column(VendAddr_5_; BuyFromAddrG[5])
                    {
                    }
                    column(VendAddr_6_; BuyFromAddrG[6])
                    {
                    }
                    column(VendAddr_7_; BuyFromAddrG[7])
                    {
                    }
                    column(VendAddr_8_; BuyFromAddrG[8])
                    {
                    }
                    column(OrderDate_PH; FORMAT("Purchase Header"."Order Date"))
                    {
                    }
                    column(No_PH; "Purchase Header"."No.")
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
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(CoFaxG; CoFaxG)
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(Name_SalPurch; SalesPurchG.Name)
                    {
                    }
                    column(OurAccountNo_PH; "Purchase Header"."Our Account No.")
                    {
                    }
                    column(CopyTextG; CopyTextG)
                    {
                    }
                    column(PayToAddrLineG; PayToAddrLineG)
                    {
                    }
                    column(ShipToAddrLineG; ShipToAddrLineG)
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(PurchOrderNoLbl; PurchOrderNoLbl)
                    {
                    }
                    column(OrderDateLbl; OrderDateLbl)
                    {
                    }
                    column(PageLbl; PageLbl)
                    {
                    }
                    column(PurchaserLbl; PurchaserLbl)
                    {
                    }
                    column(OurCustomerNoLbl; OurCustomerNoLbl)
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
                    column(PaymentMethodCode_PH; "Purchase Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_PH; "Purchase Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_PH; "Purchase Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_PH; "Purchase Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_PH; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_PH; "Purchase Header"."Tax Registration No.")
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
                    column(DueDate_PH; "Purchase Header"."Due Date")
                    {
                    }
                    column(DueDateCpn_PH; "Purchase Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_PH; "Purchase Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_PH; "Purchase Header".FIELDCAPTION("Variable Symbol"))
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
                    column(DocumentDate_PH; "Purchase Header"."Document Date")
                    {
                    }
                    column(VendNoCpn_PH; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(VendNo_PH; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    dataitem(HeaderHeaderText; "Purch. Document Text")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
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
                    dataitem(PurchaseLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(CollectiveG_TextShowOutput_PurchLineG_FIELDCAPTION__Unit_of_Measure___ShowUnitsofMeasureG_; CollectiveG.TextShowOutput(PurchLineG.FIELDCAPTION("Unit of Measure"), ShowUnitsofMeasureG))
                        {
                        }
                        column(DiscTextG; DiscTextG)
                        {
                        }
                        column(HidePurchaseLineHeader1; RDLHideOutputAsInteger(2))
                        {
                        }
                        column(PurchaseLineNumber; PurchaseLine.Number)
                        {
                        }
                        column(CurrentVehicleG; CurrentVehicleG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineG_Description; PurchLineG.Description)
                        {
                        }
                        column(HidePurchaseLineBody3; RDLHideOutput(PurchLineG.Type = PurchLineG.Type::" "))
                        {
                        }
                        column(PurchLineG_Description_Control58; PurchLineG.Description)
                        {
                        }
                        column(PurchLineG_Quantity; PurchLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowPurchPriceG; ShowPurchPriceG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmountG; DspAmountG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CollectiveG_TextShowOutput_PurchLineG__Unit_of_Measure__ShowUnitsofMeasureG_; CollectiveG.TextShowOutput(PurchLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(HidePurchaseLineBody4; RDLHideOutput(PurchLineG.Type = PurchLineG.Type::"Account (G/L)"))
                        {
                        }
                        column(PurchLineG__Description_2_; PurchLineG."Description 2")
                        {
                        }
                        column(HidePurchaseLineBody5; RDLHideOutput((PurchLineG.Type = 0) OR (PurchLineG.Type = PurchLineG.Type::"Account (G/L)") AND (PurchLineG."Description 2" <> '')))
                        {
                        }
                        column(PrintNoG; PrintNoG)
                        {
                        }
                        column(PurchLineG_Description_Control65; PurchLineG.Description)
                        {
                        }
                        column(PurchLineG_Quantity_Control66; PurchLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowPurchPriceG_Control68; ShowPurchPriceG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG_Control69; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmountG_Control70; DspAmountG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CollectiveG_TextShowOutput_PurchLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control67; CollectiveG.TextShowOutput(PurchLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(HidePurchaseLineBody6; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" <> PurchLineG."Item Type"::Vehicle)))
                        {
                        }
                        column(ShowPurchPriceG_Control1109400000; ShowPurchPriceG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG_Control1109400001; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmountG_Control1109400002; DspAmountG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineG_Quantity_Control1109400003; PurchLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(CollectiveG_TextShowOutput_PurchLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control1109400004; CollectiveG.TextShowOutput(PurchLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(PurchLineG_Description_Control1109400005; PurchLineG.Description)
                        {
                        }
                        column(PrintNoG_Control1109400006; PrintNoG)
                        {
                        }
                        column(HidePurchaseLineBody7; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::"Charge (Item)")))
                        {
                        }
                        column(PurchLineG__Description_2__Control5025400; PurchLineG."Description 2")
                        {
                        }
                        column(HidePurchaseLineBody8; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" <> PurchLineG."Item Type"::Vehicle) AND (PurchLineG."Description 2" <> '')))
                        {
                        }
                        column(VehicleDescriptionG; VehicleDescriptionG)
                        {
                        }
                        column(ShowPurchPriceG_Control143; ShowPurchPriceG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(ShowLineDiscPctG_Control145; ShowLineDiscPctG)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(DspAmountG_Control146; DspAmountG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineG__No__; PurchLineG."No.")
                        {
                        }
                        column(PurchLineG_Quantity_Control1000000000; PurchLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(HidePurchaseLineBody9; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (NOT PrintOptionG OR NOT PrintUnitPriceG OR NOT OptionFoundG)))
                        {
                        }
                        column(CurrentVehicleG_Control22; CurrentVehicleG)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumVehicleG; SumVehicleG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumMfgOptG; SumMfgOptG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePurchaseLineFooter13; RDLHideOutput(SumMfgOptG <> 0))
                        {
                        }
                        column(SumTransferFeesG; SumTransferFeesG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePurchaseLineFooter14; RDLHideOutput(SumTransferFeesG <> 0))
                        {
                        }
                        column(SumOtherG; SumOtherG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePurchaseLineFooter15; RDLHideOutput(SumOtherG <> 0))
                        {
                        }
                        column(InvDiscountAmountTotalG; -InvDiscAmountTotalG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePurchaseLineFooter17; RDLHideOutput(((InvDiscAmountTotalG <> 0) AND (NOT DoNotShowVATG))))
                        {
                        }
                        column(AmountTotalG; AmountTotalG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG_VATAmountText; VATAmountLineG.VATAmountText)
                        {
                        }
                        column(ShowCurrencyG; ShowCurrencyG)
                        {
                        }
                        column(AmountIncludingVATTotalG___AmountTotalG; AmountIncludingVATTotalG - AmountTotalG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATTextG; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePurchaseLineFooter18; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND (NOT DoNotShowVATG)))
                        {
                        }
                        column(TotalInclVATTextG_Control10; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG_Control13; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePurchaseLineFooter19; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND (DoNotShowVATG)))
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
                        column(SumTransferFeesGCaption; SumTransferFeesGCaptionLbl)
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
                            column(PurchLineG_VIN; PurchLineG.VIN)
                            {
                            }
                            column(Vehicle__Registration_Certificate_; "Registration Certificate")
                            {
                            }
                            column(FORMAT_PurchLineG__Vehicle_Status__; FORMAT(PurchLineG."Vehicle Status"))
                            {
                            }
                            column(HideVehicleBody1; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (NOT PrintOptionG OR NOT PrintUnitPriceG OR NOT OptionFoundG)))
                            {
                            }
                            column(Vehicle__Registration_Certificate_Caption; Vehicle__Registration_Certificate_CaptionLbl)
                            {
                            }
                            column(PurchLineG_VINCaption; PurchLineG_VINCaptionLbl)
                            {
                            }
                            column(Vehicle_Status_Caption; Vehicle_Status_CaptionLbl)
                            {
                            }
                            column(Vehicle_VIN; VIN)
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(VIN, PurchLineG.VIN);
                            end;
                        }
                        dataitem("Optn Var. Vehicle"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Purchase), "Document Type" = CONST("Return Order"), Type = CONST(Vehicle));
                            column(VehicleDescriptionG_Control133; VehicleDescriptionG)
                            {
                            }
                            column(Optn_Var__Vehicle_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowPurchPriceG_Control141; ShowPurchPriceG)
                            {
                                AutoFormatExpression = PurchLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPctG_Control148; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmountG_Control149; DspAmountG)
                            {
                                AutoFormatExpression = PurchLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(PurchLineG__No___Control153; PurchLineG."No.")
                            {
                            }
                            column(CollectiveG_TextShowOutput_PurchLineG__Unit_of_Measure__ShowUnitsofMeasureG__Control190; CollectiveG.TextShowOutput(PurchLineG."Unit of Measure", ShowUnitsofMeasureG))
                            {
                            }
                            column(HideOptnVarVehicleBody1; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG AND PrintUnitPriceG) AND (Type = Type::Vehicle)))
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121; Vehicle."Registration Certificate")
                            {
                            }
                            column(PurchLineG_VIN_Control122; PurchLineG.VIN)
                            {
                            }
                            column(FORMAT_PurchLineG__Vehicle_Status___Control54; FORMAT(PurchLineG."Vehicle Status"))
                            {
                            }
                            column(PurchLineG_VIN_Control122Caption; PurchLineG_VIN_Control122CaptionLbl)
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121Caption; Vehicle__Registration_Certificate__Control121CaptionLbl)
                            {
                            }
                            column(Vehicle_Status_Caption_Control56; Vehicle_Status_Caption_Control56Lbl)
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
                                // Start PA033336.9200299
                                IF PrintDiscG THEN BEGIN
                                    ShowPurchPriceG := "Direct Unit Cost";
                                    ShowLineDiscPctG := "Line Discount %";
                                END ELSE BEGIN
                                    ShowPurchPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF DoNotShowVATG THEN BEGIN
                                    DspAmountG := "Amount Including VAT";
                                END ELSE BEGIN
                                    DspAmountG := Amount;
                                END;
                                VehicleDescriptionG := PurchLineG."Shortcut Dimension 2 Code" + ' ' + PurchLineG.Description;
                                // Stop PA033336.9200299
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", PurchLineG."Document No.");
                                SETRANGE("Document Line No.", PurchLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Color"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Purchase), "Document Type" = CONST("Return Order"));
                            column(Optn_Var__Color_Description; Description)
                            {
                            }
                            column(Optn_Var__Color_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowPurchPriceG_Control142; ShowPurchPriceG)
                            {
                                AutoFormatExpression = PurchLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPctG_Control144; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmountG_Control157; DspAmountG)
                            {
                                AutoFormatExpression = PurchLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Optn_Var__Color__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(HideOptnVarColorBody1; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG AND PrintUnitPriceG AND NOT "Series Option") AND (Type <> Type::Vehicle)))
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
                            column(HideOptnVarColorBody2; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG AND ((NOT PrintUnitPriceG) OR "Series Option")) AND (Type <> Type::Vehicle)))
                            {
                            }
                            column(Optn_Var__Color__Description_2_; "Description 2")
                            {
                            }
                            column(HideOptnVarColorBody3; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG) AND (Type <> Type::Vehicle) AND ("Description 2" <> '')))
                            {
                            }
                            column(CurrentVehicleG_Control91; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Purchase Header"."Currency Code";
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
                                // Start PA036549.32571
                                IF Type = Type::"Manuf. Option" THEN BEGIN
                                    IF DoNotShowVATG THEN BEGIN
                                        SumVehicleG -= "Amount Including VAT";
                                        SumMfgOptG += "Amount Including VAT";
                                    END ELSE BEGIN
                                        SumVehicleG -= Amount;
                                        SumMfgOptG += Amount;
                                    END;
                                END;
                                // Stop PA036549.32571

                                // Start PA033336.9200299
                                IF PrintDiscG THEN BEGIN
                                    ShowPurchPriceG := "Direct Unit Cost";
                                    ShowLineDiscPctG := "Line Discount %";
                                END ELSE BEGIN
                                    ShowPurchPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF DoNotShowVATG THEN BEGIN
                                    DspAmountG := "Amount Including VAT";
                                END ELSE BEGIN
                                    DspAmountG := Amount;
                                END;
                                // Stop PA033336.9200299
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Option Type",
                                  "Optn Var. Color"."Option Type"::Color,
                                  "Optn Var. Color"."Option Type"::Upholstery);
                                SETRANGE("Document No.", PurchLineG."Document No.");
                                SETRANGE("Document Line No.", PurchLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Series"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Purchase), "Document Type" = CONST("Return Order"), "Series Option" = CONST(true), "Option Type" = CONST(Option));
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
                            column(HideOptnVarSeriesBody1; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG) AND "Series Option" AND (Type <> Type::Vehicle)))
                            {
                            }
                            column(Optn_Var__Series__Description_2_; "Description 2")
                            {
                            }
                            column(HideOptnVarSeriesBody2; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG) AND "Series Option" AND (Type <> Type::Vehicle) AND ("Description 2" <> '')))
                            {
                            }
                            column(CurrentVehicleG_Control60; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Purchase Header"."Currency Code";
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
                                SETRANGE("Document No.", PurchLineG."Document No.");
                                SETRANGE("Document Line No.", PurchLineG."Line No.");
                            end;
                        }
                        dataitem("Option Variant"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Purchase), "Document Type" = CONST("Return Order"), "Series Option" = CONST(false), "Option Type" = CONST(Option));
                            column(Option_Variant_Description; Description)
                            {
                            }
                            column(Option_Variant_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowPurchPriceG_Control171; ShowPurchPriceG)
                            {
                                AutoFormatExpression = PurchLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(ShowLineDiscPctG_Control172; ShowLineDiscPctG)
                            {
                                DecimalPlaces = 0 : 2;
                            }
                            column(DspAmountG_Control175; DspAmountG)
                            {
                                AutoFormatExpression = PurchLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Option_Variant__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(HideOptionVariantBody1; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG) AND (Type <> Type::Vehicle)))
                            {
                            }
                            column(Option_Variant__Description_2_; "Description 2")
                            {
                            }
                            column(HideOptionVariantBody2; RDLHideOutput((PurchLineG.Type = PurchLineG.Type::Item) AND (PurchLineG."Item Type" = PurchLineG."Item Type"::Vehicle) AND (PrintOptionG) AND (Type <> Type::Vehicle) AND ("Description 2" <> '')))
                            {
                            }
                            column(CurrentVehicleG_Control42; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Purchase Header"."Currency Code";
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
                                // Start PA036549.32571
                                IF Type = Type::"Manuf. Option" THEN BEGIN
                                    IF DoNotShowVATG THEN BEGIN
                                        SumVehicleG -= "Amount Including VAT";
                                        SumMfgOptG += "Amount Including VAT";
                                    END ELSE BEGIN
                                        SumVehicleG -= Amount;
                                        SumMfgOptG += Amount;
                                    END;
                                END;
                                // Stop PA036549.32571

                                // Start PA033336.9200299
                                IF PrintDiscG AND PrintUnitPriceG THEN BEGIN
                                    ShowPurchPriceG := "Direct Unit Cost";
                                    ShowLineDiscPctG := "Line Discount %";
                                END ELSE BEGIN
                                    ShowPurchPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;
                                IF DoNotShowVATG THEN BEGIN
                                    DspAmountG := "Amount Including VAT";
                                END ELSE BEGIN
                                    DspAmountG := Amount;
                                END;
                                // Stop PA033336.9200299
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", PurchLineG."Document No.");
                                SETRANGE("Document Line No.", PurchLineG."Line No.");
                            end;
                        }
                        dataitem(VehicleTotal; "Integer")
                        {
                            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1));
                            column(HideVehicleTotalBody1; RDLHideOutput(ShowVehicleTotalsBodyG))
                            {
                            }
                            column(TotalVehG; TotalVehG)
                            {
                                AutoFormatExpression = PurchLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(TotalVehGCaption; TotalVehGCaptionLbl)
                            {
                            }
                            column(VehicleTotal_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                PurchLineL: Record "Purchase Line";
                            begin
                                // Start PA033336.9200299
                                ShowVehicleTotalsBodyG := FALSE;
                                PurchLineL.RESET;
                                PurchLineL.COPY(PurchLineG);
                                PurchLineL.SETPOSITION(PurchLineG.GETPOSITION);
                                IF PurchLineL.FIND('=') THEN BEGIN
                                    IF PurchLineL.NEXT = 0 THEN BEGIN
                                        IF PurchLineG."Item Type" <> PurchLineG."Item Type"::Item THEN BEGIN
                                            PurchLineL.RESET;
                                            PurchLineL.SETRANGE("Document Type", PurchLineG."Document Type");
                                            PurchLineL.SETRANGE("Document No.", PurchLineG."Document No.");
                                            PurchLineL.SETRANGE("Item Type", PurchLineL."Item Type"::Item);
                                            PurchLineL.SETFILTER("Line No.", '<>%1', PurchLineG."Line No.");
                                            IF PurchLineL.FIND('-') THEN BEGIN
                                                ShowVehicleTotalsBodyG := PurchLineL.VIN <> PurchLineG.VIN;
                                            END ELSE BEGIN
                                                ShowVehicleTotalsBodyG := TRUE;
                                            END;
                                        END ELSE BEGIN
                                            ShowVehicleTotalsBodyG := TRUE;
                                        END;
                                    END ELSE BEGIN
                                        ShowVehicleTotalsBodyG := PurchLineL.VIN <> PurchLineG.VIN;
                                    END;
                                END;
                                IF DoNotShowVATG THEN BEGIN
                                    TotalVehG += PurchLineG."Amount Including VAT";
                                END ELSE BEGIN
                                    TotalVehG += PurchLineG.Amount + PurchLineG."Inv. Discount Amount";
                                END;
                                // Stop PA033336.9200299
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemL: Record Item;
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT PurchLineG.FIND('-') THEN BEGIN
                                    PurchLineG.SETRANGE("Item Type", PurchLineG."Item Type"::Item);
                                    PurchLineG.FIND('-');
                                END;
                                VINOldG := PurchLineG.VIN;
                                // Start PA033336.9200299
                                ShowVehicleTotalsBodyG := FALSE;
                                TotalVehG := 0;
                                CurrentVehicleG := 0;
                            END ELSE BEGIN
                                // Stop PA033336.9200299
                                IF PurchLineG.NEXT = 0 THEN BEGIN
                                    PurchLineG.SETRANGE("Item Type", PurchLineG."Item Type"::Item);
                                    PurchLineG.FIND('-');
                                END;
                                // Start PA033336.9200299
                            END;
                            IF ShowVehicleTotalsBodyG THEN BEGIN
                                TotalVehG := 0;
                                CurrentVehicleG := 0;
                            END;
                            // Stop PA033336.9200299
                            // Check if Option is available
                            OptionVariantG.SETRANGE(Area, OptionVariantG.Area::Purchase);
                            OptionVariantG.SETRANGE("Document Type", PurchLineG."Document Type");
                            OptionVariantG.SETRANGE("Document No.", PurchLineG."Document No.");
                            OptionVariantG.SETRANGE("Document Line No.", PurchLineG."Line No.");
                            OptionFoundG := OptionVariantG.FIND('-');

                            VATAmountLineG.INIT;
                            // Start PA033011.5983155
                            VATAmountLineG."VAT Identifier" := FORMAT(PurchLineG."VAT %");
                            VATAmountLineG."Sales Amount" := PurchLineG.Amount;
                            // Stop PA033011.5983155
                            VATAmountLineG."VAT %" := PurchLineG."VAT %";
                            VATAmountLineG."VAT Base" := PurchLineG.Amount;
                            VATAmountLineG."Amount Including VAT" := PurchLineG."Amount Including VAT";
                            VATAmountLineG.InsertLine;

                            IF DoNotShowVATG THEN BEGIN
                                IF PurchLineG.Type = PurchLineG.Type::Item THEN BEGIN
                                    CASE PurchLineG."Item Type" OF
                                        PurchLineG."Item Type"::Item:
                                            SumOtherG += PurchLineG."Amount Including VAT";
                                        PurchLineG."Item Type"::Vehicle:
                                            SumVehicleG += PurchLineG."Amount Including VAT";
                                        PurchLineG."Item Type"::"Veh. Transfer":
                                            SumTransferFeesG += PurchLineG."Amount Including VAT"
                                    END;
                                END ELSE
                                    SumOtherG += PurchLineG."Amount Including VAT";
                            END ELSE BEGIN
                                IF PurchLineG.Type = PurchLineG.Type::Item THEN BEGIN
                                    CASE PurchLineG."Item Type" OF
                                        PurchLineG."Item Type"::Item:
                                            SumOtherG += PurchLineG.Amount + PurchLineG."Inv. Discount Amount";
                                        PurchLineG."Item Type"::Vehicle:
                                            SumVehicleG += PurchLineG.Amount + PurchLineG."Inv. Discount Amount";
                                        PurchLineG."Item Type"::"Veh. Transfer":
                                            SumTransferFeesG += PurchLineG.Amount + PurchLineG."Inv. Discount Amount";
                                    END;
                                END ELSE
                                    SumOtherG += PurchLineG.Amount + PurchLineG."Inv. Discount Amount";
                            END;
                            // Start PA033336.9200299
                            IF PrintDiscG THEN BEGIN
                                ShowPurchPriceG := PurchLineG."Direct Unit Cost";
                                ShowLineDiscPctG := PurchLineG."Line Discount %"
                            END ELSE BEGIN
                                ShowPurchPriceG := 0;
                                ShowLineDiscPctG := 0;
                            END;
                            IF DoNotShowVATG THEN
                                DspAmountG := PurchLineG."Amount Including VAT"
                            ELSE
                                DspAmountG := PurchLineG.Amount + PurchLineG."Inv. Discount Amount";
                            PrintNoG := PurchLineG."No.";
                            IF PurchLineG.Type = PurchLineG.Type::Item THEN BEGIN
                                IF ItemL.GET(PurchLineG."No.") THEN BEGIN
                                    IF ItemL."Manufacturer No." <> '' THEN BEGIN
                                        PrintNoG := ItemL."Manufacturer No.";
                                    END;
                                END;
                            END;
                            VehicleDescriptionG := PurchLineG."Shortcut Dimension 2 Code" + ' ' + PurchLineG.Description;
                            InvDiscAmountTotalG += PurchLineG."Inv. Discount Amount";
                            AmountTotalG += PurchLineG.Amount;
                            AmountIncludingVATTotalG += PurchLineG."Amount Including VAT";
                            // Stop PA033336.9200299
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            PurchLineG.RESET;
                            PurchLineG.SETRANGE("Document Type", "Purchase Header"."Document Type");
                            PurchLineG.SETRANGE("Document No.", "Purchase Header"."No.");
                            MoreLinesG := PurchLineG.FIND('+');
                            WHILE MoreLinesG AND (PurchLineG.Description = '') AND
                               (PurchLineG."No." = '') AND (PurchLineG.Quantity = 0) AND
                               (PurchLineG.Amount = 0)
                            DO
                                MoreLinesG := NEXT(-1) <> 0;

                            IF NOT MoreLinesG THEN
                                CurrReport.BREAK;

                            PurchLineG.SETRANGE("Line No.", 0, PurchLineG."Line No.");

                            SETRANGE(Number, 1, PurchLineG.COUNT);

                            PurchLineG.SETFILTER("Item Type", '<>%1', PurchLineG."Item Type"::Item);
                            CurrReport.CREATETOTALS(PurchLineG.Amount, PurchLineG."Amount Including VAT",
                              PurchLineG."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrencyG_Control38; ShowCurrencyG)
                        {
                        }
                        column(AmountTotalG_Control44; AmountTotalG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT___; VATAmountLineG."VAT %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(VATAmountLineG__VAT_Base__Control108; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__Amount_Including_VAT____VATAmountLineG__VAT_Base_; VATAmountLineG."Amount Including VAT" - VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterBody3; RDLHideOutput(NOT DoNotShowVATG))
                        {
                        }
                        column(VATAmountLineG__VAT_Base__Control112; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount__Control113; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATTextG_Control48; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG_Control51; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = PurchLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control72; TotalCaption_Control72Lbl)
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
                        column(PaymentTermsG_Description; PaymentTermsG.Description)
                        {
                        }
                        column(ShipMethodG_Description; ShipMethodG.Description)
                        {
                        }
                        column(HidePaymentTermsBody1; RDLHideOutputAsInteger(3))
                        {
                        }
                        column(PaymentTermsG_DescriptionCaption; PaymentTermsG_DescriptionCaptionLbl)
                        {
                        }
                        column(ShipMethodG_DescriptionCaption; ShipMethodG_DescriptionCaptionLbl)
                        {
                        }
                        column(Payment_Terms_Number; Number)
                        {
                        }
                    }
                    dataitem(HeaderFooterText; "Purch. Document Text")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Header/Footer" = CONST(Footer));
                        column(HeaderFooterText_Text; Text)
                        {
                        }
                        column(HideHeaderFooterTextBody1; RDLHideOutputAsInteger(4))
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
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;
                    TotalVehG := 0;
                    SumVehicleG := 0;
                    SumTotVehicleG := 0;
                    SumMfgOptG := 0;
                    SumTransferFeesG := 0;
                    SumOtherG := 0;
                    CurrentVehicleG := 0;
                    // Start PA035597
                    // Stop PA035597
                    // Start PA033336.9200299
                    InvDiscAmountTotalG := 0;
                    AmountTotalG := 0;
                    AmountIncludingVATTotalG := 0;
                    // Stop PA033336.9200299


                    // ?vapa má mít taky duplicate text/obr?
                    // ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    // IF ("Purch. Invoice Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                    //  IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN  //API.1      01.03.18 PV
                    //    DuplicateTextG := C_INC_DuplicateText
                    //  ELSE // Start API.1      01.03.18 PV
                    //    ShowDuplicateImageG := TRUE;
                    // END; // Stop API.1      01.03.18 PV
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA044433.102716
                    IF NOT CurrReport.PREVIEW THEN
                        PurchHdrPrintCounterG.RUN("Purchase Header");
                    // Stop PA044433.102716
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    IF NoOfLoopsG <= 0 THEN
                        NoOfLoopsG := 1;
                    CopyTextG := '';
                    SETRANGE(Number, 1, NoOfLoopsG);
                end;
            }

            trigger OnAfterGetRecord()
            var
                InteractionLogL: Record "Interaction Log Entry";
                IntCustL: Code[20];
            begin
                //Start API.1      01.03.18 PV
                //vapa? vendor lang?
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");

                IsRepSelectionSetupAvailableG := VehicleReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Parts Purch. Invoice CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");

                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Purchase Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Purchase Header"."Original User ID");
                //Stop API.1      01.03.18 PV

                // Start PA036547
                // Start PA039225.51457
                // Stop PA039225.51457
                // Stop PA036547

                IF NOT VendG.GET("Buy-from Vendor No.") THEN
                    CLEAR(VendG);
                CurrReport.LANGUAGE := VendG.DocPrintoutInVendorLanguage();
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

                IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                   OwnBanksG.GET(IntCustL, LocationG."Bank Code")
                THEN BEGIN // Start API.1      01.03.18 PV
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

                PurchLineG.RESET;
                PurchLineG.SETRANGE("Document Type", "Purchase Header"."Document Type");
                PurchLineG.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchLineG.SETRANGE("VAT Calculation Type", PurchLineG."VAT Calculation Type"::"Differential Tax");
                IF PurchLineG.FIND('-') THEN BEGIN
                    DiffTaxG := TRUE;
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
                FormatAddrG.PurchHeaderBuyFrom(BuyFromAddrG, "Purchase Header");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Purchase Header"."Payment Method Code") THEN
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

                FormatAddrG.PurchHeaderShipTo(ShipToAddrG, "Purchase Header");

                IF AddressSalutationG.GET("Purchase Header"."Buy-from Addr. Salutation Code") THEN
                    PurchAddressSalutationG := AddressSalutationG."Document Salutation";
                IF "Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No." THEN BEGIN
                    FormatAddrG.PurchHeaderPayAddr(PayToAddrG, "Purchase Header");
                    PayToAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    PayToAddrLineG := '';

                IF "Purchase Header"."Sell-to Customer No." <> '' THEN BEGIN
                    FormatAddrG.PurchHeaderShipAddr(ShipToAddrG, "Purchase Header");
                    ShipToAddrLineG := C_INC012 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    ShipToAddrLineG := '';

                IF PrintDiscG THEN BEGIN
                    DiscCheckPurchLineG.SETRANGE("Document Type", "Document Type");
                    DiscCheckPurchLineG.SETRANGE("Document No.", "No.");
                    DiscCheckPurchLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckPurchLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';
                IF NOT SalesPurchG.GET("Purchaser Code") THEN
                    SalesPurchG.Name := "Purchaser Code";
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(49) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::VePurRetOrd,
                      "No.",
                      0,
                      0,
                      DATABASE::Vendor,
                      "Pay-to Vendor No.",
                      "Purchaser Code",
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
        Caption = 'Vehicle Purch. Return Order';
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

                        trigger OnValidate()
                        begin
                            IF PrintOptionG THEN
                                PrintUnitPriceG := TRUE
                            ELSE
                                PrintUnitPriceG := FALSE;
                        end;
                    }
                    field(PrintUnitPriceG; PrintUnitPriceG)
                    {
                        Caption = 'Print Unit Price';

                        trigger OnValidate()
                        begin
                            IF PrintUnitPriceG THEN
                                PrintOptionG := TRUE;
                        end;
                    }
                    field(ShowUnitsofMeasureG; ShowUnitsofMeasureG)
                    {
                        Caption = 'Print UoM';
                    }
                    field(DoNotShowVATG; DoNotShowVATG)
                    {
                        Caption = 'Do not show VAT';
                    }
                    field(PrintDiscG; PrintDiscG)
                    {
                        Caption = 'Print discount';
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
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA039225.51457
            PrintOptionG := TRUE;
            PrintUnitPriceG := TRUE;
            PrintDiscG := TRUE;
            // Start PA033336
            // Stop PA033336
            // Start PA033336
            // Stop PA033336
            GetReportSelection();
            // Stop PA039225.51457
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        // Start PA039225.51457
        GLSetupG.GET;
        PrintOptionG := TRUE;
        PrintUnitPriceG := TRUE;
        PrintDiscG := TRUE;
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
        VehicleReportSelectionG: Record "Vehicle Purch. Rep. Selection";
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        PurchLineG: Record "Purchase Line";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        VendG: Record Vendor;
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        DiscCheckPurchLineG: Record "Purchase Line";
        OptionVariantG: Record "Option Variant";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        UserSessionG: Codeunit "User Session Unit";
        PurchHdrPrintCounterG: Codeunit "Purch.Header-Printed";
        ShowCurrencyG: Text[30];
        BankTextG: Text[250];
        PurchAddressSalutationG: Text[30];
        BuyFromAddrG: array[8] of Text[50];
        VehicleDescriptionG: Text[100];
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
        ShipToAddrLineG: Text[250];
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        DiscTextG: Text[30];
        ReferenceTextG: Text[30];
        TotalInclVATTextG: Text[50];
        PayToAddrG: array[8] of Text[50];
        PayToAddrLineG: Text[250];
        CurrentVehicleG: Decimal;
        DspAmountG: Decimal;
        CountTransAmountOldG: Decimal;
        ShowPurchPriceG: Decimal;
        ShowLineDiscPctG: Decimal;
        TotalVehG: Decimal;
        SumVehicleG: Decimal;
        SumTotVehicleG: Decimal;
        SumMfgOptG: Decimal;
        SumOtherG: Decimal;
        SumTransferFeesG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintOptionG: Boolean;
        OptionFoundG: Boolean;
        DiffTaxG: Boolean;
        ShowUnitsofMeasureG: Boolean;
        PrintUnitPriceG: Boolean;
        MoreLinesG: Boolean;
        DoNotShowVATG: Boolean;
        PrintDiscG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        C_INC008: Label 'Payment due on:';
        C_INC009: Label 'Disc. %';
        C_INC010: Label 'Ending Total %1';
        C_INC012: Label 'Ship to:';
        C_INC028: Label 'Series';
        C_INC029: Label 'Copy';
        C_INC031: Label 'Total %1 Incl. VAT';
        VINOldG: Code[20];
        PrintNoG: Code[20];
        SegMgntG: Codeunit SegManagement;
        LogInteractionG: Boolean;
        ShowVehicleTotalsBodyG: Boolean;
        InvDiscAmountTotalG: Decimal;
        C_INC032: Label 'Vehicle Purch. - Return Order';
        AmountTotalG: Decimal;
        AmountIncludingVATTotalG: Decimal;
        PurchOrderNoLbl: Label 'Purch. Order No.';
        OrderDateLbl: Label 'Order Date';
        PageLbl: Label 'Page';
        PurchaserLbl: Label 'Purchaser';
        OurCustomerNoLbl: Label 'Our Customer No.';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        CurrentVehicleGCaptionLbl: Label 'Continued';
        CurrentVehicleG_Control22CaptionLbl: Label 'Sum carried forward';
        SumVehicleGCaptionLbl: Label 'Sum Vehicle';
        SumMfgOptGCaptionLbl: Label 'Sum Mgr Option';
        SumTransferFeesGCaptionLbl: Label 'Sum Transfer Fees';
        SumOtherGCaptionLbl: Label 'Sum Other';
        InvDiscountAmountTotalGCaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        Vehicle__Registration_Certificate_CaptionLbl: Label 'Vehicle Paper Number:';
        PurchLineG_VINCaptionLbl: Label 'VIN:';
        Vehicle_Status_CaptionLbl: Label 'Vehicle Status:';
        PurchLineG_VIN_Control122CaptionLbl: Label 'VIN:';
        Vehicle__Registration_Certificate__Control121CaptionLbl: Label 'Vehicle Paper Number:';
        Vehicle_Status_Caption_Control56Lbl: Label 'Vehicle Status:';
        CurrentVehicleG_Control91CaptionLbl: Label 'Sum carried forward';
        CurrentVehicleG_Control60CaptionLbl: Label 'Sum carried forward';
        CurrentVehicleG_Control42CaptionLbl: Label 'Sum carried forward';
        TotalVehGCaptionLbl: Label 'Vehicle Total';
        TotalCaption_Control72Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        VAT_onCaptionLbl: Label '% VAT on';
        ContinuedCaption_Control111Lbl: Label 'Continued';
        PaymentTermsG_DescriptionCaptionLbl: Label 'Payment Terms';
        ShipMethodG_DescriptionCaptionLbl: Label 'Shipment Method';
        ReportTitleG: Text[100];
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
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA033336
        EXIT(NOT ShowOutputP);
        // Stop PA033336
    end;

    [Scope('Internal')]
    procedure RDLHideOutputAsInteger(DummyIntegerP: Integer): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility with a dummy integer
        // @ Send different numbers to create new dataset fields
        // @ param DummyIntegerP - Integer
        // @ retval - Boolean
        // Start PA033336
        EXIT(FALSE);
        // Stop PA033336
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
        ReportTitleG := C_INC032;
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
                TitleTextRightG := "Purchase Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Purchase Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Purchase Header"."No.";
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


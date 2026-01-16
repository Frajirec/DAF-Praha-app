report 80019 "DPG Parts Purch. Order CZ" // 1057622 "Parts Purch. Order CZ"
{
    // // @ Area PartsPurchase
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033052   05.05.11 PR Added code to print the report title from 'Report Selection' setup.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA033011   07.02.12 GC 5983155: VAT legend is not printed correctly
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   06.09.12 SS 8591510: DataItemTableView property for Purchase Header DataItem modified.
    // PA033336   12.09.12 SS 8660909: '* = Exchange Part' footer note is displayed in case the order contains the Exchange Part.
    //                        - "Purchase Line - OnAfterGetRecord()" trigger modified
    //                        - "Purchase Line, Footer (11)" section modified
    // PA033336   13.09.12 SS 8674318:
    //                        - Print Footer Line function removed
    //                        - Alternative Vendor Address printed
    // PA033336   14.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    // PA033336   17.10.12 SS 8746211: Modified Report - OnInitReport, OnOpenForm, OnOpenPage
    // PA033336   17.10.12 8660909: Exchange Part was missing now it is shown in RDLC.
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036461   29.08.14 GF 27549 RDLC layout corrections for Header to be visible
    // PA037562   23.04.15 UX 35254 The property "Can Grow" has been changed for the field "Item No." in RDLC.
    // PA038227   12.08.15 GN Changed Header information.
    //                        Added Footer functionality.
    // PA038227   24.08.15 GN 43677 Changed Footer functionality
    // PA041125   22.07.16 GV 67084 RDLC Layout Modifications
    //                        RDLC Layout corrections
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA041125   09.08.16 GJ 68126 RDLC Layout Modifications
    // PA041187   11.04.17 GL 93354 PageBreak set to "Between" to avoid extra Page.
    // --- NAVCZ ---
    // API.1      27.03.18 LC report object created as a copy of Report 5028813 Parts Purch. Order
    //                        NAVCZ fields and features added
    //                        localised RDLC layout header information
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  27.04.18 SD Commented-out code removed
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsPurchOrderCZ.rdlc';

    Caption = 'Parts Purch. Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order), "Order Type" = CONST("Parts Sales & Purchases"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Parts Purch. Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            column(ShowShippingAddrG; ShowShippingAddrG)
            {
                Description = 'PA033336';
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
                    column(VendAddr_2_; VendAddrG[2])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(VendAddr_3_; VendAddrG[3])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(VendAddr_4_; VendAddrG[4])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(VendAddr_5_; VendAddrG[5])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(VendAddr_6_; VendAddrG[6])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(VendAddr_7_; VendAddrG[7])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(VendAddr_8_; VendAddrG[8])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(CompanyAddr_1_; CompanyAddrG[1])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddrG[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.67084';
                    }
                    column(CoTelephone; CoTelephoneG)
                    {
                    }
                    column(CoFax; CoFaxG)
                    {
                    }
                    column(Purchase_Header___No__; "Purchase Header"."No.")
                    {
                    }
                    column(CoEmail; CoEmailG)
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Purchase_Header___Order_Date_; "Purchase Header"."Order Date")
                    {
                        Description = 'PA033336';
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
                    {
                    }
                    column(Purchase_Header___Our_Account_No__; "Purchase Header"."Our Account No.")
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
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(DataItem1119432000; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(OutputNoG; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(OrderVendAddrLineG; OrderVendAddrLineG)
                    {
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_6_6_; ReportLayoutSetupG."Footer 6-6")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_5_4_; ReportLayoutSetupG."Footer 5-4")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_6_4_; ReportLayoutSetupG."Footer 6-4")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_5_5_; ReportLayoutSetupG."Footer 5-5")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_6_5_; ReportLayoutSetupG."Footer 6-5")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_5_6_; ReportLayoutSetupG."Footer 5-6")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_2_3_; ReportLayoutSetupG."Footer 2-3")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_3_3_; ReportLayoutSetupG."Footer 3-3")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_4_3_; ReportLayoutSetupG."Footer 4-3")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_5_3_; ReportLayoutSetupG."Footer 5-3")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_6_3_; ReportLayoutSetupG."Footer 6-3")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_2_4_; ReportLayoutSetupG."Footer 2-4")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_3_4_; ReportLayoutSetupG."Footer 3-4")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_4_4_; ReportLayoutSetupG."Footer 4-4")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_2_5_; ReportLayoutSetupG."Footer 2-5")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_3_5_; ReportLayoutSetupG."Footer 3-5")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_4_5_; ReportLayoutSetupG."Footer 4-5")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_2_6_; ReportLayoutSetupG."Footer 2-6")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_3_6_; ReportLayoutSetupG."Footer 3-6")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_4_6_; ReportLayoutSetupG."Footer 4-6")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_6_2_; ReportLayoutSetupG."Footer 6-2")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_5_2_; ReportLayoutSetupG."Footer 5-2")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_4_2_; ReportLayoutSetupG."Footer 4-2")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_3_2_; ReportLayoutSetupG."Footer 3-2")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_2_2_; ReportLayoutSetupG."Footer 2-2")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_1_2_; ReportLayoutSetupG."Footer 1-2")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_1_3_; ReportLayoutSetupG."Footer 1-3")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_1_4_; ReportLayoutSetupG."Footer 1-4")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_1_5_; ReportLayoutSetupG."Footer 1-5")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_1_6_; ReportLayoutSetupG."Footer 1-6")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_1_1_; ReportLayoutSetupG."Footer 1-1")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_2_1_; ReportLayoutSetupG."Footer 2-1")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_3_1_; ReportLayoutSetupG."Footer 3-1")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_4_1_; ReportLayoutSetupG."Footer 4-1")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_5_1_; ReportLayoutSetupG."Footer 5-1")
                    {
                        Description = 'PA038227';
                    }
                    column(ReportLayoutSetupG__Footer_6_1_; ReportLayoutSetupG."Footer 6-1")
                    {
                        Description = 'PA038227';
                    }
                    column(FooterPicture01HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Left".HASVALUE))
                    {
                    }
                    column(FooterPicture02HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Right".HASVALUE))
                    {
                    }
                    column(sep1; FORMAT('-----------------------------------------------------------------------------------------'))
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(Purchase_Header___VAT_Registration_No__; "Purchase Header"."VAT Registration No.")
                    {
                        Description = 'PA041125.67084';
                    }
                    column(DataItem1109400044; CollectiveG.TextShowOutput("Purchase Header".FIELDCAPTION("VAT Registration No."), "Purchase Header"."VAT Registration No." <> ''))
                    {
                        Description = 'PA041125.67084';
                    }
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Purchase_Header___Our_Account_No__Caption; Purchase_Header___Our_Account_No__CaptionLbl)
                    {
                    }
                    column(SalesPurch_NameCaption; SalesPurch_NameCaptionLbl)
                    {
                    }
                    column(Purchase_Header___Order_Date_Caption; Purchase_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(Purchase_Header___No__Caption; Purchase_Header___No__CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
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
                    column(RegistrationNo_Comp; CompanyInfoG."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_Comp; CompanyInfoG."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_Comp; CompanyInfoG."Tax Registration No.")
                    {
                    }
                    column(EmailCpn_Comp; CompanyInfoG.FIELDCAPTION("E-Mail"))
                    {
                    }
                    column(IbanCpn_Comp; CompanyInfoG.FIELDCAPTION(IBAN))
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
                    column(DocumentDate_PHdr; "Purchase Header"."Document Date")
                    {
                    }
                    column(PhoneLbl; PhoneLbl)
                    {
                    }
                    column(SwiftLbl; SwiftLbl)
                    {
                    }
                    column(PaymentMethodDescLbl; PaymentMethodDescLbl)
                    {
                    }
                    column(Description_PayMethod; PaymentMethodG.Description)
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
                    column(DueDateCpn_PHdr; "Purchase Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(DueDate_PHdr; "Purchase Header"."Due Date")
                    {
                    }
                    column(VatDateCpn_PHdr; "Purchase Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VatDate_PHdr; "Purchase Header"."VAT Date")
                    {
                    }
                    column(VarSymbolCpn_PHdr; "Purchase Header".FIELDCAPTION("Variable Symbol"))
                    {
                    }
                    column(VarSymbol_PHdr; "Purchase Header"."Variable Symbol")
                    {
                    }
                    column(PaymentMethod_PHdr; "Purchase Header"."Payment Method Code")
                    {
                    }
                    column(RegistrationNo_PHdr; "Purchase Header"."Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_PHdr; "Purchase Header"."Tax Registration No.")
                    {
                    }
                    column(VatRegistrationNo_PHdr; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(EmployeeFullName; EmployeeFullNameG)
                    {
                    }
                    dataitem("Header Text"; "Purch. Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Order), "Header/Footer" = CONST(Header));
                        column(COPYSTR_Text_1_80_; COPYSTR(Text, 1, 80))
                        {
                        }
                        column(Header_Text_Text; "Header Text".Text)
                        {
                            Description = 'PA033336';
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
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
                        column(DiscText; DiscTextG)
                        {
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line_Description; Description)
                        {
                        }
                        column(TypeG; Type)
                        {
                            Description = 'PA033336';
                        }
                        column(LineTypeG; LineTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Type2G; Type2G)
                        {
                            Description = 'PA033336';
                        }
                        column(Purchase_Line_Description_Control65; Description)
                        {
                        }
                        column(Purchase_Line_Quantity; Quantity)
                        {
                        }
                        column(Purchase_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Purchase_Line__Direct_Unit_Cost_; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control70; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintNo; PrintNoG)
                        {
                        }
                        column(Purchase_Line_Description_Control73; Description)
                        {
                        }
                        column(Purchase_Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Purchase_Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Purchase_Line__Direct_Unit_Cost__Control84; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control86; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control1109400002; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line__Direct_Unit_Cost__Control1109400003; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line__Line_Discount____Control1109400004; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Purchase_Line_Description_Control1109400005; Description)
                        {
                        }
                        column(Purchase_Line_Quantity_Control1109400006; Quantity)
                        {
                        }
                        column(Purchase_Line__Unit_of_Measure__Control1109400007; "Unit of Measure")
                        {
                        }
                        column(PrintNo_Control1109400008; PrintNoG)
                        {
                        }
                        column(Purchase_Line__Description_2_; "Description 2")
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ShowCurrency; ShowCurrencyG)
                        {
                        }
                        column(Purchase_Line__Purchase_Line__Amount; "Purchase Line".Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line___Amount_Including_VAT_____Purchase_Line__Amount____Exch__Parts_Tax_Amount_; "Purchase Line"."Amount Including VAT" - "Purchase Line".Amount - "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPct; VATPctG)
                        {
                        }
                        column(Purchase_Line__VAT_Base_Amount_; "VAT Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchPartG; ExchPartG)
                        {
                        }
                        column(VATAmountLineCountG; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(Purchase_Line__Exch__Parts_Tax_Amount_; "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct; ExchTaxPctG)
                        {
                        }
                        column(Purchase_Line__Exch__Parts_Tax_Base_; "Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Amount_Including_VAT_; "Purchase Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
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
                        column(Purchase_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Purchase_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purchase_Line_Line_No_; "Line No.")
                        {
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
                            //IF "Exch. Parts VAT %" <> 0 THEN
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                                ExchTaxPctG := "Exch. Parts VAT %";

                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLineG.InsertLine;

                            NoPropertyG := '';
                            // Start PA033336
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
                                NoPropertyG := C_INC016;
                                ExchPartG := C_INC_ExchPart;
                            END;
                            // Stop PA033336

                            IF Type = Type::Item THEN
                                SumItemG := SumItemG + Amount + "Inv. Discount Amount"
                            ELSE
                                SumOtherG := SumOtherG + Amount + "Inv. Discount Amount";

                            // Start PA035597
                            LineTypeG := "Purchase Line".Type;
                            IF ("Line Discount Amount" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                "Direct Unit Cost" := (Amount + "Inv. Discount Amount") / Quantity;
                                "Line Discount %" := 0;
                            END;

                            PrintNoG := "No.";
                            IF (Type = Type::Item) AND ItemG.GET("No.") AND (ItemG."Manufacturer No." <> '') THEN
                                PrintNoG := ItemG."Manufacturer No.";
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
                            CLEAR(LineTypeG);
                            // Stop PA033336
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrency_Control37; ShowCurrencyG)
                        {
                        }
                        column(Purchase_Line__Amount; "Purchase Line".Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VAT_IdentifierG; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLineCount1G; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control106; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control107; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control110; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPct_Control94; ExchTaxPctG)
                        {
                        }
                        column(Purchase_Line___Exch__Parts_Tax_Amount_; "Purchase Line"."Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016_Control112; C_INC016)
                        {
                        }
                        column(TotalInclVATText_Control44; TotalInclVATTextG)
                        {
                        }
                        column(Purchase_Line___Amount_Including_VAT_; "Purchase Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control55; TotalCaption_Control55Lbl)
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
                        column(Exch__Tax_fromCaption_Control120; Exch__Tax_fromCaption_Control120Lbl)
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
                    dataitem("Footer Text"; "Purch. Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Order), "Header/Footer" = CONST(Footer));
                        column(COPYSTR_Text_1_80__Control30; COPYSTR(Text, 1, 80))
                        {
                        }
                        column(COPYSTR_Text_81_20__Control1109400001; COPYSTR(Text, 81, 20))
                        {
                        }
                        column(Footer_Text_Text; "Footer Text".Text)
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
                        column(ShipToAddr_1_; ShipToAddrG[1])
                        {
                        }
                        column(ShipToAddr_2_; ShipToAddrG[2])
                        {
                        }
                        column(ShipToAddr_3_; ShipToAddrG[3])
                        {
                        }
                        column(ShipToAddr_4_; ShipToAddrG[4])
                        {
                        }
                        column(ShipToAddr_5_; ShipToAddrG[5])
                        {
                        }
                        column(ShipToAddr_6_; ShipToAddrG[6])
                        {
                        }
                        column(ShipToAddr_7_; ShipToAddrG[7])
                        {
                        }
                        column(ShipToAddr_8_; ShipToAddrG[8])
                        {
                        }
                        column(Ship_to_Caption; Ship_to_CaptionLbl)
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }

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
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    END;
                    // Stop PA033336

                    CurrReport.PAGENO := 1;

                    SumItemG := 0;
                    SumOtherG := 0;
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrintedG.RUN("Purchase Header");
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
                // Start API.1
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                // Stop API.1

                // Start PA038227
                IsRepSelectionSetupAvailableG := ReportSelection2G.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Parts Purch. Order CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA038227

                // Start API.1
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Purchase Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Purchase Header"."Original User ID");
                // Stop API.1


                IF "Buy-from Vendor No." <> '' THEN
                    VendG.GET("Buy-from Vendor No.")
                ELSE
                    CLEAR(VendG);
                CurrReport.LANGUAGE := VendG.DocPrintoutInVendorLanguage();
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

                FormatAddrG.PurchHeaderBuyFrom(VendAddrG, "Purchase Header");

                // API.1
                IF NOT PaymentMethodG.GET("Purchase Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // API.1


                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipMethodG.INIT
                ELSE
                    ShipMethodG.GET("Shipment Method Code");


                FormatAddrG.PurchHeaderShipTo(ShipToAddrG, "Purchase Header");
                IF ("Purchase Header"."Sell-to Customer No." = '') AND ("Purchase Header"."Ship-to Code" = '') THEN
                    ShowShippingAddrG := FALSE
                ELSE
                    ShowShippingAddrG := TRUE;

                IF NOT SalesPurchG.GET("Purchaser Code") THEN
                    SalesPurchG.Name := "Purchaser Code";

                // Start PA033336
                IF "Buy-from Vendor No." <> "Pay-to Vendor No." THEN BEGIN
                    IF VendG.GET("Pay-to Vendor No.") THEN
                        IF AddressSalutationG.GET(VendG."Address Salutation Code") THEN
                            SalutationG := AddressSalutationG."Document Salutation" + ' ';
                    OrderVendAddrLineG := C_INC008 + ' ' + SalutationG + "Pay-to Name" +
                      CollectiveG.TextShowOutput(C_INC005, "Pay-to Name 2" <> '') + "Pay-to Name 2" +
                      CollectiveG.TextShowOutput(C_INC005, "Pay-to Address" <> '') + "Pay-to Address" +
                      CollectiveG.TextShowOutput(C_INC005, "Pay-to Address 2" <> '') + "Pay-to Address 2" +
                      CollectiveG.TextShowOutput(C_INC005, "Pay-to Post Code" <> '') + "Pay-to Post Code" +
                      ' ' + "Pay-to City";
                END ELSE
                    OrderVendAddrLineG := '';
                // Stop PA033336

                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscCheckPurchLineG.SETRANGE("Document Type", "Document Type");
                    DiscCheckPurchLineG.SETRANGE("Document No.", "No.");
                    DiscCheckPurchLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckPurchLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(13) <> '';
                    IF LogInteractionG THEN
                        SegMgntG.LogDocument(
                          13, "No.", 0, 0, DATABASE::Vendor, "Pay-to Vendor No.",
                          "Purchaser Code", '', "Posting Description");
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
        SaveValues = false;

        layout
        {
            area(content)
            {
                Description = 'PA033336';
                group(Option)
                {
                    Description = 'PA033336';
                    field("No. of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                        Description = 'PA033336';
                    }
                    field("Print Sent-From Line"; PrintSentFromLineG)
                    {
                        Caption = 'Print Sent-From Line';
                        Description = 'PA033336';
                    }
                    field("Print Address Block"; PrintAddrBlockG)
                    {
                        Caption = 'Print Address Block';
                        Description = 'PA033336';
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
        // Start PA032727
        // Start PA039225.51457
        // Start PA035597
        // Stop PA035597
        GLSetupG.GET;
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
        DiscCheckPurchLineG: Record "Purchase Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        AddressSalutationG: Record "Address Salutation";
        ReportSelection2G: Record "Report Selection";
        ItemG: Record Item;
        PurchCountPrintedG: Codeunit "Purch.Header-Printed";
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
        UserSessionG: Codeunit "User Session Unit";
        IntCustG: Code[20];
        ShowCurrencyG: Text[30];
        OrderVendAddrLineG: Text[250];
        VendAddrG: array[8] of Text[50];
        ShipToAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        TotalInclVATTextG: Text[50];
        CompAddrG: Text[250];
        CopyTextG: Text[30];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        DiscTextG: Text[30];
        NoPropertyG: Text[30];
        ExchPartG: Text[30];
        SalutationG: Text[30];
        SumItemG: Decimal;
        SumOtherG: Decimal;
        VATPctG: Decimal;
        ExchTaxPctG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        ShowShippingAddrG: Boolean;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Vendor:';
        C_INC009: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC029: Label 'Copy of';
        C_INC031: Label 'Total %1 Incl. VAT';
        IsRepSelectionSetupAvailableG: Boolean;
        PrintNoG: Code[20];
        LogInteractionG: Boolean;
        C_INC032: Label 'Parts Purch. Order';
        C_INC_ExchPart: Label '* = Exchange Part';
        OutputNoG: Integer;
        LineTypeG: Integer;
        Type2G: Integer;
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Purchase_Header___Our_Account_No__CaptionLbl: Label 'Vendor No.';
        SalesPurch_NameCaptionLbl: Label 'Purchaser';
        Purchase_Header___Order_Date_CaptionLbl: Label 'Document Date';
        Purchase_Header___No__CaptionLbl: Label 'Document No.';
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
        TotalCaption_Control55Lbl: Label 'Total';
        ContinuedCaption_Control101Lbl: Label 'Continued';
        VAT_ofCaption_Control104Lbl: Label '% VAT of';
        ContinuedCaption_Control109Lbl: Label 'Continued';
        Exch__Tax_fromCaption_Control120Lbl: Label '% Exch. Tax from';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        Ship_to_CaptionLbl: Label 'Ship to:';
        ReportTitleG: Text[100];
        _API_: Integer;
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
        // Start PA038227
        EXIT(NOT ShowOutputP);
        // Stop PA038227
    end;

    [Scope('Internal')]
    procedure RDLHideOutputAsInteger(DummyIntegerP: Integer): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility with a dummy integer
        // @ Send different numbers to create new dataset fields
        // @ param DummyIntegerP - Integer
        // @ retval - Boolean
        // Start PA038227
        EXIT(FALSE);
        // Stop PA038227
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

    local procedure SetTitles()
    var
        headerGraphicCount: Integer;
    begin
        // @ This function sets variables to  identify whether and where (not) to print Report title and "Document No.", ... on layout
        // Start API.1
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
        // Stop API.1
    end;

    local procedure GetUserIDFullName(UserIDP: Code[50]) FullNameR: Text
    var
        userSetupL: Record "User Setup";
        employeeL: Record Employee;
    begin
        // @ This function get fullname from Employee table of passed user id
        // @ param UserIDP - Code[50]
        // @ retval FullNameR - Text
        // Start API.1
        FullNameR := '';
        IF userSetupL.GET(UserIDP) THEN BEGIN
            IF employeeL.GET(userSetupL."Employee No.") THEN
                FullNameR := employeeL.FullName;
        END;
        EXIT(FullNameR);
        // Stop API.1
    end;
}


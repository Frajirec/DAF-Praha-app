report 80025 "DPG Parts Sales Shipment CZ" // 1057634 "Parts Sales Shipment CZ"
{
    // // @ Area PartsSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033052   05.05.11 PR  Added code to print the report title from 'Report Selection' setup.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incades styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033890   27.11.12 GC 9272400: RDL Layout Created
    // PA034590   18.07.13 WZ Updated captions of "Receipt No." to "Shipment No." and "Receipt Date" to "Shipment Date"
    // PA035395   27.12.13 GD 18593 Fixed "Header Graphic Right" Overlap in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   17.01.13 GF 20145 Added code to set Usage & parameters for printing Deposit Ticket report.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036547   26.11.14 GJ Merge N.6.1.4 to N.7.1.0 - PA035395.18593, PA035484.20145.
    // PA036549   20.01.15 GP 32585 RDLC Layout Corrections
    //                              -Removed Page Break from List1
    //                              -incadeaSetData textbox removed from Header
    //                              -Add functionality to OnOpenPage trigger
    // PA037562   23.04.15 UX 35254 The property "Can Grow" has been changed for the field "Item No." in RDLC.
    // PA038227   12.08.15 GN Changed Header information.
    //                        Added Footer functionality.
    // PA038227   24.08.15 GN 43664 Changed Footer fields sequence.
    // PA038218   18.09.15 IS 44878 "Sales Person" field left indented and size of text box is extended in header.
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457
    // PA042484   20.01.17 PT Added the code on CopyLoop OnPostdataItem to incremnent the value for field "No. Printed"
    //                        - Added the text box in RDLC and sections to print word "DUPLICATE"
    // PA042485   10.05.17 PT 95156 Modified the code in RDLC to get the output of the report
    //                        -Added the check on NoOfCopies value if its less than 0
    // --- 7.1.5 ---
    // PA041125   21.07.16 GV 66987 RDLC Layout Modifications
    // PA041125   16.08.16 GV 68124 RDLC Layout corrections
    // PA041023   28.11.16 KB Report modified to Show VIN field.
    // PA041023   03.02.17 SV 87225 Report Modified to Show "Refernece License No." information and Caption change of "Refernece VIN"
    // --- 7.1.6 ---
    // EU.0002138 28.06.17 AK 2101 Merge of PA042484 & PA042485.95156 & PA042487.99438
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1      27.03.18 LC report object created as a copy of Report 5028809 Parts Sales Shipment
    //                        NAVCZ fields and features added
    //                        localised RDLC layout header information
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  05.02.18 LC header layout corrected
    // API.1.0.3  07.08.18 PV RDLC Layout changed, Final header design
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsSalesShipmentCZ.rdlc';

    Caption = 'Parts Sales Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Parts Sales Shipment';
            column(Sales_Shipment_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoopDocumentPageNo; CopyLoop.Number)
                {
                }
                column(CopyLoopNo; CopyLoopNoG)
                {
                }
                column(ReportLayoutSetupG__Duplicate_Graphic_; ReportLayoutSetupG."Duplicate Graphic")
                {
                }
                column(Picture01HasValue; RDLHideOutput(ReportLayoutSetupG."Header Graphic Left".HASVALUE))
                {
                }
                column(Picture02HasValue; RDLHideOutput(ReportLayoutSetupG."Header Graphic Right".HASVALUE))
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
                column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                {
                }
                column(sep1; FORMAT('-----------------------------------------------------------------------------------------'))
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                {
                    Description = 'PA041125.66987';
                }
                column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                {
                    Description = 'PA041125.66987';
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyAddr_1_; CompanyAddrG[1])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(CompanyAddr_2_; CompanyAddrG[2])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(CoTelephoneG; CoTelephoneG)
                    {
                    }
                    column(CoFaxG; CoFaxG)
                    {
                    }
                    column(DocumentDate_SSH; "Sales Shipment Header"."Document Date")
                    {
                    }
                    column(No_SSH; "Sales Shipment Header"."No.")
                    {
                    }
                    column(OrderNo_SSH; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(CoEmailG; CoEmailG)
                    {
                    }
                    column(CompAddrG; CompAddrG)
                    {
                    }
                    column(OrderDate_SSH; "Sales Shipment Header"."Order Date")
                    {
                    }
                    column(No_Cust; CustG."No.")
                    {
                    }
                    column(Field20; CoFaxTextG)
                    {
                    }
                    column(CoEmailTextG; CoEmailTextG)
                    {
                    }
                    column(CoTelephoneTextG; CoTelephoneTextG)
                    {
                    }
                    column(ShipAddr_1_; ShipToAddrG[1])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(ShipAddr_2_; ShipToAddrG[2])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(ShipAddr_3_; ShipToAddrG[3])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(ShipAddr_4_; ShipToAddrG[4])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(ShipAddr_5_; ShipToAddrG[5])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(ShipAddr_6_; ShipToAddrG[6])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(ShipAddr_7_; ShipToAddrG[7])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(ShipAddr_8_; ShipToAddrG[8])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(Name_SalPur; SalesPurchG.Name)
                    {
                    }
                    column(CopyTextG; CopyTextG)
                    {
                    }
                    column(VATRegistrationNo_SSH; "Sales Shipment Header"."VAT Registration No.")
                    {
                    }
                    column(VATRegistrationNoCpn_SSH; CollectiveG.TextShowOutput("Sales Shipment Header".FIELDCAPTION("VAT Registration No."), "Sales Shipment Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(VATRegistrationNoCpn_Comp; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(VATRegistrationNo1_Comp; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(TaxNoCpn; CollectiveG.TextShowOutput(C_INC033, PrintAddrBlockG))
                    {
                    }
                    column(RegistrationNo1_Comp; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA035484.20145';
                    }
                    column(OrderCustAddrLineG; OrderCustAddrLineG)
                    {
                    }
                    column(DocumentNoLbl; DocumentNoLbl)
                    {
                    }
                    column(DocumentDateLbl1; DocumentDateLbl)
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
                    column(OrderNoLbl; OrderNoLbl)
                    {
                    }
                    column(OrderDateLbl; OrderDateLbl)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA042484';
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(SalesShimentHeader_SupplyVIN; "Sales Shipment Header"."Supply VIN")
                    {
                        Description = 'PA041023';
                    }
                    column(SalesShimentHeader_Reference_LicenseNo; "Sales Shipment Header"."Reference License No.")
                    {
                        Description = 'PA041023.87225';
                    }
                    column(Show_VIN_Boolean_Header; ShowVING)
                    {
                        Description = 'PA041023';
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
                    column(DocumentDate_SHdr; "Sales Shipment Header"."Document Date")
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
                    column(PaymentMethod_SHdr; "Sales Shipment Header"."Payment Method Code")
                    {
                    }
                    column(RegistrationNo_SHdr; "Sales Shipment Header"."Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SHdr; "Sales Shipment Header"."Tax Registration No.")
                    {
                    }
                    column(VatRegistrationNo_SHdr; "Sales Shipment Header"."VAT Registration No.")
                    {
                    }
                    column(PageNoCaption; PageLbl)
                    {
                    }
                    column(EmployeeFullName; EmployeeFullNameG)
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
                    column(Name_SalPurch; SalesPurchG.Name)
                    {
                    }
                    column(NameSalesPurchLbl; NameSalesPurchLbl)
                    {
                    }
                    dataitem("Header Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Shipment), "Header/Footer" = CONST(Header));
                        column(Header_Text_Text; Text)
                        {
                        }
                        column(HideHeaderTextBody1; RDLHideOutputAsInteger(1))
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
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(CollectiveG_TextShowOutput_C_INC011_ShowPricesG_; CollectiveG.TextShowOutput(C_INC011, ShowPricesG))
                        {
                        }
                        column(DiscTextG; DiscTextG)
                        {
                        }
                        column(HideSalesShipmentHeader1; RDLHideOutputAsInteger(2))
                        {
                        }
                        column(Sales_Shipment_Line_Description; Description)
                        {
                        }
                        column(HideSalesShipmentLineBody2; RDLHideOutput(Type = Type::Header))
                        {
                        }
                        column(Sales_Shipment_Line_Description_Control64; Description)
                        {
                        }
                        column(HideSalesShipmentLineBody3; RDLHideOutput(Type = 0))
                        {
                        }
                        column(Sales_Shipment_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Shipment_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Shipment_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Shipment_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Shipment_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(HideSalesShipmentLineBody4; RDLHideOutput(Type = Type::"Account (G/L)"))
                        {
                        }
                        column(Sales_Shipment_Line__No__; "No.")
                        {
                        }
                        column(Sales_Shipment_Line_Description_Control73; Description)
                        {
                        }
                        column(Sales_Shipment_Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Sales_Shipment_Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Sales_Shipment_Line__Unit_Price__Control84; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Shipment_Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(NoPropertyG; NoPropertyG)
                        {
                        }
                        column(HideSalesShipmentLineBody5; RDLHideOutput((Type = Type::Item) OR (Type = Type::Resource)))
                        {
                        }
                        column(Sales_Shipment_Line__Line_Discount____Control1109400000; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Shipment_Line__Unit_Price__Control1109400001; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Shipment_Line__Unit_of_Measure__Control1109400002; "Unit of Measure")
                        {
                        }
                        column(Sales_Shipment_Line_Quantity_Control1109400003; Quantity)
                        {
                        }
                        column(Sales_Shipment_Line_Description_Control1109400004; Description)
                        {
                        }
                        column(Sales_Shipment_Line__No___Control1109400005; "No.")
                        {
                        }
                        column(HideSalesShipmentLineBody6; RDLHideOutput((Type = Type::"Charge (Item)")))
                        {
                        }
                        column(Sales_Shipment_Line__Description_2_; "Description 2")
                        {
                        }
                        column(HideSalesShipmentLineBody7; RDLHideOutput((Type IN [Type::" ", Type::"Account (G/L)", Type::Item, Type::Resource]) AND ("Description 2" <> '')))
                        {
                        }
                        column(C_INC017; C_INC017)
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
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(Sales_Shipment_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Shipment_Line_Line_No_; "Line No.")
                        {
                        }
                        column(SupplyVIN_SalesShipmentLine; "Sales Shipment Line"."Supply VIN")
                        {
                            Description = 'PA041023.87225';
                        }
                        column(Sales_Shipment_Line_Reference_License_No; "Sales Shipment Line"."Reference License No.")
                        {
                            Description = 'PA041023.87225';
                        }
                        column(Show_VIN_Boolean; ShowVING)
                        {
                            Description = 'PA041023';
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemL: Record Item;
                            RefMasterL: Record "Reference Master";
                        begin
                            NoPropertyG := '';
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                                NoPropertyG := C_INC016;
                            IF (Quantity <> 0) AND ("Additional Item" = "Additional Item"::Deposit) THEN BEGIN
                                MARK(TRUE);
                            END;
                            IF (PrntDangerousGoodsListG) AND (Type = Type::Item) THEN BEGIN
                                IF ItemL.GET("No.") THEN BEGIN
                                    IF ItemL."Dangerous Goods Code" <> '' THEN BEGIN
                                        DangerousGoodsListTG.INIT;
                                        DangerousGoodsListTG."Entry No." := DangerousGoodsListTG."Entry No." + 1;
                                        DangerousGoodsListTG."Code 01" := ItemL."No.";
                                        DangerousGoodsListTG."Text 01" := ItemL.Description;
                                        DangerousGoodsListTG."Value 1" := Quantity;
                                        DangerousGoodsListTG."Code 02" := ItemL."Dangerous Goods Code";
                                        RefMasterL.SETRANGE("Make Code", ItemL."Make Code");
                                        RefMasterL.SETRANGE(Type, RefMasterL.Type::"Dangerous Goods Code");
                                        RefMasterL.SETRANGE(Code, ItemL."Dangerous Goods Code");
                                        IF RefMasterL.FINDFIRST THEN
                                            DangerousGoodsListTG."Text 02" := RefMasterL.Description;
                                        DangerousGoodsListTG.INSERT;
                                    END;
                                END;
                            END;
                            // Start PA033890.9272400
                            IF Type IN [Type::Item, Type::Resource, Type::"Charge (Item)", Type::"Account (G/L)"] THEN BEGIN
                                IF ("Line Discount %" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                    "Unit Price" := "Unit Price" * (100 - "Line Discount %") / 100;
                                    "Line Discount %" := 0;
                                END;
                                IF NOT ShowPricesG THEN BEGIN
                                    "Unit Price" := 0;
                                    "Line Discount %" := 0;
                                END;
                            END;
                            // Stop PA033890.9272400
                        end;
                    }
                    dataitem("Footer Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Shipment), "Header/Footer" = CONST(Footer));
                        column(Footer_Text_Text; Text)
                        {
                        }
                        column(HideFooterTextBody1; RDLHideOutputAsInteger(3))
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
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowCustAddrG THEN
                                CurrReport.BREAK;
                        end;
                    }
                }
                dataitem(Deposit; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    trigger OnAfterGetRecord()
                    var
                        DepositReportL: Report "Deposit Ticket";
                    begin
                        IF PrintDepositTicketsG THEN BEGIN
                            "Sales Shipment Line".MARKEDONLY(TRUE);
                            IF "Sales Shipment Line".FIND('-') THEN BEGIN
                                REPEAT
                                    IF ("Sales Shipment Line"."Printed Deposit Tickets" > 0) OR
                                       (DepositReportL.SalShipLinePrtQty("Sales Shipment Line") > 0)
                                    THEN BEGIN
                                        // Start PA035484.20145
                                        UserSessionG.SetUsage(ReportSelection2G.Usage::"Deposit Ticket");
                                        DepositReportL.DefParameters("Sales Shipment Line".TABLECAPTION, CopyTextG,
                                          CopyLoop.Number - 1, 0);
                                        // Stop PA035484.20145
                                        DepositReportL.SETTABLEVIEW("Sales Shipment Line");
                                        DepositReportL.RUNMODAL();
                                        "Sales Shipment Line".FIND('+');
                                    END;
                                UNTIL "Sales Shipment Line".NEXT = 0;
                            END;
                        END;
                    end;
                }
                dataitem(DangerousGoods; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(DangerousGoodsField01; CompAddrG)
                    {
                    }
                    column(DShipAddr_1_; ShipToAddrG[1])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DShipAddr_2_; ShipToAddrG[2])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DShipAddr_3_; ShipToAddrG[3])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DShipAddr_4_; ShipToAddrG[4])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DShipAddr_5_; ShipToAddrG[5])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DShipAddr_6_; ShipToAddrG[6])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DShipAddr_7_; ShipToAddrG[7])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DShipAddr_8_; ShipToAddrG[8])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DangerousGoodsField13; CopyTextG)
                    {
                        Description = 'BMW Position changed';
                    }
                    column(DCompanyAddr_1_; CompanyAddrG[1])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DCompanyAddr_2_; CompanyAddrG[2])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DCompanyAddr_3_; CompanyAddrG[3])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DCompanyAddr_4_; CompanyAddrG[4])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DCompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(DCompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.66987';
                    }
                    column(CoFaxTextG_DG; CoFaxTextG)
                    {
                    }
                    column(CoEmailTextG_DG; CoEmailTextG)
                    {
                    }
                    column(CoTelephoneTextG_DG; CoTelephoneTextG)
                    {
                    }
                    column(VATRegistrationNoCpn_Comp_DG; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(TaxNoCpn_DG; CollectiveG.TextShowOutput(C_INC033, PrintAddrBlockG))
                    {
                    }
                    column(CoTelephoneG_DG; CoTelephoneG)
                    {
                    }
                    column(CoFaxG_DG; CoFaxG)
                    {
                    }
                    column(CoEmailG_DG; CoEmailG)
                    {
                    }
                    column(VATRegistrationNo_Comp_DG; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(RegistrationNo_Comp_DG; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(DocumentDate_SSH_DG; "Sales Shipment Header"."Document Date")
                    {
                    }
                    column(No_SSH_DG; "Sales Shipment Header"."No.")
                    {
                    }
                    column(OrderNo_SSH_DG; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(OrderDate_SSH_DG; "Sales Shipment Header"."Order Date")
                    {
                    }
                    column(No_Cust_DG; CustG."No.")
                    {
                    }
                    column(Name_SalPur_DG; SalesPurchG.Name)
                    {
                    }
                    column(VATRegistrationNo_SSH_DG; "Sales Shipment Header"."VAT Registration No.")
                    {
                    }
                    column(VATRegistrationNoCpn_SSH_DG; CollectiveG.TextShowOutput("Sales Shipment Header".FIELDCAPTION("VAT Registration No."), "Sales Shipment Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(OrderCustAddrLineG_DG; OrderCustAddrLineG)
                    {
                    }
                    column(DangerousGoodsListTG__Code_01_; DangerousGoodsListTG."Code 01")
                    {
                    }
                    column(DangerousGoodsListTG__Text_01_; DangerousGoodsListTG."Text 01")
                    {
                    }
                    column(DangerousGoodsListTG__Value_1_; DangerousGoodsListTG."Value 1")
                    {
                    }
                    column(DangerousGoodsListTG__Code_02_; DangerousGoodsListTG."Code 02")
                    {
                    }
                    column(DangerousGoodsListTG__Text_02_; DangerousGoodsListTG."Text 02")
                    {
                    }
                    column(HideDangerousGoods; RDLHideOutput(PrintDangerousG))
                    {
                    }
                    column(DangerousGoodsLbl; DangerousGoodsLbl)
                    {
                        Description = 'BMW Position changed';
                    }
                    column(CustomerNoLbl_DG; CustomerNoLbl)
                    {
                    }
                    column(OrderNoLbl_DG; OrderNoLbl)
                    {
                    }
                    column(OrderDateLbl_DG; OrderDateLbl)
                    {
                    }
                    column(DocumentNoLbl_DG; DocumentNoLbl)
                    {
                    }
                    column(DocumentDateLbl1_DG; DocumentDateLbl1)
                    {
                    }
                    column(SalespersonLbl_DG; SalespersonLbl)
                    {
                    }
                    column(PageLbl_DG; PageLbl)
                    {
                    }
                    column(NoLbl; NoLbl)
                    {
                    }
                    column(DescriptionLbl; DescriptionLbl)
                    {
                    }
                    column(QtyLbl; QtyLbl)
                    {
                    }
                    column(Dangerous_Goods_CodeLbl; Dangerous_Goods_CodeLbl)
                    {
                    }
                    column(DescriptionLbl2; DescriptionLbl)
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
                            // Start PA042484
                            CopyLoopNoG := CopyLoopNoG + 1;
                            // Stop PA042484
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
                    // Start PA042484
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;

                    ShowDuplicateImageG := FALSE; //  API.1.0.3
                    IF ("Sales Shipment Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN //  API.1.0.3.
                            DuplicateTextG := C_INC_DuplicateText
                        ELSE // Start API.1.0.3
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1.0.3

                    CopyLoopNoG := CopyLoopNoG + 1;
                    // Stop PA042484
                    // Start PA035597
                    // Stop PA035597
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        SalesShptPrintCounterG.RUN("Sales Shipment Header");
                    // Stop PA032727
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA042484
                    CopyTextG := '';
                    SETRANGE(Number, 1, ABS(NoOfCopiesG) + 1);
                    DuplicateTextG := '';
                    // Stop PA042484
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Start API.1
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                // Stop API.1


                DangerousGoodsListTG.DELETEALL;
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelection2G.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Parts Sales Shipment CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593
                // Start PA035484.20145
                // Start PA039225.51457
                // Stop PA039225.51457
                // Stop PA035484.20145

                // Start API.1
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Shipment Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Shipment Header"."User ID");

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;
                // Stop API.1


                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.")
                ELSE
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();
                // Start PA032727
                // Stop PA032727

                IF CurrReport.PREVIEW THEN
                    PrintDepositTicketsG := FALSE;
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

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipMethodG.INIT
                ELSE
                    ShipMethodG.GET("Shipment Method Code");

                FormatAddrG.SalesShptShipTo(ShipToAddrG, "Sales Shipment Header");
                FormatAddrG.SalesShptBillTo(CustAddrG, "Sales Shipment Header");
                ShowCustAddrG := "Bill-to Customer No." <> "Sell-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(CustAddrG) DO
                    IF CustAddrG[IG] <> ShipToAddrG[IG] THEN
                        ShowCustAddrG := TRUE;

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.");

                IF "Sales Shipment Header"."Sell-to Customer No." <> "Sales Shipment Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesShptCust(OrderCustAddrG, "Sales Shipment Header");
                    OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';

                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscCheckSalShipLineG.SETRANGE("Document No.", "No.");
                    DiscCheckSalShipLineG.SETFILTER("Line Discount %", '>%1', 0);
                    IF DiscCheckSalShipLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';

                IF NOT ShowPricesG THEN BEGIN
                    DiscTextG := '';
                END;
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(5) <> '';
                    IF LogInteractionG THEN
                        SegMgntG.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.",
                          "Salesperson Code", '', "Posting Description");
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                // Start PA033890.9272400
                CopyLoopNoG := 0;
                // Stop PA033890.9272400
            end;
        }
    }

    requestpage
    {
        Caption = 'Parts Sales - Shipment';
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

                        trigger OnValidate()
                        begin
                            // Start PA042485.95156
                            IF NoOfCopiesG < 0 THEN
                                ERROR(C_INC_NoOfCopiesValue);
                            //Stop PA042485.95156
                        end;
                    }
                    field(ShowPricesG; ShowPricesG)
                    {
                        Caption = 'Print Prices';
                    }
                    field(SelectionDeposit; PrintDepositTicketsG)
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
                    field(PrntDangerousGoodsList; PrntDangerousGoodsListG)
                    {
                        Caption = 'Print Dangerous Goods List';
                    }
                    field("Print VIN"; ShowVING)
                    {
                        Caption = 'Print VIN/License No';
                        Description = 'PA041023.87225';
                    }
                    field("Re-Print Original Invoice"; RePrintOriginalInvG)
                    {
                        Caption = 'Re-Print Original Invoice';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA036549.32585
            // Start PA039225.51457
            GetReportSelection();
            // Stop PA039225.51457
            // Stop PA036549.32585
        end;
    }

    labels
    {
        Supply_VIN_Caption = 'Reference VIN';
        Reference_License_No = 'Reference License No.';
    }

    trigger OnInitReport()
    begin
        GLSetupG.GET;
        // Start PA032727
        // Start PA039225.51457
        // Start PA035597
        // Stop PA035597
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

    var
        ReportSelectionG: Record "Report Selection";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnDelivAddressG: Record "Ship-to Address";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        DiscCheckSalShipLineG: Record "Sales Shipment Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        InvtSetupG: Record "Inventory Setup";
        SalesShptPrintCounterG: Codeunit "Sales Shpt.-Printed";
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        UserSessionG: Codeunit "User Session Unit";
        IntCustG: Code[20];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        CustAddrG: array[8] of Text[50];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        CopyTextG: Text[30];
        ShipToAddrG: array[8] of Text[50];
        CompAddrG: Text[250];
        NoPropertyG: Text[30];
        DiscTextG: Text[30];
        ReportTitleG: Text[250];
        DuplicateTextG: Text[100];
        NoOfCopiesG: Integer;
        IG: Integer;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        ShowCustAddrG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        PrintDepositTicketsG: Boolean;
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC009: Label 'Disc. %';
        ShowPricesG: Boolean;
        C_INC011: Label 'Unit Price';
        C_INC016: Label '*';
        C_INC017: Label '* = Exchange part';
        C_INC029: Label 'Copy of';
        C_INC033: Label 'Tax No.';
        SegMgntG: Codeunit SegManagement;
        LogInteractionG: Boolean;
        PrntDangerousGoodsListG: Boolean;
        DangerousGoodsListTG: Record "Temporary Statistics" temporary;
        C_INC034: Label 'Parts Sales Shipment';
        CopyLoopNoG: Integer;
        PrintDangerousG: Boolean;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelection2G: Record "Report Selection";
        IsRepSelectionSetupAvailableG: Boolean;
        C_INC_DuplicateText: Label 'D U P L I C A T E';
        C_INC_NoOfCopiesValue: Label 'Please enter value greater than 0 or equal to 0';
        DocumentNoLbl: Label 'Document No.';
        DocumentDateLbl1: Label 'Document Date';
        PageLbl: Label 'Page';
        CustomerNoLbl: Label 'Customer No.';
        SalespersonLbl: Label 'Salesperson';
        OrderNoLbl: Label 'Order No.';
        OrderDateLbl: Label 'Order Date';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        DangerousGoodsLbl: Label 'Dangerous Goods';
        NoLbl: Label 'No.';
        DescriptionLbl: Label 'Description';
        QtyLbl: Label 'Qty.';
        Dangerous_Goods_CodeLbl: Label 'Dangerous Goods Code';
        ShowVING: Boolean;
        RePrintOriginalInvG: Boolean;
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
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        UnitPriceLbl: Label 'Unit Price';
        NameSalesPurchLbl: Label 'Salesperson';
        ShowTaxNoG: Boolean;
        RegistrationNoCustG: Text[20];
        TaxRegistrationNoCustG: Text[20];

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
        ReportTitleG := C_INC034;
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
                TitleTextRightG := "Sales Shipment Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Shipment Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Shipment Header"."No.";
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


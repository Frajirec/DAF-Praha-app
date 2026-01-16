report 80013 "DPG Branch Order Conf. Veh. CZ" // 1057600 "Branch Order Conf. Veh. CZ"
{
    // // @ Area BranchTransaction
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly - Remove VATAmountLineG variable
    // PA033067   12.04.12 DR DE Captions implemented
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   14.09.12 SS 8674987: Added "Print Footer Line" functionality
    //            14.09.12    RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Improvements in Layout readability using RDLC (Description and Caption of report if No. of copy is defined)
    //                        - Standardizing Font size across all controls
    //                        - DataSetFieldName generated for all controls
    //                        - Shipment Date is written as caption on a control in the PageLoop Section
    //                        - Caption for Charging Price is changed for RDLC
    //                        - Global Vairaiable OutputNoG and Text Variable C_INC029 created
    //                        - Layout 1 and Layout 2 Concepts added in Report
    // PA033336   26.09.12    8737882: All the controls in header are aligned vertically.
    // PA033336   17.10.12 SS 8746211 Modified Report - OnInitReport, "Branch Order Header - OnAfterGetRecord()" triggers
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035395   13.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036547   12.11.14 GJ Merge N.6.1.4 to N.7.1.0 - PA035395.18593
    // PA036549   30.12.14 GN 32238 Field Visibility issue fixed
    // PA036549   02.02.15 GJ 32672 Fixed Print Footer Line functionality in Request Page.
    //                        Correct CopyText functionality.
    // PA041125   11.07.16 GQ 65561 Report Layout modifications according to design
    // PA041125   18.07.16 GQ 65561 Report Layout modifications:
    //            - "Copy of" is displayed for copies
    //            - "Shipment Date" replaced by "Order Date"
    //            - RDLC layout modifications
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   01.08.16 JS Merge of PA039225.51457
    // PA041125   12.08.16 GV 68054 RDLC Layout corrections
    // --- NAVCZ ---
    // API.1      27.03.18 LC report object created as a copy of Report 5025375 Branch Order Confirmation Veh.
    //                        NAVCZ fields and features added
    //                        localised RDLC layout header information
    //                        ReportLayoutSetup Translation added
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/BranchOrderConfVehCZ.rdlc';

    Caption = 'Branch Order Confirmation Veh.';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Branch Order Header"; "Branch Order Header")
        {
            DataItemTableView = SORTING("Document Type", "Sell-to Customer No.", "No.") ORDER(Ascending) WHERE("Document Type" = CONST("Branch Order Vehicle"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Branch Order Vehicle';
            column(Branch_Order_Header_Document_Type; "Document Type")
            {
            }
            column(Branch_Order_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(STRSUBSTNO_C_INC004_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(C_INC004, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(CustAddrG_1_; CustAddrG[1])
                    {
                    }
                    column(CompanyAddrG_1_; CompanyAddrG[1])
                    {
                    }
                    column(CustAddrG_2_; CustAddrG[2])
                    {
                    }
                    column(CompanyAddrG_2_; CompanyAddrG[2])
                    {
                    }
                    column(CustAddrG_3_; CustAddrG[3])
                    {
                    }
                    column(CompanyAddrG_3_; CompanyAddrG[3])
                    {
                    }
                    column(CustAddrG_4_; CustAddrG[4])
                    {
                    }
                    column(CompanyAddrG_4_; CompanyAddrG[4])
                    {
                    }
                    column(CustAddrG_5_; CustAddrG[5])
                    {
                    }
                    column(CompanyInfoG__Phone_No__; CompanyInfoG."Phone No.")
                    {
                    }
                    column(CustAddrG_6_; CustAddrG[6])
                    {
                    }
                    column(CustAddrG_7_; CustAddrG[7])
                    {
                        Description = 'PA041125.65561';
                    }
                    column(CustAddrG_8_; CustAddrG[8])
                    {
                        Description = 'PA041125.65561';
                    }
                    column(CompanyInfoG__Fax_No__; CompanyInfoG."Fax No.")
                    {
                    }
                    column(CompanyInfoG__VAT_Registration_No__; CompanyInfoG."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoG__Giro_No__; CompanyInfoG."Giro No.")
                    {
                    }
                    column(CompanyInfoG__Bank_Name_; CompanyInfoG."Bank Name")
                    {
                    }
                    column(CompanyInfoG__Bank_Account_No__; CompanyInfoG."Bank Account No.")
                    {
                    }
                    column(Branch_Order_Header___Bill_to_Customer_No__; "Branch Order Header"."Bill-to Customer No.")
                    {
                    }
                    column(VATNoTextG; VATNoTextG)
                    {
                    }
                    column(Branch_Order_Header___VAT_Registration_No__; "Branch Order Header"."VAT Registration No.")
                    {
                    }
                    column(FORMAT__Branch_Order_Header___Shipment_Date__; FORMAT("Branch Order Header"."Shipment Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(Branch_Order_Header___Order_Date; FORMAT("Branch Order Header"."Order Date"))
                    {
                        Description = 'PA041125.65561';
                    }
                    column(SalespersonTextG; SalespersonTextG)
                    {
                    }
                    column(SalesPurchPersonG_Name; SalesPurchPersonG.Name)
                    {
                    }
                    column(Branch_Order_Header___No__; "Branch Order Header"."No.")
                    {
                    }
                    column(ReferenceTextG; ReferenceTextG)
                    {
                    }
                    column(Branch_Order_Header___Your_Reference_; "Branch Order Header"."Your Reference")
                    {
                    }
                    column(CompanyAddrG_5_; CompanyAddrG[5])
                    {
                    }
                    column(CompanyAddrG_6_; CompanyAddrG[6])
                    {
                    }
                    column(Branch_Order_Header___Sell_to_Customer_No__; "Branch Order Header"."Sell-to Customer No.")
                    {
                    }
                    column(OutputNo; OutputNoG)
                    {
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(STRSUBSTNO_C_INC003_CopyText_; ReportTitleG)
                    {
                        Description = 'PA039225.51457';
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(C_INC006; C_INC006)
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
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA041125.65561';
                    }
                    column(QtyLbl; QtyLbl)
                    {
                        Description = 'PA041125.68054';
                    }
                    column(Cust_NoLbl; Cust_NoLbl)
                    {
                        Description = 'PA041125.65561';
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField41; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA036547';
                    }
                    column(CompanyInfoG__Phone_No__Caption; CompanyInfoG__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfoG__Fax_No__Caption; CompanyInfoG__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfoG__VAT_Registration_No__Caption; CompanyInfoG__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfoG__Giro_No__Caption; CompanyInfoG__Giro_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfoG__Bank_Name_Caption; CompanyInfoG__Bank_Name_CaptionLbl)
                    {
                    }
                    column(CompanyInfoG__Bank_Account_No__Caption; CompanyInfoG__Bank_Account_No__CaptionLbl)
                    {
                    }
                    column(Branch_Order_Header___Bill_to_Customer_No__Caption; Branch_Order_Header___Bill_to_Customer_No__CaptionLbl)
                    {
                    }
                    column(Order_DateCaption; Order_DateCaptionLbl)
                    {
                        Description = 'PA041125.65561';
                    }
                    column(Order_No_Caption; Order_No_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
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
                    column(Email_Comp; CompanyInfoG.FIELDCAPTION("E-Mail"))
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
                    column(DocumentDate_PHdr; "Branch Order Header"."Document Date")
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
                    column(PaymentMethod_BHdr; "Branch Order Header"."Payment Method Code")
                    {
                    }
                    column(VatRegistrationNo_BHdr; "Branch Order Header"."VAT Registration No.")
                    {
                    }
                    column(EmployeeFullName; EmployeeFullNameG)
                    {
                    }
                    dataitem("Branch Order Line"; "Branch Order Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Branch Order Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(Branch_Order_Line___No__Caption; Branch_Order_Line___No__CaptionLbl)
                        {
                        }
                        column(Branch_Order_Line__Description_Control63Caption; FIELDCAPTION(Description))
                        {
                        }
                        column(Branch_Order_Line__QuantityCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(Branch_Order_Line___Unit_of_Measure_Caption; Branch_Order_Line___Unit_of_Measure_CaptionLbl)
                        {
                        }
                        column(Branch_Order_Line___Location_Code_Caption; Branch_Order_Line___Location_Code_CaptionLbl)
                        {
                        }
                        column(Branch_Order_Line___New_Location_Code_Caption; Branch_Order_Line___New_Location_Code_CaptionLbl)
                        {
                        }
                        column(Charging_PriceCaption; Charging_PriceCaptionLbl)
                        {
                        }
                        column(Branch_Order_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Branch_Order_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Branch_Order_Line_Line_No_; "Line No.")
                        {
                        }
                        dataitem(OutputDocumentLine; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(Branch_Order_Line__Description; "Branch Order Line".Description)
                            {
                            }
                            column(Branch_Order_Line__Type; "Branch Order Line".Type)
                            {
                                Description = 'PA033336';
                            }
                            column(LineTypeG; LineTypeG)
                            {
                                Description = 'PA033336';
                            }
                            column(Branch_Order_Line___Unit_of_Measure_; "Branch Order Line"."Unit of Measure")
                            {
                                Description = 'PA033336';
                            }
                            column(Branch_Order_Line__Quantity; "Branch Order Line".Quantity)
                            {
                            }
                            column(Branch_Order_Line__Description_Control63; "Branch Order Line".Description)
                            {
                            }
                            column(Branch_Order_Line___No__; "Branch Order Line"."No.")
                            {
                            }
                            column(Branch_Order_Line___Location_Code_; "Branch Order Line"."Location Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Branch_Order_Line___New_Location_Code_; "Branch Order Line"."New Location Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Branch_Order_Line___Charging_Price_; "Branch Order Line"."Charging Price")
                            {
                                AutoFormatExpression = "Branch Order Line"."Currency Code";
                                AutoFormatType = 1;
                                Description = 'PA033336';
                            }
                            column(OutputDocumentLine_Number; Number)
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, 1);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033336
                            LineTypeG := "Branch Order Line".Type;
                            // Stop PA033336
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(ShipmentMethodG_Description; ShipMethodG.Description)
                        {
                        }
                        column(ShipmentMethodG_DescriptionCaption; ShipmentMethodG_DescriptionCaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(ShipToAddrG_8_; ShipToAddrG[8])
                        {
                        }
                        column(ShipToAddrG_7_; ShipToAddrG[7])
                        {
                        }
                        column(ShipToAddrG_6_; ShipToAddrG[6])
                        {
                        }
                        column(ShipToAddrG_5_; ShipToAddrG[5])
                        {
                        }
                        column(ShipToAddrG_4_; ShipToAddrG[4])
                        {
                        }
                        column(ShipToAddrG_3_; ShipToAddrG[3])
                        {
                        }
                        column(ShipToAddrG_2_; ShipToAddrG[2])
                        {
                        }
                        column(ShipToAddrG_1_; ShipToAddrG[1])
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
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
                    CLEAR(SalesLine2G);

                    // Start PA033336
                    IF NoOfLoopsG >= 1 THEN
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                    // Stop PA035597
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;
                    CurrReport.PAGENO := 1;
                    // Stop PA033336
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

                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPersonG);
                    SalespersonTextG := '';
                END ELSE BEGIN
                    SalesPurchPersonG.GET("Salesperson Code");
                    SalespersonTextG := 'Salesperson';
                END;
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
                    TotalTextG := STRSUBSTNO(C_INC001, GLSetupG."LCY Code");
                    TotalInclVATTextG := STRSUBSTNO(C_INC002, GLSetupG."LCY Code");
                END ELSE BEGIN
                    TotalTextG := STRSUBSTNO(C_INC001, "Currency Code");
                    TotalInclVATTextG := STRSUBSTNO(C_INC002, "Currency Code");
                END;

                FormatVehicleAddrG.BrnchOrdHdrSoldTo(CustAddrG, "Branch Order Header");

                // API.1
                IF NOT PaymentMethodG.GET("Branch Order Header"."Payment Method Code") THEN
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

                FormatVehicleAddrG.BrnchOrdHdrShipTo(ShipToAddrG, "Branch Order Header");
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(
                  ReportLayoutSetupG, "Make Code", "Location Code", REPORT::"DPG Branch Order Conf. Veh. CZ"); // API.1
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Make Code", "Location Code");
                // Stop PA035395.18593

                // Start API.1
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Branch Order Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Branch Order Header"."User ID");
                // Stop API.1
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
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
                group(Control1101338950)
                {
                    ShowCaption = false;
                    field("No Of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No Of Copies';
                    }
                    field("Print Footer Line"; PrintFooterLineG)
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
            // Start PA036549.32672
            // Start PA039225.51457
            GetReportSelection();
            // Stop PA039225.51457
            // Stop PA036549.32672
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
        GetReportSelection();
        // Stop PA039225.51457
        // Stop PA033336
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        ShipMethodG: Record "Shipment Method";
        PaymentTermsG: Record "Payment Terms";
        SalesPurchPersonG: Record "Salesperson/Purchaser";
        CompanyInfoG: Record "Company Information";
        SalesLine2G: Record "Branch Order Line" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Rep. Selection - Branch Order";
        SalesCountPrintedG: Codeunit "Sales-Printed";
        FormatAddrG: Codeunit "Format Address";
        FormatVehicleAddrG: Codeunit "Veh Format Address";
        SalesPostG: Codeunit "Sales-Post";
        UserSessionG: Codeunit "User Session Unit";
        CustAddrG: array[8] of Text[50];
        ShipToAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        SalespersonTextG: Text[30];
        VATNoTextG: Text[30];
        ReferenceTextG: Text[30];
        TotalTextG: Text[50];
        TotalInclVATTextG: Text[50];
        CopyTextG: Text[30];
        MoreLinesG: Boolean;
        PrintFooterLineG: Boolean;
        PageLoopFooterG: Integer;
        ShowShippingAddrG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        OutputNoG: Integer;
        C_INC001: Label 'Total %1';
        C_INC002: Label 'Total %1 Incl. VAT';
        C_INC003: Label 'Branch Order Confirmation Vehicle %1';
        C_INC004: Label 'Page %1';
        C_INC029: Label 'Copy of';
        C_INC030: Label 'Branch Order Confirmation Vehicle';
        C_INC006: Label 'Page';
        LineTypeG: Integer;
        CompanyInfoG__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfoG__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfoG__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        CompanyInfoG__Giro_No__CaptionLbl: Label 'Giro No.';
        CompanyInfoG__Bank_Name_CaptionLbl: Label 'Bank';
        CompanyInfoG__Bank_Account_No__CaptionLbl: Label 'Account No.';
        Branch_Order_Header___Bill_to_Customer_No__CaptionLbl: Label 'Ship to :';
        Order_DateCaptionLbl: Label 'Order Date';
        Order_No_CaptionLbl: Label 'Order No.';
        Branch_Order_Line___No__CaptionLbl: Label 'No.';
        Branch_Order_Line___Unit_of_Measure_CaptionLbl: Label 'UoM';
        Branch_Order_Line___Location_Code_CaptionLbl: Label 'Location';
        Branch_Order_Line___New_Location_Code_CaptionLbl: Label 'New Location';
        Charging_PriceCaptionLbl: Label 'Charging Price';
        ShipmentMethodG_DescriptionCaptionLbl: Label 'Shipment Method';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
        Cust_NoLbl: Label 'Customer No.';
        ReportTitleG: Text[100];
        QtyLbl: Label 'Qty.';
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

        // Start PA035395.18593
        EXIT(NOT ShowOutputP);
        // Stop PA035395.18593
    end;

    [Scope('Internal')]
    procedure GetReportSelection()
    var
        RecordRefL: RecordRef;
    begin
        // @ Picks all the parameters from Report Selection through User Session Unit.

        // Start PA039225.51457
        ReportSelectionG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC003;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionG);
            IF ReportSelectionG."Print Report Title" THEN
                ReportTitleG := ReportSelectionG."Report Title"
            ELSE BEGIN
                ReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        PrintFooterLineG := ReportSelectionG."Print Footer Line";
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
                TitleTextRightG := "Branch Order Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Branch Order Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Branch Order Header"."No.";
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


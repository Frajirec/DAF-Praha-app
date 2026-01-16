report 80039 "DPG Vehicle Sales Order CZ" // 1057605 "Vehicle Sales Order CZ"
{
    // // @ Area VehicleSales
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
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                        Moved the VATTextLoop, VATTextLine Dataitem position as last footer.
    // PA032727   12.07.11 PR 3534679: Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032651   27.07.11 PR 4262653: Increased width of 'VAT Identifier' control.
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6220283: Layout Changes for Vat
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
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
    // PA033336   03.10.12 8789623: New "VAT Identifier" control is added in classic client and RDLC layout.
    //                        Modified code to print the correct "Amount" and 'Total' values.
    //                        Filter is applied in Body Section of RDLC layout.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Sales Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (5) - OnPreSection()", "PageLoop, Footer (6) - OnPreSection()"
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033765   21.12.12 GC EUTireData Dataitem added
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036090   10.07.14 GJ 24365 Modified RDL Layout to correct Header and Print.
    // PA035395   27.12.13 GD 18593 Fixed FooterLines visibility in RTC.
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035766   07.03.14 GF Fixed RDL layout to not print unnecessary empty lines.
    // PA035484   01.04.14 GF 20756 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036395   23.07.14 MC 26382 Modified Vehicle total for DIFF Tax to print amount including vat
    //                              Changed the footer for the total amount for DIFF TAX
    //                              If there are lines of DIFF TAX, the report will act as if "Do not show VAT" was selected
    //                              New Text constant C_INC_total
    // PA036549   13.01.15 GN 32374 Visibility issues fixed
    // PA037341   21.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA036395.26382
    // PA036549   28.01.15 GK 33228 FooterLine functionality moved to OnOpenPage trigger
    // PA038229   10.07.15 GJ Added Header information.
    //                        Added Footer functionality.
    //                        Added detailed information for the Model/Vehicle.
    // PA038229   22.07.15 GK 41878 RDLC Layout Fixes
    // PA038218   18.09.15 IS 44878 "Sales Person" field left indented and size of text box is extended in header.
    // PA039048   09.10.15 VJ "PrintOptionG" and "PrintUnitPriceG" in Request Page added OptionCaption and OptionCaptionML.
    // PA039049   13.10.15 VJ Merge of PA039048.
    // PA039959   17.02.16 KR Interchanged OptVariantType4G and OptVariantType3G.
    // PA039960   17.02.16 KR Merge of PA039959.
    // PA040293   16.03.16 KR Code changed to make the trade amount rounded according to the rounding setup.
    // PA040294   16.03.16 KR Merge of PA040293.
    // PA040256   08.04.16 GV 57127 Get Amount Rounding Precision from Currency table
    // PA041125   19.07.16 GQ 66556 RDLC layout modifications
    // PA041125   20.07.16 GQ 66556 - "Shipment Date" field removed
    //                              - layout modifications
    // PA041125   21.07.16 GQ 66556 RDLC layout modifications
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457
    // PA041125   12.08.16 GV 68107 RDLC Layout corrections
    // PA042665   17.01.17 JV 86105 Added dataitem Emission Related Text and added a table to display Emission Related Text in layout
    // PA041687   18.01.17 IM Report adapted for not own vehicles
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   09.03.17 IM 90151 Dafault value for option - print not owned vehicles
    // 
    // EU.0000045 23.06.17 DT Support of automatic signature received from webservice
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1      27.03.18 LC report object created as a copy of Report 5025408 Vehicle Sales Order
    //                        NAVCZ fields and features added
    //                        localised RDLC layout header information
    //                        ReportLayoutSetup Translation added
    // API.1.0.2  07.06.18 PV RDLC Layout changed, Final header design, bank source
    //                        put VAT% instead of VAT identifier
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/VehicleSalesOrderCZ.rdlc';

    Caption = 'Vehicle Sales Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order), "Order Type" = CONST("Vehicle Sales & Purchases"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            column(CityCaption; CityCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Signatures_Lbl_Caption; Signatures_Lbl)
            {
                Description = 'PA040669.61931';
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(HideSignature; HideSignatureG)
            {
            }
            column(Signature_Client_Graphic; SignatureClientTG.Blob)
            {
            }
            column(Signature_Representative_Graphic; SignatureRepresentativeTG.Blob)
            {
            }
            column(Signature_City_Date; SignatureCityDateG)
            {
            }
            column(Signature_City_Date_Caption; SignatureCityDateCaptionG)
            {
            }
            column(Signature_Client_Graphic_Caption; SignatureClient_Lbl)
            {
            }
            column(Signature_Representative_Graphic_Caption; SignatureRepresentative_Lbl)
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
                    column(Sales_Header___Document_Date_; "Sales Header"."Document Date")
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(Sales_Header___Order_Date_; "Sales Header"."Order Date")
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Header___Order_Date_Caption; "Sales Header".FIELDCAPTION("Order Date"))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Header___Shipment_Date_; "Sales Header"."Shipment Date")
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Header___Shipment_Date_Caption; "Sales Header".FIELDCAPTION("Shipment Date"))
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
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(CustAddr_7_; CustAddrG[7])
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
                    column(DataItem163; CollectiveG.TextShowOutput("Sales Header".FIELDCAPTION("VAT Registration No."), "Sales Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo_FIELDCAPTION__VAT_Registration_No_____PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__VAT_Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_C_INC032__PrintAddrBlock_; CollectiveG.TextShowOutput(C_INC032, PrintAddrBlockG))
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo__Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(OutputNo; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(DoNotShowVAT_Control1101338997; DoNotShowVATG)
                    {
                        Description = 'PA033336';
                    }
                    column(TradeInExtra; TradeInExtraG)
                    {
                        Description = 'PA033336';
                    }
                    column(ShowUnitsofMeasure; ShowUnitsofMeasureG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintAddrBlock; PrintAddrBlockG)
                    {
                        Description = 'PA033336';
                    }
                    column(PrintSentFromLine; FORMAT(PrintSentFromLineG))
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
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(PageLoopFooterG; FORMAT(PageLoopFooterG))
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
                    column(ReportLayoutSetupG__Footer_Graphic_Right_HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Right".HASVALUE))
                    {
                        Description = 'PA038229';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Left".HASVALUE))
                    {
                        Description = 'PA038229';
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
                    column(Sales_Header___No__Caption; Sales_Header___No__CaptionLbl)
                    {
                    }
                    column(Sales_Header___Document_Date_Caption; Sales_Header___Document_Date_CaptionLbl)
                    {
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
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
                        Description = 'PA038229';
                    }
                    column(HideVehicleMainInfoG; HideVehicleMainInfoG)
                    {
                        Description = 'PA038229.41878';
                    }
                    column(Vehicle_VIN_Hdr; SalesLine3G.VIN)
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_VIN_HdrCaption; SalesLine3G.FIELDCAPTION(VIN))
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__Make_Code_; SalesLine3G."Shortcut Dimension 2 Code")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle__Make_Code_Caption; SalesLine3G.FIELDCAPTION("Shortcut Dimension 2 Code"))
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
                    column(Sales_Line__Book_No_; SalesLine3G."Book No.")
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Line__Book_No_Caption; SalesLine3G.FIELDCAPTION("Book No."))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Line__Vehicle_Status_; FORMAT(SalesLine3G."Vehicle Status"))
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Line__Vehicle_Status_Caption; FORMAT__Sales_Line___Vehicle_Status__CaptionLbl)
                    {
                        Description = 'PA038229';
                    }
                    column(Sales_Line__From_Purch__Document_No_; SalesLine3G."From Purch. Document No.")
                    {
                        Description = 'PA038229';
                    }
                    column(Vehicle_Initial_Registration_; VehicleG."Initial Registration")
                    {
                        Description = 'PA038229,PA041125.66556';
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
                        Description = 'PA038229,PA041125.68107';
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
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA041125.66556';
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA041125.66556';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA041125.66556';
                    }
                    column(ofLbl; ofLbl)
                    {
                        Description = 'PA041125.66556';
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
                    column(DocumentDate_SHdr; "Sales Header"."Document Date")
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
                    column(DueDateCpn_SHdr; "Sales Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(DueDate_SHdr; "Sales Header"."Due Date")
                    {
                    }
                    column(VatDateCpn_SHdr; "Sales Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VatDate_SHdr; "Sales Header"."VAT Date")
                    {
                    }
                    column(VarSymbolCpn_SHdr; "Sales Header".FIELDCAPTION("Variable Symbol"))
                    {
                    }
                    column(VarSymbol_SHdr; "Sales Header"."Variable Symbol")
                    {
                    }
                    column(PaymentMethod_SHdr; "Sales Header"."Payment Method Code")
                    {
                    }
                    column(RegistrationNo_SHdr; "Sales Header"."Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SHdr; "Sales Header"."Tax Registration No.")
                    {
                    }
                    column(VatRegistrationNo_SHdr; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(PageNoCaption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(EmployeeFullName; EmployeeFullNameG)
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
                    column(WithoutVATLbl; WithoutVATLbl)
                    {
                    }
                    column(ShowVehicleInfo; ShowVehicleInfoG)
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
                        column(HeaderHeaderText__Header_Footer_; "Header/Footer")
                        {
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
                        column(Collective_TextShowOutput__Sales_Line__FIELDCAPTION__Unit_of_Measure___ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesLineG.FIELDCAPTION("Unit of Measure"), ShowUnitsofMeasureG))
                        {
                        }
                        column(Collective_TextShowOutput_C_INC009_ShowDiscPctG_; CollectiveG.TextShowOutput(C_INC009, ShowDiscPctG))
                        {
                        }
                        column(CurrentVehicle; CurrentVehicleG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalVeh; TotalVehG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__VIN_Control1101338953; SalesLineG.VIN)
                        {
                            Description = 'PA033336';
                        }
                        column(VINOld; VINOldG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line___Unit_Price_; SalesLineG."Unit Price")
                        {
                            Description = 'PA033336';
                        }
                        column(ShowFooterG; ShowFooterG)
                        {
                        }
                        column(PrintOption2G; PrintOption2G)
                        {
                        }
                        column(Sales_Line___Line_No__; SalesLineG."Line No.")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line__Type; SalesLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(SalesLineTypeG; SalesLineTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(SaleLineItemTypeG; SaleLineItemTypeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line__Description; SalesLineG.Description)
                        {
                        }
                        column(OptionFound; OptionFoundG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintOption; PrintOptionG)
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
                        column(Sales_Line__Description_Control58; SalesLineG.Description)
                        {
                        }
                        column(Sales_Line__Quantity; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG_; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(DspAmount; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput__Sales_Line___Unit_of_Measure__ShowUnitsofMeasure_; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(PrintUnitPriceHelp; PrintUnitPriceHelpG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintOptionHelpG; PrintOptionHelpG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line___Line_Discount___; SalesLineG."Line Discount %")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line__Description_Control1109400014; SalesLineG.Description)
                        {
                        }
                        column(Sales_Line__Quantity_Control1109400015; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Collective_TextShowOutput__Sales_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400016; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Line__Description_1G; SalesLineG.Description)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Line___Description_2_; SalesLineG."Description 2")
                        {
                        }
                        column(Sales_Line___No__; SalesLineG."No.")
                        {
                        }
                        column(Sales_Line__Description_Control65; SalesLineG.Description)
                        {
                        }
                        column(Sales_Line__Quantity_Control66; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice_Control68; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control69; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(DspAmount_Control70; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Collective_TextShowOutput__Sales_Line___Unit_of_Measure__ShowUnitsofMeasure__Control67; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Line___VAT_Identifier__Control1101347774; SalesLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(DspAmount_Control1109400000; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__Quantity_Control1109400001; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(ShowSalPrice_Control1109400002; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control1109400008; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(Collective_TextShowOutput__Sales_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400009; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Line__Description_Control1109400010; SalesLineG.Description)
                        {
                        }
                        column(Sales_Line___No___Control1109400011; SalesLineG."No.")
                        {
                        }
                        column(Sales_Line__Description_Control1109400019; SalesLineG.Description)
                        {
                        }
                        column(Sales_Line__Quantity_Control1109400021; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Collective_TextShowOutput__Sales_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400025; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Line___No___Control1109400026; SalesLineG."No.")
                        {
                        }
                        column(Sales_Line___Description_2__Control5025400; SalesLineG."Description 2")
                        {
                        }
                        column(Sales_Line__Description_Control1109400003; SalesLineG.Description)
                        {
                        }
                        column(Sales_Line__Quantity_Control1109400004; SalesLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Collective_TextShowOutput__Sales_Line___Unit_of_Measure__ShowUnitsofMeasure__Control1109400005; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                        {
                        }
                        column(Sales_Line___No___Control1109400006; SalesLineG."No.")
                        {
                        }
                        column(Sales_Line___Description_2__Control1109400007; SalesLineG."Description 2")
                        {
                        }
                        column(VehicleDescription; VehicleDescriptionG)
                        {
                        }
                        column(ShowSalPrice_Control143; ShowSalPriceG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control145; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                        {
                        }
                        column(DspAmount_Control146; DspAmountG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___No___Control147; SalesLineG."No.")
                        {
                        }
                        column(Sales_Line___VAT_Identifier_; SalesLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(CurrentVehicle_Control22; CurrentVehicleG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalVeh_Control100; TotalVehG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumVehicle; SumVehicleG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumMfgOpt; SumMfgOptG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOwnOpt; SumOwnOptG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumTransferFees; SumTransferFeesG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumChargeItems; SumChargeItemsG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSum; SumVehicleG + SumMfgOptG + SumOwnOptG + SumTransferFeesG + SumChargeItemsG + SumOtherG - TotalInvDiscAmtG)
                        {
                        }
                        column(TotalSumPlusVAT; SumVehicleG + SumMfgOptG + SumOwnOptG + SumTransferFeesG + SumChargeItemsG + SumOtherG - TotalInvDiscAmtG + TotalCurrVatAmtG)
                        {
                        }
                        column(Sales_Line___Inv__Discount_Amount_; -SalesLineG."Inv. Discount Amount")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmtG; -TotalInvDiscAmtG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            Description = 'PA033336';
                        }
                        column(Sales_Line__Amount; SalesLineG.Amount)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLineG.VATAmountText)
                        {
                        }
                        column(ShowCurrency; ShowCurrencyG)
                        {
                        }
                        column(Sales_Line___Amount_Including_VAT_____Sales_Line__Amount; SalesLineG."Amount Including VAT" - SalesLineG.Amount)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Line___Amount_Including_VAT_; SalesLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(DoNotShowVAT; DoNotShowVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalCurrVatAmtG; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumOnlyDifftaxationG; SumOnlyDifftaxationG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
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
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NormalVATTotalG; NormalVATTotalG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___Amount_Including_VAT__Control255; SalesLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control10; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Line___Amount_Including_VAT__Control13; SalesLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
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
                        column(Sales_Line___Inv__Discount_Amount_Caption; Sales_Line___Inv__Discount_Amount_CaptionLbl)
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
                        column(VATpercent_SL; SalesLineG."VAT %")
                        {
                        }
                        column(VATpercentCpn_SL; SalesLineG.FIELDCAPTION("VAT %"))
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
                                  (SalesLineG.Type = SalesLineG.Type::Item) AND (SalesLineG."Item Type" = SalesLineG."Item Type"::Item),
                                  SalesLineG."EU Tire Data Code");
                                IF EUTireInformationG = '' THEN BEGIN
                                    CurrReport.BREAK;
                                END;
                                // Stop PA033765
                            end;
                        }
                        dataitem(Vehicle; Vehicle)
                        {
                            DataItemTableView = SORTING(VIN);
                            column(Sales_Line__VIN; SalesLineG.VIN)
                            {
                            }
                            column(Sales_Line___License_No__; SalesLineG."License No.")
                            {
                            }
                            column(Sales_Line__Mileage; SalesLineG.Mileage)
                            {
                            }
                            column(Vehicle__Registration_Certificate_; "Registration Certificate")
                            {
                            }
                            column(RegisText; RegisTextG)
                            {
                            }
                            column(FORMAT__Sales_Line___Vehicle_Status__; FORMAT(SalesLineG."Vehicle Status"))
                            {
                            }
                            column(Sales_Line__MileageCaption; Sales_Line__MileageCaptionLbl)
                            {
                            }
                            column(Sales_Line___License_No__Caption; Sales_Line___License_No__CaptionLbl)
                            {
                            }
                            column(Vehicle__Registration_Certificate_Caption; Vehicle__Registration_Certificate_CaptionLbl)
                            {
                            }
                            column(Sales_Line__VINCaption; Sales_Line__VINCaptionLbl)
                            {
                            }
                            column(RegisTextCaption; RegisTextCaptionLbl)
                            {
                            }
                            column(FORMAT__Sales_Line___Vehicle_Status__Caption; FORMAT__Sales_Line___Vehicle_Status__CaptionLbl)
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

                                IF SalesLineG."Registration Date" = 0D THEN
                                    CustRegisTextG := ' -- '
                                ELSE
                                    CustRegisTextG := FORMAT(SalesLineG."Registration Date");
                                RegisTextG := InitialRegisTextG + ' / ' + CustRegisTextG;

                                // Start PA035597
                                PrintOptionHelpG := (PrintOptionG <> PrintOptionG::"Print no lines");
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(VIN, SalesLineG.VIN);
                            end;
                        }
                        dataitem("Optn Var. Vehicle"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Purch. Order/Order"), Type = CONST(Vehicle));
                            column(VehicleDescription_Control133; VehicleDescriptionG)
                            {
                            }
                            column(Optn_Var__Vehicle_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control141; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(DspAmount_Control149; DspAmountG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Sales_Line___No___Control153; SalesLineG."No.")
                            {
                            }
                            column(Collective_TextShowOutput__Sales_Line___Unit_of_Measure__ShowUnitsofMeasure__Control190; CollectiveG.TextShowOutput(SalesLineG."Unit of Measure", ShowUnitsofMeasureG))
                            {
                            }
                            column(Collective_TextShowOutput_FORMAT_ROUND__Sales_Line___Line_Discount____0_01___ShowDiscPctG_; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                            {
                            }
                            column(Sales_Line___VAT_Identifier__Control1115000001; SalesLineG."VAT Identifier")
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(OptVariantTypeG; OptVariantTypeG)
                            {
                                Description = 'PA033336';
                            }
                            column(Sales_Line___License_No___Control115; SalesLineG."License No.")
                            {
                            }
                            column(Sales_Line__Mileage_Control116; SalesLineG.Mileage)
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121; Vehicle."Registration Certificate")
                            {
                            }
                            column(Sales_Line__VIN_Control122; SalesLineG.VIN)
                            {
                            }
                            column(RegisText_Control155; RegisTextG)
                            {
                            }
                            column(FORMAT__Sales_Line___Vehicle_Status___Control160; FORMAT(SalesLineG."Vehicle Status"))
                            {
                            }
                            column(Sales_Line__VIN_Control122Caption; Sales_Line__VIN_Control122CaptionLbl)
                            {
                            }
                            column(Sales_Line___License_No___Control115Caption; Sales_Line___License_No___Control115CaptionLbl)
                            {
                            }
                            column(Sales_Line__Mileage_Control116Caption; Sales_Line__Mileage_Control116CaptionLbl)
                            {
                            }
                            column(Vehicle__Registration_Certificate__Control121Caption; Vehicle__Registration_Certificate__Control121CaptionLbl)
                            {
                            }
                            column(RegisText_Control155Caption; RegisText_Control155CaptionLbl)
                            {
                            }
                            column(FORMAT__Sales_Line___Vehicle_Status___Control160Caption; FORMAT__Sales_Line___Vehicle_Status___Control160CaptionLbl)
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
                                // Start PA035597
                                PrintOptionHelpG := (PrintOptionG <> PrintOptionG::"Print no lines");
                                PrintUnitPriceHelpG := (PrintUnitPriceG <> PrintUnitPriceG::"Print no prices");

                                ShowSalPriceG := 0;
                                ShowLineDiscPctG := 0;
                                CASE SalesLineG."VAT Calculation Type" OF
                                    SalesLineG."VAT Calculation Type"::"Differential Tax":
                                        DspAmountG := getSalPrice(SalesLineG, 1);
                                    ELSE BEGIN
                                            IF DoNotShowVATG THEN
                                                DspAmountG := getSalPrice(SalesLineG, 1)
                                            ELSE
                                                DspAmountG := getSalPrice(SalesLineG, 2) + getLineDiscPct(SalesLineG, 2);
                                            IF PrintDiscG THEN BEGIN
                                                ShowSalPriceG := getSalPrice(SalesLineG, 0);
                                                ShowLineDiscPctG := getLineDiscPct(SalesLineG, 0);
                                                IF (ShowSalPriceG <> 0) THEN BEGIN
                                                    IF DoNotShowVATG THEN
                                                        DspAmountG := getSalPrice(SalesLineG, 1) + getLineDiscPct(SalesLineG, 1);
                                                    ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                                END;
                                            END;
                                        END;
                                END;

                                VehicleDescriptionG := SalesLineG."Shortcut Dimension 2 Code" + ' ' + SalesLineG.Description;
                                OptVariantTypeG := Type;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Color"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Purch. Order/Order"));
                            column(Optn_Var__Color_Description; Description)
                            {
                            }
                            column(Optn_Var__Color_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control142; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control144; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                            {
                            }
                            column(DspAmount_Control157; DspAmountG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Optn_Var__Color__Option_Code_; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Sales_Line__Type_Control1101339008; SalesLineG.Type)
                            {
                                Description = 'PA033336';
                            }
                            column(OptVariantType2G; OptVariantType2G)
                            {
                                Description = 'PA033336';
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
                            column(Optn_Var__Color__Description_2_; "Description 2")
                            {
                            }
                            column(CurrentVehicle_Control91; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
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
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           OptionVariantG."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND OptionVariantG."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN BEGIN
                                            SumMfgOptG += "Amount Including VAT";
                                            SumVehicleG -= "Amount Including VAT";
                                        END ELSE
                                            SumMfgOptG += 0
                                    END ELSE BEGIN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           OptionVariantG."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND OptionVariantG."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN BEGIN
                                            SumMfgOptG += Amount;
                                            SumVehicleG -= Amount;
                                        END ELSE
                                            SumMfgOptG += 0
                                    END;
                                END;

                                // Start PA035597
                                PrintOptionHelpG := (PrintOptionG = PrintOptionG::"Print all lines") OR
                                  ((PrintOptionG = PrintOptionG::"Print selected lines") AND "Optn Var. Color"."Print Option Line");
                                PrintUnitPriceHelpG := FunctionPrintUnitPriceOVC;

                                CalcValues("Optn Var. Color");
                                OptVariantType2G := Type;

                                IF NOT PrintUnitPriceHelpG THEN
                                    DspAmountG := 0;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Option Type", "Option Type"::Color, "Option Type"::Upholstery);
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }
                        dataitem("Optn Var. Series"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Purch. Order/Order"), "Series Option" = CONST(true), "Option Type" = CONST(Option));
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
                                AutoFormatExpression = "Sales Header"."Currency Code";
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
                                IF Type = Type::"Manuf. Option" THEN BEGIN
                                    IF DoNotShowVATG THEN BEGIN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN BEGIN
                                            SumMfgOptG += "Amount Including VAT";
                                            SumVehicleG -= "Amount Including VAT";
                                        END ELSE
                                            SumMfgOptG += 0
                                    END ELSE BEGIN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN BEGIN
                                            SumMfgOptG += Amount;
                                            SumVehicleG -= Amount;
                                        END ELSE
                                            SumMfgOptG += 0
                                    END;
                                END;

                                // Start PA035597
                                PrintOptionHelpG := (PrintOptionG = PrintOptionG::"Print all lines") OR
                                  ((PrintOptionG = PrintOptionG::"Print selected lines") AND "Optn Var. Series"."Print Option Line");
                                // Start PA039959
                                OptVariantType3G := Type;
                                // Stop PA039959
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }
                        dataitem("Option Variant"; "Option Variant")
                        {
                            DataItemTableView = SORTING(Area, "Document Type", "Document No.", "Document Line No.", Type, "Option Type", "Series Option") WHERE(Area = CONST(Sale), "Document Type" = CONST("Purch. Order/Order"), "Series Option" = CONST(false), "Option Type" = CONST(Option));
                            column(Option_Variant_Description; Description)
                            {
                            }
                            column(Option_Variant_Quantity; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShowSalPrice_Control171; ShowSalPriceG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
                                AutoFormatType = 2;
                            }
                            column(Collective_TextShowOutput_FORMAT_ROUND_ShowLineDiscPct_0_01___ShowDiscPctG__Control172; CollectiveG.TextShowOutput(FORMAT(ROUND(ShowLineDiscPctG, 0.01)), ShowDiscPctG))
                            {
                            }
                            column(DspAmount_Control175; DspAmountG)
                            {
                                AutoFormatExpression = SalesLineG."Currency Code";
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
                            column(Option_Variant_Description_Control1109400017; Description)
                            {
                            }
                            column(Option_Variant_Quantity_Control1109400018; Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(Option_Variant__Option_Code__Control1109400022; "Option Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Option_Variant__Description_2_; "Description 2")
                            {
                            }
                            column(CurrentVehicle_Control42; CurrentVehicleG)
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
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
                                       (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                    THEN BEGIN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN BEGIN
                                            SumMfgOptG += "Amount Including VAT";
                                            SumVehicleG -= "Amount Including VAT";
                                        END ELSE
                                            SumMfgOptG += 0
                                    END ELSE BEGIN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           "Option Variant"."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND "Option Variant"."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN BEGIN
                                            SumMfgOptG += Amount;
                                            SumVehicleG -= Amount;
                                        END ELSE
                                            SumMfgOptG += 0
                                    END;
                                END;

                                // Start PA035597
                                PrintOptionHelpG := (PrintOptionG = PrintOptionG::"Print all lines") OR
                                  ((PrintOptionG = PrintOptionG::"Print selected lines") AND "Option Variant"."Print Option Line");
                                PrintUnitPriceHelpG := FunctionPrintUnitPriceOV;

                                IF PrintDiscG AND PrintUnitPriceHelpG AND
                                  NOT (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN BEGIN
                                    ShowSalPriceG := "Unit Price";
                                    ShowLineDiscPctG := "Line Discount %";
                                END ELSE BEGIN
                                    ShowSalPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;

                                IF DoNotShowVATG OR
                                  (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
                                THEN
                                    DspAmountG := "Amount Including VAT"
                                ELSE
                                    DspAmountG := Amount;

                                IF NOT PrintUnitPriceHelpG THEN
                                    DspAmountG := 0;

                                IF PrintDiscG AND PrintUnitPriceHelpG THEN BEGIN
                                    ShowSalPriceG := "Unit Price";
                                    ShowLineDiscPctG := "Line Discount %";
                                END ELSE BEGIN
                                    ShowSalPriceG := 0;
                                    ShowLineDiscPctG := 0;
                                END;

                                IF DoNotShowVATG THEN
                                    DspAmountG := "Amount Including VAT"
                                ELSE
                                    DspAmountG := Amount;
                                // Start PA039959
                                OptVariantType4G := Type;
                                // Stop PA039959
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Document No.", SalesLineG."Document No.");
                                SETRANGE("Document Line No.", SalesLineG."Line No.");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Line";
                            VehicleL: Record Vehicle;
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT SalesLineG.FIND('-') THEN BEGIN
                                    SalesLineG.SETRANGE("Item Type", SalesLineG."Item Type"::Item);
                                    SalesLineG.FIND('-');
                                END;
                                VINOldG := SalesLineG.VIN;
                            END ELSE
                                IF SalesLineG.NEXT = 0 THEN BEGIN
                                    SalesLineG.SETRANGE("Item Type", SalesLineG."Item Type"::Item);
                                    SalesLineG.FIND('-');
                                END;

                            // Start PA041687
                            IF NotOwnedVehDataG THEN BEGIN
                                IF VehicleL.GET(SalesLineG.VIN) THEN BEGIN
                                    FORMAT__Sales_Line___Vehicle_Status__CaptionLbl := VehicleStatus;
                                    FORMAT__Sales_Line___Vehicle_Status___Control160CaptionLbl := VehicleStatus;
                                END ELSE BEGIN
                                    FORMAT__Sales_Line___Vehicle_Status__CaptionLbl := VehicleStatusE;
                                    FORMAT__Sales_Line___Vehicle_Status___Control160CaptionLbl := VehicleStatusE;
                                END;
                            END;
                            // Stop PA041687


                            // Check if Option is available
                            OptionVariantG.SETRANGE(Area, OptionVariantG.Area::Sale);
                            OptionVariantG.SETRANGE("Document Type", SalesLineG."Document Type");
                            OptionVariantG.SETRANGE("Document No.", SalesLineG."Document No.");
                            OptionVariantG.SETRANGE("Document Line No.", SalesLineG."Line No.");
                            OptionFoundG := OptionVariantG.FIND('-');
                            IF SalesLineG."VAT Calculation Type" <> SalesLineG."VAT Calculation Type"::"Differential Tax"
                            THEN BEGIN
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
                                // Start PA033336
                                TotalCurrVatAmtG := TotalCurrVatAmtG + SalesLineG."Amount Including VAT";
                                TotalInvDiscAmtG := TotalInvDiscAmtG + SalesLineG."Inv. Discount Amount";
                                // Stop PA033336
                                IF SalesLineG.Type = SalesLineG.Type::Item THEN BEGIN
                                    CASE SalesLineG."Item Type" OF
                                        SalesLineG."Item Type"::Item:
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"Print no lines")
                                            THEN
                                                SumOtherG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::Vehicle:
                                            SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::"Own Option":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"Print no lines")
                                            THEN
                                                SumOwnOptG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";
                                        SalesLineG."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"Print no lines")
                                            THEN
                                                SumTransferFeesG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";

                                        SalesLineG."Item Type"::"Charge (Item)":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"Print no lines")
                                            THEN
                                                SumChargeItemsG += SalesLineG."Amount Including VAT"
                                            ELSE
                                                SumVehicleG += SalesLineG."Amount Including VAT";
                                    END;
                                END ELSE
                                    IF (SalesLineG.Type = SalesLineG.Type::"Account (G/L)") OR
                                       (SalesLineG.Type = SalesLineG.Type::"Charge (Item)")
                                    THEN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           SalesLineG."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN
                                            SumOtherG += SalesLineG."Amount Including VAT"
                                        ELSE
                                            SumVehicleG += SalesLineG."Amount Including VAT"
                            END ELSE BEGIN
                                IF SalesLineG.Type = SalesLineG.Type::Item THEN BEGIN
                                    CASE SalesLineG."Item Type" OF
                                        SalesLineG."Item Type"::Item:
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"Print no lines")
                                            THEN
                                                SumOtherG += SalesLineG.Amount
                                            ELSE BEGIN
                                                SumVehicleG += SalesLineG.Amount;
                                            END;
                                        SalesLineG."Item Type"::Vehicle:
                                            BEGIN
                                                SumVehicleG += SalesLineG.Amount;
                                                IF SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax" THEN
                                                    SumOnlyDifftaxationG += SalesLineG.Amount;
                                            END;
                                        SalesLineG."Item Type"::"Own Option":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"Print no lines")
                                            THEN
                                                SumOwnOptG += SalesLineG.Amount
                                            ELSE
                                                SumVehicleG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                                        SalesLineG."Item Type"::"Veh. Transfer":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                               SalesLineG."Print Option Line" OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                               (PrintOptionG <> PrintOptionG::"Print no lines")
                                            THEN
                                                SumTransferFeesG += SalesLineG.Amount
                                            ELSE
                                                SumVehicleG += SalesLineG.Amount;
                                        SalesLineG."Item Type"::"Charge (Item)":
                                            IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") OR
                                               ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") OR
                                               (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")
                                            THEN
                                                SumChargeItemsG += SalesLineG.Amount + SalesLineG."Inv. Discount Amount"
                                            ELSE
                                                SumVehicleG += SalesLineG.Amount;
                                    END;
                                END ELSE
                                    //SumOther += "Sales Line".Amount + "Sales Line"."Inv. Discount Amount";
                                    IF (SalesLineG.Type = SalesLineG.Type::"Account (G/L)") OR
                                       (SalesLineG.Type = SalesLineG.Type::"Charge (Item)")
                                    THEN
                                        IF (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print selected lines") AND
                                           SalesLineG."Print Option Line" OR
                                           (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND (PrintOptionG = PrintOptionG::"Print all lines") OR
                                           ((PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND SalesLineG."Print Unit Price") AND
                                           (PrintOptionG <> PrintOptionG::"Print no lines")
                                        THEN
                                            SumOtherG += SalesLineG.Amount
                                        ELSE
                                            SumVehicleG += SalesLineG.Amount;
                                // Start PA033336
                                TotalCurrVatAmtG := TotalCurrVatAmtG + SalesLineG."Amount Including VAT" - SalesLineG.Amount;
                                TotalInvDiscAmtG := TotalInvDiscAmtG + SalesLineG."Inv. Discount Amount";
                                // Stop PA033336

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
                            IF SalesLineG."VAT Identifier" <> '' THEN
                                IF NOT VATIdentifierTempG.GET(SalesLineG."VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := SalesLineG."VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042

                            // Start PA035597
                            CLEAR(CounterG);
                            CLEAR(Counter2G);
                            CLEAR(CheckG);
                            CLEAR(ShowFooterG);
                            CLEAR(LastG);

                            SalesLine2G.RESET;
                            SalesLine2G.SETRANGE("Document No.", "Sales Header"."No.");
                            SalesLine2G.SETRANGE("Line No.", 0, SalesLineG."Line No.");
                            Counter2G := SalesLine2G.COUNT;

                            SalesLine2G.SETRANGE("Line No.");
                            LastG := SalesLine2G.COUNT;

                            IF SalesLine2G.FINDFIRST THEN
                                REPEAT
                                    CounterG := CounterG + 1;
                                    IF (CounterG > Counter2G) AND (NOT CheckG) THEN BEGIN
                                        CheckG := TRUE;
                                        IF ((SalesLine2G.VIN <> SalesLineG.VIN)) THEN
                                            ShowFooterG := TRUE
                                    END;
                                    IF LastG = Counter2G THEN
                                        ShowFooterG := TRUE;
                                UNTIL SalesLine2G.NEXT = 0;

                            SaleLineItemTypeG := SalesLineG."Item Type";
                            SalesLineTypeG := SalesLineG.Type;

                            PrintOptionHelpG := (PrintOptionG = PrintOptionG::"Print all lines") OR
                              ((PrintOptionG = PrintOptionG::"Print selected lines") AND SalesLineG."Print Option Line");
                            PrintUnitPriceHelpG := FunctionPrintUnitPrice;

                            ShowSalPriceG := 0;
                            ShowLineDiscPctG := 0;
                            CASE SalesLineG."VAT Calculation Type" OF
                                SalesLineG."VAT Calculation Type"::"Differential Tax":
                                    DspAmountG := getSalPrice(SalesLineG, 1);
                                ELSE BEGIN
                                        IF DoNotShowVATG THEN
                                            DspAmountG := getSalPrice(SalesLineG, 1)
                                        ELSE
                                            DspAmountG := getSalPrice(SalesLineG, 2) + getLineDiscPct(SalesLineG, 2);
                                        IF PrintDiscG THEN BEGIN
                                            ShowSalPriceG := getSalPrice(SalesLineG, 0);
                                            ShowLineDiscPctG := getLineDiscPct(SalesLineG, 0);
                                            IF (ShowSalPriceG <> 0) THEN BEGIN
                                                IF DoNotShowVATG THEN
                                                    DspAmountG := getSalPrice(SalesLineG, 1) + getLineDiscPct(SalesLineG, 1);
                                                ShowLineDiscPctG := 100 - (DspAmountG * 100 / ShowSalPriceG);
                                            END;
                                        END;
                                    END;
                            END;

                            VehicleDescriptionG := SalesLineG."Shortcut Dimension 2 Code" + ' ' + SalesLineG.Description;

                            // Start PA036395.26382
                            IF (DoNotShowVATG) OR
                               (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax") THEN
                                // Stop PA036395.26382
                                TotalVehG := TotalVehG + SalesLineG."Amount Including VAT"
                            ELSE
                                TotalVehG := TotalVehG + SalesLineG.Amount + SalesLineG."Inv. Discount Amount";
                            VINOldG := SalesLineG.VIN;
                            // Stop PA035597
                        end;

                        trigger OnPostDataItem()
                        var
                            TotalL: Decimal;
                            ArrayL: array[6] of Decimal;
                            TotalVehicleL: Decimal;
                            MaxL: Decimal;
                            CountL: Integer;
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
                                    FOR IG := 1 TO 6 DO BEGIN
                                        IF ArrayL[IG] > MaxL THEN BEGIN
                                            MaxL := ArrayL[IG];
                                            CountL := IG;
                                        END;
                                    END;

                                    ArrayL[CountL] += (TotalVehicleL - TotalL);

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
                            SalesLineL: Record "Sales Line";
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
                            SumOnlyDifftaxationG := 0;
                            IF SalesLineL.FIND('-') THEN
                                REPEAT
                                    IF SalesLineL."VAT Calculation Type" = SalesLineL."VAT Calculation Type"::"Differential Tax" THEN BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesLineL."Amount Including VAT";
                                        SumOnlyDifftaxationG := SumOnlyDifftaxationG + SalesLineL."Amount Including VAT";
                                    END ELSE BEGIN
                                        SumwithDiffTaxationG := SumwithDiffTaxationG + SalesLineL.Amount;
                                        NormalVATTotalG := NormalVATTotalG + (SalesLineL."Amount Including VAT" - SalesLineL.Amount);
                                    END;
                                UNTIL SalesLineL.NEXT = 0;
                            // Start PA033336
                            CLEAR(SaleLineItemTypeG);
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
                        column(SumwithDiffTaxationG_VATC; SumwithDiffTaxationG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DoNotShowVAT_VATC; DoNotShowVATG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalCurrVatAmt1G; TotalCurrVatAmtG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATAmountLineVATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT; VATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmountLine_AmountIncludingVAT_VATBase; VATAmountLineG."Amount Including VAT" - VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATIdentifier; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(TotalInclVATText_VATC; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVAT_SL_VATC; SalesLineG."Amount Including VAT")
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOnlyDifftaxationG_VATC; SumOnlyDifftaxationG)
                        {
                            AutoFormatExpression = SalesLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_VATC; TotalCaption_Control167Lbl)
                        {
                        }
                        column(PercVATOfLbl; PercVATOfLbl)
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
                        column(SumVehicle1G; SumVehicleG)
                        {
                        }
                        column(SumTransferFees1G; SumTransferFeesG)
                        {
                        }
                        column(SumTransferFees2G; SumTransferFeesG)
                        {
                        }
                        column(SumMfgOpt1G; SumMfgOptG)
                        {
                        }
                        column(SumOther1G; SumOtherG)
                        {
                        }
                        column(TotalInvDiscAmt1G; TotalInvDiscAmtG)
                        {
                        }
                        column(SumOwnOpt1G; SumOwnOptG)
                        {
                        }
                        column(SumChargeItems1G; SumChargeItemsG)
                        {
                        }
                        column(TotalCurrVatAmt2G; TotalCurrVatAmtG)
                        {
                        }
                        column(DoNotShowVAT2G; DoNotShowVATG)
                        {
                        }
                        column(TotalTradeIn; TotalTradeInG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___Amount_Including_VAT____TotalTradeIn; SalesLineG."Amount Including VAT" - TotalTradeInG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
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
                        column(TradeinAmountLbl; TradeinAmountLbl)
                        {
                            Description = 'PA041125.66556';
                        }
                        column(TradeinMileageLbl; TradeinMileageLbl)
                        {
                            Description = 'PA041125.66556';
                        }
                        column(TradeinVINLbl; TradeinVINLbl)
                        {
                            Description = 'PA041125.66556';
                        }
                        column(TradeinDescLbl; TradeinDescLbl)
                        {
                            Description = 'PA041125.66556';
                        }
                        column(TradeinMakeLbl; TradeinMakeLbl)
                        {
                            Description = 'PA041125.66556';
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
                            column(Sales_Trade_In___Unit_Cost_Incl__VAT_; VINTotalTradeInG)
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                                Description = 'PA040293';
                            }
                            column(MileageCaption; MileageCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                PurchInvoiceLineL: Record "Purch. Invoice Line";
                                CurrencyL: Record Currency;
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
                                // Stop PA040293
                                IF "Sales Trade-In"."Posted Purch. Invoice No." > '' THEN BEGIN
                                    PurchInvoiceLineL.RESET;
                                    PurchInvoiceLineL.SETRANGE("Document No.", "Sales Trade-In"."Posted Purch. Invoice No.");
                                    PurchInvoiceLineL.CALCSUMS("Amount Including VAT");
                                    VINTotalTradeInG := PurchInvoiceLineL."Amount Including VAT";
                                END ELSE BEGIN
                                    VINTotalTradeInG := "Sales Trade-In"."Unit Cost Incl. VAT";
                                    PurchasesPayablesSetupG.GET;
                                    IF PurchasesPayablesSetupG."Invoice Rounding" THEN BEGIN
                                        IF "Sales Header"."Currency Code" > '' THEN
                                            CurrencyL.GET("Sales Header"."Currency Code")
                                        ELSE
                                            CurrencyL.InitRoundingPrecision;
                                        VINTotalTradeInG := ROUND(VINTotalTradeInG, CurrencyL."Invoice Rounding Precision", CurrencyL.InvoiceRoundingDirection);
                                    END;
                                END;
                                // Stop PA040293
                                // Start PA035597
                                IF NOT TradeInExtraG THEN
                                    // Stop PA040293
                                    TotalTradeInG := TotalTradeInG + VINTotalTradeInG;
                                // Stop PA040293
                                // Stop PA035597
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
                            // Start PA040293
                            VINTotalTradeInG := 0;
                            // Stop PA040293
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
                    dataitem(DiffTaxText; "Veh SalesDoc DiffTaxText")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Entry No.");
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
                    dataitem(HeaderFooterText; "Sales Document Text")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Header/Footer" = CONST(Footer));
                        column(HeaderFooterText_Text; Text)
                        {
                        }
                        column(PrintFooterLine; PrintFooterLineG)
                        {
                            Description = 'PA033336';
                        }
                        column(HeaderFooterText__Header_Footer_; "Header/Footer")
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
                    dataitem(EmissionDocRelLegTxt; "Emissions Related Docs Text")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Entry No.");
                        column(EmissionRelText_Text; EmissionDocRelLegTxt.Text)
                        {
                            Description = 'PA042665.86105';
                        }
                        column(EmissionRelatedTextLbl; EmissionRelatedTextLbl)
                        {
                            Description = 'PA042665.86105';
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // Start PA035597
                        IF PrintFooterLineG THEN
                            PageLoopFooterG := 1;
                        IF PrintSentFromLine2G THEN
                            PrintSentFromLineG := 1;
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
                    // Stop PA033336

                    TotalVehG := 0;
                    SumVehicleG := 0;
                    SumTotVehicleG := 0;
                    SumOwnOptG := 0;
                    SumMfgOptG := 0;
                    SumTransferFeesG := 0;
                    SumChargeItemsG := 0;
                    SumOtherG := 0;
                    TotalTradeInG := 0;
                    CurrentVehicleG := 0;
                    CurrReport.PAGENO := 1;
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

                    // Start PA035597
                    OutputNoG := 1;
                    // Stop PA035597
                end;
            }

            trigger OnAfterGetRecord()
            var
                InteractionLogL: Record "Interaction Log Entry";
                IntCustL: Code[20];
                ObjectTypeL: Option TableData,"Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System,FieldNumber;
                bankAccountL: Record "Bank Account";
            begin
                // Start API.1
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                // Stop API.1


                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := VehicleReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Vehicle Sales Order CZ"); // API.1
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593

                // Start API.1
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Header"."Original User ID");

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;
                // Stop API.1

                // Start PA040256.57127
                AmountRoundPrecisionG := CurrencyG.GetAmountRoundingPrecision("Currency Code");
                // Stop PA040256.57127

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
                // Start PA036549.32374
                IF PrintSentFromLine2G THEN
                    // Stop PA036549.32374
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

                //Start API.1.0.2  07.06.18 PV
                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccountL.RESET;
                IF bankAccountL.GET("Sales Header"."Bank Account Code") THEN BEGIN
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
                // THEN
                //  BEGIN // API.1
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // API.1
                //    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                //  END // API.1
                // ELSE
                //  BEGIN // API.1
                //    BankNameG := CompanyInfoG."Bank Name";
                //    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                //    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                //    BankIbanG := CompanyInfoG.IBAN;
                //    BankAccountNoG := CompanyInfoG."Bank Account No.";
                //    // API.1
                //    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                //  END; // API.1
                //Stop API.1.0.2  07.06.18 PV

                // Start PA038229
                SalesLine3G.RESET;
                SalesLine3G.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesLine3G.SETRANGE("Document No.", "Sales Header"."No.");
                SalesLine3G.SETRANGE("Item Type", SalesLine3G."Item Type"::Vehicle);
                // Start PA038229.41878
                HideVehicleMainInfoG := SalesLine3G.ISEMPTY;
                // Stop PA038229.41878
                ShowManyVehiclesG := SalesLine3G.COUNT > 1;
                CLEAR(MainNextAppDateG);
                CLEAR(EmissionNextAppDateG);
                IF NOT ShowManyVehiclesG AND SalesLine3G.FINDFIRST THEN BEGIN
                    // Start PA041687
                    FORMAT__Sales_Line___Vehicle_Status__CaptionLbl := VehicleStatus;
                    // Stop PA041687
                    IF VehicleG.GET(SalesLine3G.VIN) THEN BEGIN
                        MainNextAppDateG := GetNextApptDate(1, "Sales Header"."Document Date");
                        EmissionNextAppDateG := GetNextApptDate(2, "Sales Header"."Document Date");
                        //vapa
                        //this var will be used to (not)show vehicle info in layout instead of original
                        // layout condition for values visibility, ie. Hidden:
                        //  IIF((Fields!ShowManyVehiclesG.Value Or Fields!HideVehicleMainInfoG.Value), True, False)
                        ShowVehicleInfoG := SalesLine3G.COUNT = 1;
                        //vapa<-
                        // Start PA041687
                    END ELSE
                        IF NotOwnedVehDataG THEN BEGIN
                            GetNotOwnedVehicle("Sales Header", SalesLine2G, VehicleG);
                            FORMAT__Sales_Line___Vehicle_Status__CaptionLbl := VehicleStatusE;
                        END;
                    // Stop PA041687
                END;
                // Stop PA038229




                SalesLineG.RESET;
                SalesLineG.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesLineG.SETRANGE("Document No.", "Sales Header"."No.");
                SalesLineG.SETRANGE("VAT Calculation Type", SalesLineG."VAT Calculation Type"::"Differential Tax");
                IF SalesLineG.FIND('-') THEN BEGIN
                    DiffTaxExistsG := TRUE;
                END ELSE
                    DiffTaxExistsG := FALSE;

                // Start PA036395.26382
                IF DiffTaxExistsG THEN
                    DoNotShowVATG := TRUE;
                // Stop PA036395.26382

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
                // Start PA036385.26242
                IF DiffTaxExistsG THEN
                    TotalInclVATTextG := STRSUBSTNO(C_INC_Total, ShowCurrencyG)
                ELSE
                    TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);
                // Stop PA036385.26242
                FormatAddrG.SalesHeaderBillTo(CustAddrG, "Sales Header");

                // API.1
                IF NOT PaymentMethodG.GET("Sales Header"."Payment Method Code") THEN
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
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    "Sales Header"."Customer Confirmation Date" := TODAY;
                    "Sales Header".MODIFY;
                END;
                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                // Start PA035597
                IF CheckPermission(ObjectTypeL::TableData, DATABASE::"Interaction Template") THEN
                    // Stop PA035597
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        LogInteractionG := SegMgntG.FindInteractTmplCode(27) <> '';
                        IF LogInteractionG THEN
                            // Start PA034256.I000009
                            SegMgntG.LogDocument(
                        InteractionLogL."Document Type"::VeSaleOrdConf,
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
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Výbavy")
                {
                    Caption = 'Options';
                    field(NoOfCopiesG; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(PrintOptionG; PrintOptionG)
                    {
                        Caption = 'Print Option';
                        OptionCaption = 'Print selected lines,Print all lines,Print no lines';

                        trigger OnValidate()
                        begin
                            // Start PA033336
                            PrintOption2G := PrintOptionG;
                            // Stop PA033336
                        end;
                    }
                    field(PrintUnitPriceG; PrintUnitPriceG)
                    {
                        Caption = 'Print Unit Price';
                        OptionCaption = 'Print selected prices,Print all prices,Print no prices';
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
                    }
                    field(NotOwnedVehDataG; NotOwnedVehDataG)
                    {
                        Caption = 'Print not-owned Veh. Data';
                        Description = 'PA041687';
                    }
                    field(PrintSentFromLine2G; PrintSentFromLine2G)
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
                    field(ShowDiscPctG; ShowDiscPctG)
                    {
                        Caption = 'Print Discount %';
                        MultiLine = true;
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
            PrintOptionG := PrintOptionG::"Print selected lines";
            PrintUnitPriceG := PrintUnitPriceG::"Print selected prices";

            PrintDiscG := TRUE;
            // Start PA036549.33228
            // Stop PA036549.33228
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
        GLSetupG.GET;
        // Start PA032727
        // Start PA039225.51457
        // Start PA035597
        // Stop PA035597
        PrintOptionG := PrintOptionG::"Print selected lines";
        PrintUnitPriceG := PrintUnitPriceG::"Print selected prices";
        PrintDiscG := TRUE;
        // Start PA033336
        // Stop PA033336
        // Start PA035484.20756
        // Stop PA035484.20756
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        // Stop PA032727
        GetReportSelection();
        // Stop PA039225.51457

        // Start PA041687
        FORMAT__Sales_Line___Vehicle_Status__CaptionLbl := VehicleStatus;
        FORMAT__Sales_Line___Vehicle_Status___Control160CaptionLbl := VehicleStatus;
        // Stop PA041687

        // Start PA041187.90151
        NotOwnedVehDataG := TRUE;
        // Stop PA041187.90151
    end;

    trigger OnPreReport()
    begin
        TotalVehG := 0;

        // Start EU.0000045
        UserSessionG.GetDocumentSignature(DocumentSignatureTG);
        HideSignatureG := FALSE;
        IF NOT DocumentSignatureTG.ISEMPTY() THEN BEGIN
            HideSignatureG := TRUE;
            DocumentSignatureTG.FINDFIRST();
            REPEAT
                CASE DocumentSignatureTG.Type OF
                    DocumentSignatureTG.Type::Client:
                        BEGIN
                            DocumentSignatureTG.CALCFIELDS(Content);
                            SignatureClientTG.INIT;
                            SignatureClientTG.Blob := DocumentSignatureTG.Content;
                            SignatureClientTG.INSERT;
                            SignatureClientTG.CALCFIELDS(Blob);
                            IF DocumentSignatureTG."Signature Date" = 0D THEN
                                DocumentSignatureTG."Signature Date" := TODAY();
                            IF DocumentSignatureTG."Signature City" = '' THEN BEGIN
                                SignatureCityDateCaptionG := DateCaptionLbl;
                                SignatureCityDateG := FORMAT(DocumentSignatureTG."Signature Date");
                            END ELSE BEGIN
                                SignatureCityDateCaptionG := STRSUBSTNO('%1, %2', CityCaptionLbl, DateCaptionLbl);
                                SignatureCityDateG := STRSUBSTNO('%1, %2', DocumentSignatureTG."Signature City", DocumentSignatureTG."Signature Date");
                            END;
                        END;
                    DocumentSignatureTG.Type::Representative:
                        BEGIN
                            DocumentSignatureTG.CALCFIELDS(Content);
                            SignatureRepresentativeTG.INIT;
                            SignatureRepresentativeTG.Blob := DocumentSignatureTG.Content;
                            SignatureRepresentativeTG.INSERT;
                            SignatureRepresentativeTG.CALCFIELDS(Blob);
                        END;
                END;
            UNTIL DocumentSignatureTG.NEXT = 0;
        END;
        // Stop EU.0000045
    end;

    var
        PurchasesPayablesSetupG: Record "Purchases & Payables Setup";
        AddressSalutationG: Record "Address Salutation";
        VehicleReportSelectionG: Record "Vehicle Sales Rep. Selection";
        SalesAndReceivSetupG: Record "Sales & Receivables Setup";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        OptionVariantG: Record "Option Variant";
        SalesLineG: Record "Sales Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Vehicle Sales Rep. Selection";
        SalesLine2G: Record "Sales Line";
        SalesLine3G: Record "Sales Line";
        VehicleG: Record Vehicle;
        CurrencyG: Record Currency;
        DocumentSignatureTG: Record "Document Signature" temporary;
        SignatureClientTG: Record TempBlob temporary;
        SignatureRepresentativeTG: Record TempBlob temporary;
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
        UserSessionG: Codeunit "User Session Unit";
        VATLegendsG: Text[15];
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
        ReferenceTextG: Text[30];
        TotalInclVATTextG: Text[50];
        SalesAddrSaluationG: Text[30];
        RegisTextG: Text[100];
        ReportTitleG: Text[100];
        SignatureCityDateG: Text[250];
        SignatureCityDateCaptionG: Text[250];
        VINOldG: Code[20];
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
        TotalCurrVatAmtG: Decimal;
        TotalInvDiscAmtG: Decimal;
        NormalVATTotalG: Decimal;
        SumwithDiffTaxationG: Decimal;
        SumOnlyDifftaxationG: Decimal;
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
        VINTotalTradeInG: Decimal;
        AmountRoundPrecisionG: Decimal;
        PrintOptionG: Option "Print selected lines","Print all lines","Print no lines";
        PrintUnitPriceG: Option "Print selected prices","Print all prices","Print no prices";
        C_INC033: Label 'Vehicle Sales Order';
        IncrG: Integer;
        C_INC034: Label ' =';
        OutputNoG: Integer;
        SalesItemTypeG: Integer;
        SalesTypeG: Integer;
        SalesLineTypeG: Integer;
        SaleLineItemTypeG: Integer;
        CounterG: Integer;
        Counter2G: Integer;
        LastG: Integer;
        OptVariantTypeG: Integer;
        PrintOption2G: Integer;
        OptVariantType2G: Integer;
        OptVariantType3G: Integer;
        OptVariantType4G: Integer;
        PageLoopFooterG: Integer;
        PrintSentFromLineG: Integer;
        DiffTaxExistsG: Boolean;
        ShowDiscPctG: Boolean;
        OptionFoundG: Boolean;
        ShowUnitsofMeasureG: Boolean;
        TradeInExtraG: Boolean;
        ShowShippingAddrG: Boolean;
        MoreLinesG: Boolean;
        PrintDiscG: Boolean;
        PrintSentFromLine2G: Boolean;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        DoNotShowVATG: Boolean;
        CheckG: Boolean;
        ShowFooterG: Boolean;
        PrintOptionHelpG: Boolean;
        LogInteractionG: Boolean;
        VehFoundG: Boolean;
        PrintUnitPriceHelpG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        ShowManyVehiclesG: Boolean;
        HideVehicleMainInfoG: Boolean;
        HideSignatureG: Boolean;
        EUTireInformationG: Text[1024];
        C_INC_Total: Label 'Total %1';
        Sales_Header___No__CaptionLbl: Label 'Document No.';
        Sales_Header___Document_Date_CaptionLbl: Label 'Document Date';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        SalesPurch_NameCaptionLbl: Label 'Salesperson';
        Payments_to_CaptionLbl: Label 'Payments to:';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
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
        Sales_Line___Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        of_these_diff__taxation_CaptionLbl: Label '(of these diff. taxation)';
        TotalCaption_Control251Lbl: Label 'Total';
        Sales_Line__MileageCaptionLbl: Label 'Mileage:';
        Sales_Line___License_No__CaptionLbl: Label 'License No.:';
        Vehicle__Registration_Certificate_CaptionLbl: Label 'Vehicle Paper Number:';
        Sales_Line__VINCaptionLbl: Label 'VIN:';
        RegisTextCaptionLbl: Label 'Initial/Customer Registration:';
        Sales_Line__VIN_Control122CaptionLbl: Label 'VIN:';
        Sales_Line___License_No___Control115CaptionLbl: Label 'License No.:';
        Sales_Line__Mileage_Control116CaptionLbl: Label 'Mileage:';
        Vehicle__Registration_Certificate__Control121CaptionLbl: Label 'Vehicle Paper Number:';
        RegisText_Control155CaptionLbl: Label 'Initial/Customer Registration:';
        CurrentVehicle_Control91CaptionLbl: Label 'Sum carried forward';
        CurrentVehicle_Control60CaptionLbl: Label 'Sum carried forward';
        CurrentVehicle_Control42CaptionLbl: Label 'Sum carried forward';
        TotalCaption_Control167Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        PercVATOfLbl: Label '% VAT of';
        ContinuedCaption_Control111Lbl: Label 'Continued';
        of_these_diff__taxation_Caption_Control178Lbl: Label '(of these diff. taxation)';
        Trade_Ins_CaptionLbl: Label 'Trade-Ins:';
        TotalTradeInCaptionLbl: Label 'Sum Trade-In';
        PayableCaptionLbl: Label 'Payable';
        MileageCaptionLbl: Label 'Mileage';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        MainNextAppDateGLbl: Label 'Inspection Date';
        EmissionNextAppDateGLbl: Label 'Emission Date';
        PurchaseDocumentLbl: Label 'Purchase Document';
        VehicleRegistrationCertificateLbl: Label 'Registration Certificate';
        TradeinMakeLbl: Label 'Make';
        TradeinDescLbl: Label 'Trade-in Description';
        TradeinVINLbl: Label 'VIN';
        TradeinMileageLbl: Label 'Km/M/Hours';
        TradeinAmountLbl: Label 'Trade-in Amount';
        ofLbl: Label ' of';
        EmissionRelatedTextLbl: Label 'Emissions Related Text';
        NotOwnedVehDataG: Boolean;
        FORMAT__Sales_Line___Vehicle_Status__CaptionLbl: Text;
        FORMAT__Sales_Line___Vehicle_Status___Control160CaptionLbl: Text;
        VehicleStatus: Label 'Vehicle Status:';
        VehicleStatusE: Label 'Vehicle Status (e):';
        CityCaptionLbl: Label 'City';
        DateCaptionLbl: Label 'Date';
        SignatureCaptionLbl: Label 'Signature';
        Signatures_Lbl: Label 'Signatures';
        SignatureRepresentative_Lbl: Label 'Salesperson';
        SignatureClient_Lbl: Label 'Customer';
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
        ShowTaxNoG: Boolean;
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        MakeCaptionLbl: Label 'Make';
        WithoutVATLbl: Label 'without VAT';
        ShowVehicleInfoG: Boolean;

    [Scope('Internal')]
    procedure getSalPrice(SalesLineP: Record "Sales Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        OptionVariantL: Record "Option Variant";
        SalesPriceL: Decimal;
    begin
        // 0 = "Unit Price"
        // 1 = "Amount Including VAT"
        // 2 = Amount

        // Fahrzeug-Wert ermitteln
        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
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

        IF (PrintOptionG <> PrintOptionG::"Print all lines") OR (PrintUnitPriceG <> PrintUnitPriceG::"Print all prices") THEN BEGIN

            IF (PrintOptionG = PrintOptionG::"Print selected lines") OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
               (PrintOptionG = PrintOptionG::"Print no lines")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices"))
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

            IF (PrintOptionG = PrintOptionG::"Print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
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

            IF (PrintOptionG = PrintOptionG::"Print selected lines") OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
               (PrintOptionG = PrintOptionG::"Print no lines")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices"))
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

            IF (PrintOptionG = PrintOptionG::"Print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")
            THEN BEGIN
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
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
        OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        OptionVariantL.SETRANGE(Type, OptionVariantL.Type::Vehicle);
        IF OptionVariantL.FIND('-') THEN
            CASE ValueTypeP OF
                0:
                    IF (PrintUnitPriceG <> PrintUnitPriceG::"Print no prices") THEN
                        LineDiscPctL := OptionVariantL."Line Discount %"
                    ELSE
                        LineDiscPctL := SalesLineP."Line Discount %";
                2:
                    LineDiscPctL := 0;
            END
        ELSE
            LineDiscPctL := 0;

        IF (PrintOptionG <> PrintOptionG::"Print all lines") OR (PrintUnitPriceG <> PrintUnitPriceG::"Print all prices") THEN BEGIN

            IF (PrintOptionG = PrintOptionG::"Print selected lines") OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
               (PrintOptionG = PrintOptionG::"Print no lines")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
                OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
                OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
                OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
                IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                    OptionVariantL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices"))
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

            IF (PrintOptionG = PrintOptionG::"Print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")
            THEN BEGIN
                OptionVariantL.RESET;
                OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
                OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
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

            IF (PrintOptionG = PrintOptionG::"Print selected lines") OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
               (PrintOptionG = PrintOptionG::"Print no lines")
            THEN BEGIN
                SalesLineL.RESET;
                SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
                SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
                SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices"))
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

            IF (PrintOptionG = PrintOptionG::"Print selected lines") AND
               (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")
            THEN BEGIN
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
                        END;
                    UNTIL (SalesLineL.NEXT = 0);
            END;

        END;

        EXIT(LineDiscPctL);
    end;

    [Scope('Internal')]
    procedure getSalPrice2(SalesLineP: Record "Sales Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        OptionVariantL: Record "Option Variant";
        SalesPriceL: Decimal;
    begin

        // 0 = "Unit Price"
        // 1 = "Amount Including VAT"
        // 2 = Amount

        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
        OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        OptionVariantL.SETRANGE(Type, OptionVariantL.Type::Vehicle);
        IF OptionVariantL.FIND('-') THEN BEGIN
            VehFoundG := TRUE;
            CASE ValueTypeP OF
                0:
                    SalesPriceL := OptionVariantL."Unit Price";
                1:
                    SalesPriceL := OptionVariantL."Amount Including VAT";
                2:
                    SalesPriceL := OptionVariantL.Amount;
            END
        END ELSE BEGIN
            VehFoundG := FALSE;
            SalesPriceL := 0;
        END;
        IF ((PrintOptionG = PrintOptionG::"Print selected lines")) OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
           (PrintOptionG = PrintOptionG::"Print no lines")
        THEN BEGIN
            OptionVariantL.RESET;
            OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
            OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
            OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
            OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
            OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
            IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                OptionVariantL.SETRANGE("Print Option Line", FALSE);
            IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
               ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices"))
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

        IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") THEN BEGIN
            OptionVariantL.RESET;
            OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
            OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
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

        IF (PrintOptionG = PrintOptionG::"Print selected lines") OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
           (PrintOptionG = PrintOptionG::"Print no lines")
        THEN BEGIN
            SalesLineL.RESET;
            SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
            SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
            SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
            IF (SalesLineP."Item Type" = SalesLineP."Item Type"::Vehicle) AND (NOT VehFoundG) THEN
                SalesLineL.SETFILTER("Item Type", '%1', SalesLineL."Item Type"::Vehicle)
            ELSE BEGIN
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices"))
                THEN
                    SalesLineL.SETRANGE("Print Unit Price", FALSE);
            END;
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

        IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") THEN BEGIN
            SalesLineL.RESET;
            SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
            SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
            SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
            IF (SalesLineP."Item Type" = SalesLineP."Item Type"::Vehicle) AND (NOT VehFoundG) THEN
                SalesLineL.SETFILTER("Item Type", '%1', SalesLineL."Item Type"::Vehicle)
            ELSE BEGIN
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                SalesLineL.SETRANGE("Print Option Line", FALSE);
                SalesLineL.SETRANGE("Print Unit Price", TRUE);
            END;
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

        EXIT(SalesPriceL);
    end;

    [Scope('Internal')]
    procedure getLineDiscPct2(SalesLineP: Record "Sales Line"; ValueTypeP: Integer): Decimal
    var
        SalesLineL: Record "Sales Line";
        OptionVariantL: Record "Option Variant";
        LineDiscPctL: Decimal;
    begin

        // 0 = "Line Discount %"
        // 2 = "Inv. Discount Amount"

        OptionVariantL.RESET;
        OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
        OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
        OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
        OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
        OptionVariantL.SETRANGE(Type, OptionVariantL.Type::Vehicle);
        IF OptionVariantL.FIND('-') THEN BEGIN
            VehFoundG := TRUE;
            CASE ValueTypeP OF
                0:
                    IF (PrintUnitPriceG <> PrintUnitPriceG::"Print no prices") THEN
                        LineDiscPctL := OptionVariantL."Line Discount %"
                    ELSE
                        LineDiscPctL := SalesLineP."Line Discount %";
                2:
                    LineDiscPctL := 0;
            END
        END ELSE BEGIN
            VehFoundG := FALSE;
            LineDiscPctL := 0;
        END;

        IF ((PrintOptionG = PrintOptionG::"Print selected lines")) OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
           (PrintOptionG = PrintOptionG::"Print no lines")
        THEN BEGIN
            OptionVariantL.RESET;
            OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
            OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
            OptionVariantL.SETRANGE("Document No.", SalesLineP."Document No.");
            OptionVariantL.SETRANGE("Document Line No.", SalesLineP."Line No.");
            OptionVariantL.SETFILTER(Type, '<>%1', OptionVariantL.Type::Vehicle);
            IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                OptionVariantL.SETRANGE("Print Option Line", FALSE);
            IF ((PrintOptionG = PrintOptionG::"Print selected lines")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
               ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
               ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices"))
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

        IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") THEN BEGIN
            OptionVariantL.RESET;
            OptionVariantL.SETRANGE(Area, OptionVariantL.Area::Sale);
            OptionVariantL.SETRANGE("Document Type", OptionVariantL."Document Type"::"Purch. Order/Order");
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

        IF ((PrintOptionG = PrintOptionG::"Print selected lines")) OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
           (PrintOptionG = PrintOptionG::"Print no lines")
        THEN BEGIN
            SalesLineL.RESET;
            SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
            SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
            SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
            IF (SalesLineP."Item Type" = SalesLineP."Item Type"::Vehicle) AND (NOT VehFoundG) THEN
                SalesLineL.SETFILTER("Item Type", '%1', SalesLineL."Item Type"::Vehicle)
            ELSE BEGIN
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") THEN
                    SalesLineL.SETRANGE("Print Option Line", FALSE);
                IF ((PrintOptionG = PrintOptionG::"Print selected lines")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")) OR
                   ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices"))
                THEN
                    SalesLineL.SETRANGE("Print Unit Price", FALSE);
            END;
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

        IF (PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") THEN BEGIN
            SalesLineL.RESET;
            SalesLineL.SETRANGE("Document Type", SalesLineP."Document Type");
            SalesLineL.SETRANGE("Document No.", SalesLineP."Document No.");
            SalesLineL.SETRANGE(VIN, SalesLineP.VIN);
            IF (SalesLineP."Item Type" = SalesLineP."Item Type"::Vehicle) AND (NOT VehFoundG) THEN
                SalesLineL.SETFILTER("Item Type", '%1', SalesLineL."Item Type"::Vehicle)
            ELSE BEGIN
                SalesLineL.SETFILTER("Item Type", '<>%1', SalesLineL."Item Type"::Vehicle);
                SalesLineL.SETRANGE("Print Option Line", FALSE);
                SalesLineL.SETRANGE("Print Unit Price", TRUE);
            END;
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

        EXIT(LineDiscPctL);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPrice(): Boolean
    begin
        IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT SalesLineG."Print Option Line" AND SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND
           NOT SalesLineG."Print Option Line" AND SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT SalesLineG."Print Option Line" AND NOT SalesLineG."Print Unit Price") OR
           (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPriceOVC(): Boolean
    begin
        IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND "Optn Var. Color"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND "Optn Var. Color"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT "Optn Var. Color"."Print Option Line" AND NOT "Optn Var. Color"."Print Unit Price") OR
           (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure FunctionPrintUnitPriceOV(): Boolean
    begin
        IF ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT "Option Variant"."Print Option Line" AND "Option Variant"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND
           NOT "Option Variant"."Print Option Line" AND "Option Variant"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print selected lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print all prices") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           ((PrintOptionG = PrintOptionG::"Print all lines") AND (PrintUnitPriceG = PrintUnitPriceG::"Print selected prices") AND
           NOT "Option Variant"."Print Option Line" AND NOT "Option Variant"."Print Unit Price") OR
           (PrintUnitPriceG = PrintUnitPriceG::"Print no prices")
        THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure CheckPermission(ObjectTypeP: Option TableData,"Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System,FieldNumber; ObjectIDP: Integer): Boolean
    var
        LicPermL: Record "License Permission";
    begin
        IF LicPermL.GET(ObjectTypeP, ObjectIDP) THEN BEGIN
            IF LicPermL."Read Permission" = LicPermL."Read Permission"::Yes THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure CalcValues(OptionVariantP: Record "Option Variant")
    begin
        // Start PA033336
        ShowSalPriceG := 0;
        ShowLineDiscPctG := 0;
        IF PrintDiscG AND PrintUnitPriceHelpG AND
          NOT (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
        THEN BEGIN
            ShowSalPriceG := OptionVariantP."Unit Price";
            ShowLineDiscPctG := OptionVariantP."Line Discount %";
        END;

        IF DoNotShowVATG OR
          (SalesLineG."VAT Calculation Type" = SalesLineG."VAT Calculation Type"::"Differential Tax")
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
        VehApptL.SETFILTER(Status, '%1|%2|%3', VehApptL.Status::Recurring, VehApptL.Status::New, VehApptL.Status::Prepared);
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

        // Start PA039225.51457
        VehicleReportSelectionG."Print Sent-From Line" := TRUE;
        VehicleReportSelectionG."Print Address Block" := TRUE;
        VehicleReportSelectionG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC033;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(VehicleReportSelectionG);
            IF VehicleReportSelectionG."Print Report Title" THEN
                ReportTitleG := VehicleReportSelectionG."Report Title"
            ELSE BEGIN
                VehicleReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(VehicleReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        PrintSentFromLine2G := VehicleReportSelectionG."Print Sent-From Line";
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
    procedure GetNotOwnedVehicle(SalesHeaderP: Record "Sales Header"; SalesLineP: Record "Sales Line"; var VehicleP: Record Vehicle)
    var
        NotOwnedVehDetailsL: Record "Not Owned Veh. Detail";
    begin
        // Start PA041687
        IF NotOwnedVehDetailsL.GET(SalesHeaderP."Document Type", SalesHeaderP."No.", SalesLineP."Line No.") THEN BEGIN
            IF (NotOwnedVehDetailsL."Vehicle Source Type" = NotOwnedVehDetailsL."Vehicle Source Type"::Internal)
               AND (NotOwnedVehDetailsL."Company Name" <> COMPANYNAME)
            THEN BEGIN
                VehicleP.RESET;
                VehicleP.CHANGECOMPANY(NotOwnedVehDetailsL."Company Name");
                VehicleP.GET(SalesLineP.VIN);
            END;
        END;


        // Stop PA041687
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
        IF SalesHdrL.FINDSET THEN BEGIN
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


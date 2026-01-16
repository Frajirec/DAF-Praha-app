report 80012 "DPG Arch. Service Order Conf." // 1057643 "Arch. Service Order Confirm.CZ"
{
    // // @ Area Service
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA032589   28.03.11 YI Update of Service Header IsInternalCustomer() Call.
    // PA032473   14.06.11 GL 4067820: Version List corrected
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA033011   07.02.12 GC 5983155: VAT legend is not printed correctly
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033336   21.11.12 RH Changes to provide the RDLC-Layout
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA034264   16.05.13 GF I000953 RDL Layout modifications
    // PA034264   23.05.13 GF I000979 Classic, RDL Layout & code modifications
    // PA034051   30.07.13 MF Changes to print Performed Veh. Appointments and New Veh. Appointments.
    //            04.11.13 AN I002281 Code Review.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA035597   08.04.14 GD NAV 2013 R2 Technical Upgrade
    // PA035399   17.01.14 GG 19604 Field "Next Vehicle Appointments" added in request Form/Page. RDL modifications in order to
    //                              hide or not the "Next Vehicle Appointments".
    // PA035484   01.04.14 GF 20869 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036455   06.08.14 KK Correction of layout
    // PA035406   23.12.14 GN 29261 Service Advisor field is blank if Service Advisor is deleted from list
    // PA036549   14.01.15 GJ 32498 Layout corrections.
    // PA037341   21.01.15 GL Merge of PA035406
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035399.19604, PA035484.20869, PA036455, PA035406.29261
    // PA036549   29.01.15 GP 33267 Report Selection indication for "Print Footer Line" corrected
    // PA038165   03.06.15 VJ Double Byte German Names in RDLC are been changed as Service_Order_ConfirmationCaption1.
    // PA038166   03.06.15 VJ Merge of PA038165.
    // PA037047   02.09.15 LR 44278 Correct Filterts in RDLC
    //                        Correctly add the quantities
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457
    // PA042484   28.12.16 PT Added the code to print word Duplicate if its not a original invoice
    // PA042484   20.01.17 PT Added the text box in RDLC to print word "DUPLICATE"
    // PA042484   03.02.17 PT Added the code on CopyLoop on OnPostDataItem to increment the value of field "No. Printed"
    // PA042485   10.05.17 PT 95156 Added the check on NoOfCopies value if its less than 0
    // PA041187   13.02.17 MS 87564 Modifications to consider Service Job fixed price calculation in totals.
    //                              Modifications on layout to display only one block of totals (based on VAT Amount Line).
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   13.03.17 GV 89231 Fix Calculation of VAT Total.
    // PA043099   13.03.17 GW 90573 CopyLoopNo added to print copies. RDLC modifications.
    // PA043100   15.03.17 GW 90911 Merge of PA043099.90573.
    // --- 7.1.6 ---
    // EU.0000011 30.05.17 DR "Job Details Text Block" print enabled.
    //                        - 2 new lines in the RDLC added to print a Title and a Text Block.
    //                        - Use ReportSelectionG.INIT to set the preferred default Boolean values in the report selection.
    //                        - New Parameter "Print Job Detailed Descript." shown in the Report Request Page.
    //                        - Global variables PrintSentFromLineG, PrintAddrBlockG and PrintFooterLineG removed.
    //                        - Use the Report selection table fields for "Print Sent-From Line", "Print Address Block" and "Print Footer Line"
    //                          directly as source fields in the Report Request Page.
    //                        - JobOutputG renamed to ConsolidatePositionsOfAJobG as it is the "Consolidate Positions of a Job" parameter value.
    //                        - PkgOutputG renamed to ConsolidatePositionsOfAPackageG as it is the "Consolidate Positions of a Package" parameter value.
    //                        - Use CalcBaseOrderConfirmation as a replacement for constant 2 standing for CalcBase::"Order Confirmation".
    //                        - All single changed in which a SETFILTER can be replaced by a SETRANGE
    //                        - All Data Items which are not in used in the Report RDLC have been removed.
    //                        - Use Table.FIELDCAPTION(Fieldname) command for all report captions which exists as table fields.
    // EU.0000011 21.06.17 MS Complete re-structure of Service Preview Line creation and Consolidation options:
    //                        - MakeLines() former function removed and replaced by new centralized functions which handle the lines creation and consolidation options
    //                        - New Labor Consolidation option
    //                        - VAT Amount Line temporal creation removed and replaced by the centralized function
    //                        - CreateTotals() former function removed and replaced by a new centralized function
    //                        - PkgBOM DataItem re-structured to be based on temporal records calculated on the centralized function
    //                        - Fair Deal and Exchange parts calculation in totals has been centralized.
    //                        - Conditions to show/hide some controls have been simplified.
    //                        - "Print only Own Part" feature has been improved (VAT displayed based was wrong in the former version).
    //                        - In terms of RDLC there were two blocks of totals and only one was really used. The useless one was removed. All columns from the useless one were removed.
    //                          All controls on the final total block renamed to improve readability.
    //                        - Several RDLC small changes; cleanup/renaming of some columns to improve readability
    // EU.0000497 22.06.17 DR Increase the "No. Printed" field with each real paper print
    // EU.0002138 28.06.17 AK 2101 Merge of PA042484 & PA042485.95156
    // EU.0006767 28.09.17 GN 205 DetermineColumnVisibility() added and corresponding boolean variables to set columns visibility /
    //                        - Changed indentation and variable names from ServCustG,ServLineL to ArchServCustG,ArchServLineL
    // --- 7.2.0 ---
    // EU.0005636 19.10.17 MS Adjustments on report and RDLC to proper printing of Service Job Fixed Price
    // EU.0009764 28.11.17 MS 9813 Downmerge of EU.0005636 from N730
    // --- NAVCZ ---
    // API.1.0.3  07.08.18 PV New object created as a copy of Report 5025601 Service Order Confirm.
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    //                        Final design of vehicle/contract info part of header
    //                        Translation of req.page, Final header design,
    //                        Bank source, SK legislation
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ArchServiceOrderConf.rdlc';

    Caption = 'Arch. Service Order Confirm.';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Archived Service Header"; "Archived Service Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Service Order';
            column(Archived_Service_Header_Document_Type; "Document Type")
            {
            }
            column(Archived_Service_Header_No_; "No.")
            {
            }
            column(Archived_Service_Header_VIN; VIN)
            {
            }
            column(PrintPrices; PrintPricesG)
            {
                Description = 'EU.0000011';
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoopNo; Number)
                {
                    Description = 'PA043099.90573';
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
                        Description = 'PA040669.61931';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669.61931';
                    }
                    column(OrderCustAddrLineG; OrderCustAddrLineG)
                    {
                        Description = 'PA040669.61931';
                    }
                    column(Archived_Service_Header___Pickup_Time_; FORMAT("Archived Service Header"."Pickup Time", 0, '<Hours24,2>:<Minutes,2>'))
                    {
                    }
                    column(Archived_Service_Header___Pickup_Date_; FORMAT("Archived Service Header"."Pickup Date"))
                    {
                    }
                    column(Archived_Service_Header___No__; "Archived Service Header"."No.")
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Archived_Service_Header___Order_Date_; "Archived Service Header"."Order Date")
                    {
                    }
                    column(Cust__No__; CustG."No.")
                    {
                    }
                    column(CoTelephoneText; CoTelephoneTextG)
                    {
                    }
                    column(CoFaxText; CoFaxTextG)
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
                    column(CoEmailText; CoEmailTextG)
                    {
                    }
                    column(Archived_Service_Header___Time_of_Order_; FORMAT("Archived Service Header"."Time of Order", 0, '<Hours24,2>:<Minutes,2>'))
                    {
                    }
                    column(PhoneText; PhoneTextG)
                    {
                    }
                    column(Make_Name; MakeG.Name)
                    {
                    }
                    column(SalesPurch_Name_2; SalesPurchG.Name)
                    {
                    }
                    column(CurrencyText; CurrencyTextG)
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
                    column(CustAddr_7_; CustAddrG[7])
                    {
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(SalesPurch_Name_1; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(DataItem175; CollectiveG.TextShowOutput("Archived Service Header".FIELDCAPTION("VAT Registration No."), "Archived Service Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Archived_Service_Header___VAT_Registration_No__; "Archived Service Header"."VAT Registration No.")
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
                    column(Collective_TextShowOutput_C_INC041__PrintAddrBlock_; CollectiveG.TextShowOutput(C_INC_TaxNo, ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Collective_TextShowOutput_CompanyInfo__Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(CopyLoopNoG; CopyLoopNoG)
                    {
                        Description = 'PA042484';
                    }
                    column(BankText; BankTextG)
                    {
                    }
                    column(PrintFooterLine; ReportSelectionG."Print Footer Line")
                    {
                        Description = 'PA036549.32498,EU.0000011';
                    }
                    column(Archived_Service_Header___Pickup_Date_Caption; Archived_Service_Header___Pickup_Date_CaptionLbl)
                    {
                    }
                    column(PageLbl; Page_CaptionLbl)
                    {
                        Description = 'EU.0000011';
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(MakeLbl; MakeCaptionLbl)
                    {
                    }
                    column(MakeCode_ASH; "Archived Service Header"."Make Code")
                    {
                    }
                    column(ModelDescriptionLbl; ModelDescriptionCaptionLbl)
                    {
                    }
                    column(Model_ASH; "Archived Service Header".Model)
                    {
                    }
                    column(VINCpn_ASH; "Archived Service Header".FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(VIN_ASH; "Archived Service Header".VIN)
                    {
                    }
                    column(LicenseNoCpn_ASH; "Archived Service Header".FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(LicenseNo_ASH; "Archived Service Header"."License No.")
                    {
                    }
                    column(InitialRegistrationCpn_ASH; "Archived Service Header".FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(InitialRegistration_ASH; "Archived Service Header"."Initial Registration")
                    {
                    }
                    column(MileageLbl; MileageCaptionLbl)
                    {
                        Description = 'EU.0000011';
                    }
                    column(Mileage_RunningTime_ASH; FORMAT("Archived Service Header".Mileage) + ' /  ' + FORMAT("Archived Service Header"."Running Time"))
                    {
                    }
                    column(Mileage_ASH; "Archived Service Header".Mileage)
                    {
                    }
                    column(FuelLevelLbl; FuelLevelCaptionLbl)
                    {
                    }
                    column(FuelLevel_ASH; "Archived Service Header"."Fuel Level")
                    {
                    }
                    column(ServiceAdvisorLbl; ServiceAdvisorCaptionLbl)
                    {
                    }
                    column(ServiceAdvisorG; ServAdvisorG)
                    {
                    }
                    column(ServiceContractLbl; Service_ContractLbl)
                    {
                    }
                    column(ContractNo_VehCust; VehicleCustomerG."Contract No.")
                    {
                    }
                    column(AppointmentDateLbl; Appointment_DateLbl)
                    {
                    }
                    column(OrderDate_ASH; FORMAT("Archived Service Header"."Order Date") + ' / ' + FORMAT("Archived Service Header"."Time of Order"))
                    {
                    }
                    column(OrderLimitCpn_ASH; "Archived Service Header".FIELDCAPTION("Order Limit"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(OrderLimit_ASH; "Archived Service Header"."Order Limit")
                    {
                    }
                    column(Archived_Service_Header___Model_Code_; "Archived Service Header"."Model Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Archived_Service_Header___Engine_Code_; "Archived Service Header"."Engine Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Archived_Service_Header___Labor_Type_; "Archived Service Header"."Labor Type")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Archived_Service_Header___Engine_No__; "Archived Service Header"."Engine No.")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Archived_Service_Header___Engine_Code_Caption; "Archived Service Header".FIELDCAPTION("Engine Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Archived_Service_Header___Labor_Type_Caption; "Archived Service Header".FIELDCAPTION("Labor Type"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Archived_Service_Header___Engine_No__Caption; "Archived Service Header".FIELDCAPTION("Engine No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(SalesAdvisorCaption; SalesAdvisorCaptionLbl)
                    {
                    }
                    column(Archived_Service_Header___Model_Code_Caption; "Archived Service Header".FIELDCAPTION("Model Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(SalesPurch_Name_Cpn; SalesPurch_Name_Control151CaptionLbl)
                    {
                    }
                    column(Archived_Service_Header___No__Caption; Archived_Service_Header___No__CaptionLbl)
                    {
                    }
                    column(Archived_Service_Header___Order_Date_Caption; Archived_Service_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(ServiceOrderConfirmationCaption; ServiceOrderConfirmationCaptionLbl)
                    {
                    }
                    column(PaymentsToCaption; PaymentsToCaptionLbl)
                    {
                    }
                    column(DuplicateText; DuplicateTextG)
                    {
                        Description = 'PA042484';
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA033336,PA039225.51457';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; ReportLayoutSetupG."One Column Footer")
                    {
                        Description = 'PA040669.61931';
                    }
                    column(HideOneColumnFooter; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61931';
                    }
                    column(FooterField43; RDLHideOutput(ReportSelectionG."Print Footer Line" AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'EU.0000011';
                    }
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
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
                    column(PaymentMethodCode_SH; "Archived Service Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SH; "Archived Service Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SH; "Archived Service Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SH; "Archived Service Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SH; "Archived Service Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SH; "Archived Service Header"."Tax Registration No.")
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
                    column(DueDateCpn_SH; "Archived Service Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SH; "Archived Service Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SH; "Archived Service Header".FIELDCAPTION("Variable Symbol"))
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
                    column(DocumentDate_ASH; "Archived Service Header"."Document Date")
                    {
                    }
                    column(DueDate_ASH; "Archived Service Header"."Due Date")
                    {
                    }
                    column(DriverNameCpn_ASH; "Archived Service Header".FIELDCAPTION("Driver Name"))
                    {
                    }
                    column(DriverName_ASH; "Archived Service Header"."Driver Name")
                    {
                    }
                    column(PickupDateTime_ASH; PickupDateTime)
                    {
                    }
                    column(PickupDateTimeLbl_ASH; PickupDateTimeLbl)
                    {
                    }
                    column(YourReferenceCpt_ASH; "Archived Service Header".FIELDCAPTION("Your Reference"))
                    {
                    }
                    column(YourReference_ASH; "Archived Service Header"."Your Reference")
                    {
                    }
                    column(VehicleCategoryCode_ASH; "Archived Service Header"."Vehicle Category Code")
                    {
                    }
                    column(VehicleCategoryCodeCpn_ASH; "Archived Service Header".FIELDCAPTION("Vehicle Category Code"))
                    {
                    }
                    column(Description_PM; PaymentMethodG.Description)
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
                    column(DocumentDateCpn_ASH; "Archived Service Header".FIELDCAPTION("Document Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    dataitem("Header Text"; "Archived Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Archived Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Order), "Header/Footer" = CONST(Header));
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
                    dataitem("Vehicle Appointment"; "Vehicle Appointment")
                    {
                        DataItemLink = VIN = FIELD(VIN);
                        DataItemLinkReference = "Archived Service Header";
                        DataItemTableView = SORTING(VIN, "Next Appointment Date") ORDER(Ascending) WHERE(Status = FILTER(New));
                        column(HideVehicleAppointmentHeader1; RDLHideOutput(PrintNextVehicleAppointmentsG))
                        {
                            Description = 'PA035399.19604';
                        }
                        column(Next_Vehicle_Description; VehApptDescriptionG)
                        {
                            Description = 'PA031318';
                        }
                        column(Next_Vehicle_Appointments__Caption; Next_Vehicle_Appointments__CaptionLbl)
                        {
                            Description = 'PA034051';
                        }
                        column(Vehicle_Appointment_VIN; VIN)
                        {
                        }
                        column(Vehicle_Appointment_Appointment_Type; "Appointment Type")
                        {
                        }
                        column(Vehicle_Appointment_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA034051
                            VehApptDescriptionG := GetNextVehicleAppointmentTexts("Vehicle Appointment");
                            // Stop PA034051
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA034051
                            SETFILTER("Next Appointment Date", '%1..', "Archived Service Header"."Document Date");
                            // Stop PA034051
                        end;
                    }
                    dataitem(PrintPosition; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
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
                        column(BOMOutput; BOMOutputG)
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line__Description____________Service_Preview_Line___Description_2_; ServPreviewLineG.Description + CollectiveG.TextShowOutput(' - ', (ServPreviewLineG.Description > '') AND (ServPreviewLineG."Description 2" > '')) + ServPreviewLineG."Description 2")
                        {
                            Description = 'EU.0000011';
                        }
                        column(Service_Preview_Line___Service_Job_No__; ServPreviewLineG."Service Job No.")
                        {
                        }
                        column(Service_Preview_Line__Amount; ServPreviewLineG.Amount)
                        {
                        }
                        column(Service_Preview_Line__Attribute; ServPreviewLineG.Attribute)
                        {
                        }
                        column(OptSerialNoG; OptSerialNoG)
                        {
                        }
                        column(VehApptDescriptionG_; VehApptDescriptionG)
                        {
                        }
                        column(Service_Preview_Line___Package_No__; ServPreviewLineG."Package No.")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(Service_Preview_Line__Description__________Service_Preview_Line___Description_2_; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(ServicePreviewLine_LineType; (ServPreviewLineG."Line Type" + 0))
                        {
                            Description = 'EU.0000011';
                        }
                        column(ServicePreviewLine_Type; (ServPreviewLineG.Type + 0))
                        {
                            Description = 'EU.0000011';
                        }
                        column(ServCustomer_PrintFixedUnitPrice; FORMAT(ArchServCustG."Print Fixed Unit Price", 0, 2))
                        {
                        }
                        column(FixedPriceLab; FORMAT(FixedPriceLabG, 0, 2))
                        {
                        }
                        column(ServicePreviewLine_EntryNo; ServPreviewLineG."Entry No.")
                        {
                        }
                        column(Service_Preview_Line__Description; ServPreviewLineG.Description)
                        {
                        }
                        column(Service_Preview_Line__Quantity; ServPreviewLineG.Quantity)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Service_Preview_Line___Unit_of_Measure_; ServPreviewLineG."Unit of Measure")
                        {
                        }
                        column(Service_Preview_Line___Unit_Price_; ServPreviewLineG."Unit Price")
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Service_Preview_Line___Line_Discount___; ServPreviewLineG."Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Service_Preview_Line___No__; ServPreviewLineG."No.")
                        {
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Service_Preview_Line___Description_2_; ServPreviewLineG."Description 2")
                        {
                        }
                        column(JobOutput; ConsolidatePositionsOfAJobG)
                        {
                            Description = 'EU.0000011';
                        }
                        column(PackageOutput; ConsolidatePositionsOfAPackageG)
                        {
                            Description = 'EU.0000011';
                        }
                        column(SumLabor; SumLaborG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumExtServ; SumExtServG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(NoCaption; ServPreviewLineG.FIELDCAPTION("No."))
                        {
                            Description = 'EU.0000011';
                        }
                        column(DescriptionCaption; ServPreviewLineG.FIELDCAPTION(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(QtyCaption; QtyCaptionLbl)
                        {
                        }
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(AmountCaption; ServPreviewLineG.FIELDCAPTION(Amount))
                        {
                            Description = 'EU.0000011';
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
                        column(PrintPosition_Number; Number)
                        {
                        }
                        column(PrintFixedPriceG; PrintFixedPriceG)
                        {
                            Description = 'EU.0006767.205';
                        }
                        column(HidePrintSubtotal; RDLHideOutput(EvalHidePrintSubtotal()))
                        {
                            Description = 'EU.0006767.205';
                        }
                        column(HideQty; RDLHideOutput(ShowQtyG))
                        {
                            Description = 'EU.0006767.205';
                        }
                        column(HideUOM; RDLHideOutput(ShowUOMG))
                        {
                            Description = 'EU.0006767.205';
                        }
                        column(HideUnitPrice; RDLHideOutput(ShowUnitPriceG))
                        {
                            Description = 'EU.0006767.205';
                        }
                        column(HideDiscount; RDLHideOutput(ShowDiscountG))
                        {
                            Description = 'EU.0006767.205';
                        }
                        column(HideAmount; RDLHideOutput(ShowAmountG))
                        {
                            Description = 'EU.0006767.205';
                        }
                        column(WithoutVATLbl; WithoutVATLbl)
                        {
                        }
                        dataitem(PkgBOM; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(PkgBOM_UnitOfMeasure; TempServPreviewLineBOMG."Unit of Measure")
                            {
                            }
                            column(PkgBOM_Quantity; TempServPreviewLineBOMG.Quantity)
                            {
                            }
                            column(PkgBOM_Description; TempServPreviewLineBOMG.Description)
                            {
                            }
                            column(PkgBOM_No; TempServPreviewLineBOMG."No.")
                            {
                            }
                            column(PkgBOM_DocumentType; TempServPreviewLineBOMG."Document Type")
                            {
                            }
                            column(PkgBOM_DocumentNo; TempServPreviewLineBOMG."Document No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start EU.0000011
                                IF Number = 1 THEN
                                    TempServPreviewLineBOMG.FINDSET
                                ELSE
                                    TempServPreviewLineBOMG.NEXT;
                                // Stop EU.0000011
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT BOMOutputG THEN
                                    CurrReport.BREAK;

                                IF (ServPreviewLineG."Line Type" <> ServPreviewLineG."Line Type"::Job) OR
                                   (ServPreviewLineG."Service Job No." <> 0) OR (ServPreviewLineG."Package No." = '')
                                THEN
                                    CurrReport.BREAK;

                                // Start EU.0000011
                                TempServPreviewLineBOMG.RESET;
                                TempServPreviewLineBOMG.SETRANGE("Package No.", ServPreviewLineG."Package No.");
                                TempServPreviewLineBOMG.SETRANGE("Suppress in Order", FALSE);
                                IF TempServPreviewLineBOMG.ISEMPTY THEN
                                    CurrReport.BREAK;
                                SETRANGE(Number, 1, TempServPreviewLineBOMG.COUNT);
                                // Stop EU.0000011
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            ArchServLineL: Record "Archived Service Line";
                            ArchServJobLineL: Record "Archived Service Job Line";
                            ServJobLineL: Record "Service Job Line";
                            TaxAmountL: Decimal;
                            TaxRateL: Decimal;
                        begin
                            IF Number = 1 THEN
                                TempServPreviewLineG.FIND('-')
                            ELSE
                                TempServPreviewLineG.NEXT;
                            // Start EU.0000011
                            ServPreviewLineG := TempServPreviewLineG;
                            TextBlockContentG := '';
                            // Stop EU.0000011
                            IF PrintServOptionG THEN
                                GetServOptionNo;
                            IF ServPreviewLineG.Type <> ServPreviewLineG.Type::" " THEN BEGIN
                                // Start EU.0000011
                                // Stop EU.0000011
                                FixedPriceLabG := FALSE;
                                CLEAR(ArchServLineL);
                                CLEAR(ArchServCustG);
                                NoPropertyG := '';
                                IF NOT ArchServLineL.GET(
                                   ServPreviewLineG."Document Type",
                                   ServPreviewLineG."Document No.",
                                   ServPreviewLineG."Document Line No.")
                                // Start PA041187.87564
                                THEN BEGIN
                                    // Start EU.0000011
                                    // Stop EU.0000011
                                    ServPreviewLineG."No." := '';
                                    // Start EU.0005636
                                    IF ArchServCustG.GET(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Bill-to Customer No.") THEN
                                        ;
                                    // Stop EU.0005636
                                END ELSE BEGIN
                                    // Stop PA041187.87564
                                    IF ArchServCustG.GET("Archived Service Header"."Document Type", "Archived Service Header"."No.",
                                       ArchServLineL."Bill-to Customer No.")
                                    THEN
                                        ;
                                    IF (ArchServLineL.Type = ArchServLineL.Type::Labor) AND (ArchServLineL."Fixed Price" <> 0) THEN
                                        FixedPriceLabG := TRUE;
                                    // Start EU.0000011
                                    SetAttribute(ArchServLineL, ServPreviewLineG, NoPropertyG);
                                    // Stop EU.0000011
                                    IF ProportinatelyChargingLineG THEN BEGIN
                                        ServPreviewLineG."Unit Price" := 0;
                                        ServPreviewLineG."Line Discount %" := 0;
                                    END;
                                    // Start EU.0000011
                                END;
                            END;

                            IF ((ServPreviewLineG."Line Discount Amount" < 0) OR PrintWithoutDiscG) AND
                               NOT ProportinatelyChargingLineG AND (ServPreviewLineG.Quantity <> 0)
                            THEN BEGIN
                                ServPreviewLineG."Unit Price" := ServPreviewLineG.Amount / ServPreviewLineG.Quantity;
                                ServPreviewLineG."Line Discount %" := 0;
                            END;
                            // Stop EU.0000011
                            // Stop PA035597

                            // Start EU.0006767.205
                            IF ArchServJobLineL.GET(
                               ServPreviewLineG."Document Type",
                               ServPreviewLineG."Document No.",
                               ServPreviewLineG."Service Job No.")
                            THEN BEGIN
                                // Start EU.0005636
                                IF ArchServJobLineL."Includes Fixed Price" THEN
                                    // Stop EU.0005636
                                    PrintFixedPriceG := TRUE;
                            END;
                            DetermineColumnVisibility();
                            // Stop EU.0006767.205

                            // Start PA034051
                            VehApptDescriptionG := '';
                            IF ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job THEN
                                IF ArchServJobLineL.GET(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.",
                                   ServPreviewLineG."Service Job No.")
                                THEN
                                    IF (ArchServJobLineL."Veh. Appointment Code" <> '') AND
                                       (ArchServJobLineL."Veh. Appointment Status" <> ArchServJobLineL."Veh. Appointment Status"::New)
                                    THEN BEGIN
                                        ServJobLineL.TRANSFERFIELDS(ArchServJobLineL);
                                        VehApptDescriptionG := ServManagementG.CreateApptDescription(ServJobLineL);
                                    END;
                            // Start EU.0000011
                            TextBlockG.INIT;
                            IF ServPreviewLineG.Type = ServPreviewLineG.Type::" " THEN
                                IF ServPreviewLineG."Job Details Text Block" > 0 THEN BEGIN
                                    ServPreviewLineG."Line Type" := ServPreviewLineG."Line Type"::Text;
                                    IF NOT ReportSelectionG."Print Job Detailed Descript." THEN
                                        CurrReport.SKIP;
                                    IF NOT TextBlockG.GET(ServPreviewLineG."Job Details Text Block") THEN
                                        CurrReport.SKIP;
                                    TextBlockContentG := TextBlockG.GetTextBlock();
                                    ServPreviewLineG.Description := '';
                                    TextBlockG."Headline Text" := '';
                                    ServPreviewLineG."Description 2" := '          '; // Add a Blank line in the end
                                    ServPreviewLineG."Service Job No." := 0;
                                END;
                            // Stop EU.0000011
                            // Stop PA034051
                        end;

                        trigger OnPreDataItem()
                        var
                            ArchServJobLineL: Record "Archived Service Job Line";
                        begin
                            // Start EU.0000011
                            IF PrintFairDealRateG AND PrintPricesG THEN
                                MakeServPreviewG.ActivateFairDealCalculation(WarrCustG, TRUE);
                            MakeServPreviewG.ShowJob("Archived Service Header", TempServPreviewLineG, MakeServPreviewG.CalcBaseOrderConfirmation(), TRUE);
                            MakeServPreviewG.GetVATAmountLineTemp(VATAmountLineG);
                            // totals
                            TempServPreviewLineG.GetTotals(ServSetupG."Output Ext. Service", SumItemG, SumExtServG, SumLaborG, SumOtherG, SumFairDealG);
                            VATAmountLineG.GetTotals(TotalNetG, TotalGrossG, TotalVATG);
                            TempServPreviewLineG.GetTotalExchangeParts(SumExchTaxG, SumExchAmountG, ExchRateG);
                            TotalGrossG := TotalGrossG + SumExchTaxG;
                            // consolidation
                            IF ConsolidatePositionsOfAJobG THEN
                                TempServPreviewLineG.ConsolidateJobs(PrintPricesG);
                            IF ConsolidateNegativePosG THEN
                                TempServPreviewLineG.ConsolidateNegativePositions();
                            IF ConsolidateLaborPosG THEN
                                TempServPreviewLineG.ConsolidateByType(TempServPreviewLineG.Type::Labor, ConsolidatePositionsOfAPackageG);
                            IF ConsolidatePositionsOfAPackageG THEN
                                TempServPreviewLineG.ConsolidatePackages("Archived Service Header"."Document Type", "Archived Service Header"."No.", TempServPreviewLineBOMG, TRUE, BOMOutputG, PrintPricesG);

                            TempServPreviewLineG.SETRANGE("Suppress in Order", FALSE);
                            // Stop EU.0000011
                            IF PrintOnlyOwnPartG THEN BEGIN
                                SetCustomerAmounts();
                            END;

                            CLEAR(MakeServPreviewG);

                            // Start EU.0000011
                            // Stop EU.0000011

                            // Start PA025769
                            SetOptionLines;

                            MoreLinesG := TempServPreviewLineG.FINDLAST;

                            TempServPreviewLineG.SETRANGE("Entry No.", 0, TempServPreviewLineG."Entry No.");
                            SETRANGE(Number, 1, TempServPreviewLineG.COUNT);

                            CurrReport.CREATETOTALS(TempServPreviewLineG."Line Discount Amount", TempServPreviewLineG.Amount,
                              TempServPreviewLineG."Amount Including VAT");
                        end;
                    }
                    dataitem(ServiceOption; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TempArchServLineG_Amount; TempArchServLineG.Amount)
                        {
                        }
                        column(TempArchServLineG_Description; TempArchServLineG.Description)
                        {
                        }
                        column(TempArchServLineG__No__; TempArchServLineG."No.")
                        {
                        }
                        column(OptSerialNoG_Control1109400022; OptSerialNoG)
                        {
                        }
                        column(CreatedOwnOptionsCaption; CreatedOwnOptionsCaptionLbl)
                        {
                        }
                        column(DescriptionCaption_Control1109400012; ServLine2G.FIELDCAPTION(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(OptionCodeCaption; "Archived Service Header".FIELDCAPTION("Option Code"))
                        {
                            Description = 'EU.0000011';
                        }
                        column(NoCaption_Control1109400014; ServPreviewLineG.FIELDCAPTION("No."))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PriceCaption_Control1109400015; PriceCaption_Control1109400015Lbl)
                        {
                        }
                        column(ServiceOption_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempArchServLineG.FIND('-')
                            ELSE
                                TempArchServLineG.NEXT;
                            OptSerialNoG := C_INC045 + FORMAT(TempArchServLineG."Line No.");
                            SerOptionG := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempArchServLineG.RESET;
                            ServiceOption.SETRANGE(Number, 1, TempArchServLineG.COUNT);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TotalGross; TotalGrossG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalNet; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalTextG)
                        {
                        }
                        column(SumFairDeal; SumFairDealG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(FairDealText; FairDealTextG)
                        {
                        }
                        column(C_INC033; C_INC033)
                        {
                        }
                        column(VATText; VATTextG)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(VATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Archived Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Archived Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintFairDealRate; PrintFairDealRateG)
                        {
                        }
                        column(SumExchAmount; SumExchAmountG)
                        {
                            AutoFormatExpression = "Archived Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumExchTax; SumExchTaxG)
                        {
                            AutoFormatExpression = "Archived Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                            VATTextG := C_INC001;
                            // Start PA033336
                            VATTextG := STRSUBSTNO('%1%2', VATAmountLineG."VAT %", C_INC001);
                            // Stop PA033336
                        end;

                        trigger OnPostDataItem()
                        begin
                            // Start PA033336
                            VATTextG := STRSUBSTNO('%1%2', ExchRateG, C_INC022);
                            // Stop PA033336
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA041187.87564
                            IF VATAmountLineG.COUNT < 1 THEN
                                // Stop PA041187.87564
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Footer Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Archived Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Order), "Header/Footer" = CONST(Footer));
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
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(LegendText; LegendTextG)
                        {
                        }
                        column(FooterTextG; FooterTextG)
                        {
                        }
                        column(WtyDate; FORMAT(WtyDateG, 0, 2))
                        {
                        }
                        column(FairDealDa; FORMAT(FairDealDaG, 0, 2))
                        {
                        }
                        column(ReturnDa; FORMAT(ReturnDaG, 0, 2))
                        {
                        }
                        column(ExchangeDa; FORMAT(ExchangeDaG, 0, 2))
                        {
                        }
                        column(ProportinatelyCharging; FORMAT(ProportinatelyChargingG, 0, 2))
                        {
                        }
                        column(SerOptionG; FORMAT(SerOptionG, 0, 2))
                        {
                        }
                        column(PaymentTerms_Description; PaymentTermsG.Description)
                        {
                        }
                        column(ExplanationsCaption; ExplanationsCaptionLbl)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033336
                            LegendTextG := '';
                            IF WtyDateG THEN
                                LegendTextG := C_INC037;
                            IF FairDealDaG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC038
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC038;
                            IF ReturnDaG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC039
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC039;
                            IF ExchangeDaG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC040
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC040;
                            IF ProportinatelyChargingG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC042
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC042;
                            IF SerOptionG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC045 + C_INC043
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC045 + C_INC043;
                            IF SerOptionG AND PrintPricesG THEN
                                FooterTextG := C_INC044
                            ELSE
                                FooterTextG := '';
                            // Stop PA033336
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // Start PA033336
                        VehicleAppointmentsPrintedG := VehicleAppointmentsTextG > '';

                        IF VehicleAppointmentsPrintedG THEN BEGIN
                            VehicleAppointmentsText_Line1G := CollectiveG.DevideTextInLine(VehicleAppointmentsTextG, 77);
                            VehicleAppointmentsText_Line2G := CollectiveG.DevideTextInLine(VehicleAppointmentsTextG, 77);
                            VehicleAppointmentsText_Line3G := CollectiveG.DevideTextInLine(VehicleAppointmentsTextG, 77);
                        END ELSE BEGIN
                            VehicleAppointmentsText_Line1G := '';
                            VehicleAppointmentsText_Line2G := '';
                            VehicleAppointmentsText_Line3G := '';
                        END;
                        // Stop PA033336
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    CLEAR(ServLine2G);
                    CLEAR(CalcServAmtsG);
                    CalcServAmtsG.ArchGetServLines("Archived Service Header", ServLine2G, 0);
                    // Start PA042484
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;
                    IF ("Archived Service Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN
                        DuplicateTextG := C_INC_DuplicateText;
                    CopyLoopNoG := CopyLoopNoG + 1;
                    // Stop PA042484
                    // Start PA035597
                    // Stop PA035597

                    SumLaborG := 0;
                    SumItemG := 0;
                    SumExtServG := 0;
                    SumOtherG := 0;
                    TotalNetG := 0;
                    TotalVATG := 0;
                    TotalGrossG := 0;
                    SumExchTaxG := 0;
                    SumExchAmountG := 0;
                    ExchRateG := 0;
                    SumFairDealG := 0;
                    // Start EU.0000011
                    // Stop EU.0000011
                    ProportinatelyChargingG := FALSE;
                    // Start PA042484
                    // Stop PA042484
                end;

                trigger OnPostDataItem()
                begin
                    // Start EU.0000497
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        "Archived Service Header".FIND;
                        "Archived Service Header"."No. Printed" := "Archived Service Header"."No. Printed" + 1;
                        "Archived Service Header".MODIFY;
                    END;
                    // Stop EU.0000497
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
            var
                ServLineL: Record "Service Line";
                ArchServJobLineL: Record "Archived Service Job Line";
                ArchServLineL: Record "Archived Service Line";
                ServPrevLineL: Record "Service Preview Line";
                bankAccountL: Record "Bank Account";
            begin
                //Start API.1.0.3
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");

                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Make Code", "Location Code",
                  REPORT::"DPG Arch. Service Order Conf.");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN BEGIN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Make Code", "Location Code");
                END;

                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Archived Service Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName(USERID);
                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                "Archived Service Header".CALCFIELDS("Driver Name");

                CLEAR(VehicleCustomerG);
                VehicleCustomerG.SETRANGE(VIN, "Archived Service Header".VIN);
                VehicleCustomerG.SETRANGE(Type, VehicleCustomerG.Type::"Service Contract");
                VehicleCustomerG.SETFILTER("Beginning of Contract", '<=%1', "Archived Service Header"."Order Date");
                VehicleCustomerG.SETFILTER("Expiration of Contract", '>=%1', "Archived Service Header"."Order Date");
                IF VehicleCustomerG.FINDFIRST THEN
                    ;

                PickupDateTime := CREATEDATETIME("Archived Service Header"."Pickup Date", "Pickup Time");

                IF "Archived Service Header"."Sell-to Customer No." <> "Archived Service Header"."Bill-to Customer No." THEN BEGIN
                    FormatServAddrG.ArchivServiceHeaderBillto(OrderCustAddrG, "Archived Service Header");
                    OrderCustAddrLineG := C_INC008 + FormatServAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';
                //Stop API.1.0.3

                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.")
                ELSE
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();  // vapa?

                IF NOT LocationG.GET("Location Code") THEN
                    CLEAR(LocationG);
                IntCustG := CompanyInfoG."Internal Customer";
                IF LocationG."Internal Customer" <> '' THEN
                    IntCustG := LocationG."Internal Customer";
                IF (LocationG."Ship-to Address Code" <> '') AND
                   (OwnDelivAddressG.GET(IntCustG, LocationG."Ship-to Address Code"))
                THEN BEGIN
                    FormatAddrG.OwnCustomerAddress(CompanyAddrG, OwnDelivAddressG);
                    FormatAddrG.OwnAddressLetterWindow(AddrWindowG, OwnDelivAddressG);
                    CoTelephoneG := OwnDelivAddressG."Phone No.";
                    CoFaxG := OwnDelivAddressG."Fax No.";
                    CoEmailG := OwnDelivAddressG."E-Mail";
                END ELSE BEGIN
                    FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
                    FormatAddrG.CompanyLetterAddressWindow(AddrWindowG, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
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

                //Start API.1.0.3.
                //  Correct company bank info is filled when OnValidate of T36."Bank Account Code" is run.
                //  Then it is passed to posted tables, ... Ie. this info should be shown in reports.
                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccountL.RESET;
                IF bankAccountL.GET("Archived Service Header"."Bank Account Code") THEN BEGIN
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
                //   OwnBanksG.GET(IntCustG, LocationG."Bank Code")
                // THEN
                //  BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                // ELSE
                //  BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                //Stop API.1.0.3

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
                    TotalTextG := STRSUBSTNO(C_INC030, GLSetupG."LCY Code");
                    TotalInclVATTextG := STRSUBSTNO(C_INC031, GLSetupG."LCY Code");
                    CurrencyTextG := GLSetupG."LCY Code";
                    FairDealTextG := STRSUBSTNO(C_INC032, GLSetupG."LCY Code");
                END ELSE BEGIN
                    TotalTextG := STRSUBSTNO(C_INC030, "Currency Code");
                    TotalInclVATTextG := STRSUBSTNO(C_INC031, "Currency Code");
                    CurrencyTextG := "Currency Code";
                    FairDealTextG := STRSUBSTNO(C_INC032, "Currency Code");
                END;
                VehicleFormatAddrG.ArchivServiceHeaderSoldto(CustAddrG, "Archived Service Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");

                // Start API.1.0.3
                IF NOT PaymentMethodG.GET("Archived Service Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // Stop API.1.0.3

                PhoneTextG := '';
                IF ("Sell-to Mobile Phone No." <> '') OR
                   ("Sell-to Home Mobile Phone No." <> '') OR
                   ("Sell-to Phone No." <> '') OR
                   ("Sell-to Bus. Mobile Phone No." <> '')
                THEN BEGIN
                    PhoneTextG := C_INC010;
                    IF "Sell-to Mobile Phone No." <> '' THEN
                        PhoneTextG := PhoneTextG + ' ' + C_INC011 + ' ' + "Sell-to Mobile Phone No.";
                    IF "Sell-to Home Mobile Phone No." <> '' THEN BEGIN
                        IF "Sell-to Mobile Phone No." <> '' THEN
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC012
                        ELSE
                            PhoneTextG := PhoneTextG + '  ' + C_INC012;
                        PhoneTextG := PhoneTextG + ' ' + "Sell-to Home Mobile Phone No.";
                    END;
                    IF "Sell-to Phone No." <> '' THEN BEGIN
                        IF "Sell-to Home Mobile Phone No." <> '' THEN
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC013
                        ELSE
                            PhoneTextG := PhoneTextG + '  ' + C_INC013;
                        PhoneTextG := PhoneTextG + ' ' + "Sell-to Phone No.";
                    END;
                    IF "Sell-to Bus. Mobile Phone No." <> '' THEN BEGIN
                        IF "Sell-to Phone No." <> '' THEN
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC014
                        ELSE
                            PhoneTextG := PhoneTextG + '  ' + C_INC014;
                        PhoneTextG := PhoneTextG + ' ' + "Sell-to Bus. Mobile Phone No.";
                    END;
                END;

                PrintWithoutDiscG := NOT "Archived Service Header"."Show Discount";

                ServLineL.RESET;
                ServLineL.SETRANGE("Document Type", "Archived Service Header"."Document Type");
                ServLineL.SETRANGE("Document No.", "Archived Service Header"."No.");
                ServLineL.SETFILTER("Line Discount %", '>%1', 0);
                IF (ServLineL.COUNT <> 0) AND (NOT PrintWithoutDiscG) THEN
                    DiscTextG := C_INC015
                ELSE
                    DiscTextG := '';

                WarrCustG := '';
                IF "Make Code" <> '' THEN BEGIN
                    MakeG.GET("Make Code");
                    WarrCustG := MakeG."Factory Warranty Customer";
                END ELSE
                    MakeG.INIT;

                IF "Service Advisor No." <> '' THEN BEGIN
                    // Start PA035406
                    IF EmployeeG.GET("Service Advisor No.") THEN BEGIN
                        ServAdvisorG := EmployeeG.Name;
                    END ELSE
                        ServAdvisorG := '';
                    // Stop PA035406
                END ELSE
                    ServAdvisorG := '';

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                WtyDateG := FALSE;
                FairDealDaG := FALSE;
                ReturnDaG := FALSE;
                ExchangeDaG := FALSE;
                VehicleAppointmentsTextG := VehAppointmG.GetVehicleAppoitnmentTexts(VIN, TRUE);
                // Start PA041187.87564
                CALCFIELDS("Includes Fixed Price");
                // Stop PA041187.87564

                // Start EU.0006767.205
                PrintTotalG := TRUE;
                ArchServJobLineL.RESET;
                ArchServJobLineL.SETRANGE("Document Type", "Document Type");
                ArchServJobLineL.SETRANGE("Document No.", "No.");
                ArchServJobLineL.SETRANGE("Includes Fixed Price", TRUE);
                IF ArchServJobLineL.FINDSET THEN
                    REPEAT
                        IF PrintTotalG THEN BEGIN
                            ArchServLineL.RESET;
                            ArchServLineL.SETCURRENTKEY("Document Type", "Document No.", "Service Job No.");
                            ArchServLineL.SETRANGE("Document Type", ArchServJobLineL."Document Type");
                            ArchServLineL.SETRANGE("Document No.", ArchServJobLineL."Document No.");
                            ArchServLineL.SETRANGE("Service Job No.", ArchServJobLineL."Line No.");
                            ServPrevLineL.RESET;
                            ServPrevLineL.SETRANGE("Document Type", ArchServJobLineL."Document Type");
                            ServPrevLineL.SETRANGE("Document No.", ArchServJobLineL."Document No.");
                            ServPrevLineL.SETRANGE("Service Job No.", ArchServJobLineL."Line No.");
                            IF ArchServLineL.ISEMPTY AND NOT ServPrevLineL.ISEMPTY THEN
                                PrintTotalG := FALSE;
                        END;
                    UNTIL ArchServJobLineL.NEXT = 0;
                // Stop EU.0006767.205
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                // Start PA042484
                CopyLoopNoG := 0;
                // Stop PA042484
                ServSetupG.GET();
            end;
        }
    }

    requestpage
    {
        Caption = 'Service Order Confirm.';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Možnosti")
                {
                    Caption = 'Options';
                    field("No. of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start PA042485.95156
                            IF NoOfCopiesG < 0 THEN
                                ERROR(C_INC_NoOfCopiesValue);
                            //Stop PA042485.95156
                        end;
                    }
                    field("Print Prices"; PrintPricesG)
                    {
                        Caption = 'Print Prices';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            IF PrintPricesG = FALSE THEN BEGIN
                                PrintFairDealRateG := FALSE;
                                PrintOnlyOwnPartG := FALSE;
                            END;
                        end;
                    }
                    field("Print only Own Part"; PrintOnlyOwnPartG)
                    {
                        Caption = 'Print only Own Part';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            IF PrintOnlyOwnPartG THEN
                                PrintPricesG := TRUE;
                        end;
                    }
                    field("Print Fair Deal Rate"; PrintFairDealRateG)
                    {
                        Caption = 'Print Fair Deal Rate';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            IF PrintFairDealRateG THEN
                                PrintPricesG := TRUE;
                        end;
                    }
                    field("Print Sent-From Line"; ReportSelectionG."Print Sent-From Line")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Sent-From Line");
                        Description = 'EU.0000011';
                    }
                    field("Print Address Block"; ReportSelectionG."Print Address Block")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Address Block");
                        Description = 'EU.0000011';
                    }
                    field("Print Footer Line"; ReportSelectionG."Print Footer Line")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Footer Line");
                        Description = 'EU.0000011';
                    }
                    field("Print Service Options"; PrintServOptionG)
                    {
                        Caption = 'Print Service Options';
                        Description = 'EU.0000011';
                    }
                    field("Print Next Vehicle Appointments"; PrintNextVehicleAppointmentsG)
                    {
                        Caption = 'Print Next Vehicle Appointments';
                        Description = 'EU.0000011';
                    }
                    field("Print Job Detailed Descript."; ReportSelectionG."Print Job Detailed Descript.")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Job Detailed Descript.");
                        Description = 'EU.0000011';
                    }
                }
                group(Konsolidace)
                {
                    Caption = 'Consolidation';
                    Description = 'EU.0000011';
                    field("Consolidate Negative Positions"; ConsolidateNegativePosG)
                    {
                        Caption = 'Consolidate Negative Positions';
                        Description = 'EU.0000011';
                    }
                    field("Consolidate Positions of a Job"; ConsolidatePositionsOfAJobG)
                    {
                        Caption = 'Consolidate Positions of a Job';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start EU.0000011
                            IF ConsolidatePositionsOfAJobG THEN BEGIN
                                ConsolidateLaborPosG := FALSE;
                                ConsolidatePositionsOfAPackageG := FALSE;
                                BOMOutputG := FALSE;
                            END;
                            // Stop EU.0000011
                        end;
                    }
                    field("Consolidate Positions of a Package"; ConsolidatePositionsOfAPackageG)
                    {
                        Caption = 'Consolidate Positions of a Package';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start EU.0000011
                            IF ConsolidatePositionsOfAPackageG THEN
                                ConsolidatePositionsOfAJobG := FALSE
                            ELSE
                                // Stop EU.0000011
                                BOMOutputG := FALSE;
                        end;
                    }
                    field("Output Package BOM"; BOMOutputG)
                    {
                        Caption = 'Output Package BOM';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            BOMOutputGOnPush;
                        end;
                    }
                    field("Consolidate Labor Positions"; ConsolidateLaborPosG)
                    {
                        Caption = 'Consolidate Labor Positions';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start EU.0000011
                            IF ConsolidateLaborPosG THEN
                                ConsolidatePositionsOfAJobG := FALSE;
                            // Stop EU.0000011
                        end;
                    }
                    field(RePrintOriginalInvG; RePrintOriginalInvG)
                    {
                        Caption = 'Re-Print Original Invoice';
                        Description = 'PA042484';
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
            PrintPricesG := FALSE;
            PrintFairDealRateG := FALSE;
            PrintOnlyOwnPartG := FALSE;
            GetReportSelection();
            BOMOutputG := FALSE;
            ConsolidateNegativePosG := TRUE;
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
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
        ServSetupG.GET();
        PrintPricesG := FALSE;
        PrintFairDealRateG := FALSE;
        GetReportSelection();
        BOMOutputG := FALSE;
        ConsolidateNegativePosG := TRUE;
        PrintNextVehicleAppointmentsG := TRUE;
        // Stop EU.0000011
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        ServSetupG: Record "Service Setup";
        ReportSelectionG: Record "Service Manag. Rep. Selection";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        MakeG: Record Make;
        EmployeeG: Record Employee;
        VATAmountLineG: Record "VAT Amount Line" temporary;
        TempServPreviewLineG: Record "Service Preview Line" temporary;
        TempServPreviewLineBOMG: Record "Service Preview Line" temporary;
        ServPrevLineTempG: Record "Service Preview Line" temporary;
        SalesPurchG: Record "Salesperson/Purchaser";
        ServPreviewLineG: Record "Service Preview Line";
        ArchServCustG: Record "Archived Service Customer";
        ServLine2G: Record "Archived Service Line" temporary;
        ServLineCustG: Record "Archived Service Line Customer";
        TextBlockG: Record "Text Block";
        PaymentTermsG: Record "Payment Terms";
        VehAppointmG: Record "Vehicle Appointment";
        TempArchServLineG: Record "Archived Service Line" temporary;
        FormatAddrG: Codeunit "Format Address";
        VehicleFormatAddrG: Codeunit "Veh Format Address";
        CalcServAmtsG: Codeunit "Calculate Serv. Amounts";
        MakeServPreviewG: Codeunit "Make Serv. Preview/Archive";
        ServManagementG: Codeunit "Service Management";
        UserSessionG: Codeunit "User Session Unit";
        CollectiveG: Codeunit "Collection Unit";
        TextBlockContentG: Text;
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
        AddrWindowG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoEmailG: Text[80];
        CoEmailTextG: Text[80];
        CoFaxG: Text[30];
        CoFaxTextG: Text[30];
        CoTelephoneG: Text[30];
        CoTelephoneTextG: Text[30];
        CopyTextG: Text[30];
        FairDealTextG: Text[50];
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        VATTextG: Text[50];
        NoPropertyG: Text[10];
        DiscTextG: Text[20];
        ReferenceTextG: Text[30];
        ServAdvisorG: Text[50];
        PhoneTextG: Text[150];
        TotalInclVATTextG: Text[50];
        TotalTextG: Text[50];
        CurrencyTextG: Text[10];
        LegendTextG: Text[250];
        VehicleAppointmentsTextG: Text[1024];
        DuplicateTextG: Text[100];
        VehicleAppointmentsPrintedG: Boolean;
        OptSerialNoG: Text[30];
        FooterTextG: Text[150];
        WarrCustG: Code[20];
        IntCustG: Code[20];
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        NextEntryNoG: Integer;
        ExchRateG: Decimal;
        TotalGrossG: Decimal;
        TotalVATG: Decimal;
        TotalNetG: Decimal;
        SumLaborG: Decimal;
        SumItemG: Decimal;
        SumExchAmountG: Decimal;
        SumExchTaxG: Decimal;
        SumExtServG: Decimal;
        SumFairDealG: Decimal;
        SumFairDealPerSectionG: Decimal;
        SumOtherG: Decimal;
        ExchangeDaG: Boolean;
        FixedPriceLabG: Boolean;
        WtyDateG: Boolean;
        ConsolidatePositionsOfAJobG: Boolean;
        ConsolidatePositionsOfAPackageG: Boolean;
        ConsolidateLaborPosG: Boolean;
        PrintFairDealRateG: Boolean;
        FairDealDaG: Boolean;
        MoreLinesG: Boolean;
        PrintWithoutDiscG: Boolean;
        PrintPricesG: Boolean;
        ReturnDaG: Boolean;
        BOMOutputG: Boolean;
        C_INC001: Label '% VAT of';
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        C_INC008: Label 'Order Customer:';
        C_INC010: Label 'Phone:';
        C_INC011: Label 'Private';
        C_INC012: Label 'Mobile';
        C_INC013: Label 'Bus.';
        C_INC014: Label 'Mobile';
        C_INC015: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC017: Label 'Package BOMs can only be output for consolidated packages !';
        C_INC022: Label '% Exch. Tax from';
        C_INC023: Label '% VAT of';
        C_INC029: Label 'Copy';
        C_INC030: Label 'Total %1';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Fair deal amount %1';
        C_INC033: Label 'F';
        C_INC035: Label 'G';
        C_INC036: Label 'R';
        C_INC037: Label 'W = Warranty Position';
        C_INC038: Label 'F = Fair Deal Position';
        C_INC039: Label 'R =Return-mandatory part';
        C_INC040: Label '* = Replacement Part';
        C_INC_TaxNo: Label 'Tax No.';
        ConsolidateNegativePosG: Boolean;
        ProportinatelyChargingG: Boolean;
        ProportinatelyChargingLineG: Boolean;
        C_INC042: Label 'P = Proportionately Charged';
        PrintOnlyOwnPartG: Boolean;
        PrintServOptionG: Boolean;
        SerOptionG: Boolean;
        C_INC043: Label 'X = Serial No. of Service Options. ';
        C_INC044: Label 'Total Of Options price can vary from manual calculation because of rounding';
        C_INC045: Label 'O';
        SkipAddLineToTotalsG: Boolean;
        CopyLoopNoG: Integer;
        ShowQtyG: Boolean;
        ShowUOMG: Boolean;
        ShowUnitPriceG: Boolean;
        ShowDiscountG: Boolean;
        ShowAmountG: Boolean;
        ShowLineSubTotalsG: Boolean;
        PrintFixedPriceG: Boolean;
        PrintTotalG: Boolean;
        OutputNoG: Integer;
        ExTypeG: Integer;
        VATAmountLineCountG: Integer;
        VehicleAppointmentsText_Line1G: Text[250];
        VehicleAppointmentsText_Line2G: Text[250];
        VehicleAppointmentsText_Line3G: Text[250];
        [InDataSet]
        VehApptDescriptionG: Text[50];
        PrintNextVehicleAppointmentsG: Boolean;
        C_INC046: Label 'Service Order Confirm.';
        C_INC_DuplicateText: Label 'D U P L I C A T E';
        C_INC_NoOfCopiesValue: Label 'Please enter value greater than 0 or equal to 0';
        Archived_Service_Header___Pickup_Date_CaptionLbl: Label 'Pickup Appt.';
        Page_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        MakeCaptionLbl: Label 'Make';
        ModelDescriptionCaptionLbl: Label 'Model Description';
        ServiceAdvisorCaptionLbl: Label 'Service Advisor';
        SalesAdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_Name_Control151CaptionLbl: Label 'Salesperson';
        Archived_Service_Header___No__CaptionLbl: Label 'Order No.';
        Archived_Service_Header___Order_Date_CaptionLbl: Label 'ReceivingDate';
        ServiceOrderConfirmationCaptionLbl: Label 'Service Order Confirmation';
        PaymentsToCaptionLbl: Label 'Payments to:';
        Next_Vehicle_Appointments__CaptionLbl: Label 'Next Vehicle Appointments:';
        QtyCaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        ContinuedCaptionLbl: Label 'Continued';
        TotalNet___SumFairDealPerSection_Control125CaptionLbl: Label 'Sum carried forward';
        SumLaborCaptionLbl: Label 'Sum Labor';
        SumItemCaptionLbl: Label 'Sum Item';
        SumExtServCaptionLbl: Label 'Sum External Services';
        SumOtherCaptionLbl: Label 'Sum Other';
        CreatedOwnOptionsCaptionLbl: Label 'Created Own Options';
        PriceCaption_Control1109400015Lbl: Label 'Price';
        ExplanationsCaptionLbl: Label 'Explanations';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        RePrintOriginalInvG: Boolean;
        _Incadea_vars: Integer;
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportTitleG: Text[100];
        IsRepSelectionSetupAvailableG: Boolean;
        OrderCustAddrLineG: Text[100];
        OrderCustAddrG: array[8] of Text[100];
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
        ShowTaxNoG: Boolean;
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
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        UnitPriceLbl: Label 'Unit Price';
        NoLbl: Label 'No.';
        MileageCaptionLbl: Label 'Mileage / Running Time';
        FuelLevelCaptionLbl: Label 'Fuel Level';
        VehicleCustomerG: Record "Vehicle Customer";
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
        PickupDateTime: DateTime;
        PickupDateTimeLbl: Label 'Pickup DateTime';
        FormatServAddrG: Codeunit "Veh Format Address";
        WithoutVATLbl: Label 'without VAT';

    [Scope('Internal')]
    procedure SetAttribute(ArchServLineP: Record "Archived Service Line"; var CurServPreviewLineP: Record "Service Preview Line"; var LinePropertyL: Text[10])
    var
        ItemL: Record Item;
    begin
        // SetAttribute

        // Check Exchange Part flag and set it, if required
        // Flag for exchange part = *
        IF ArchServLineP."VAT Calculation Type" = ArchServLineP."VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
            IF STRPOS(LinePropertyL, C_INC016) = 0 THEN
                LinePropertyL := LinePropertyL + C_INC016;
            ExchangeDaG := TRUE;
        END;

        // Check fair deal position and load fair deal flag
        // Start EU.0000011
        // Stop EU.0000011
        // Only set the warranty flag if the rate is no fair deal position and the warranty customer
        IF CurServPreviewLineP."Fair Deal" THEN BEGIN
            IF STRPOS(LinePropertyL, COPYSTR(C_INC038, 1, 1)) = 0 THEN
                LinePropertyL := LinePropertyL + COPYSTR(C_INC038, 1, 1);
            FairDealDaG := TRUE;
        END;

        // contains a complete invoice for this line
        // Check if the items are return-mandatory
        // Flag for return part = R
        // Start EU.0000011
        IF NOT CurServPreviewLineP."Fair Deal" THEN BEGIN
            // Stop EU.0000011
            ArchServLineP.CALCFIELDS("No. of Bill-to Customers");
            IF (ArchServLineP."Bill-to Customer No." = WarrCustG) AND (ArchServLineP."No. of Bill-to Customers" = 1) THEN BEGIN
                WtyDateG := TRUE;
                IF STRPOS(LinePropertyL, C_INC035) = 0 THEN
                    LinePropertyL := LinePropertyL + C_INC035;
            END;
        END;

        // Check if the items are return-mandatory
        // Flag for return part = R
        IF ArchServLineP.Type = ArchServLineP.Type::Item THEN BEGIN
            IF NOT ItemL.GET(ArchServLineP."No.") THEN
                CLEAR(ItemL);
            IF ItemL."Sending Required" IN [ItemL."Sending Required"::Keep, ItemL."Sending Required"::Send] THEN BEGIN
                IF STRPOS(LinePropertyL, C_INC036) = 0 THEN
                    LinePropertyL := LinePropertyL + C_INC036;
                ReturnDaG := TRUE;
            END;
        END;
        ProportinatelyChargingLineG := FALSE;
        IF PrintPricesG THEN BEGIN
            ServLineCustG.RESET;
            ServLineCustG.SETRANGE("Document Type", "Archived Service Header"."Document Type");
            ServLineCustG.SETRANGE("Document No.", "Archived Service Header"."No.");
            ServLineCustG.SETRANGE("Document Line No.", ArchServLineP."Line No.");
            ServLineCustG.SETRANGE("Bill-to Customer No.", "Archived Service Header"."Bill-to Customer No.");
            IF ServLineCustG.FIND('-') THEN BEGIN
                IF ServLineCustG."Portion %" <> 100 THEN BEGIN
                    IF STRPOS(LinePropertyL, COPYSTR(C_INC042, 1, 1)) = 0 THEN
                        LinePropertyL := LinePropertyL + COPYSTR(C_INC042, 1, 1);
                    ProportinatelyChargingG := TRUE;
                    ProportinatelyChargingLineG := TRUE;
                END;
            END ELSE BEGIN
                IF STRPOS(LinePropertyL, COPYSTR(C_INC042, 1, 1)) = 0 THEN
                    LinePropertyL := LinePropertyL + COPYSTR(C_INC042, 1, 1);
                ProportinatelyChargingG := TRUE;
                ProportinatelyChargingLineG := TRUE;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure SetCustomerAmounts()
    var
        TempServPreviewLineL: Record "Service Preview Line" temporary;
        FromPreviewLineL: Integer;
        ToPreviewLineL: Integer;
    begin
        TempServPreviewLineL.DELETEALL();
        // Start EU.0000011
        VATAmountLineG.RESET;
        VATAmountLineG.DELETEALL;
        MakeServPreviewG.ShowCustomer("Archived Service Header", TempServPreviewLineL, MakeServPreviewG.CalcBaseOrderConfirmation(), TRUE);
        // Stop EU.0000011
        TempServPreviewLineG.RESET;
        IF TempServPreviewLineG.FINDSET THEN BEGIN
            REPEAT
                TempServPreviewLineG."Unit Price" := 0;
                TempServPreviewLineG."Line Discount %" := 0;
                TempServPreviewLineG."Line Discount Amount" := 0;
                TempServPreviewLineG.Amount := 0;
                TempServPreviewLineG."Amount Including VAT" := 0;
                TempServPreviewLineG."Exch. Parts Tax Base" := 0;
                TempServPreviewLineG."Exch. Parts Tax Amount" := 0;
                TempServPreviewLineG."Portion %" := 0;
                TempServPreviewLineG.MODIFY;
            UNTIL TempServPreviewLineG.NEXT = 0;
        END;

        FromPreviewLineL := 0;
        ToPreviewLineL := 0;
        TempServPreviewLineL.RESET;
        TempServPreviewLineL.SETRANGE("Bill-to Customer No.", "Archived Service Header"."Bill-to Customer No.");
        IF TempServPreviewLineL.FINDFIRST THEN BEGIN
            FromPreviewLineL := TempServPreviewLineL."Entry No.";
            TempServPreviewLineL.SETRANGE("Bill-to Customer No.");
            TempServPreviewLineL.SETFILTER("Entry No.", '>%1', FromPreviewLineL);
            TempServPreviewLineL.SETRANGE("Line Type", TempServPreviewLineL."Line Type"::Total);
            IF TempServPreviewLineL.FINDFIRST THEN BEGIN
                ToPreviewLineL := TempServPreviewLineL."Entry No.";
            END;
            TempServPreviewLineL.RESET;
            IF ToPreviewLineL <> 0 THEN BEGIN
                TempServPreviewLineL.SETFILTER("Entry No.", '%1..%2', FromPreviewLineL, ToPreviewLineL);
            END ELSE BEGIN
                TempServPreviewLineL.SETFILTER("Entry No.", '>=%1', FromPreviewLineL);
            END;
            IF TempServPreviewLineL.FINDSET THEN BEGIN
                REPEAT
                    TempServPreviewLineG.RESET;
                    IF TempServPreviewLineL.Type = TempServPreviewLineL.Type::" " THEN BEGIN
                        TempServPreviewLineG.SETRANGE("Line Type", TempServPreviewLineL."Line Type");
                        TempServPreviewLineG.SETRANGE(Description, TempServPreviewLineL.Description);
                        IF TempServPreviewLineG.FINDFIRST THEN BEGIN
                            TempServPreviewLineG."Unit Price" := TempServPreviewLineG."Unit Price" + TempServPreviewLineL."Unit Price";
                            TempServPreviewLineG."Line Discount %" := TempServPreviewLineG."Line Discount %" + TempServPreviewLineL."Line Discount %";
                            TempServPreviewLineG."Line Discount Amount" := TempServPreviewLineG."Line Discount Amount" +
                              TempServPreviewLineL."Line Discount Amount";
                            TempServPreviewLineG.Amount := TempServPreviewLineG.Amount + TempServPreviewLineL.Amount;
                            TempServPreviewLineG."Amount Including VAT" := TempServPreviewLineG."Amount Including VAT" +
                              TempServPreviewLineL."Amount Including VAT";
                            TempServPreviewLineG."Exch. Parts Tax Base" := TempServPreviewLineG."Exch. Parts Tax Base" +
                              TempServPreviewLineL."Exch. Parts Tax Base";
                            TempServPreviewLineG."Exch. Parts Tax Amount" := TempServPreviewLineG."Exch. Parts Tax Amount" +
                              TempServPreviewLineL."Exch. Parts Tax Amount";
                            TempServPreviewLineG."Portion %" := TempServPreviewLineG."Portion %" + TempServPreviewLineL."Portion %";
                            // Start EU.0000011
                            IF (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Line) AND (TempServPreviewLineG.Amount <> 0) THEN BEGIN
                                TempServPreviewLineG."VAT %" := TempServPreviewLineL."VAT %";
                                VATAmountLineG.CreateFromServicePreviewLine(TempServPreviewLineG, '', FALSE);
                            END;
                            // Stop EU.0000011
                            TempServPreviewLineG.MODIFY;
                        END;
                    END ELSE BEGIN
                        TempServPreviewLineG.SETRANGE("Document Line No.", TempServPreviewLineL."Document Line No.");
                        TempServPreviewLineG.SETRANGE(Type, TempServPreviewLineL.Type);
                        TempServPreviewLineG.SETRANGE("No.", TempServPreviewLineL."No.");
                        IF TempServPreviewLineG.FINDFIRST THEN BEGIN
                            TempServPreviewLineG."Unit Price" := TempServPreviewLineG."Unit Price" + TempServPreviewLineL."Unit Price";
                            TempServPreviewLineG."Line Discount %" := TempServPreviewLineG."Line Discount %" + TempServPreviewLineL."Line Discount %";
                            TempServPreviewLineG."Line Discount Amount" := TempServPreviewLineG."Line Discount Amount" +
                              TempServPreviewLineL."Line Discount Amount";
                            TempServPreviewLineG.Amount := TempServPreviewLineG.Amount + TempServPreviewLineL.Amount;
                            TempServPreviewLineG."Amount Including VAT" := TempServPreviewLineG."Amount Including VAT" +
                              TempServPreviewLineL."Amount Including VAT";
                            TempServPreviewLineG."Exch. Parts Tax Base" := TempServPreviewLineG."Exch. Parts Tax Base" +
                              TempServPreviewLineL."Exch. Parts Tax Base";
                            TempServPreviewLineG."Exch. Parts Tax Amount" := TempServPreviewLineG."Exch. Parts Tax Amount" +
                              TempServPreviewLineL."Exch. Parts Tax Amount";
                            TempServPreviewLineG."Portion %" := TempServPreviewLineG."Portion %" + TempServPreviewLineL."Portion %";
                            // Start EU.0000011
                            IF (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Line) AND (TempServPreviewLineG.Amount <> 0) THEN BEGIN
                                TempServPreviewLineG."VAT %" := TempServPreviewLineL."VAT %";
                                VATAmountLineG.CreateFromServicePreviewLine(TempServPreviewLineG, '', FALSE);
                            END;
                            // Stop EU.0000011
                            TempServPreviewLineG.MODIFY;
                        END;
                    END;
                UNTIL TempServPreviewLineL.NEXT = 0;
            END;
        END;
        TempServPreviewLineG.RESET;
        // Start EU.0000011
        TempServPreviewLineG.GetTotals(ServSetupG."Output Ext. Service", SumItemG, SumExtServG, SumLaborG, SumOtherG, SumFairDealG);
        VATAmountLineG.GetTotals(TotalNetG, TotalGrossG, TotalVATG);
        TempServPreviewLineG.GetTotalExchangeParts(SumExchTaxG, SumExchAmountG, ExchRateG);
        TempServPreviewLineG.RESET;
        // Stop EU.0000011
    end;

    [Scope('Internal')]
    procedure SetOptionLines()
    var
        ArchServLineL: Record "Archived Service Line";
        ArchServJobL: Record "Archived Service Job Line";
        ItemL: Record Item;
        OptionLineNoL: Integer;
    begin
        TempArchServLineG.DELETEALL;
        IF NOT PrintServOptionG THEN
            EXIT;
        // Start EU.0000011
        OptionLineNoL := 0;
        // Stop EU.0000011
        ArchServLineL.RESET;
        ArchServLineL.SETRANGE("Document Type", "Archived Service Header"."Document Type");
        ArchServLineL.SETRANGE("Document No.", "Archived Service Header"."No.");
        ArchServLineL.SETRANGE(ArchServLineL."Value Increasing Measure", TRUE);

        IF ArchServLineL.FINDSET THEN
            REPEAT
                TempArchServLineG.RESET;
                TempArchServLineG.SETRANGE("Document Type", ArchServLineL."Document Type");
                TempArchServLineG.SETRANGE("Document No.", ArchServLineL."Document No.");

                IF ArchServLineL."Service Job No." = 0 THEN
                    TempArchServLineG.SETFILTER("Service Job No.", '=%1', 0)
                ELSE
                    TempArchServLineG.SETRANGE("Service Job No.", ArchServLineL."Service Job No.");
                TempArchServLineG.SETRANGE("No.", ArchServLineL."Option Code");
                IF NOT TempArchServLineG.FINDFIRST THEN BEGIN
                    TempArchServLineG.TRANSFERFIELDS(ArchServLineL);
                    IF NOT PrintPricesG THEN
                        TempArchServLineG.Amount := 0;
                    TempArchServLineG."No." := ArchServLineL."Option Code";
                    IF ArchServLineL."Service Job No." <> 0 THEN BEGIN
                        ArchServJobL.GET(ArchServLineL."Document Type", ArchServLineL."Document No.", ArchServLineL."Service Job No.");
                        IF ArchServJobL.Instruction <> '' THEN BEGIN
                            TempArchServLineG.Description := ArchServJobL.Instruction;
                            TempArchServLineG."Description 2" := ArchServJobL.Complaint;
                        END ELSE
                            TempArchServLineG.Description := ArchServJobL.Complaint;
                    END ELSE BEGIN
                        ItemL.GET(ArchServLineL."Option Code");
                        TempArchServLineG.Description := ItemL.Description;
                    END;
                    // Start EU.0000011
                    OptionLineNoL := OptionLineNoL + 1;
                    TempArchServLineG."Line No." := OptionLineNoL;
                    // Stop EU.0000011
                    TempArchServLineG.INSERT;
                END ELSE
                    IF PrintPricesG THEN BEGIN
                        TempArchServLineG.Amount := TempArchServLineG.Amount + ArchServLineL.Amount;
                        TempArchServLineG.MODIFY;
                        OptSerialNoG := C_INC045 + FORMAT(TempArchServLineG."Line No.");
                    END;
            UNTIL ArchServLineL.NEXT = 0;
        TempArchServLineG.RESET;
    end;

    [Scope('Internal')]
    procedure GetServOptionNo()
    var
        ArchServLineL: Record "Archived Service Line";
        NoOfPackOptionL: Integer;
    begin
        OptSerialNoG := '';
        IF NOT PrintServOptionG THEN
            EXIT;

        IF TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Job THEN BEGIN
            // Start EU.0000011
            IF ConsolidatePositionsOfAJobG AND (TempServPreviewLineG."Service Job No." <> 0) THEN BEGIN
                // Stop EU.0000011
                TempArchServLineG.RESET;
                TempArchServLineG.SETRANGE("Document Type", TempServPreviewLineG."Document Type");
                TempArchServLineG.SETRANGE("Document No.", TempServPreviewLineG."Document No.");
                TempArchServLineG.SETRANGE("Service Job No.", TempServPreviewLineG."Service Job No.");
                IF TempArchServLineG.FINDFIRST THEN
                    OptSerialNoG := C_INC045 + FORMAT(TempArchServLineG."Line No.");
                EXIT;
            END;
            IF (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Job) AND
               (TempServPreviewLineG."Service Job No." = 0)
            THEN
                // Start EU.0000011
                IF ConsolidatePositionsOfAPackageG THEN BEGIN
                    // Stop EU.0000011
                    ArchServLineL.RESET;
                    ArchServLineL.SETRANGE("Document Type", TempServPreviewLineG."Document Type");
                    ArchServLineL.SETRANGE("Document No.", TempServPreviewLineG."Document No.");
                    ArchServLineL.SETRANGE("Package No.", TempServPreviewLineG."Package No.");
                    // Start EU.0000011
                    IF ConsolidatePositionsOfAJobG THEN
                        ArchServLineL.SETRANGE("Service Job No.", 0);
                    // Stop EU.0000011
                    IF ArchServLineL.FINDSET THEN
                        REPEAT
                            TempArchServLineG.RESET;
                            TempArchServLineG.SETRANGE("Document Type", ArchServLineL."Document Type");
                            TempArchServLineG.SETRANGE("Document No.", ArchServLineL."Document No.");
                            // Start EU.0000011
                            TempArchServLineG.SETRANGE("Service Job No.", ArchServLineL."Service Job No.");
                            // Stop EU.0000011
                            TempArchServLineG.SETRANGE("No.", ArchServLineL."Option Code");
                            IF TempArchServLineG.FINDFIRST THEN BEGIN
                                NoOfPackOptionL := NoOfPackOptionL + 1;
                                IF NoOfPackOptionL = 1 THEN
                                    OptSerialNoG := C_INC045 + FORMAT(TempArchServLineG."Line No.")
                                ELSE
                                    IF NoOfPackOptionL <= 3 THEN
                                        IF STRPOS(OptSerialNoG, FORMAT(TempArchServLineG."Line No.")) = 0 THEN
                                            OptSerialNoG := OptSerialNoG + ';' + C_INC045 + FORMAT(TempArchServLineG."Line No.")
                                        ELSE
                                            NoOfPackOptionL := NoOfPackOptionL - 1;
                            END;
                        UNTIL ArchServLineL.NEXT = 0;
                    EXIT;
                END;
        END;
        IF NOT ArchServLineL.GET(TempServPreviewLineG."Document Type",
           TempServPreviewLineG."Document No.",
           TempServPreviewLineG."Document Line No.")
        THEN
            EXIT;
        TempArchServLineG.RESET;
        TempArchServLineG.SETRANGE("Document Type", ArchServLineL."Document Type");
        TempArchServLineG.SETRANGE("Document No.", ArchServLineL."Document No.");
        // Start EU.0000011
        TempArchServLineG.SETRANGE("Service Job No.", ArchServLineL."Service Job No.");
        // Stop EU.0000011
        TempArchServLineG.SETRANGE("No.", ArchServLineL."Option Code");
        IF TempArchServLineG.FINDFIRST THEN
            OptSerialNoG := C_INC045 + FORMAT(TempArchServLineG."Line No.");
    end;

    local procedure BOMOutputGOnPush()
    begin
        // Start EU.0000011
        IF NOT ConsolidatePositionsOfAPackageG AND BOMOutputG THEN BEGIN
            MESSAGE(C_INC017);
            BOMOutputG := FALSE;
            RequestOptionsPage.UPDATE(FALSE);
        END;
        // Stop EU.0000011
    end;

    [Scope('Internal')]
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use it to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA033336
        EXIT(NOT ShowOutputP);
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
        // Start EU.0000011
        ReportSelectionG.INIT;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC046;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionG);
            // Stop EU.0000011
            //Start API.1.0.3
            IF ReportSelectionG."Print Report Title" THEN
                ReportTitleG := ReportSelectionG."Report Title"
            ELSE BEGIN
                ReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;
        //Stop API.1.0.3
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
        ArchServHdrL: Record "Archived Service Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        ArchServHdrL.SETRANGE(ArchServHdrL."No.", "Archived Service Header".GETFILTER("No."));
        IF ArchServHdrL.FINDSET THEN BEGIN
            IF ArchServHdrL."Sell-to Customer No." <> '' THEN
                CustL.GET(ArchServHdrL."Sell-to Customer No.")
            ELSE
                CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
        END;
        // Stop PA043099
    end;

    [Scope('Internal')]
    procedure DetermineColumnVisibility()
    begin
        // @ Determines Column Visibility based on Print Service Job Fixed Price value of the current Service Customer
        // @ Applies only to Fixed Price related lines.

        // Start EU.0006767.205
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

        CASE ArchServCustG."Print Service Job Fixed Price" OF
            ArchServCustG."Print Service Job Fixed Price"::"Fixed Price Only":
                BEGIN
                    ShowQtyG := FALSE;
                    ShowUOMG := FALSE;
                    ShowUnitPriceG := FALSE;
                    ShowDiscountG := FALSE;
                    ShowAmountG := FALSE;
                    ShowLineSubTotalsG := FALSE;
                    IF ServPreviewLineG."Control Type" = ServPreviewLineG."Control Type"::Job THEN
                        ShowLineSubTotalsG := TRUE;
                END;
            ArchServCustG."Print Service Job Fixed Price"::"Quantity Only":
                BEGIN
                    ShowQtyG := TRUE;
                    ShowUOMG := TRUE;
                    ShowUnitPriceG := FALSE;
                    ShowDiscountG := FALSE;
                    ShowAmountG := FALSE;
                    ShowLineSubTotalsG := FALSE;
                    IF ServPreviewLineG."Control Type" = ServPreviewLineG."Control Type"::Job THEN
                        ShowLineSubTotalsG := TRUE;
                END;
            ArchServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit":
                BEGIN
                    ShowQtyG := TRUE;
                    ShowUOMG := TRUE;
                    ShowUnitPriceG := TRUE;
                    ShowDiscountG := TRUE;
                    ShowAmountG := TRUE;
                    ShowLineSubTotalsG := TRUE;
                END;
        END;
        // Stop EU.0006767.205
    end;

    [Scope('Internal')]
    procedure EvalHidePrintSubtotal() ValueR: Boolean
    begin
        // @ Evaluates Sum Line Visibility
        // @ retval ValueR - Boolean

        // Start EU.0005636
        ValueR := (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Sum) AND PrintPricesG AND ShowLineSubTotalsG;
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

        //19.7.18: TitleText* variables must remain blank
        //to print Barcode instead of the header column "Auth. Left Line x"
        // IF PrintBarCodeG THEN BEGIN
        //  PrintDocTitleAndNoUpG := FALSE;
        //  ReportLayoutSetupG."Auth. Left Line 1" := '';
        //  ReportLayoutSetupG."Auth. Left Line 2" := '';
        //  ReportLayoutSetupG."Auth. Left Line 3" := '';
        //  ReportLayoutSetupG."Auth. Left Line 4" := '';
        //  ReportLayoutSetupG."Auth. Left Line 5" := '';
        //  CLEAR(ReportLayoutSetupG."Header Graphic Left");
        // END;

        headerGraphicCount := 0;
        IF PrintDocTitleAndNoUpG THEN BEGIN
            IF (ReportLayoutSetupG."Header Graphic Left".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := '';
                TitleTextCenterG := ReportTitleG;
                TitleTextRightG := "Archived Service Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Archived Service Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Archived Service Header"."No.";
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


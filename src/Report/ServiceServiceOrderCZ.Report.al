report 80035 "DPG Service - Service Order CZ" // 1057610 "Service - Service Order CZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA032589   11.04.11 YI Function IsInternalCustomer changed: now refers to new fiel in customer record, thus less loops
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032031   07.10.11 GB Barcode printout of the Order No in the Report Header based on the Option in the Request Form.
    //                        Barcode printout of the Service Job based on the field Job Task Acquisition Mandatory in Human Res. Setup
    // PA033011   07.02.12 GC 5983155: VAT legend is not printed correctly
    // PA032672   02.04.12 GB 7007221: Make frame Request Form bigger
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032672   19.04.12 GB 7180283: Print Job No. Barcode when print barcode option is selected
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA032861   06.08.12 KC 6269811: Modified OnPreReport() trigger after removal of parameter "Job Task Acquisition Mandatory" from table HR Setup
    // PA033336   06.09.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - New 'OutputNoG' global variable created.
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Logos are not incorporated in RDLC layout due to alignment with the new Report Layout Concept.
    //                        - Section Code is moved to body code trigger.
    //                        - hidden field added
    //                        - Layout1 concept added
    // PA033336   01.10.12 8782891: Totals are wrong while using copy functionality, code modied in printposition
    //                        OnAfterGetRecord().
    //                        In RTC single vat printing table is modified.
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Service Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (7) - OnPreSection()", "PageLoop, Footer (8) - OnPreSection()"
    // PA033336   30.10.12 SS 8719075: Changed the Text Constant C_INC040 to "* = Exchange Part".
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033019   14.11.12 SM 9277732: Changed Layout to show the Service invoice line with type "".
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA034255   18.06.13 GG I000012 Classic and RDL Layout modification
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034051   30.07.13 MF Changes to print Performed Veh. Appointments and New Veh. Appointments.
    //            04.11.13 AN I002281 Code Review.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036461   29.08.14 GI 27592 RDLC layout corrections
    // PA035399   17.01.14 GG 19604 Field "Next Vehicle Appointments" added in request Form/Page. RDL modifications in order to
    //                        hide or not the "Next Vehicle Appointments".
    // PA035484   01.04.14 GF 20784 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   14.01.15 GD 32502 RDL Layout fix for Labels.
    //                        Fix For "Payment To" visibility.
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035399.19604, PA035484.20784
    // PA036549   23.01.15 GP 32502 Report Layout Selection corrected.
    //                        RDLC Layout corrections.
    // PA038228   05.08.15 GN Added Header information.
    //                        Added Footer functionality.
    //                        Added detailed Service information
    // PA038228   21.08.15 GN 43628 Changed Footer fields sequence.
    // PA037047   03.09.15 LR 44247 Correctly filter for JobOutput. Correct RDLC bug.
    // PA037047   06.09.15 LR 44234 Correctly add the quantities
    // PA038218   22.09.15 KR 45498 Code modified in "Re-sortLines" to correct the display of VAT% and corrected som allignment issues.
    // PA040587   21.04.16 GU RDLC Modification in order to print Decription correctly
    // PA040589   05.05.16 GS Merge of PA040587
    // PA040669   27.05.16 GP 61816 Redesign RDLC layout
    // PA040669   01.06.16 GQ 61816 RDLC layout corrections
    // PA040669   02.06.16 GQ 61816 RDLC layout corrections
    // PA040669   03.06.16 GQ 61816 RDLC layout corrections and changed value of C_INC029
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   03.08.16 JS Merge of PA039225.51457
    // PA040837   20.07.16 CH 66154 Totals are shown and calculated based on the temporary VATAmountLineG records.
    // PA041179   07.09.16 DR Merge of PA040837.66154
    // PA041125   08.08.16 GN 68081 RDLC Layout Corrections
    // PA041366   17.08.16 GS Determine the return status on an Item from Service Line, according to design
    // PA041366   24.11.16 GQ 81144 RDLC Layout corrections - C_INC035 variable corrected
    // PA042076   24.12.16 UX "Print Service Job Fixed Price" functionality added.
    // PA041187   13.02.17 MS 87564 Modifications to consider Service Job fixed price calculation in totals
    //                              Modifications on layout to display only one block of totals. Tablix 'Table15' is not displayed (Filters property changed)
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   13.03.17 GV 89231 Fix calculation of VAT Totals.
    //            13.03.17 WZ 90476 Check Service Job and Service Customer for the rounding account line which is not a Service Line
    //            22.03.17 MS 91511 New column ServPreviewLineG."Control Type". Changes to consider additional Fixed Price conditions
    // PA043382   31.03.17 JS Changed Report Layout to print "Unit of Measure" description completely.
    // PA041187   04.04.17 MS 92447 Modification to not print totals in case of service jobs with fixed prices and no service lines assigned
    // PA043382   12.04.17 JS Changed Report Layout to print "Unit of Measure" description completely.
    // --- 7.1.6 ---
    // EU.0000011 30.05.17 DR "Job Details Text Block" and "Internal Comments Text Block" print enabled.
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
    //                        - Overlapped controls were fixed by adjusting the tablix controls properly.
    //                        - Fair Deal and Exchange parts calculation in totals has been centralized.
    //                        - Package BOM grouping on RDLC has been improved. It didn't work before.
    //                        - Conditions to show/hide some controls have been simplified.
    //                        - "Print only Own Part" feature has been improved (VAT displayed based was wrong in the former version).
    //                        - In terms of RDLC there were two blocks of totals and only one was really used. The useless one was removed. All columns from the useless one were removed.
    //                          All controls on the final total block renamed to improve readability.
    //                        - Several RDLC small changes; cleanup/renaming of some columns to improve readability
    // --- 7.2.0 ---
    // EU.0000485 12.07.17 BL Repeat Repair: Column added, where presented if Service Job Line has flag Repeat Repair.
    // EU.0005682 06.09.17 DR Downmerge of EU.0000485
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5025619 Service - Service Order
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed, translation
    //                        Final design of vehicle/contract info part of header
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, SK legislation,
    //                        Barcode
    // API.1.0.4  07.11.18 PV Barcode changed to Free 3 of 9
    // API.1.0.4  21.11.18 PV RDLC - extend email place
    //                         -get user fullname through common codeunit 1057605 "ET91,290,382,383,1226"
    // API.1.0.4  07.12.18 PV Variable OrderCustAddrLineG extended to avoid error messages
    // --- DAF CZ ---
    // 
    // DAF CZ    01.03.19  FJC Adjusted spaces. Header text removed.
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceServiceOrderCZ.rdlc';

    Caption = 'Service - Service Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Service Order';
            column(Service_Header_Document_Type; "Document Type")
            {
            }
            column(Service_Header_No_; "No.")
            {
            }
            column(Service_Header_VIN; VIN)
            {
            }
            column(Service_Header_VINisEmpty; VIN = '')
            {
            }
            column(PrintTotal; PrintTotalG)
            {
                Description = 'PA041187.92447';
            }
            column(PrintPrices; PrintPricesG)
            {
                Description = 'EU.0000011';
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyAddr_1_; CompanyAddrG[1])
                    {
                        Description = 'PA028449';
                    }
                    column(CompanyAddr_2_; CompanyAddrG[2])
                    {
                        Description = 'PA028449';
                    }
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                        Description = 'PA028449';
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA040669.61816';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669.61816';
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
                    {
                        Description = 'PA040669.61816';
                    }
                    column(Service_Header___No__; "Service Header"."No.")
                    {
                        Description = 'PA028449';
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                        Description = 'PA028449';
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Service_Header___Order_Date_; FORMAT("Service Header"."Order Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(Cust__No__; CustG."No.")
                    {
                        Description = 'PA028449';
                    }
                    column(CoTelephoneText; CoTelephoneTextG)
                    {
                        Description = 'PA028449';
                    }
                    column(CoFaxText; CoFaxTextG)
                    {
                        Description = 'PA028449';
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
                        Description = 'PA028449';
                    }
                    column(Service_Header___Time_of_Order_; FORMAT("Service Header"."Time of Order", 0, '<Hours24,2> : <Minutes,2>'))
                    {
                        Description = 'PA033336';
                    }
                    column(PhoneText; PhoneTextG)
                    {
                    }
                    column(Make_Name; MakeG.Name)
                    {
                    }
                    column(Service_Header___Order_Limit_; "Service Header"."Order Limit")
                    {
                        Description = 'PA028449';
                    }
                    column(Service_Header___Engine_Code_; "Service Header"."Engine Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___License_No__; "Service Header"."License No.")
                    {
                    }
                    column(Service_Header_Make_Code; "Service Header"."Make Code")
                    {
                    }
                    column(Service_Header__Model; "Service Header".Model)
                    {
                    }
                    column(Service_Header__VIN; "Service Header".VIN)
                    {
                    }
                    column(Service_Header___Labor_Type_; "Service Header"."Labor Type")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___Initial_Registration_; FORMAT("Service Header"."Initial Registration"))
                    {
                        Description = 'PA033336';
                    }
                    column(Service_Header__Mileage; "Service Header".Mileage)
                    {
                    }
                    column(Service_Header___Licence_No_; "Service Header"."License No.")
                    {
                    }
                    column(Service_Header___Engine_No__; "Service Header"."Engine No.")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___Fuel_Level_; "Service Header"."Fuel Level")
                    {
                    }
                    column(Service_Advisor_; ServAdvisorG)
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(Service_Header___Model_Code_; "Service Header"."Model Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___Initial_Reg_; "Service Header"."Initial Registration")
                    {
                    }
                    column(Service_Header___Appt_Serv_Adv_; "Service Header"."Service Advisor No.")
                    {
                    }
                    column(Service_Header___PickupServiceAdv_; "Service Header"."Service Advisor No./Pick-Up")
                    {
                    }
                    column(Service_Header___Appointment_Date_; FORMAT("Service Header"."Order Date") + ' / ' + FORMAT("Service Header"."Time of Order"))
                    {
                    }
                    column(Service_Header___Pickup_Date_; FORMAT("Service Header"."Pickup Date") + ' / ' + FORMAT("Service Header"."Pickup Time"))
                    {
                    }
                    column(Service_Header___Mileage_RunningTime_; FORMAT("Service Header".Mileage) + ' /  ' + FORMAT("Service Header"."Running Time"))
                    {
                    }
                    column(Service_Header___Serv_Adv_No_Pickup_; "Service Header"."Service Advisor No./Pick-Up")
                    {
                    }
                    column(Service_Header___Guide_No__; "Service Header"."Guide No.")
                    {
                        Description = 'PA029090';
                    }
                    column(Service_Contract_No; VehicleCustomerG."Contract No.")
                    {
                    }
                    column(MainNextAppDate_G; FORMAT(MainNextAppDateG))
                    {
                        Description = 'PA040669.61816';
                    }
                    column(EmissionNextAppDate_G; FORMAT(EmissionNextAppDateG))
                    {
                        Description = 'PA040669.61816';
                    }
                    column(CurrencyText; CurrencyTextG)
                    {
                        Description = 'PA028449';
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
                    column(SalesPurch_Name_Control151; SalesPurchG.Name)
                    {
                        Description = 'PA028449';
                    }
                    column(CopyText; CopyTextG)
                    {
                        Description = 'PA028449';
                    }
                    column(TitleText; ReportTitleG)
                    {
                        Description = 'PA033336,PA039225.51457';
                    }
                    column(Service_Header___VAT_Registration_No__; "Service Header"."VAT Registration No.")
                    {
                        Description = 'PA028449';
                    }
                    column(DataItem183; CollectiveG.TextShowOutput("Service Header".FIELDCAPTION("VAT Registration No."), "Service Header"."VAT Registration No." <> ''))
                    {
                        Description = 'PA028449';
                    }
                    column(Collective_TextShowOutput_CompanyInfo_FIELDCAPTION__VAT_Registration_No_____PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), ReportSelectionG."Print Address Block"))
                    {
                        Description = 'PA028449,EU.0000011';
                    }
                    column(Collective_TextShowOutput_CompanyInfo__VAT_Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'PA028449,EU.0000011';
                    }
                    column(Collective_TextShowOutput_C_INC041__PrintAddrBlock_; CollectiveG.TextShowOutput(C_INC_TaxNo, ReportSelectionG."Print Address Block"))
                    {
                        Description = 'PA028449,EU.0000011';
                    }
                    column(Collective_TextShowOutput_CompanyInfo__Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'PA028449,EU.0000011';
                    }
                    column(BarcodeTextG; BarCodeTextG)
                    {
                    }
                    column(OutputNoG; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(HidePrintFooterLineG; RDLHideOutput(ReportSelectionG."Print Footer Line"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(BankText; BankTextG)
                    {
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; ReportLayoutSetupG."One Column Footer")
                    {
                        Description = 'PA040669.61816';
                    }
                    column(HideOneColumnFooter; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61816';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA038229';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA038229';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Right_HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Right".HASVALUE))
                    {
                        Description = 'PA038229';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_HasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Left".HASVALUE))
                    {
                        Description = 'PA038229';
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
                    column(Service_Header___Pickup_Date_Caption; Service_Header___Pickup_Date_CaptionLbl)
                    {
                        Description = 'PA028449';
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                        Description = 'PA028449';
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                        Description = 'PA028449';
                    }
                    column(Service_Header___Order_Limit_Caption; "Service Header".FIELDCAPTION("Order Limit"))
                    {
                        Description = 'PA028449,PA031318,EU.0000011';
                    }
                    column(Service_Header___Engine_Code_Caption; "Service Header".FIELDCAPTION("Engine Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___License_No__Caption; "Service Header".FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MakeCaption; "Service Header".FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Model_DescriptionCaption; "Service Header".FIELDCAPTION(Model))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header__VINCaption; "Service Header".FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Labor_Type_Caption; "Service Header".FIELDCAPTION("Labor Type"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Initial_Registration_Caption; "Service Header".FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MileageCaption; MileageCaptionLbl)
                    {
                    }
                    column(Service_Header___Engine_No__Caption; "Service Header".FIELDCAPTION("Engine No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_AdvisorCaption; Service_AdvisorCaptionLbl)
                    {
                    }
                    column(Sales_AdvisorCaption; Sales_AdvisorCaptionLbl)
                    {
                    }
                    column(Service_Header___Model_Code_Caption; "Service Header".FIELDCAPTION("Model Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(SalesPurch_NameLbl; SalesPurch_NameLbl)
                    {
                        Description = 'PA028449,EU.0000011';
                    }
                    column(Service_Header___No_Caption; ServLineG.FIELDCAPTION("Document No."))
                    {
                        Description = 'PA028449,EU.0000011';
                    }
                    column(Service_Header___Order_Date_Caption; "Service Header".FIELDCAPTION("Order Date"))
                    {
                        Description = 'PA028449,EU.0000011';
                    }
                    column(Guide_No_Caption; "Service Header".FIELDCAPTION("Guide No."))
                    {
                        Description = 'PA029090,EU.0000011';
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(FuelLevelCaption; "Service Header".FIELDCAPTION("Fuel Level"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Emission_Date; Emission_DateLbl)
                    {
                    }
                    column(Inspection_Date; Inspection_DateLbl)
                    {
                    }
                    column(Appt_Service_Advisor; Appt_Service_AdvisorLbl)
                    {
                    }
                    column(Pickup_Service_Advisor; Pickup_Service_AdvisorLbl)
                    {
                    }
                    column(Service_Contract; Service_ContractLbl)
                    {
                    }
                    column(Appointment_Date; Appointment_DateLbl)
                    {
                    }
                    column(Pickup_Date_Time; "Service Header".FIELDCAPTION("Pickup Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Order_Limit_LCY; "Service Header".FIELDCAPTION("Order Limit"))
                    {
                        Description = 'EU.0000011';
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
                    column(PaymentMethodCode_SH; "Service Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SH; "Service Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SH; "Service Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SH; "Service Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SH; "Service Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SH; "Service Header"."Tax Registration No.")
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
                    column(DueDateCpn_SH; "Service Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SH; "Service Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SH; "Service Header".FIELDCAPTION("Variable Symbol"))
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
                    column(DocumentDate_SH; "Service Header"."Document Date")
                    {
                    }
                    column(DueDate_SH; "Service Header"."Due Date")
                    {
                    }
                    column(DriverName_SH; "Service Header"."Driver Name")
                    {
                    }
                    column(YourReferenceCpt_SH; "Service Header".FIELDCAPTION("Your Reference"))
                    {
                    }
                    column(YourReference_SH; "Service Header"."Your Reference")
                    {
                    }
                    column(DriverNameCpn_SH; "Service Header".FIELDCAPTION("Driver Name"))
                    {
                    }
                    column(PickupDateTime_SH; "Service Header"."Pickup DateTime")
                    {
                    }
                    column(PickupDateTimeCpn_SH; "Service Header".FIELDCAPTION("Pickup DateTime"))
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
                    column(VehicleCategoryCode_SH; "Service Header"."Vehicle Category Code")
                    {
                    }
                    column(VehicleCategoryCodeCpn_SH; "Service Header".FIELDCAPTION("Vehicle Category Code"))
                    {
                    }
                    dataitem("Header Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Service Header";
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
                        DataItemLinkReference = "Service Header";
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
                            SETFILTER("Next Appointment Date", '%1..', "Service Header"."Document Date");
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
                        column(Service_Preview_Line__Type; ServPreviewLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line___Line_Type_; ServPreviewLineG."Line Type")
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
                        column(Service_Preview_Line__Attribute; ServPreviewLineG.Attribute)
                        {
                        }
                        column(Service_Preview_Line__Amount; ServPreviewLineG.Amount)
                        {
                        }
                        column(OptSerialNoG; OptSerialNoG)
                        {
                        }
                        column(VehApptDescriptionG_; VehApptDescriptionG)
                        {
                        }
                        column(FORMAT__Service_Preview_Line___Service_Job_No_______; '*' + FORMAT(ServPreviewLineG."Service Job No.") + '*')
                        {
                        }
                        column(FixedPriceLab; FixedPriceLabG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintBarcodeG; PrintBarCodeG)
                        {
                            Description = 'PA033336';
                        }
                        column(ServPreviewLine_TypeG; (ServPreviewLineG.Type + 0))
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(ServPreviewLine_LineTypeG; (ServPreviewLineG."Line Type" + 0))
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(ServCustPrintG; ServCustPrintG)
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line___Package_No__; ServPreviewLineG."Package No.")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(Service_Preview_Line___Description_2_; ServPreviewLineG."Description 2")
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(ServCustomer__Print_Fixed_Unit_Price_; ServCustG."Print Fixed Unit Price")
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line__Description; CollectiveG.TextShowOutput(ServPreviewLineG.Description, ServPreviewLineG."Job Details Text Block" + ServPreviewLineG."Internal Comments Text Block" = 0))
                        {
                            Description = 'EU.0000011';
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
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Service_Preview_Line___No__; ServPreviewLineG."No.")
                        {
                        }
                        column(Service_Preview_Line___Line_Discount____Control85; ServPreviewLineG."Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(SumLabor; SumLaborG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PackageOutput; ConsolidatePositionsOfAPackageG)
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(JobOutput; ConsolidatePositionsOfAJobG)
                        {
                            Description = 'PA033336,EU.0000011';
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
                        column(C_INC033; C_INC033)
                        {
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(No_Caption; ServPreviewLineG.FIELDCAPTION("No."))
                        {
                            Description = 'EU.0000011';
                        }
                        column(DescriptionCaption; ServPreviewLineG.FIELDCAPTION(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
                        {
                        }
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; ServPreviewLineG.FIELDCAPTION("Unit Price"))
                        {
                            Description = 'EU.0000011';
                        }
                        column(AmountCaption; ServPreviewLineG.FIELDCAPTION(Amount))
                        {
                            Description = 'EU.0000011';
                        }
                        column(TotalNet___SumFairDealPerSectionCaption; ContinuedCaptionLbl)
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
                        column(ServCustPrintFixedPriceG; ServCustPrintFixedPriceG)
                        {
                        }
                        column(PrintFixedPriceG; PrintFixedPriceG)
                        {
                        }
                        column(HidePrintJobHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) AND (ServPreviewLineG."Service Job No." <> 0)))
                        {
                        }
                        column(HidePrintPackageHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) AND (ServPreviewLineG."Package No." <> '')))
                        {
                        }
                        column(HidePrintSubtotal; RDLHideOutput(EvalHidePrintSubtotal()))
                        {
                        }
                        column(RepeatRepair_Format; RepeatRepairFormatG)
                        {
                            Description = 'EU.0000485';
                        }
                        column(RepeatRepairCaption; RepeatRepairLbl)
                        {
                            Description = 'EU.0000485';
                        }
                        column(VATpercent_SL; ServPreviewLineG."VAT %")
                        {
                        }
                        column(VATpercentCpn_SL; ServPreviewLineG.FIELDCAPTION("VAT %"))
                        {
                        }
                        column(Unit_PriceLbl; UnitPriceLbl)
                        {
                        }
                        column(No_Cpn; NoLbl)
                        {
                            Description = 'PA032651';
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
                            ServLineL: Record "Service Line";
                            ServJobLineL: Record "Service Job Line";
                            TaxAmountL: Decimal;
                            TaxRateL: Decimal;
                        begin
                            IF Number = 1 THEN
                                TempServPreviewLineG.FINDFIRST
                            ELSE
                                TempServPreviewLineG.NEXT;
                            // Start EU.0000011
                            ServPreviewLineG := TempServPreviewLineG;
                            TextBlockContentG := '';
                            // Stop EU.0000011
                            // Start PA025769
                            IF PrintServOptionG THEN
                                GetServOptionNo;
                            // Stop PA025769

                            // Start EU.0000485
                            RepeatRepairFormatG := '';
                            IF (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) AND
                               (ServPreviewLineG."Service Job No." <> 0)
                            THEN BEGIN
                                IF ServJobLineL.GET(
                                  ServPreviewLineG."Document Type",
                                  ServPreviewLineG."Document No.",
                                  ServPreviewLineG."Service Job No.")
                                THEN
                                    IF ServJobLineL."Repeat Repair" THEN
                                        RepeatRepairFormatG := FORMAT(ServJobLineL."Repeat Repair")
                            END;
                            // Stop EU.0000485

                            // Start PA022363
                            IF ServPreviewLineG.Type <> ServPreviewLineG.Type::" " THEN BEGIN
                                // Start EU.0000011
                                // Stop EU.0000011
                                FixedPriceLabG := FALSE;
                                // Start PA042076
                                PrintFixedPriceG := FALSE;
                                // Stop PA042076
                                CLEAR(ServLineL);
                                CLEAR(ServCustG);
                                NoPropertyG := '';
                                IF NOT ServLineL.GET(
                                   ServPreviewLineG."Document Type",
                                   ServPreviewLineG."Document No.",
                                   ServPreviewLineG."Document Line No.")
                                THEN BEGIN
                                    // Start EU.0000011
                                    IF ServJobLineL.GET(
                                       ServPreviewLineG."Document Type",
                                       ServPreviewLineG."Document No.",
                                       ServPreviewLineG."Service Job No.")
                                    THEN
                                        IF ServJobLineL."Includes Fixed Price" THEN
                                            PrintFixedPriceG := TRUE;
                                    IF ServCustG.GET(ServJobLineL."Document Type", ServJobLineL."Document No.", ServPreviewLineG."Bill-to Customer No.") THEN
                                        ;
                                    // Stop EU.0000011
                                    ServPreviewLineG."No." := '';
                                END ELSE BEGIN
                                    // Stop PA041187.87564
                                    IF ServCustG.GET("Service Header"."Document Type", "Service Header"."No.", ServLineL."Bill-to Customer No.") THEN
                                        ;
                                    IF (ServLineL.Type = ServLineL.Type::Labor) AND (ServLineL."Fixed Price" <> 0) THEN
                                        FixedPriceLabG := TRUE;
                                    // Start PA042076
                                    IF ServJobLineL.GET(
                                       ServLineL."Document Type",
                                       ServLineL."Document No.",
                                       ServLineL."Service Job No.")
                                    THEN
                                        // Start EU.0000011
                                        IF ServJobLineL."Includes Fixed Price" THEN
                                            PrintFixedPriceG := TRUE;
                                    SetAttribute(ServLineL, ServPreviewLineG, NoPropertyG);
                                    // Stop EU.0000011
                                    // Start PA022298
                                    IF ProportinatelyChargingLineG THEN BEGIN
                                        ServPreviewLineG."Unit Price" := 0;
                                        ServPreviewLineG."Line Discount %" := 0;
                                    END;
                                    // Stop PA022298

                                    // Start EU.0000011
                                    // Stop EU.0000011
                                END;
                                // Start EU.0000011
                                // Stop EU.0000011
                            END;


                            ServCustPrintG := ServCustG."Print Fixed Unit Price";

                            // Start EU.0000011

                            IF ((ServPreviewLineG."Line Discount Amount" < 0) OR PrintWithoutDiscG) AND
                               NOT ProportinatelyChargingLineG AND (ServPreviewLineG.Quantity <> 0)
                            THEN BEGIN
                                ServPreviewLineG."Unit Price" := ServPreviewLineG.Amount / ServPreviewLineG.Quantity;
                                ServPreviewLineG."Line Discount %" := 0;
                            END;

                            // Stop EU.0000011
                            // Stop PA035597
                            // Start PA042076
                            ServCustPrintFixedPriceG := ServCustG."Print Service Job Fixed Price";
                            // Stop PA042076

                            // Start PA034051
                            VehApptDescriptionG := '';
                            IF ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job THEN
                                IF ServJobLineL.GET(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Service Job No.") THEN
                                    IF (ServJobLineL."Veh. Appointment Code" <> '') AND
                                       (ServJobLineL."Veh. Appointment Status" <> ServJobLineL."Veh. Appointment Status"::New)
                                    THEN
                                        VehApptDescriptionG := ServManagementG.CreateApptDescription(ServJobLineL);
                            // Start EU.0000011
                            TextBlockG.INIT;
                            IF ServPreviewLineG.Type = ServPreviewLineG.Type::" " THEN BEGIN
                                IF ServPreviewLineG."Job Details Text Block" > 0 THEN BEGIN
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
                                IF ServPreviewLineG."Internal Comments Text Block" > 0 THEN BEGIN
                                    IF NOT ReportSelectionG."Print Job Detailed Descript." THEN
                                        CurrReport.SKIP;
                                    IF NOT TextBlockG.GET(ServPreviewLineG."Internal Comments Text Block") THEN
                                        CurrReport.SKIP;
                                    TextBlockContentG := TextBlockG.GetTextBlock();
                                    ServPreviewLineG.Description := '';
                                    ServPreviewLineG."Description 2" := '          '; // Add a Blank line in the end
                                    ServPreviewLineG."Service Job No." := 0;
                                END;
                            END;
                            // Stop EU.0000011
                            // Stop PA034051
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start EU.0000011
                            MakeServPreviewG.ActivateWithInternalCommentsTextBlock();
                            IF PrintFairDealRateG AND PrintPricesG THEN
                                MakeServPreviewG.ActivateFairDealCalculation(WarrCustG, TRUE);
                            MakeServPreviewG.ShowJob("Service Header", TempServPreviewLineG, MakeServPreviewG.CalcBaseOrderConfirmation(), TRUE);
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
                                TempServPreviewLineG.ConsolidatePackages("Service Header"."Document Type", "Service Header"."No.", TempServPreviewLineBOMG, FALSE, BOMOutputG, PrintPricesG);

                            TempServPreviewLineG.SETRANGE("Suppress in Order", FALSE);
                            // Stop EU.0000011

                            // Start PA022298
                            IF PrintOnlyOwnPartG THEN BEGIN
                                SetCustomerAmounts();
                            END;
                            // Stop PA022298

                            CLEAR(MakeServPreviewG);

                            // Start EU.0000011
                            // Stop EU.0000011

                            // Start PA025769
                            SetOptionLines;
                            // Stop PA025769

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
                        column(PrintServOptionG; PrintServOptionG)
                        {
                            Description = 'PA033336';
                        }
                        column(TempServLineG_Amount; TempServLineG.Amount)
                        {
                        }
                        column(TempServLineG_Description_; TempServLineG.Description)
                        {
                        }
                        column(TempServLineG__No__; TempServLineG."No.")
                        {
                        }
                        column(OptSerialNoG_Control1109400021; OptSerialNoG)
                        {
                        }
                        column(Created_Own_OptionsCaption; Created_Own_OptionsCaptionLbl)
                        {
                        }
                        column(DescriptionCaption_Control1109400011; ServPreviewLineG.FIELDCAPTION(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(Option_CodeCaption; "Service Header".FIELDCAPTION("Option Code"))
                        {
                            Description = 'EU.0000011';
                        }
                        column(No_Caption_Control1109400013; ServPreviewLineG.FIELDCAPTION("No."))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PriceCaption; PriceCaptionLbl)
                        {
                        }
                        column(ServiceOption_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA025769
                            IF Number = 1 THEN
                                TempServLineG.FINDFIRST
                            ELSE
                                TempServLineG.NEXT;
                            OptSerialNoG := C_INC045 + FORMAT(TempServLineG."Line No.");
                            SerOptionG := TRUE;
                            // Stop PA025769
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA025769
                            TempServLineG.RESET;
                            ServiceOption.SETRANGE(Number, 1, TempServLineG.COUNT);
                            // Stop PA025769
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
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
                        column(C_INC033_Control173; C_INC033)
                        {
                        }
                        column(VATIdentifier; VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA033336';
                        }
                        column(VATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATText; VATTextG)
                        {
                        }
                        column(VATAmountCOUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(FairDealRate; PrintFairDealRateG)
                        {
                            Description = 'PA033336';
                        }
                        column(SumExchTax; SumExchTaxG)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumExchAmount; SumExchAmountG)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(TotalGross; TotalGrossG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
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
                            // Start PA035597
                            IF PrintPricesG THEN
                                VATTextG := STRSUBSTNO('%1%2', VATAmountLineG."VAT %", C_INC001);
                            IF (SumExchTaxG <> 0) AND PrintPricesG THEN
                                VATTextG := STRSUBSTNO('%1%2', ExchRateG, C_INC022);
                            // Stop PA035597
                            // Start EU.0000011
                            // Stop EU.0000011
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA040837.66154
                            IF VATAmountLineG.COUNT < 1 THEN
                                // Stop PA040837.66154
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                            // Start EU.0000011
                            // Stop EU.0000011
                        end;
                    }
                    dataitem("Footer Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Service Header";
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
                    dataitem("ServiceFooter Text"; "Service Footer Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Order));
                        column(ServLine_Type; ServLineG.Type)
                        {
                            OptionCaption = ' ,G/L Account,Item,Labor,Ext. Service';
                            OptionMembers = " ","G/L Account",Item,Labor,"Ext. Service";
                        }
                        column(ServLine__No__; ServLineG."No.")
                        {
                        }
                        column(ServLine_Description; ServLineG.Description)
                        {
                        }
                        column(TempFooterText__Document_Line_No__; FooterTextTempG."Document Line No.")
                        {
                            Description = 'PA033336';
                        }
                        column(PrintServiceFooterG; PrintServFooterG)
                        {
                            Description = 'PA033336';
                        }
                        column(ServiceFooter_Text_Text; Text)
                        {
                        }
                        column(Additional_Service_Information_Caption; Additional_Service_Information_CaptionLbl)
                        {
                        }
                        column(ServiceFooter_Text_Document_Type; "Document Type")
                        {
                        }
                        column(ServiceFooter_Text_Document_No_; "Document No.")
                        {
                        }
                        column(ServiceFooter_Text_Document_Line_No_; "Document Line No.")
                        {
                        }
                        column(ServiceFooter_Text_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA035597
                            IF (ServLineG.GET("Service Header"."Document Type", "Service Header"."No.", "ServiceFooter Text"."Document Line No.") AND
                               ("ServiceFooter Text"."Document Line No." <> FooterTextTempG."Document Line No."))
                            THEN
                                PrintServFooterG := TRUE
                            ELSE
                                PrintServFooterG := FALSE;
                            FooterTextTempG := "ServiceFooter Text";
                            // Stop PA035597
                        end;
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
                        column(FairDealDa; FairDealDaG)
                        {
                            Description = 'PA033336';
                        }
                        column(ExchangeDa; ExchangeDaG)
                        {
                            Description = 'PA033336';
                        }
                        column(SerOptionG; SerOptionG)
                        {
                            Description = 'PA033336';
                        }
                        column(ProportinatelyChargingG; ProportinatelyChargingG)
                        {
                            Description = 'PA033336';
                        }
                        column(ReturnDa; ReturnDaG)
                        {
                            Description = 'PA033336';
                        }
                        column(WtyDate; WtyDateG)
                        {
                            Description = 'PA033336';
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
                            // Start PA035597
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
                            // Start EU.0000485
                            IF LegendTextG = '' THEN
                                LegendTextG := RepeatRepairLbl + C_INC_RepeatRepairLegend
                            ELSE
                                LegendTextG := LegendTextG + ',  ' + RepeatRepairLbl + C_INC_RepeatRepairLegend;
                            // Stop EU.0000485
                            IF SerOptionG AND PrintPricesG THEN
                                FooterTextG := C_INC044
                            ELSE
                                FooterTextG := '';
                            // Stop PA035597
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // Start PA035597
                        BarCodeTextG := '';
                        IF PrintBarCodeG THEN BEGIN
                            //Start API.1.0.2
                            //BarCodeTextG := 'ö' + "Service Header"."No." + 'ö';
                            BarCodeTextG := '*' + "Service Header"."No." + '*';
                            //Stop API.1.0.2
                        END;
                        IF (VehicleAppointmentsTextG > '') THEN
                            VehicleAppointmentsPrintedG := TRUE;
                        // Stop PA035597
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    CLEAR(ServLine2G);
                    CLEAR(CalcServAmtsG);
                    CalcServAmtsG.GetServLines("Service Header", ServLine2G, 0);

                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    END;
                    // Start PA035597
                    // Stop PA035597
                    OldServJobNoG := 0;
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
                    // Start PA021922
                    CLEAR(FooterTextTempG);
                    // Stop PA021922

                    // Start PA022298
                    ProportinatelyChargingG := FALSE;
                    // Stop PA022298
                end;

                trigger OnPostDataItem()
                begin
                    //Start PA023215
                    //Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        ServPrintCounterG.RUN("Service Header");
                    //Stop PA032727
                    //Stop PA023215
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA043099
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    // Stop PA043099
                    // Start PA035597
                    OutputNoG := 1;
                    // Stop PA035597

                    CopyTextG := '';
                    SETRANGE(Number, 1, NoOfLoopsG);
                end;
            }

            trigger OnAfterGetRecord()
            var
                InteractionLogL: Record "Interaction Log Entry";
                ServJobLineL: Record "Service Job Line";
                ServLineL: Record "Service Line";
                bankAccountL: Record "Bank Account";
                T91Fnc: Codeunit "ET91,98,290,382,383,1226";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA033336
                // Start EU.0000011
                IF ReportSelectionG."Print Footer Line" THEN
                    // Stop EU.0000011
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Make Code", "Location Code");
                // Stop PA033336

                //Start API.1      01.03.18 PV
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Make Code", "Location Code",
                  REPORT::"DPG Service - Service Order CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Make Code", "Location Code");

                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Service Header"."Language Code");
                SetTitles;
                //EmployeeFullNameG := GetUserIDFullName(USERID); //API.1.0.4
                EmployeeFullNameG := T91Fnc.T91_GetUserIDFullName(USERID); //API.1.0.4

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;
                "Service Header".CALCFIELDS("Driver Name");
                //Stop API.1      01.03.18 PV

                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.")
                ELSE
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();
                TitleTextG := C_INC034;

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

                //Start API.1.0.2  07.06.18 PV
                //  Correct company bank info is filled when OnValidate of T36."Bank Account Code" is run.
                //  Then it is passed to posted tables, ... Ie. this info should be shown in reports.
                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccountL.RESET;
                IF bankAccountL.GET("Service Header"."Bank Account Code") THEN BEGIN
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
                //Stop API.1.0.2  07.06.18 PV

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
                VehicleFormatAddrG.ServHeaderSellTo(CustAddrG, "Service Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Service Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // Stop API.1      01.03.18 PV

                PhoneTextG := '';
                IF ("Sell-to Home Phone No." <> '') OR
                   ("Sell-to Home Mobile Phone No." <> '') OR
                   ("Sell-to Phone No." <> '') OR
                   ("Sell-to Mobile Phone No." <> '')
                THEN BEGIN
                    PhoneTextG := C_INC010;
                    IF "Sell-to Home Phone No." <> '' THEN
                        PhoneTextG := PhoneTextG + ' ' + C_INC011 + ' ' + "Sell-to Home Phone No.";
                    IF "Sell-to Home Mobile Phone No." <> '' THEN BEGIN
                        IF "Sell-to Home Phone No." <> '' THEN
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
                    IF "Sell-to Mobile Phone No." <> '' THEN BEGIN
                        IF "Sell-to Phone No." <> '' THEN
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC014
                        ELSE
                            PhoneTextG := PhoneTextG + '  ' + C_INC014;
                        PhoneTextG := PhoneTextG + ' ' + "Sell-to Mobile Phone No.";
                    END;
                END;

                PrintWithoutDiscG := NOT "Service Header"."Show Discount";

                // Start PA038228
                CLEAR(MainNextAppDateG);
                CLEAR(EmissionNextAppDateG);
                MainNextAppDateG := GetNextApptDate(1, "Service Header"."Document Date");
                EmissionNextAppDateG := GetNextApptDate(2, "Service Header"."Document Date");

                CLEAR(VehicleCustomerG);
                VehicleCustomerG.SETRANGE(VIN, "Service Header".VIN);
                VehicleCustomerG.SETRANGE(Type, VehicleCustomerG.Type::"Service Contract");
                VehicleCustomerG.SETFILTER("Beginning of Contract", '<=%1', "Service Header"."Order Date");
                VehicleCustomerG.SETFILTER("Expiration of Contract", '>=%1', "Service Header"."Order Date");
                IF VehicleCustomerG.FINDFIRST THEN
                    ;
                // Stop PA038228
                // Start PA040669.61816
                IF "Service Header"."Sell-to Customer No." <> "Service Header"."Bill-to Customer No." THEN BEGIN
                    FormatServAddrG.ServHeaderBillTo(OrderCustAddrG, "Service Header");
                    //OrderCustAddrLineG := C_INC008 + FormatServAddrG.GetWindowAddress(C_INC005);   //API.1.0.1  09.05.18 PV
                    OrderCustAddrLineG := FormatServAddrG.GetWindowAddress(C_INC005);  //API.1.0.1  09.05.18 PV
                END ELSE
                    OrderCustAddrLineG := '';
                // Stop PA040669.61816

                // Start PA041187.92447
                PrintTotalG := TRUE;
                // Stop PA041187.92447
                // Start PA041187.91511
                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscTextG := '';
                    ServJobLineL.RESET;
                    ServJobLineL.SETRANGE("Document Type", "Service Header"."Document Type");
                    ServJobLineL.SETRANGE("Document No.", "Service Header"."No.");
                    ServJobLineL.SETRANGE("Includes Fixed Price", TRUE);
                    IF ServJobLineL.FINDSET THEN
                        REPEAT
                            IF ServCustG.GET(
                               ServJobLineL."Document Type",
                               ServJobLineL."Document No.",
                               ServJobLineL."Bill-to Customer No.")
                            THEN
                                IF ServCustG."Print Service Job Fixed Price" = ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit" THEN
                                    DiscTextG := C_INC015;
                            // Start PA041187.92447
                            IF PrintTotalG THEN BEGIN
                                ServLineL.RESET;
                                ServLineL.SETCURRENTKEY("Document Type", "Document No.", "Service Job No.");
                                ServLineL.SETRANGE("Document Type", ServJobLineL."Document Type");
                                ServLineL.SETRANGE("Document No.", ServJobLineL."Document No.");
                                ServLineL.SETRANGE("Service Job No.", ServJobLineL."Line No.");
                                IF ServLineL.ISEMPTY THEN
                                    PrintTotalG := FALSE;
                            END;
                        // Stop PA041187.92447
                        UNTIL ServJobLineL.NEXT = 0;
                    IF DiscTextG = '' THEN BEGIN
                        ServJobLineL.SETRANGE("Includes Fixed Price", FALSE);
                        IF ServJobLineL.FINDSET THEN
                            REPEAT
                                ServLineL.RESET;
                                ServLineL.SETRANGE("Document Type", ServJobLineL."Document Type");
                                ServLineL.SETRANGE("Document No.", ServJobLineL."Document No.");
                                ServLineL.SETRANGE("Service Job No.", ServJobLineL."Line No.");
                                ServLineL.SETFILTER("Line Discount %", '>%1', 0);
                                IF NOT ServLineL.ISEMPTY THEN
                                    DiscTextG := C_INC015
                            UNTIL (ServJobLineL.NEXT = 0) OR (DiscTextG <> '');
                    END;
                    IF DiscTextG = '' THEN BEGIN
                        ServLineL.RESET;
                        ServLineL.SETRANGE("Document Type", "Service Header"."Document Type");
                        ServLineL.SETRANGE("Document No.", "Service Header"."No.");
                        ServLineL.SETRANGE("Service Job No.", 0);
                        ServLineL.SETFILTER("Line Discount %", '>%1', 0);
                        IF NOT ServLineL.ISEMPTY THEN
                            DiscTextG := C_INC015
                    END;
                END;
                // Stop PA041187.91511

                WarrCustG := '';
                IF "Make Code" <> '' THEN BEGIN
                    MakeG.GET("Make Code");
                    WarrCustG := MakeG."Factory Warranty Customer";
                END ELSE
                    MakeG.INIT;

                IF "Service Advisor No." <> '' THEN BEGIN
                    EmployeeG.GET("Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                END ELSE
                    ServAdvisorG := '';

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                WtyDateG := FALSE;
                FairDealDaG := FALSE;
                ReturnDaG := FALSE;
                ExchangeDaG := FALSE;
                // Start PA041187.87564
                CALCFIELDS("Includes Fixed Price");
                // Stop PA041187.87564
                // Start PA031318
                VehicleAppointmentsTextG := VehAppointmG.GetVehicleAppoitnmentTexts(VIN, TRUE);
                // Stop PA031318
                // Start PA024130
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(50) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::SrvOrd,
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
                // Stop PA024130
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                ServSetupG.GET();
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
                    field("No. of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                        Description = 'EU.0000011';
                    }
                    field("Print Prices"; PrintPricesG)
                    {
                        Caption = 'Print Prices';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start PA033336
                            IF PrintPricesG = FALSE THEN BEGIN
                                PrintFairDealRateG := FALSE;
                                PrintOnlyOwnPartG := FALSE;
                            END;
                            // Stop PA033336
                        end;
                    }
                    field("Print only Own Part"; PrintOnlyOwnPartG)
                    {
                        Caption = 'Print only Own Part';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start PA033336
                            IF PrintOnlyOwnPartG THEN
                                PrintPricesG := TRUE;
                            // Stop PA033336
                        end;
                    }
                    field("Print Fair Deal Rate"; PrintFairDealRateG)
                    {
                        Caption = 'Print Fair Deal Rate';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start PA033336
                            IF PrintFairDealRateG THEN
                                PrintPricesG := TRUE;
                            // Stop PA033336
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
                    field("Print Barcode"; PrintBarCodeG)
                    {
                        Caption = 'Print Barcode';
                        Description = 'EU.0000011';
                    }
                    field("Print Next Vehicle Appointments"; PrintNextVehicleAppointmentsG)
                    {
                        Caption = 'Print Next Vehicle Appointments';
                        Description = 'PA035399.19604,EU.0000011';
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
                            // Start PA033336
                            // Start EU.0000011;
                            IF ConsolidatePositionsOfAPackageG THEN
                                ConsolidatePositionsOfAJobG := FALSE
                            ELSE
                                // Stop EU.0000011;
                                BOMOutputG := FALSE;
                            // Stop PA033336
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

    trigger OnPreReport()
    begin
        // Start PA032031
        // Start PA032861.6269811
        IF PrintBarCodeG THEN
            // Stop PA032861.6269811
            PrintJobBarCodeG := TRUE;
        // Stop PA032031
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        ServSetupG: Record "Service Setup";
        ReportLayoutSetupG: Record "Report Layout Setup";
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
        FooterTextTempG: Record "Service Footer Text";
        SalesPurchG: Record "Salesperson/Purchaser";
        ServPreviewLineG: Record "Service Preview Line";
        ServCustG: Record "Service Customer";
        ServLineG: Record "Service Line";
        ServLine2G: Record "Service Line" temporary;
        ServLineCustG: Record "Service Line Customer";
        PaymentTermsG: Record "Payment Terms";
        VehAppointmG: Record "Vehicle Appointment";
        TempServLineG: Record "Service Line" temporary;
        VehicleCustomerG: Record "Vehicle Customer";
        TextBlockG: Record "Text Block";
        FormatAddrG: Codeunit "Format Address";
        VehicleFormatAddrG: Codeunit "Veh Format Address";
        CalcServAmtsG: Codeunit "Calculate Serv. Amounts";
        ServPrintCounterG: Codeunit "Serv. Printed";
        MakeServPreviewG: Codeunit "Make Serv. Preview";
        SegMgntG: Codeunit SegManagement;
        CollectiveG: Codeunit "Collection Unit";
        ServManagementG: Codeunit "Service Management";
        UserSessionG: Codeunit "User Session Unit";
        FormatServAddrG: Codeunit "Veh Format Address";
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
        PhoneTextG: Text[250];
        TotalInclVATTextG: Text[50];
        TotalTextG: Text[50];
        CurrencyTextG: Text[10];
        TitleTextG: Text[50];
        LegendTextG: Text[250];
        VehicleAppointmentsTextG: Text[1024];
        [InDataSet]
        VehApptDescriptionG: Text[50];
        OptSerialNoG: Text[30];
        FooterTextG: Text[150];
        ReportTitleG: Text[100];
        OrderCustAddrLineG: Text;
        OrderCustAddrG: array[8] of Text;
        RepeatRepairFormatG: Text;
        WarrCustG: Code[20];
        IntCustG: Code[20];
        BarCodeTextG: Code[30];
        PkgNoG: Code[20];
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        ExTypeG: Integer;
        OldServJobNoG: Integer;
        NextEntryNoG: Integer;
        DocLineNumberG: Integer;
        OutputNoG: Integer;
        [InDataSet]
        ServCustPrintG: Integer;
        [InDataSet]
        ServCustPrintFixedPriceG: Integer;
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
        SumOtherG: Decimal;
        C_INC001: Label '% VAT of';
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        FixedPriceLabG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC010: Label 'Phone:';
        C_INC011: Label 'Private';
        C_INC012: Label 'Mobile';
        C_INC013: Label 'Bus.';
        C_INC014: Label 'Mobile';
        C_INC015: Label 'Disc. %';
        MoreLinesG: Boolean;
        PrintWithoutDiscG: Boolean;
        C_INC016: Label '*';
        C_INC017: Label 'Package BOMs can only be output for consolidated packages !';
        C_INC022: Label '% Exch. Tax from';
        [InDataSet]
        PrintPricesG: Boolean;
        PrintFairDealRateG: Boolean;
        C_INC023: Label '% VAT of';
        C_INC029: Label 'Copy of';
        C_INC030: Label 'Total %1';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Fair deal amount %1';
        C_INC033: Label 'k';
        C_INC034: Label 'Service Order';
        ReturnDaG: Boolean;
        WtyDateG: Boolean;
        FairDealDaG: Boolean;
        ExchangeDaG: Boolean;
        C_INC035: Label 'W';
        C_INC036: Label 'R';
        C_INC037: Label 'W = Warranty Position';
        C_INC038: Label 'F = Fair Deal Position';
        C_INC039: Label 'R =Return-mandatory part';
        C_INC040: Label '* = Exchange Part';
        ConsolidatePositionsOfAJobG: Boolean;
        ConsolidatePositionsOfAPackageG: Boolean;
        ConsolidateLaborPosG: Boolean;
        C_INC_TaxNo: Label 'Tax No.';
        BOMOutputG: Boolean;
        ConsolidateNegativePosG: Boolean;
        PrintServOptionG: Boolean;
        ProportinatelyChargingG: Boolean;
        ProportinatelyChargingLineG: Boolean;
        C_INC042: Label 'P = Proportionately Charged';
        PrintOnlyOwnPartG: Boolean;
        SerOptionG: Boolean;
        LogInteractionG: Boolean;
        C_INC043: Label 'X = Serial No. of Service Options. ';
        C_INC044: Label 'Total Of Options price can vary from manual calculation because of rounding';
        C_INC045: Label 'O';
        PrintBarCodeG: Boolean;
        PrintJobBarCodeG: Boolean;
        VehicleAppointmentsPrintedG: Boolean;
        [InDataSet]
        PrintServFooterG: Boolean;
        [InDataSet]
        PrintFixedPriceG: Boolean;
        PrintTotalG: Boolean;
        PrintNextVehicleAppointmentsG: Boolean;
        Service_Header___Pickup_Date_CaptionLbl: Label 'Pickup Appt.';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        MileageCaptionLbl: Label 'Mileage / Running Time';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_NameLbl: Label 'Salesperson';
        Payments_to_CaptionLbl: Label 'Payments to:';
        Next_Vehicle_Appointments__CaptionLbl: Label 'Next Vehicle Appointments:';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        TotalNet___SumFairDealPerSection_Control125CaptionLbl: Label 'Sum carried forward';
        SumLaborCaptionLbl: Label 'Sum Labor';
        SumItemCaptionLbl: Label 'Sum Item';
        SumExtServCaptionLbl: Label 'Sum External Services';
        SumOtherCaptionLbl: Label 'Sum Other';
        Created_Own_OptionsCaptionLbl: Label 'Created Own Options';
        PriceCaptionLbl: Label 'Price';
        ContinuedCaptionLbl: Label 'Continued';
        Additional_Service_Information_CaptionLbl: Label 'Additional Service Information:';
        ExplanationsCaptionLbl: Label 'Explanations';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        Inspection_DateLbl: Label 'Inspection Date';
        Emission_DateLbl: Label 'Emission Date';
        Appt_Service_AdvisorLbl: Label 'Appt. Service Advisor';
        Pickup_Service_AdvisorLbl: Label 'Pickup Service Advisor';
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        RepeatRepairLbl: Label 'R. R.';
        C_INC_RepeatRepairLegend: Label ' = Repeat Repair';
        _incadeaVars: Integer;
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
        ShowTaxNoG: Boolean;
        VendorLbl: Label 'Vendor';
        UnitPriceLbl: Label 'Unit Price';
        NoLbl: Label 'No.';

    [Scope('Internal')]
    procedure SetAttribute(ServLineP: Record "Service Line"; var CurServPreviewLineP: Record "Service Preview Line"; var LinePropertyL: Text[10])
    var
        ItemL: Record Item;
    begin
        // SetAttribute

        // Check Exchange Part flag and set it, if required
        // Flag for exchange part = *
        IF ServLineP."VAT Calculation Type" = ServLineP."VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
            IF STRPOS(LinePropertyL, C_INC016) = 0 THEN
                LinePropertyL := LinePropertyL + C_INC016;
            ExchangeDaG := TRUE;
        END;

        // Check fair deal position and load fair deal flag
        // Start EU.0000011
        // Stop EU.0000011
        // Only set the warranty flag if the rate is no fair deal position and the warranty customer
        IF CurServPreviewLineP."Fair Deal" THEN BEGIN
            IF STRPOS(LinePropertyL, C_INC033) = 0 THEN
                LinePropertyL := LinePropertyL + C_INC033;
            FairDealDaG := TRUE;
        END;

        // contains a complete invoice for this line
        // Check if the items are return-mandatory
        // Flag for return part = R
        // Start EU.0000011
        IF NOT CurServPreviewLineP."Fair Deal" THEN BEGIN
            // Stop EU.0000011
            ServLineP.CALCFIELDS("No. of Bill-to Customers");
            IF (ServLineP."Bill-to Customer No." = WarrCustG) AND (ServLineP."No. of Bill-to Customers" = 1) THEN BEGIN
                WtyDateG := TRUE;
                IF STRPOS(LinePropertyL, C_INC035) = 0 THEN
                    LinePropertyL := LinePropertyL + C_INC035;
            END;
        END;

        // Check if the items are return-mandatory
        // Flag for return part = R
        IF ServLineP.Type = ServLineP.Type::Item THEN BEGIN
            // Start PA041366
            IF ServLineP."Sending Required" IN [ServLineP."Sending Required"::Keep, ServLineP."Sending Required"::Send] THEN BEGIN
                // Stop PA041366
                IF STRPOS(LinePropertyL, C_INC036) = 0 THEN
                    LinePropertyL := LinePropertyL + C_INC036;
                ReturnDaG := TRUE;
            END;
        END;

        // Start PA022298
        ProportinatelyChargingLineG := FALSE;
        IF PrintPricesG THEN BEGIN
            ServLineCustG.RESET;
            ServLineCustG.SETRANGE("Document Type", "Service Header"."Document Type");
            ServLineCustG.SETRANGE("Document No.", "Service Header"."No.");
            ServLineCustG.SETRANGE("Document Line No.", ServLineP."Line No.");
            ServLineCustG.SETRANGE("Bill-to Customer No.", ServLineP."Bill-to Customer No.");
            IF ServLineCustG.FINDFIRST THEN BEGIN
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
        // Stop PA022298
    end;

    [Scope('Internal')]
    procedure SetCustomerAmounts()
    var
        TempServPreviewLineL: Record "Service Preview Line" temporary;
        FromPreviewLineL: Integer;
        ToPreviewLineL: Integer;
    begin
        // SetCustomerAmounts

        // Start PA022298
        TempServPreviewLineL.DELETEALL();
        // Start EU.0000011
        VATAmountLineG.RESET;
        VATAmountLineG.DELETEALL;
        MakeServPreviewG.ShowCustomer("Service Header", TempServPreviewLineL, MakeServPreviewG.CalcBaseOrderConfirmation(), TRUE);
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
        TempServPreviewLineL.SETRANGE("Bill-to Customer No.", "Service Header"."Bill-to Customer No.");
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
        // Stop PA022298
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
        ServLineL: Record "Service Line";
        ServJobL: Record "Service Job Line";
        ItemL: Record Item;
        OptionLineNoL: Integer;
    begin
        // Start PA025769
        TempServLineG.DELETEALL;
        IF NOT PrintServOptionG THEN
            EXIT;
        // Start EU.0000011
        OptionLineNoL := 0;
        // Stop EU.0000011
        ServLineL.RESET;
        ServLineL.SETRANGE("Document Type", "Service Header"."Document Type");
        ServLineL.SETRANGE("Document No.", "Service Header"."No.");
        ServLineL.SETRANGE(ServLineL."Value Increasing Measure", TRUE);
        IF ServLineL.FINDSET THEN
            REPEAT
                TempServLineG.RESET;
                TempServLineG.SETRANGE("Document Type", ServLineL."Document Type");
                TempServLineG.SETRANGE("Document No.", ServLineL."Document No.");
                // Start EU.0000011
                TempServLineG.SETRANGE("Service Job No.", ServLineL."Service Job No.");
                // Stop EU.0000011
                TempServLineG.SETRANGE("No.", ServLineL."Option Code");
                IF NOT TempServLineG.FINDFIRST THEN BEGIN
                    TempServLineG.TRANSFERFIELDS(ServLineL);
                    IF NOT PrintPricesG THEN
                        TempServLineG.Amount := 0;
                    TempServLineG."No." := ServLineL."Option Code";
                    IF ServLineL."Service Job No." <> 0 THEN BEGIN
                        ServJobL.GET(ServLineL."Document Type", ServLineL."Document No.", ServLineL."Service Job No.");
                        IF ServJobL.Instruction <> '' THEN BEGIN
                            TempServLineG.Description := ServJobL.Instruction;
                            TempServLineG."Description 2" := ServJobL.Complaint;
                        END ELSE
                            TempServLineG.Description := ServJobL.Complaint;
                    END ELSE BEGIN
                        ItemL.GET(ServLineL."Option Code");
                        TempServLineG.Description := ItemL.Description;
                    END;
                    // Start EU.0000011
                    OptionLineNoL := OptionLineNoL + 1;
                    TempServLineG."Line No." := OptionLineNoL;
                    // Stop EU.0000011
                    TempServLineG.INSERT;
                END ELSE
                    IF PrintPricesG THEN BEGIN
                        TempServLineG.Amount := TempServLineG.Amount + ServLineL.Amount;
                        TempServLineG.MODIFY;
                        OptSerialNoG := C_INC045 + FORMAT(TempServLineG."Line No.");
                    END;
            UNTIL ServLineL.NEXT = 0;
        TempServLineG.RESET;
        // Stop PA025769
    end;

    [Scope('Internal')]
    procedure GetServOptionNo()
    var
        ServLineL: Record "Service Line";
        NoOfPackOptionL: Integer;
    begin
        // Start PA025769
        OptSerialNoG := '';
        IF NOT PrintServOptionG THEN
            EXIT;

        IF TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Job THEN BEGIN
            // Start EU.0000011
            IF ConsolidatePositionsOfAJobG AND (TempServPreviewLineG."Service Job No." <> 0) THEN BEGIN
                // Stop EU.0000011
                TempServLineG.RESET;
                TempServLineG.SETRANGE("Document Type", TempServPreviewLineG."Document Type");
                TempServLineG.SETRANGE("Document No.", TempServPreviewLineG."Document No.");
                TempServLineG.SETRANGE("Service Job No.", TempServPreviewLineG."Service Job No.");
                IF TempServLineG.FINDFIRST THEN
                    OptSerialNoG := C_INC045 + FORMAT(TempServLineG."Line No.");
                EXIT;
            END;
            IF (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Job) AND
               (TempServPreviewLineG."Service Job No." = 0)
            THEN
                // Start EU.0000011
                IF ConsolidatePositionsOfAPackageG THEN BEGIN
                    // Stop EU.0000011
                    ServLineL.RESET;
                    ServLineL.SETRANGE("Document Type", TempServPreviewLineG."Document Type");
                    ServLineL.SETRANGE("Document No.", TempServPreviewLineG."Document No.");
                    ServLineL.SETRANGE("Package No.", TempServPreviewLineG."Package No.");
                    // Start EU.0000011
                    IF ConsolidatePositionsOfAJobG THEN
                        ServLineL.SETRANGE("Service Job No.", 0);
                    // Stop EU.0000011
                    IF ServLineL.FINDSET THEN
                        REPEAT
                            TempServLineG.RESET;
                            TempServLineG.SETRANGE("Document Type", ServLineL."Document Type");
                            TempServLineG.SETRANGE("Document No.", ServLineL."Document No.");
                            // Start EU.0000011
                            TempServLineG.SETRANGE("Service Job No.", ServLineL."Service Job No.");
                            // Stop EU.0000011
                            TempServLineG.SETRANGE("No.", ServLineL."Option Code");
                            IF TempServLineG.FINDFIRST THEN BEGIN
                                NoOfPackOptionL := NoOfPackOptionL + 1;
                                IF NoOfPackOptionL = 1 THEN
                                    OptSerialNoG := C_INC045 + FORMAT(TempServLineG."Line No.")
                                ELSE
                                    IF NoOfPackOptionL <= 3 THEN
                                        IF STRPOS(OptSerialNoG, FORMAT(TempServLineG."Line No.")) = 0 THEN
                                            OptSerialNoG := OptSerialNoG + ';' + C_INC045 + FORMAT(TempServLineG."Line No.")
                                        ELSE
                                            NoOfPackOptionL := NoOfPackOptionL - 1;
                            END;
                        UNTIL ServLineL.NEXT = 0;
                    EXIT;
                END;
        END;
        IF NOT ServLineL.GET(TempServPreviewLineG."Document Type",
           TempServPreviewLineG."Document No.",
           TempServPreviewLineG."Document Line No.")
        THEN
            EXIT;
        TempServLineG.RESET;
        TempServLineG.SETRANGE("Document Type", ServLineL."Document Type");
        TempServLineG.SETRANGE("Document No.", ServLineL."Document No.");
        // Start EU.0000011
        TempServLineG.SETRANGE("Service Job No.", ServLineL."Service Job No.");
        // Stop EU.0000011
        TempServLineG.SETRANGE("No.", ServLineL."Option Code");
        IF TempServLineG.FINDFIRST THEN
            OptSerialNoG := C_INC045 + FORMAT(TempServLineG."Line No.");
        // Stop PA025769
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

        // Start PA038228
        VehApptL.SETRANGE(VIN, "Service Header".VIN);
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
        // Stop PA038228
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
        // Start PA035399.19604
        EXIT(NOT ShowOutputP);
        // Stop PA035399.19604
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
        // Stop EU.0000011
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
        ServHdrL: Record "Service Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        ServHdrL.SETRANGE(ServHdrL."No.", "Service Header".GETFILTER("No."));
        IF ServHdrL.FINDSET THEN BEGIN
            IF ServHdrL."Sell-to Customer No." <> '' THEN
                CustL.GET(ServHdrL."Sell-to Customer No.")
            ELSE
                CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
        END;
        // Stop PA043099
    end;

    [Scope('Internal')]
    procedure EvalHidePrintSubtotal(): Boolean
    begin
        // Start EU.0000011
        IF NOT PrintPricesG THEN
            EXIT(FALSE);
        IF ServPreviewLineG."Line Type" <> ServPreviewLineG."Line Type"::Sum THEN
            EXIT(FALSE);
        IF PrintFixedPriceG THEN BEGIN
            IF ServPreviewLineG."Control Type" = ServPreviewLineG."Control Type"::Job THEN
                EXIT(TRUE);
            EXIT(ServCustG."Print Service Job Fixed Price" = ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit");
        END;
        EXIT(TRUE);
        // Stop EU.0000011
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
        IF PrintBarCodeG THEN BEGIN
            PrintDocTitleAndNoUpG := FALSE;
            ReportLayoutSetupG."Auth. Left Line 1" := '';
            ReportLayoutSetupG."Auth. Left Line 2" := '';
            ReportLayoutSetupG."Auth. Left Line 3" := '';
            ReportLayoutSetupG."Auth. Left Line 4" := '';
            ReportLayoutSetupG."Auth. Left Line 5" := '';
            CLEAR(ReportLayoutSetupG."Header Graphic Left");
        END;

        headerGraphicCount := 0;
        IF PrintDocTitleAndNoUpG THEN BEGIN
            IF (ReportLayoutSetupG."Header Graphic Left".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := '';
                TitleTextCenterG := ReportTitleG;
                TitleTextRightG := "Service Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Service Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Service Header"."No.";
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

    /*
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
    */
}


report 80004 "DPG Service Order Confirm. CZ" // 1057607 "Service Order Confirm. CZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA021213   19.03.03 PA022054   30.09.03 PA022112   15.10.03 PA022287   21.11.03 PA022363   18.12.03 PA022298   21.01.04 PA022542   0
    // PA028871   19.12.06 Length of the variable "PhoneText" is increased from Text[150] to Text[250].
    // PA029090   07.03.07 New field "Guide No." is added
    // PA029695   05.10.07 Vers. List changed from 3.1.0.0/3.1.1.0 to 3.2.0.0
    // PA030188   29.05.08 Enlarged Width of Textbox "VAT Registration"
    // PA030681   31.10.08 Sections PrintPosition changed such that Item No's are displayed fully.
    // PA029774   25.05.09 Report Selection Enhancements
    // PA031318   02.10.09 RAD - Use new function GetVehicleAppoitnmentTexts to get all vehicle appointments
    //                     - Show complete print caption for the vehicle appointments.
    //                     - Use function DevideTextInLine from Collection Unit to print appointments without
    //                       hard line breaks.
    //                     - Print also a 3rd appointment line if required.
    //                     - Print seperation gap line only if a vehicle appointment is available.
    //                     - Useless variables eliminated: VehAppointmentsText2, VehAppointm, CurrentAppointmentL
    // --incadea.MyEngine--
    // PA032589   11.04.11 YI Function IsInternalCustomer changed: now refers to new fiel in customer record, thus less loops
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032031   07.10.11 GB Barcode printout of the Order No in the Report Header based on the Option in the Request Form.
    //                        Barcode printout of the Service Job based on the field Job required in the Time Mgmt. Setup.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA032651   29.02.12 MA 2026780 Inserted signature line
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033336   10.07.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - ExtType is local variable of Section (PrintPosition -Body(4)) modified as global variable.
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Logos are not incorporated in RDLC layout due to alignment with the new Report Layout Concept.
    //                        - City, Date and Signature controls are not printed in the bottom of the report becuase
    //                          PlaceInBottom property is not available in RDLC.
    //            20.07.12    Bugfix
    //            22.08.12    Layout 1 and Layout 2 Incorporated
    //                        - added textbox control 1101344699 in the pageloop header(2) section for ReportTitle
    //                        - Service Header -OnAfterGetRecord,CopyLoop-PostDataItem
    //                          CurrReport.Preview code doesnot works in case of RDLC Report so the same is being put under NOT
    //                          ISSERVICETIER to avoid its execution during RDLC report execution as it will hide the
    //                          "Print layout" option and "Save as" options in RDLC Report
    //                        - Pageloop Header (2) Section
    //                          added pictureBox control 1101344700 & 1101344701 with visible property 'No"  for Graphic Header Left
    //                        - Pageloop Footer(8) Section
    //                          added pictureBox control 1101344702 & 1101344703 with visible property 'No"  for Graphic Footer Left
    //                        - Added Global Variable IsReportSelectionAvailableG
    //                        - Code Commented and replaced with IsReportSelectionAvailableG functionality Pageloop OnAfterGetRecord
    //                          Pageloop footer (7) & Pageloop footer (8)
    //                        - Report Layout Setup Global Variable taken for calculating "Header Graphic Left", "Header Graphic Right",
    //                          "Footer Graphic Left" and "Footer Graphic Right" Logos.
    //                        - "Removed the fourth parameter from "Report selections".GetReportTitle function in PageHeader(2)
    //                          section to display the Report Title based on Conditions.
    // PA032861   06.09.12 KC 6269811: Modified OnPreReport() trigger after removal of parameter "Job Task Acquisition Mandatory"
    //                        from table HR Setup
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm, OnOpenPage, "Service Header - OnAfterGetRecord"
    //                        "PageLoop, Footer (7) - OnPreSection()", "PageLoop, Footer (8) - OnPreSection()"
    // PA033336   29.10.12 SS 8719075: Changed the Text Constant C_INC040 to "* = Exchange Part".
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034051   30.07.13 MF Changes to print Performed Veh. Appointments and New Veh. Appointments.
    //            04.11.13 AN I002281 Code Review.
    // PA034531   03.12.13 GF 18593 RDL Layout corrections
    // PA034531   13.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA036090   11.09.14 GF 28382 RDL layout corrections.
    // PA035395   27.12.13 GF 18593 N6.1.4 Merge code.
    // PA035399   17.01.14 GG 19604 Field "Next Vehicle Appointments" added in request Form/Page. RDL modifications in order to
    //                              hide or not the "Next Vehicle Appointments".
    // PA035422   24.01.14 AN 20220 Removed unnecessary code from OnPreDataItem (Vehicle Appointment).
    //                        Fixed the DataItemTableView from Vehicle Appointment dataitem.
    //                        Added code to fill VehApptDescriptionG on Service Job Lines printing and removed wrong code
    //                        in SetOptionLines function.
    // PA035484   01.04.14 GF 20762 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA037341   21.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035399.19604, PA035422.20220, PA035484.20762
    // PA036549   28.01.15 GK 33247 Unnecessary PageBreak Removed,Code for PrintFooterLineG to get initial value
    //                        from Report Selection Setup moved to OnOpenPage Trigger.
    // PA038165   03.06.15 VJ In Report Dataset Designer for "ExplanationsCaption" datasource,new name has been set.
    // PA038166   03.06.15 VJ Merge of PA038165.
    // PA038228   04.08.15 GN Added Header information.
    //                        Added detailed Service information
    // PA038228   21.08.15 GN 43668 Changed Footer functionality
    // PA037047   03.09.15 LR 44234 Add Growup property in RDLC and filter for JobOutput correctly
    //                        Correctly add the quantities
    // PA038218   22.09.15 KR 45498 Code modified in "Re-sortLines" to correct the display of VAT%.
    // PA040114   25.02.16 GP RDLC issue, Title covers logo picture at the right of the document
    // PA040116   25.02.16 GP Merge of PA040114
    // PA040587   21.04.16 GU RDLC Modifications in order to print Description correctly
    // PA040589   05.05.16 GS Merge of PA040587
    // PA040669   30.05.16 GP 61931 RDLC Redesign and Layout modifications
    // PA040669   02.06.16 GQ 61931 RDLC Layout corrections
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   03.08.16 JS Merge of PA039225.51457
    // PA040837   19.07.16 CH 66149 Totals are shown and calculated based on the temporary VATAmountLineG records.
    // PA041179   07.09.16 DR Merge of PA040837.66149
    // PA041125   09.08.16 GJ 68108 RDLC Layout Modifications
    // PA041366   17.08.16 GS Determine the return status on an Item from Service Line, according to design
    // PA041366   24.11.16 GQ 81144 RDLC Layout corrections
    // PA041187   01.12.16 WZ 79598 Adjusted font size of the Barcode in Report Layout
    // PA042304   05.12.16 GU RDLC Modifications - Row visibility changed in order to print Service Lines with Fixed Price
    // PA042304   02.12.16 GU 81682 SetAttribute() - modifications in order to show properly Quantity and prices for Service Lines
    // PA042305   05.12.16 GU Merge of PA042304 and PA042304.81682
    // PA041187   13.02.17 MS 87564 Modifications to consider Service Job fixed price calculation in totals
    //                              Modifications on layout to display only one block of totals. Tablix 'Table15' is not displayed (Filters property changed)
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   13.03.17 GV 89231 Fix Calculation of VAT Total.
    // PA041187   27.03.17 WZ 91653 Added Fixed Price Functionality
    // PA043382   31.03.17 JS Changed Report Layout to print "Unit of Measure" description completely.
    // PA041187   04.04.17 MS 92447 Modification to not print totals in case of service jobs with fixed prices and no service lines assigned
    // PA043382   12.04.17 JS Changed Report Layout to print "Unit of Measure" description completely.
    // --- 7.1.6 ---
    // EU.0000011 30.05.17 DR "Job Details Text Block" print enabled.
    //                        - 2 new lines in the RDLC added to print a Title and a Text Block.
    //                        - Use ReportSelectionG.INIT to set the preferred default Boolean values in the report selection.
    //                        - New Parameter "Print Job Detailed Descript." shown in the Report Request Page.
    //                        - Global variables PrintSentFromLineG, PrintFooterLineG and PrintAddrBlockG removed.
    //                        - Use the Report selection table fields for "Print Sent-From Line","Print Footer Line" and "Print Address Block"
    //                          directly as source fields in the Report Request Page.
    //                        - JobOutputG renamed to ConsolidatePositionsOfAJobG as it is the "Consolidate Positions of a Job" parameter value.
    //                        - PkgOutputG renamed to ConsolidatePositionsOfAPackageG as it is the "Consolidate Positions of a Package" parameter value.
    //                        - Use MakeArchServPreviewG.CalcBaseOrderConfirmation function as a replacement of the constant 2 which stands for
    //                          the CalcBase::"Order Confirmation" option.
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
    // 
    // EU.0000045 23.06.17 DT Support of automatic signature received from webservice
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- IncadeaCZ ---
    // --- NAVCZ ---
    // SOL.1      01.03.18 PV New object created as a copy of Report 5025601 Service Order Confirm.
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // SOL.1.0.1  25.04.18 PV RDLC Layout changed, translation
    //                        Final design of vehicle/contract info part of header
    // SOL.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, Final header design,
    //                        Bank source, SK legislation, Barcode
    // SOL.1.0.4  21.11.18 PV RDLC - extend email place
    //                         -get user fullname through common codeunit 1057605 "ET91,290,382,383,1226"
    // SOL.1.0.4  07.12.18 PV Variable OrderCustAddrLineG extended to avoid error messages
    // INCCZ0012  15.01.20 PV SOL.1.0.5 - Layout
    //                         - extend space for "VAT Registration No." value
    //                         - customer phone and email added
    //                         - layout error when dataset is empty (concerns to 1.value of Code.GetData function)
    // 
    // ---DAF ---
    // FJC        13.07.22 FJC - added Parking Lot and Paking Bay fields
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceOrderConfirmCZ.rdlc';

    Caption = 'Service Order Confirm.';
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
            column(PrintPrices; PrintPricesG)
            {
                Description = 'PA033336';
            }
            column(PrintTotal; PrintTotalG)
            {
                Description = 'PA041187.92447';
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
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
                    column(Service_Header___Pickup_Time_; Format("Service Header"."Pickup Time", 0, '<Hours24,2>:<Minutes,2>'))
                    {
                        Description = 'PA033336';
                    }
                    column(Service_Header___No__; "Service Header"."No.")
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Service_Header___Order_Date_; Format("Service Header"."Order Date"))
                    {
                        Description = 'PA033336';
                    }
                    column(Cust__No__; CustG."No.")
                    {
                    }
                    column(Email_Cust; CustG."E-Mail")
                    {
                    }
                    column(MobilePhoneNo_Cust; CustG."Mobile Phone No.")
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
                    column(Service_Header___Time_of_Order_; Format("Service Header"."Time of Order", 0, '<Hours24,2>:<Minutes,2>'))
                    {
                        Description = 'PA033336';
                    }
                    column(PhoneText; PhoneTextG)
                    {
                    }
                    column(Service_Header_Make_Code; "Service Header"."Make Code")
                    {
                    }
                    column(Driver_SH; "Service Header"."Text 4")
                    {
                    }
                    column(Service_Header___Order_Limit_; "Service Header"."CVM Target Price") // "Order Limit")
                    {
                    }
                    column(Service_Header___Engine_Code_; "Service Header"."Engine Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___License_No__; "Service Header"."License No.")
                    {
                    }
                    column(Service_Header___Fuel_Level_; "Service Header"."Fuel Level")
                    {
                    }
                    column(Make_Name; MakeG.Name)
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
                    column(Service_Header__Mileage; "Service Header".Mileage)
                    {
                    }
                    column(Service_Header___Engine_No__; "Service Header"."Engine No.")
                    {
                        AutoFormatExpression = 'JMD';
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
                    column(Service_Header___License_No_; "Service Header"."License No.")
                    {
                    }
                    column(Service_Header___Licence_No_; "Service Header"."License No.")
                    {
                    }
                    column(Service_Header___Initial_Registration_; Format("Service Header"."Initial Registration"))
                    {
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
                    column(Service_Header___Appointment_Date_; Format("Service Header"."Order Date") + ' / ' + Format("Service Header"."Time of Order"))
                    {
                    }
                    column(Service_Header___Pickup_Date_; Format("Service Header"."Pickup Date") + ' / ' + Format("Service Header"."Pickup Time"))
                    {
                    }
                    column(Service_Header___Mileage_RunningTime_; Format("Service Header".Mileage) + ' /  ' + Format("Service Header"."Running Time"))
                    {
                    }
                    column(Service_Header___Serv_Adv_No_Pickup_; "Service Header"."Service Advisor No./Pick-Up")
                    {
                    }
                    column(Service_Contract_No; VehicleCustomerG."Contract No.")
                    {
                    }
                    column(MainNextAppDate_G; Format(MainNextAppDateG))
                    {
                        Description = 'PA040669.61931';
                    }
                    column(EmissionNextAppDate_G; Format(EmissionNextAppDateG))
                    {
                        Description = 'PA040669.61931';
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
                    column(SalesPurch_Name_Control151; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(DataItem175; CollectiveG.TextShowOutput("Service Header".FieldCaption("VAT Registration No."), "Service Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Service_Header___VAT_Registration_No__; "Service Header"."VAT Registration No.")
                    {
                    }
                    column(Collective_TextShowOutput_CompanyInfo_FIELDCAPTION__VAT_Registration_No_____PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG.FieldCaption("VAT Registration No."), ReportSelectionG."Print Address Block"))
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
                    column(Service_Header___Guide_No__; "Service Header"."Guide No.")
                    {
                        Description = 'PA029090';
                    }
                    column(BarcodeTextG; BarCodeTextG)
                    {
                    }
                    column(BarcodeTextG_Control1115000001; BarCodeTextG)
                    {
                    }
                    column(BarcodeTextG_Control1115000002; BarCodeTextG)
                    {
                    }
                    column(OutputNo; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(DataItem1101344699_ReportTitleG; ReportTitleG)
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
                    column(BankText; BankTextG)
                    {
                    }
                    column(PageLoopFooterG; Format(PageLoopFooterG))
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField43; RDLHideOutput(ReportSelectionG."Print Footer Line" and (not IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'EU.0000011';
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
                    column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
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
                    column(Service_Header___Pickup_Date_Caption; C_INC_PickupAppt)
                    {
                        Description = 'EU.0000011';
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; C_INC_Page)
                    {
                        Description = 'EU.0000011';
                    }
                    column(Cust__No__Caption; C_INC_CustomerNo)
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Order_Limit_Caption; "Service Header".FieldCaption("Order Limit"))
                    {
                        Description = 'PA031318,EU.0000011';
                    }
                    column(Service_Header___Engine_Code_Caption; "Service Header".FieldCaption("Engine Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___License_No__Caption; "Service Header".FieldCaption("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MakeCaption; MakeCaptionLbl)
                    {
                    }
                    column(Model_DescriptionCaption; "Service Header".FieldCaption(Model))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header__VINCaption; "Service Header".FieldCaption(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Labor_Type_Caption; "Service Header".FieldCaption("Labor Type"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Initial_Registration_Caption; "Service Header".FieldCaption("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MileageCaption; MileageCaptionLbl)
                    {
                    }
                    column(Service_Header___Engine_No__Caption; "Service Header".FieldCaption("Engine No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_AdvisorrCaption; Service_AdvisorrCaptionLbl)
                    {
                    }
                    column(Sales_AdvisorrCaption; Sales_AdvisorrCaptionLbl)
                    {
                    }
                    column(Service_Header___Model_Code_Caption; "Service Header".FieldCaption("Model Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(SalesPurch_Name_Cpn; SalesPurch_Name_Control151CaptionLbl)
                    {
                    }
                    column(Service_Header___No__Caption; ServLine2G.FieldCaption("Document No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Order_Date_Caption; "Service Header".FieldCaption("Document Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Signatures_Lbl_Caption; Signatures_Lbl)
                    {
                        Description = 'PA040669.61931';
                    }
                    column(Guide_No_Caption; "Service Header".FieldCaption("Guide No."))
                    {
                        Description = 'PA029090,EU.0000011';
                    }
                    column(Parking_lbl_Caption; Parking_lbl)
                    {
                    }
                    column(Payments_toCaption; Payments_toCaptionLbl)
                    {
                    }
                    column(FuelLevelCaption; FuelLevelCaptionLbl)
                    {
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
                    column(Pickup_Date_Time; "Service Header".FieldCaption("Pickup Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Order_Limit_LCY; Format(Order_Limit_LCYLbl))
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
                    column(DueDateCpn_SH; "Service Header".FieldCaption("Due Date"))
                    {
                    }
                    column(VATDateCpn_SH; "Service Header".FieldCaption("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SH; "Service Header".FieldCaption("Variable Symbol"))
                    {
                    }
                    column(EmailCpn_Comp; CompanyInfoG.FieldCaption("E-Mail"))
                    {
                    }
                    column(PhoneLbl; PhoneLbl)
                    {
                    }
                    column(IbanCpn_Comp; CompanyInfoG.FieldCaption(IBAN))
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
                    column(Parking_Lot_SH; "Service Header"."CVM Parking Lot")
                    {
                    }
                    column(Parking_Bay_SH; "Service Header"."CVM Parking Bay")
                    {
                    }
                    column(YourReferenceCpt_SH; "Service Header".FieldCaption("Your Reference"))
                    {
                    }
                    column(YourReference_SH; "Service Header"."Your Reference")
                    {
                    }
                    column(DriverNameCpn_SH; "Service Header".FieldCaption("Driver Name"))
                    {
                    }
                    column(PickupDateTime_SH; "Service Header"."Pickup DateTime")
                    {
                    }
                    column(PickupDateTimeCpn_SH; "Service Header".FieldCaption("Pickup DateTime"))
                    {
                    }
                    column(VehicleCategoryCode_SH; "Service Header"."Vehicle Category Code")
                    {
                    }
                    column(VehicleCategoryCodeCpn_SH; "Service Header".FieldCaption("Vehicle Category Code"))
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
                    column(HandOver_Lbl_Caption; HandOver_Lbl)
                    {
                    }
                    column(TakeOver_Lbl_Caption; TakeOver_Lbl)
                    {
                    }
                    column(Name_Lbl; Name_Lbl)
                    {
                    }
                    column(VendorLbl; VendorLbl)
                    {
                    }
                    column(ShowTaxNoG; ShowTaxNoG)
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
                            SetFilter("Next Appointment Date", '%1..', "Service Header"."Document Date");
                            // Start PA035422.20220
                            // Stop PA035422.20220
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
                        column(ServPreviewLine_LineTypeG; (ServPreviewLineG."Line Type" + 0))
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(ServPreviewLine_TypeG; (ServPreviewLineG.Type + 0))
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(ServiCustrPrintFixedUnitPriceG; ServiCustrPrintFixedUnitPriceG)
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line__Description____________Service_Preview_Line___Description_2_; ServPreviewLineG.Description + CollectiveG.TextShowOutput(' - ', (ServPreviewLineG.Description > '') and (ServPreviewLineG."Description 2" > '')) + ServPreviewLineG."Description 2")
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
                        column(FORMAT__Service_Preview_Line___Service_Job_No_______; '*' + Format(ServPreviewLineG."Service Job No.") + '*')
                        {
                        }
                        column(Service_Preview_Line___Line_Type_; ServPreviewLineG."Line Type")
                        {
                            Description = 'PA033336';
                        }
                        column(PrintBarcodeG; PrintBarCodeG)
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line__Type; ServPreviewLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(FixedPriceLab; FixedPriceLabG)
                        {
                            Description = 'PA033336';
                        }
                        column(ServCustPrintG; ServCustPrintG)
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line___Package_No__; ServPreviewLineG."Package No.")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(Service_Preview_Line__Description__________Service_Preview_Line___Description_2_; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(ServCustomer__Print_Fixed_Unit_Price_; ServCustG."Print Fixed Unit Price")
                        {
                            Description = 'PA033336';
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
                        column(Service_Preview_Line___Description_2_; ServPreviewLineG."Description 2")
                        {
                        }
                        column(SumLabor; SumLaborG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(JobOutput; ConsolidatePositionsOfAJobG)
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(PackageOutput; ConsolidatePositionsOfAPackageG)
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
                        column(No_Caption; "Service Header".FieldCaption("No."))
                        {
                            Description = 'EU.0000011';
                        }
                        column(DescriptionCaption; ServLine2G.FieldCaption(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
                        {
                        }
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; ServPreviewLineG.FieldCaption("Unit Price"))
                        {
                            Description = 'EU.0000011';
                        }
                        column(AmountCaption; ServPreviewLineG.FieldCaption(Amount))
                        {
                            Description = 'EU.0000011';
                        }
                        column(No_Caption_Control112; "Service Header".FieldCaption("No."))
                        {
                            Description = 'EU.0000011';
                        }
                        column(DescriptionCaption_Control113; ServLine2G.FieldCaption(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(Qty_Caption_Control114; Qty_CaptionLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(UoMCaption_Control115; UoMCaptionLbl)
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
                        column(HidePrintJobHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) and (ServPreviewLineG."Service Job No." <> 0)))
                        {
                        }
                        column(HidePrintPackageHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) and (ServPreviewLineG."Package No." <> '')))
                        {
                        }
                        column(HidePrintSubtotal; RDLHideOutput(EvalHidePrintSubtotal()))
                        {
                        }
                        column(VATpercent_SL; ServPreviewLineG."VAT %")
                        {
                        }
                        column(VATpercentCpn_SL; ServPreviewLineG.FieldCaption("VAT %"))
                        {
                        }
                        column(UnitPriceLbl; UnitPriceLbl)
                        {
                        }
                        column(NoLbl; NoLbl)
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
                                if Number = 1 then
                                    TempServPreviewLineBOMG.FindSet
                                else
                                    TempServPreviewLineBOMG.Next;
                                // Stop EU.0000011
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not BOMOutputG then
                                    CurrReport.Break;

                                if (ServPreviewLineG."Line Type" <> ServPreviewLineG."Line Type"::Job) or
                                   (ServPreviewLineG."Service Job No." <> 0) or (ServPreviewLineG."Package No." = '')
                                then
                                    CurrReport.Break;

                                // Start EU.0000011
                                TempServPreviewLineBOMG.Reset;
                                TempServPreviewLineBOMG.SetRange("Package No.", ServPreviewLineG."Package No.");
                                TempServPreviewLineBOMG.SetRange("Suppress in Order", false);
                                if TempServPreviewLineBOMG.IsEmpty then
                                    CurrReport.Break;
                                SetRange(Number, 1, TempServPreviewLineBOMG.Count);
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
                            if Number = 1 then
                                TempServPreviewLineG.Find('-')
                            else
                                TempServPreviewLineG.Next;
                            // Start EU.0000011
                            ServPreviewLineG := TempServPreviewLineG;
                            TextBlockContentG := '';
                            // Stop EU.0000011
                            // Start PA025769
                            if PrintServOptionG then
                                GetServOptionNo;
                            // Stop PA025769

                            // Start PA022363
                            if ServPreviewLineG.Type <> ServPreviewLineG.Type::" " then begin
                                // Start EU.0000011
                                // Stop EU.0000011
                                FixedPriceLabG := false;
                                // Start PA041187.91653
                                PrintFixedPriceG := false;
                                // Stop PA041187.91653
                                Clear(ServLineL);
                                Clear(ServCustG);
                                NoPropertyG := '';
                                if not ServLineL.Get(
                                   ServPreviewLineG."Document Type",
                                   ServPreviewLineG."Document No.",
                                   ServPreviewLineG."Document Line No.")
                                // Start PA041187.87564
                                then begin
                                    // Start EU.0000011
                                    if ServJobLineL.Get(
                                       ServPreviewLineG."Document Type",
                                       ServPreviewLineG."Document No.",
                                       ServPreviewLineG."Service Job No.")
                                    then
                                        if ServJobLineL."Includes Fixed Price" then
                                            PrintFixedPriceG := true;
                                    if ServCustG.Get(ServJobLineL."Document Type", ServJobLineL."Document No.", ServPreviewLineG."Bill-to Customer No.") then
                                        ;
                                    // Stop EU.0000011
                                    ServPreviewLineG."No." := '';
                                end else begin
                                    // Stop PA041187.87564
                                    if ServCustG.Get("Service Header"."Document Type", "Service Header"."No.", ServLineL."Bill-to Customer No.") then
                                        ;
                                    if (ServLineL.Type = ServLineL.Type::Labor) and (ServLineL."Fixed Price" <> 0) then
                                        FixedPriceLabG := true;
                                    // Start PA041187.91653
                                    if ServJobLineL.Get(
                                       ServLineL."Document Type",
                                       ServLineL."Document No.",
                                       ServLineL."Service Job No.")
                                    then
                                        // Start EU.0000011
                                        if ServJobLineL."Includes Fixed Price" then
                                            PrintFixedPriceG := true;
                                    SetAttribute(ServLineL, ServPreviewLineG, NoPropertyG);
                                    // Stop EU.0000011
                                    // Start PA022298
                                    if ProportinatelyChargingLineG then begin
                                        ServPreviewLineG."Unit Price" := 0;
                                        ServPreviewLineG."Line Discount %" := 0;
                                    end;
                                    // Stop PA022298

                                    // Start EU.0000011
                                    // Stop EU.0000011
                                end;
                                // Start EU.0000011
                                // Stop EU.0000011
                            end;
                            // Stop PA022363

                            ServiCustrPrintFixedUnitPriceG := ServCustG."Print Fixed Unit Price";

                            // Start EU.0000011
                            if ((ServPreviewLineG."Line Discount Amount" < 0) or PrintWithoutDiscG) and
                               not ProportinatelyChargingLineG and (ServPreviewLineG.Quantity <> 0)
                            then begin
                                ServPreviewLineG."Unit Price" := ServPreviewLineG.Amount / ServPreviewLineG.Quantity;
                                ServPreviewLineG."Line Discount %" := 0;
                            end;
                            // Stop EU.0000011
                            // Stop PA035597

                            // Start PA041187.91653
                            ServCustPrintFixedPriceG := ServCustG."Print Service Job Fixed Price";
                            // Stop PA041187.91653

                            // Start PA034051
                            VehApptDescriptionG := '';
                            if ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job then
                                if ServJobLineL.Get(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Service Job No.") then
                                    if (ServJobLineL."Veh. Appointment Code" <> '') and
                                       (ServJobLineL."Veh. Appointment Status" <> ServJobLineL."Veh. Appointment Status"::New)
                                    then
                                        VehApptDescriptionG := ServManagementG.CreateApptDescription(ServJobLineL);
                            // Start EU.0000011
                            TextBlockG.Init;
                            if ServPreviewLineG.Type = ServPreviewLineG.Type::" " then begin
                                if ServPreviewLineG."Job Details Text Block" > 0 then begin
                                    if not ReportSelectionG."Print Job Detailed Descript." then
                                        CurrReport.Skip;
                                    if not TextBlockG.Get(ServPreviewLineG."Job Details Text Block") then
                                        CurrReport.Skip;
                                    TextBlockContentG := TextBlockG.GetTextBlock();
                                    ServPreviewLineG.Description := '';
                                    TextBlockG."Headline Text" := '';
                                    ServPreviewLineG."Description 2" := '          '; // Add a Blank line in the end
                                    ServPreviewLineG."Service Job No." := 0;
                                end;
                            end;
                            // Stop EU.0000011
                            // Stop PA034051
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start EU.0000011
                            if PrintFairDealRateG and PrintPricesG then
                                MakeServPreviewG.ActivateFairDealCalculation(WarrCustG, true);
                            MakeServPreviewG.ShowJob("Service Header", TempServPreviewLineG, MakeServPreviewG.CalcBaseOrderConfirmation(), true);
                            MakeServPreviewG.GetVATAmountLineTemp(VATAmountLineG);
                            // totals
                            TempServPreviewLineG.GetTotals(ServSetupG."Output Ext. Service", SumItemG, SumExtServG, SumLaborG, SumOtherG, SumFairDealG);
                            VATAmountLineG.GetTotals(TotalNetG, TotalGrossG, TotalVATG);
                            TempServPreviewLineG.GetTotalExchangeParts(SumExchTaxG, SumExchAmountG, ExchRateG);
                            TotalGrossG := TotalGrossG + SumExchTaxG;
                            // consolidation
                            if ConsolidatePositionsOfAJobG then
                                TempServPreviewLineG.ConsolidateJobs(PrintPricesG);
                            if ConsolidateNegativePosG then
                                TempServPreviewLineG.ConsolidateNegativePositions();
                            if ConsolidateLaborPosG then
                                TempServPreviewLineG.ConsolidateByType(TempServPreviewLineG.Type::Labor, ConsolidatePositionsOfAPackageG);
                            if ConsolidatePositionsOfAPackageG then
                                TempServPreviewLineG.ConsolidatePackages("Service Header"."Document Type", "Service Header"."No.", TempServPreviewLineBOMG, false, BOMOutputG, PrintPricesG);

                            TempServPreviewLineG.SetRange("Suppress in Order", false);
                            // Stop EU.0000011

                            // Start PA022298
                            if PrintOnlyOwnPartG then begin
                                SetCustomerAmounts();
                            end;
                            // Stop PA022298

                            Clear(MakeServPreviewG);

                            // Start EU.0000011
                            // Stop EU.0000011

                            // Start PA025769
                            SetOptionLines;
                            // Stop PA025769

                            MoreLinesG := TempServPreviewLineG.FindLast;

                            TempServPreviewLineG.SetRange("Entry No.", 0, TempServPreviewLineG."Entry No.");
                            SetRange(Number, 1, TempServPreviewLineG.Count);

                            CurrReport.CreateTotals(TempServPreviewLineG."Line Discount Amount", TempServPreviewLineG.Amount,
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
                        column(OptSerialNoG_Control1109400012; OptSerialNoG)
                        {
                        }
                        column(Created_Own_OptionsCaption; Created_Own_OptionsCaptionLbl)
                        {
                        }
                        column(DescriptionCaption_Control1109400017; ServLine2G.FieldCaption(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(Option_CodeCaption; "Service Header".FieldCaption("Option Code"))
                        {
                            Description = 'EU.0000011';
                        }
                        column(Unit_PriceCaption_Control1109400013; Unit_PriceCaption_Control1109400013Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1109400014; ServLine2G.FieldCaption(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(Option_CodeCaption_Control1109400015; "Service Header".FieldCaption("Option Code"))
                        {
                            Description = 'EU.0000011';
                        }
                        column(ServiceOption_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA025769
                            if Number = 1 then
                                TempServLineG.Find('-')
                            else
                                TempServLineG.Next;
                            OptSerialNoG := C_INC045 + Format(TempServLineG."Line No.");
                            SerOptionG := true;
                            // Stop PA025769
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA025769
                            TempServLineG.Reset;
                            ServiceOption.SetRange(Number, 1, TempServLineG.Count);
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
                        column(FairDealProperty; CopyStr(C_INC038, 1, 1))
                        {
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
                            Description = 'PA033336';
                        }
                        column(VATTextExch; VATTextExchG)
                        {
                            Description = 'PA033336';
                        }
                        column(PrintFairDealRate; PrintFairDealRateG)
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
                        column(ExchProperty; CopyStr(C_INC040, 1, 1))
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(TotalGross; TotalGrossG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption; C_INC_Continued)
                        {
                            Description = 'EU.0000011';
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                            // Start PA035597
                            VATTextG := StrSubstNo('%1%2', VATAmountLineG."VAT %", C_INC001);
                            VATTextExchG := StrSubstNo('%1%2', ExchRateG, C_INC022);
                            // Stop PA035597
                            // Start EU.0000011
                            // Stop EU.0000011
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA040837.66149
                            if VATAmountLineG.Count < 1 then
                                // Stop PA040837.66149
                                CurrReport.Break;
                            SetRange(Number, 1, VATAmountLineG.Count);
                            CurrReport.CreateTotals(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
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
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(LegendText; LegendTextG)
                        {
                        }
                        column(FooterTextG; FooterTextG)
                        {
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
                        column(PaymentTerms_Description; PaymentTermsG.Description)
                        {
                        }
                        column(ExplanationsCaption; ExplanationsCaption)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(CityCaption; CityCaptionLbl)
                        {
                        }
                        column(DateCaption; DateCaptionLbl)
                        {
                        }
                        column(SignatureCaption; SignatureCaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
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

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA035597
                            LegendTextG := '';
                            if WtyDateG then
                                LegendTextG := C_INC037;
                            if FairDealDaG then
                                if LegendTextG = '' then
                                    LegendTextG := C_INC038
                                else
                                    LegendTextG := LegendTextG + ',  ' + C_INC038;
                            if ReturnDaG then
                                if LegendTextG = '' then
                                    LegendTextG := C_INC039
                                else
                                    LegendTextG := LegendTextG + ',  ' + C_INC039;
                            if ExchangeDaG then
                                if LegendTextG = '' then
                                    LegendTextG := C_INC040
                                else
                                    LegendTextG := LegendTextG + ',  ' + C_INC040;
                            if ProportinatelyChargingG then
                                if LegendTextG = '' then
                                    LegendTextG := C_INC042
                                else
                                    LegendTextG := LegendTextG + ',  ' + C_INC042;
                            if SerOptionG then
                                if LegendTextG = '' then
                                    LegendTextG := C_INC045 + C_INC043
                                else
                                    LegendTextG := LegendTextG + ',  ' + C_INC045 + C_INC043;
                            if SerOptionG and PrintPricesG then
                                FooterTextG := C_INC044
                            else
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
                        if PrintBarCodeG then
                            //Start SOL.1.0.2
                            BarCodeTextG := '*' + "Service Header"."No." + '*';
                        //BarCodeTextG := 'ö' + "Service Header"."No." + 'ö';
                        //Stop SOL.1.0.2
                        // Start EU.0000011
                        if ReportSelectionG."Print Footer Line" then
                            // Stop EU.0000011
                            PageLoopFooterG := 1;
                        // Stop PA035597
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    Clear(ServLine2G);
                    Clear(CalcServAmtsG);
                    CalcServAmtsG.GetServLines("Service Header", ServLine2G, 0);

                    if Number > 1 then begin
                        CopyTextG := C_INC029;
                        // Start PA033336
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    end;
                    // Start PA035597
                    // Stop PA035597
                    // Stop PA033336

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
                    // Start PA022298
                    ProportinatelyChargingG := false;
                    // Stop PA022298
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA023215
                    // Start PA032727
                    if not CurrReport.Preview then
                        ServPrintCounterG.Run("Service Header");
                    // Stop PA032727
                    // Stop PA023215
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA043099
                    NoOfLoopsG := Abs(NoOfCopiesG) + 1;
                    // Stop PA043099

                    CopyTextG := '';
                    SetRange(Number, 1, NoOfLoopsG);
                    // Start PA035597
                    OutputNoG := 1;
                    // Stop PA035597
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
                //Start SOL.1      01.03.18 PV
                CurrReport.Language := LanguageG.GetLanguageID("Language Code");
                //Stop SOL.1      01.03.18 PV

                // Start PA034531.18593
                // Start EU.0000011
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Make Code", "Location Code",
                // Stop EU.0000011
                  REPORT::"DPG Service Order Confirm. CZ"); //SOL.1      01.03.18 PV
                Clear(ReportLayoutSetupG);
                if IsRepSelectionSetupAvailableG then begin
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Make Code", "Location Code");
                end;
                // Stop PA034531.18593

                //Start SOL.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Service Header"."Language Code");
                SetTitles;
                //EmployeeFullNameG := GetUserIDFullName(USERID); //SOL.1.0.4
                EmployeeFullNameG := T91Fnc.T91_GetUserIDFullName(UserId); //SOL.1.0.4

                if GLSetupG.Legislation = GLSetupG.Legislation::SK then
                    ShowTaxNoG := true
                else
                    ShowTaxNoG := false;

                "Service Header".CalcFields("Driver Name");
                //Stop SOL.1      01.03.18 PV

                if "Sell-to Customer No." <> '' then
                    CustG.Get("Sell-to Customer No.")
                else
                    Clear(CustG);
                CurrReport.Language := CustG.PrintDocInCustLanguage();

                if not LocationG.Get("Location Code") then
                    Clear(LocationG);
                IntCustG := CompanyInfoG."Internal Customer";
                if LocationG."Internal Customer" <> '' then
                    IntCustG := LocationG."Internal Customer";
                if (LocationG."Ship-to Address Code" <> '') and
                   (OwnDelivAddressG.Get(IntCustG, LocationG."Ship-to Address Code"))
                then begin
                    FormatAddrG.OwnCustomerAddress(CompanyAddrG, OwnDelivAddressG);
                    FormatAddrG.OwnAddressLetterWindow(AddrWindowG, OwnDelivAddressG);
                    CoTelephoneG := OwnDelivAddressG."Phone No.";
                    CoFaxG := OwnDelivAddressG."Fax No.";
                    CoEmailG := OwnDelivAddressG."E-Mail";
                end else begin
                    FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
                    FormatAddrG.CompanyLetterAddressWindow(AddrWindowG, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
                end;
                // Start EU.0000011
                if ReportSelectionG."Print Sent-From Line" then
                    CompAddrG := FormatAddrG.GetWindowAddress(C_INC005);

                if ReportSelectionG."Print Address Block" then begin
                    // Stop EU.0000011
                    CoTelephoneTextG := C_INC002;
                    CoFaxTextG := C_INC003;
                    CoEmailTextG := C_INC004;
                end else begin
                    Clear(CompanyAddrG);
                    CoTelephoneG := '';
                    CoFaxG := '';
                    CoEmailG := '';
                end;

                //Start SOL.1.0.2  07.06.18 PV
                //  Correct company bank info is filled when OnValidate of T36."Bank Account Code" is run.
                //  Then it is passed to posted tables, ... Ie. this info should be shown in reports.
                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccountL.Reset;
                if bankAccountL.Get("Service Header"."Bank Account Code") then begin
                    BankNameG := bankAccountL.Name;
                    BankBranchNoG := bankAccountL."Bank Branch No."; //not used on layout
                                                                     //vapa??
                                                                     //  IF BankAccountNoG = '' THEN BEGIN
                                                                     //    BankAccountNoG := bankAccountL."Bank Account No.";
                                                                     //    BankIbanG:= bankAccountL.IBAN;
                                                                     //    BankSwiftG := bankAccountL."SWIFT Code";
                                                                     //  END;
                end;
                // IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                //   OwnBanksG.GET(IntCustG, LocationG."Bank Code") THEN
                //  BEGIN // Start SOL.1      01.03.18 PV
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // Stop SOL.1      01.03.18 PV
                //    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                //  END // Start SOL.1      01.03.18 PV
                // ELSE
                //  BEGIN
                //    BankNameG := CompanyInfoG."Bank Name";
                //    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                //    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                //    BankIbanG := CompanyInfoG.IBAN;
                //    BankAccountNoG := CompanyInfoG."Bank Account No.";
                //    // Stop SOL.1      01.03.18 PV
                //    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                //  END; // SOL.1      01.03.18 PV
                //Stop SOL.1.0.2  07.06.18 PV

                if "Your Reference" = '' then
                    ReferenceTextG := ''
                else
                    ReferenceTextG := FieldCaption("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoTextG := ''
                else
                    VATNoTextG := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetupG.TestField("LCY Code");
                    TotalTextG := StrSubstNo(C_INC030, GLSetupG."LCY Code");
                    TotalInclVATTextG := StrSubstNo(C_INC031, GLSetupG."LCY Code");
                    CurrencyTextG := GLSetupG."LCY Code";
                    FairDealTextG := StrSubstNo(C_INC032, GLSetupG."LCY Code");
                end else begin
                    TotalTextG := StrSubstNo(C_INC030, "Currency Code");
                    TotalInclVATTextG := StrSubstNo(C_INC031, "Currency Code");
                    CurrencyTextG := "Currency Code";
                    FairDealTextG := StrSubstNo(C_INC032, "Currency Code");
                end;
                VehicleFormatAddrG.ServHeaderSellTo(CustAddrG, "Service Header");

                if "Payment Terms Code" = '' then
                    PaymentTermsG.Init
                else
                    PaymentTermsG.Get("Payment Terms Code");

                // Start SOL.1      01.03.18 PV
                if not PaymentMethodG.Get("Service Header"."Payment Method Code") then
                    PaymentMethodG.Init;
                // Stop SOL.1      01.03.18 PV

                PhoneTextG := '';
                if ("Sell-to Home Phone No." <> '') or
                   ("Sell-to Home Mobile Phone No." <> '') or
                   ("Sell-to Phone No." <> '') or
                   ("Sell-to Mobile Phone No." <> '')
                then begin
                    PhoneTextG := C_INC010;
                    if "Sell-to Home Phone No." <> '' then
                        PhoneTextG := PhoneTextG + ' ' + C_INC011 + ' ' + "Sell-to Home Phone No.";
                    if "Sell-to Home Mobile Phone No." <> '' then begin
                        if "Sell-to Home Phone No." <> '' then
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC012
                        else
                            PhoneTextG := PhoneTextG + '  ' + C_INC012;
                        PhoneTextG := PhoneTextG + ' ' + "Sell-to Home Mobile Phone No.";
                    end;
                    if "Sell-to Phone No." <> '' then begin
                        if "Sell-to Home Mobile Phone No." <> '' then
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC013
                        else
                            PhoneTextG := PhoneTextG + '  ' + C_INC013;
                        PhoneTextG := PhoneTextG + ' ' + "Sell-to Phone No.";
                    end;
                    if "Sell-to Mobile Phone No." <> '' then begin
                        if "Sell-to Phone No." <> '' then
                            PhoneTextG := PhoneTextG + C_INC005 + ' ' + C_INC014
                        else
                            PhoneTextG := PhoneTextG + '  ' + C_INC014;
                        PhoneTextG := PhoneTextG + ' ' + "Sell-to Mobile Phone No.";
                    end;
                end;

                PrintWithoutDiscG := not "Service Header"."Show Discount";

                ServLineL.Reset;
                ServLineL.SetRange("Document Type", "Service Header"."Document Type");
                ServLineL.SetRange("Document No.", "Service Header"."No.");
                ServLineL.SetFilter("Line Discount %", '>%1', 0);
                if (ServLineL.Count <> 0) and (not PrintWithoutDiscG) then
                    DiscTextG := C_INC015
                else
                    DiscTextG := '';

                // Start PA038228
                Clear(MainNextAppDateG);
                Clear(EmissionNextAppDateG);
                MainNextAppDateG := GetNextApptDate(1, "Service Header"."Document Date");
                EmissionNextAppDateG := GetNextApptDate(2, "Service Header"."Document Date");

                Clear(VehicleCustomerG);
                VehicleCustomerG.SetRange(VIN, "Service Header".VIN);
                VehicleCustomerG.SetRange(Type, VehicleCustomerG.Type::"Service Contract");
                VehicleCustomerG.SetFilter("Beginning of Contract", '<=%1', "Service Header"."Order Date");
                VehicleCustomerG.SetFilter("Expiration of Contract", '>=%1', "Service Header"."Order Date");
                if VehicleCustomerG.FindFirst then
                    ;
                // Stop PA038228
                // Start PA040669.61931
                if "Service Header"."Sell-to Customer No." <> "Service Header"."Bill-to Customer No." then begin
                    FormatServAddrG.ServHeaderBillTo(OrderCustAddrG, "Service Header");
                    OrderCustAddrLineG := C_INC008 + FormatServAddrG.GetWindowAddress(C_INC005);
                end else
                    OrderCustAddrLineG := '';
                // Stop PA040669.61931

                // Start PA041187.92447
                PrintTotalG := true;
                // Stop PA041187.92447
                // Start PA041187.91653
                if not PrintWithoutDiscG then begin
                    DiscTextG := '';
                    ServJobLineL.Reset;
                    ServJobLineL.SetRange("Document Type", "Service Header"."Document Type");
                    ServJobLineL.SetRange("Document No.", "Service Header"."No.");
                    ServJobLineL.SetRange("Includes Fixed Price", true);
                    if ServJobLineL.FindSet then
                        repeat
                            if ServCustG.Get(
                               ServJobLineL."Document Type",
                               ServJobLineL."Document No.",
                               ServJobLineL."Bill-to Customer No.")
                            then
                                if ServCustG."Print Service Job Fixed Price" = ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit" then
                                    DiscTextG := C_INC015;
                            // Start PA041187.92447
                            if PrintTotalG then begin
                                ServLineL.Reset;
                                ServLineL.SetCurrentKey("Document Type", "Document No.", "Service Job No.");
                                ServLineL.SetRange("Document Type", ServJobLineL."Document Type");
                                ServLineL.SetRange("Document No.", ServJobLineL."Document No.");
                                ServLineL.SetRange("Service Job No.", ServJobLineL."Line No.");
                                if ServLineL.IsEmpty then
                                    PrintTotalG := false;
                            end;
                        // Stop PA041187.92447
                        until ServJobLineL.Next = 0;
                    if DiscTextG = '' then begin
                        ServJobLineL.SetRange("Includes Fixed Price", false);
                        if ServJobLineL.FindSet then
                            repeat
                                ServLineL.Reset;
                                ServLineL.SetRange("Document Type", ServJobLineL."Document Type");
                                ServLineL.SetRange("Document No.", ServJobLineL."Document No.");
                                ServLineL.SetRange("Service Job No.", ServJobLineL."Line No.");
                                ServLineL.SetFilter("Line Discount %", '>%1', 0);
                                if not ServLineL.IsEmpty then
                                    DiscTextG := C_INC015
                            until (ServJobLineL.Next = 0) or (DiscTextG <> '');
                    end;
                    if DiscTextG = '' then begin
                        ServLineL.Reset;
                        ServLineL.SetRange("Document Type", "Service Header"."Document Type");
                        ServLineL.SetRange("Document No.", "Service Header"."No.");
                        ServLineL.SetRange("Service Job No.", 0);
                        ServLineL.SetFilter("Line Discount %", '>%1', 0);
                        if not ServLineL.IsEmpty then
                            DiscTextG := C_INC015
                    end;
                end;
                // Stop PA041187.91653

                WarrCustG := '';
                if "Make Code" <> '' then begin
                    MakeG.Get("Make Code");
                    WarrCustG := MakeG."Factory Warranty Customer";
                end else
                    MakeG.Init;

                if "Service Advisor No." <> '' then begin
                    EmployeeG.Get("Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                end else
                    ServAdvisorG := '';

                if not SalesPurchG.Get("Salesperson Code") then
                    SalesPurchG.Name := "Salesperson Code";

                WtyDateG := false;
                FairDealDaG := false;
                ReturnDaG := false;
                ExchangeDaG := false;
                // Start PA041187.87564
                CalcFields("Includes Fixed Price");
                // Stop PA041187.87564
                // Start PA031318
                // Start PA034051
                // Stop PA034051
                // Stop PA031318
                // Start PA024130
                if not CurrReport.Preview then begin
                    LogInteractionG := SegMgntG.FindInteractTmplCode(41) <> '';
                    if LogInteractionG then
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::SrvOrdConf,
                      "No.",
                      0,
                      0,
                      DATABASE::Customer,
                      "Bill-to Customer No.",
                      "Salesperson Code",
                      '',
                      "Posting Description");
                    // Stop PA034256.I000009
                end;
                // Stop PA024130
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.Get;
                ServSetupG.Get();
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
                group("Možnosti")
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
                            if PrintPricesG = false then begin
                                PrintFairDealRateG := false;
                                PrintOnlyOwnPartG := false;
                            end;
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
                            if PrintOnlyOwnPartG then
                                PrintPricesG := true;
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
                            if PrintFairDealRateG then
                                PrintPricesG := true;
                            // Stop PA033336
                        end;
                    }
                    field("Print Sent-From Line"; ReportSelectionG."Print Sent-From Line")
                    {
                        CaptionClass = ReportSelectionG.FieldCaption("Print Sent-From Line");
                        Description = 'EU.0000011';
                    }
                    field("Print Address Block"; ReportSelectionG."Print Address Block")
                    {
                        CaptionClass = ReportSelectionG.FieldCaption("Print Address Block");
                        Description = 'EU.0000011';
                    }
                    field("Print Footer Line"; ReportSelectionG."Print Footer Line")
                    {
                        CaptionClass = ReportSelectionG.FieldCaption("Print Footer Line");
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
                        Description = 'PA035399,EU.0000011';
                    }
                    field("Print Job Detailed Descript."; ReportSelectionG."Print Job Detailed Descript.")
                    {
                        CaptionClass = ReportSelectionG.FieldCaption("Print Job Detailed Descript.");
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
                            if ConsolidatePositionsOfAJobG then begin
                                ConsolidateLaborPosG := false;
                                ConsolidatePositionsOfAPackageG := false;
                                BOMOutputG := false;
                            end;
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
                            // Start EU.0000011
                            if ConsolidatePositionsOfAPackageG then
                                ConsolidatePositionsOfAJobG := false
                            else
                                // Stop EU.0000011
                                BOMOutputG := false;
                            // Stop PA033336
                        end;
                    }
                    field("Output Package BOM"; BOMOutputG)
                    {
                        Caption = 'Output Package BOM';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start EU.0000011
                            BOMOutputGOnPush();
                            // Stop EU.0000011
                        end;
                    }
                    field("Consolidate Labor Positions"; ConsolidateLaborPosG)
                    {
                        Caption = 'Consolidate Labor Positions';
                        Description = 'EU.0000011';

                        trigger OnValidate()
                        begin
                            // Start EU.0000011
                            if ConsolidateLaborPosG then
                                ConsolidatePositionsOfAJobG := false;
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
            PrintPricesG := false;
            PrintFairDealRateG := false;
            PrintOnlyOwnPartG := false;
            GetReportSelection();
            BOMOutputG := false;
            ConsolidateNegativePosG := true;
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
        GLSetupG.Get;
        ServSetupG.Get();
        PrintPricesG := false;
        PrintFairDealRateG := false;
        GetReportSelection();
        BOMOutputG := false;
        ConsolidateNegativePosG := true;
        PrintNextVehicleAppointmentsG := true;
        // Stop EU.0000011
    end;

    trigger OnPreReport()
    begin
        // Start PA032031
        // Start PA032861.6269811
        if PrintBarCodeG then
            // Stop PA032861.6269811
            PrintJobBarCodeG := true;
        // Stop PA032031
        // Start PA035597
        // Stop PA035597

        // Start EU.0000045
        UserSessionG.GetDocumentSignature(DocumentSignatureTG);
        HideSignatureG := false;
        if not DocumentSignatureTG.IsEmpty() then begin
            HideSignatureG := true;
            DocumentSignatureTG.FindFirst();
            repeat
                case DocumentSignatureTG.Type of
                    DocumentSignatureTG.Type::Client:
                        begin
                            DocumentSignatureTG.CalcFields(Content);
                            SignatureClientTG.Init;
                            SignatureClientTG.Blob := DocumentSignatureTG.Content;
                            SignatureClientTG.Insert;
                            SignatureClientTG.CalcFields(Blob);
                            if DocumentSignatureTG."Signature Date" = 0D then
                                DocumentSignatureTG."Signature Date" := Today();
                            if DocumentSignatureTG."Signature City" = '' then begin
                                SignatureCityDateCaptionG := DateCaptionLbl;
                                SignatureCityDateG := Format(DocumentSignatureTG."Signature Date");
                            end else begin
                                SignatureCityDateCaptionG := StrSubstNo('%1, %2', CityCaptionLbl, DateCaptionLbl);
                                SignatureCityDateG := StrSubstNo('%1, %2', DocumentSignatureTG."Signature City", DocumentSignatureTG."Signature Date");
                            end;
                        end;
                    DocumentSignatureTG.Type::Representative:
                        begin
                            DocumentSignatureTG.CalcFields(Content);
                            SignatureRepresentativeTG.Init;
                            SignatureRepresentativeTG.Blob := DocumentSignatureTG.Content;
                            SignatureRepresentativeTG.Insert;
                            SignatureRepresentativeTG.CalcFields(Blob);
                        end;
                end;
            until DocumentSignatureTG.Next = 0;
        end;
        // Stop EU.0000045
    end;

    var
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
        C_INC017: Label 'Package BOMs can only be output for consolidated packages !';
        C_INC022: Label '% Exch. Tax from';
        C_INC029: Label 'Copy of';
        C_INC030: Label 'Total %1';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Fair deal amount %1';
        C_INC037: Label 'W = Warranty Position';
        C_INC038: Label 'F = Fair Deal Position';
        C_INC039: Label 'R =Return-mandatory part';
        C_INC040: Label '* = Exchange Part';
        C_INC_TaxNo: Label 'Tax No.';
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
        SalesPurchG: Record "Salesperson/Purchaser";
        ServPreviewLineG: Record "Service Preview Line";
        ServCustG: Record "Service Customer";
        ServLine2G: Record "Service Line" temporary;
        ServLineCustG: Record "Service Line Customer";
        PaymentTermsG: Record "Payment Terms";
        TempServLineG: Record "Service Line" temporary;
        VehicleCustomerG: Record "Vehicle Customer";
        TextBlockG: Record "Text Block";
        DocumentSignatureTG: Record "Document Signature" temporary;
        SignatureClientTG: Record TempBlob temporary;
        SignatureRepresentativeTG: Record TempBlob temporary;
        FormatAddrG: Codeunit "Format Address";
        VehicleFormatAddrG: Codeunit "Veh Format Address";
        CalcServAmtsG: Codeunit "Calculate Serv. Amounts";
        ServPrintCounterG: Codeunit "Serv. Printed";
        MakeServPreviewG: Codeunit "Make Serv. Preview";
        RTCMgmtG: Codeunit "RTC Management";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
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
        NoPropertyG: Text[10];
        DiscTextG: Text[20];
        ReferenceTextG: Text[30];
        ServAdvisorG: Text[50];
        PhoneTextG: Text[250];
        TotalInclVATTextG: Text[50];
        TotalTextG: Text[50];
        CurrencyTextG: Text[10];
        LegendTextG: Text[250];
        VATTextG: Text[50];
        VATTextExchG: Text[50];
        OptSerialNoG: Text[30];
        FooterTextG: Text[150];
        ReportTitleG: Text[100];
        OrderCustAddrLineG: Text;
        OrderCustAddrG: array[8] of Text;
        SignatureCityDateG: Text[250];
        SignatureCityDateCaptionG: Text[250];
        WarrCustG: Code[20];
        IntCustG: Code[20];
        BarCodeTextG: Code[30];
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        NextEntryNoG: Integer;
        ExTypeG: Integer;
        [InDataSet]
        ServCustPrintG: Integer;
        [InDataSet]
        ServiCustrPrintFixedUnitPriceG: Integer;
        OutputNoG: Integer;
        PageLoopFooterG: Integer;
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
        ConsolidateNegativePosG: Boolean;
        ProportinatelyChargingG: Boolean;
        ProportinatelyChargingLineG: Boolean;
        PrintOnlyOwnPartG: Boolean;
        C_INC042: Label 'P = Proportionately Charged';
        PrintServOptionG: Boolean;
        SerOptionG: Boolean;
        LogInteractionG: Boolean;
        C_INC043: Label 'X = Serial No. of Service Options. ';
        C_INC044: Label 'Total Of Options price can vary from manual calculation because of rounding';
        C_INC045: Label 'O';
        PrintBarCodeG: Boolean;
        PrintJobBarCodeG: Boolean;
        C_INC046: Label 'Service Order Confirm.';
        IsRepSelectionSetupAvailableG: Boolean;
        [InDataSet]
        PrintFixedPriceG: Boolean;
        PrintTotalG: Boolean;
        HideSignatureG: Boolean;
        [InDataSet]
        VehApptDescriptionG: Text[50];
        PrintNextVehicleAppointmentsG: Boolean;
        C_INC_PickupAppt: Label 'Pickup Appt.';
        C_INC_Page: Label 'Page';
        C_INC_CustomerNo: Label 'Customer No.';
        MakeCaptionLbl: Label 'Make';
        MileageCaptionLbl: Label 'Mileage / Running Time';
        Service_AdvisorrCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorrCaptionLbl: Label 'Sales Advisor';
        SalesPurch_Name_Control151CaptionLbl: Label 'Salesperson';
        Payments_toCaptionLbl: Label 'Payments to:';
        Next_Vehicle_Appointments__CaptionLbl: Label 'Next Vehicle Appointments:';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        TotalNet___SumFairDealPerSection_Control125CaptionLbl: Label 'Sum carried forward';
        SumLaborCaptionLbl: Label 'Sum Labor';
        SumItemCaptionLbl: Label 'Sum Item';
        SumExtServCaptionLbl: Label 'Sum External Services';
        SumOtherCaptionLbl: Label 'Sum Other';
        Created_Own_OptionsCaptionLbl: Label 'Created Own Options';
        Unit_PriceCaption_Control1109400013Lbl: Label 'Price';
        C_INC_Continued: Label 'Continued';
        ExplanationsCaption: Label 'Explanations';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        CityCaptionLbl: Label 'City';
        DateCaptionLbl: Label 'Date';
        SignatureCaptionLbl: Label 'Signature';
        FuelLevelCaptionLbl: Label 'Fuel Level';
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        Inspection_DateLbl: Label 'Inspection Date';
        Emission_DateLbl: Label 'Emission Date';
        Appt_Service_AdvisorLbl: Label 'Appt. Service Advisor';
        Pickup_Service_AdvisorLbl: Label 'Pickup Service Advisor';
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
        Order_Limit_LCYLbl: Label 'Order Limit';
        Signatures_Lbl: Label 'Signatures';
        SignatureRepresentative_Lbl: Label 'Service Advisor';
        SignatureClient_Lbl: Label 'Customer';
        __SOL_vars: Integer;
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
        VendorLbl: Label 'Vendor';
        ShowTaxNoG: Boolean;
        UnitPriceLbl: Label 'Unit Price';
        NoLbl: Label 'No.';
        Parking_lbl: Label 'Parking';
        HandOver_Lbl: Label 'Handover';
        TakeOver_Lbl: Label 'Takeovver';
        Name_Lbl: Label 'Name';

    [Scope('Internal')]
    procedure SetAttribute(ServLineP: Record "Service Line"; var CurServPreviewLineP: Record "Service Preview Line"; var LinePropertyL: Text[10])
    var
        ItemL: Record Item;
    begin
        // SetAttribute

        // Check Exchange Part flag and set it, if required
        // Flag for exchange part = *
        if ServLineP."VAT Calculation Type" = ServLineP."VAT Calculation Type"::"Exch. Parts Tax" then begin
            if StrPos(LinePropertyL, CopyStr(C_INC040, 1, 1)) = 0 then
                LinePropertyL := LinePropertyL + CopyStr(C_INC040, 1, 1);
            ExchangeDaG := true;
        end;

        // Check fair deal position and load fair deal flag
        // Start EU.0000011
        // Stop EU.0000011
        // Only set the warranty flag if the rate is no fair deal position and the warranty customer
        if CurServPreviewLineP."Fair Deal" then begin
            if StrPos(LinePropertyL, CopyStr(C_INC038, 1, 1)) = 0 then
                LinePropertyL := LinePropertyL + CopyStr(C_INC038, 1, 1);
            FairDealDaG := true;
        end;

        // contains a complete invoice for this line
        // Check if the items are return-mandatory
        // Flag for return part = R
        // Start EU.0000011
        if not CurServPreviewLineP."Fair Deal" then begin
            // Stop EU.0000011
            ServLineP.CalcFields("No. of Bill-to Customers");
            if (ServLineP."Bill-to Customer No." = WarrCustG) and (ServLineP."No. of Bill-to Customers" = 1) then begin
                WtyDateG := true;
                if StrPos(LinePropertyL, CopyStr(C_INC037, 1, 1)) = 0 then
                    LinePropertyL := LinePropertyL + CopyStr(C_INC037, 1, 1);
            end;
        end;

        // Flag for return part = R
        if ServLineP.Type = ServLineP.Type::Item then begin
            // Start PA041366
            if ServLineP."Sending Required" in [ServLineP."Sending Required"::Keep, ServLineP."Sending Required"::Send] then begin
                // Stop PA041366
                if StrPos(LinePropertyL, CopyStr(C_INC039, 1, 1)) = 0 then
                    LinePropertyL := LinePropertyL + CopyStr(C_INC039, 1, 1);
                ReturnDaG := true;
            end;
        end;

        // Start PA022298
        ProportinatelyChargingLineG := false;
        if PrintPricesG then begin
            ServLineCustG.Reset;
            ServLineCustG.SetRange("Document Type", "Service Header"."Document Type");
            ServLineCustG.SetRange("Document No.", "Service Header"."No.");
            ServLineCustG.SetRange("Document Line No.", ServLineP."Line No.");
            // Start PA042304.81682
            ServLineCustG.SetRange("Bill-to Customer No.", ServLineP."Bill-to Customer No.");
            // Stop PA042304.81682
            if ServLineCustG.Find('-') then begin
                if ServLineCustG."Portion %" <> 100 then begin
                    if StrPos(LinePropertyL, CopyStr(C_INC042, 1, 1)) = 0 then
                        LinePropertyL := LinePropertyL + CopyStr(C_INC042, 1, 1);
                    ProportinatelyChargingG := true;
                    ProportinatelyChargingLineG := true;
                end;
            end else begin
                if StrPos(LinePropertyL, CopyStr(C_INC042, 1, 1)) = 0 then
                    LinePropertyL := LinePropertyL + CopyStr(C_INC042, 1, 1);
                ProportinatelyChargingG := true;
                ProportinatelyChargingLineG := true;
            end;
        end;
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
        TempServPreviewLineL.DeleteAll();
        // Start EU.0000011
        VATAmountLineG.Reset;
        VATAmountLineG.DeleteAll;
        // Stop EU.0000011
        MakeServPreviewG.ShowCustomer("Service Header", TempServPreviewLineL, 2, true);

        TempServPreviewLineG.Reset;
        if TempServPreviewLineG.FindSet then begin
            repeat
                TempServPreviewLineG."Unit Price" := 0;
                TempServPreviewLineG."Line Discount %" := 0;
                TempServPreviewLineG."Line Discount Amount" := 0;
                TempServPreviewLineG.Amount := 0;
                TempServPreviewLineG."Amount Including VAT" := 0;
                TempServPreviewLineG."Exch. Parts Tax Base" := 0;
                TempServPreviewLineG."Exch. Parts Tax Amount" := 0;
                TempServPreviewLineG."Portion %" := 0;
                TempServPreviewLineG.Modify;
            until TempServPreviewLineG.Next = 0;
        end;

        FromPreviewLineL := 0;
        ToPreviewLineL := 0;
        TempServPreviewLineL.Reset;
        TempServPreviewLineL.SetRange("Bill-to Customer No.", "Service Header"."Bill-to Customer No.");
        if TempServPreviewLineL.FindFirst then begin
            FromPreviewLineL := TempServPreviewLineL."Entry No.";
            TempServPreviewLineL.SetRange("Bill-to Customer No.");
            TempServPreviewLineL.SetFilter("Entry No.", '>%1', FromPreviewLineL);
            TempServPreviewLineL.SetRange("Line Type", TempServPreviewLineL."Line Type"::Total);
            if TempServPreviewLineL.FindFirst then begin
                ToPreviewLineL := TempServPreviewLineL."Entry No.";
            end;
            TempServPreviewLineL.Reset;
            if ToPreviewLineL <> 0 then begin
                TempServPreviewLineL.SetFilter("Entry No.", '%1..%2', FromPreviewLineL, ToPreviewLineL);
            end else begin
                TempServPreviewLineL.SetFilter("Entry No.", '>=%1', FromPreviewLineL);
            end;
            if TempServPreviewLineL.FindSet then begin
                repeat
                    TempServPreviewLineG.Reset;
                    if TempServPreviewLineL.Type = TempServPreviewLineL.Type::" " then begin
                        TempServPreviewLineG.SetRange("Line Type", TempServPreviewLineL."Line Type");
                        TempServPreviewLineG.SetRange(Description, TempServPreviewLineL.Description);
                        if TempServPreviewLineG.FindFirst then begin
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
                            if (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Line) and (TempServPreviewLineG.Amount <> 0) then begin
                                TempServPreviewLineG."VAT %" := TempServPreviewLineL."VAT %";
                                VATAmountLineG.CreateFromServicePreviewLine(TempServPreviewLineG, '', false);
                            end;
                            // Stop EU.0000011
                            TempServPreviewLineG.Modify;
                        end;
                    end else begin
                        TempServPreviewLineG.SetRange("Document Line No.", TempServPreviewLineL."Document Line No.");
                        TempServPreviewLineG.SetRange(Type, TempServPreviewLineL.Type);
                        TempServPreviewLineG.SetRange("No.", TempServPreviewLineL."No.");
                        if TempServPreviewLineG.FindFirst then begin
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
                            if (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Line) and (TempServPreviewLineG.Amount <> 0) then begin
                                TempServPreviewLineG."VAT %" := TempServPreviewLineL."VAT %";
                                VATAmountLineG.CreateFromServicePreviewLine(TempServPreviewLineG, '', false);
                            end;
                            // Stop EU.0000011
                            TempServPreviewLineG.Modify;
                        end;
                    end;
                until TempServPreviewLineL.Next = 0;
            end;
        end;
        TempServPreviewLineG.Reset;
        // Stop PA022298
        // Start EU.0000011
        TempServPreviewLineG.GetTotals(ServSetupG."Output Ext. Service", SumItemG, SumExtServG, SumLaborG, SumOtherG, SumFairDealG);
        VATAmountLineG.GetTotals(TotalNetG, TotalGrossG, TotalVATG);
        TempServPreviewLineG.GetTotalExchangeParts(SumExchTaxG, SumExchAmountG, ExchRateG);
        TempServPreviewLineG.Reset;
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
        TempServLineG.DeleteAll;
        if not PrintServOptionG then
            exit;
        // Start EU.0000011
        OptionLineNoL := 0;
        // Stop EU.0000011
        ServLineL.Reset;
        ServLineL.SetRange("Document Type", "Service Header"."Document Type");
        ServLineL.SetRange("Document No.", "Service Header"."No.");
        ServLineL.SetRange(ServLineL."Value Increasing Measure", true);
        if ServLineL.FindSet then
            repeat
                TempServLineG.Reset;
                TempServLineG.SetRange("Document Type", ServLineL."Document Type");
                TempServLineG.SetRange("Document No.", ServLineL."Document No.");
                // Start EU.0000011
                TempServLineG.SetRange("Service Job No.", ServLineL."Service Job No.");
                // Stop EU.0000011
                TempServLineG.SetRange("No.", ServLineL."Option Code");
                if not TempServLineG.FindFirst then begin
                    TempServLineG.TransferFields(ServLineL);
                    if not PrintPricesG then
                        TempServLineG.Amount := 0;
                    TempServLineG."No." := ServLineL."Option Code";
                    if ServLineL."Service Job No." <> 0 then begin
                        ServJobL.Get(ServLineL."Document Type", ServLineL."Document No.", ServLineL."Service Job No.");
                        if ServJobL.Instruction <> '' then begin
                            TempServLineG.Description := ServJobL.Instruction;
                            TempServLineG."Description 2" := ServJobL.Complaint;
                        end else
                            TempServLineG.Description := ServJobL.Complaint;
                    end else begin
                        ItemL.Get(ServLineL."Option Code");
                        TempServLineG.Description := ItemL.Description;
                    end;
                    // Start EU.0000011
                    OptionLineNoL := OptionLineNoL + 1;
                    TempServLineG."Line No." := OptionLineNoL;
                    // Stop EU.0000011
                    TempServLineG.Insert;
                end else
                    if PrintPricesG then begin
                        TempServLineG.Amount := TempServLineG.Amount + ServLineL.Amount;
                        TempServLineG.Modify;
                        OptSerialNoG := C_INC045 + Format(TempServLineG."Line No.");
                    end;
            until ServLineL.Next = 0;
        TempServLineG.Reset;
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
        if not PrintServOptionG then
            exit;

        if TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Job then begin
            // Start EU.0000011
            if ConsolidatePositionsOfAJobG and (TempServPreviewLineG."Service Job No." <> 0) then begin
                // Stop EU.0000011
                TempServLineG.Reset;
                TempServLineG.SetRange("Document Type", TempServPreviewLineG."Document Type");
                TempServLineG.SetRange("Document No.", TempServPreviewLineG."Document No.");
                TempServLineG.SetRange("Service Job No.", TempServPreviewLineG."Service Job No.");
                if TempServLineG.FindFirst then
                    OptSerialNoG := C_INC045 + Format(TempServLineG."Line No.");
                exit;
            end;
            if (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Job) and
               (TempServPreviewLineG."Service Job No." = 0)
            then
                // Start EU.0000011
                if ConsolidatePositionsOfAPackageG then begin
                    // Stop EU.0000011
                    ServLineL.Reset;
                    ServLineL.SetRange("Document Type", TempServPreviewLineG."Document Type");
                    ServLineL.SetRange("Document No.", TempServPreviewLineG."Document No.");
                    ServLineL.SetRange("Package No.", TempServPreviewLineG."Package No.");
                    // Start EU.0000011
                    if ConsolidatePositionsOfAJobG then
                        ServLineL.SetRange("Service Job No.", 0);
                    // Stop EU.0000011
                    if ServLineL.FindSet then
                        repeat
                            TempServLineG.Reset;
                            TempServLineG.SetRange("Document Type", ServLineL."Document Type");
                            TempServLineG.SetRange("Document No.", ServLineL."Document No.");
                            // Start EU.0000011
                            TempServLineG.SetRange("Service Job No.", ServLineL."Service Job No.");
                            // Stop EU.0000011
                            TempServLineG.SetRange("No.", ServLineL."Option Code");
                            if TempServLineG.FindFirst then begin
                                NoOfPackOptionL := NoOfPackOptionL + 1;
                                if NoOfPackOptionL = 1 then
                                    OptSerialNoG := C_INC045 + Format(TempServLineG."Line No.")
                                else
                                    if NoOfPackOptionL <= 3 then
                                        if StrPos(OptSerialNoG, Format(TempServLineG."Line No.")) = 0 then
                                            OptSerialNoG := OptSerialNoG + ';' + C_INC045 + Format(TempServLineG."Line No.")
                                        else
                                            NoOfPackOptionL := NoOfPackOptionL - 1;
                            end;
                        until ServLineL.Next = 0;
                    exit;
                end;
        end;
        if not ServLineL.Get(TempServPreviewLineG."Document Type",
           TempServPreviewLineG."Document No.",
           TempServPreviewLineG."Document Line No.")
        then
            exit;
        TempServLineG.Reset;
        TempServLineG.SetRange("Document Type", ServLineL."Document Type");
        TempServLineG.SetRange("Document No.", ServLineL."Document No.");
        // Start EU.0000011
        TempServLineG.SetRange("Service Job No.", ServLineL."Service Job No.");
        // Stop EU.0000011
        TempServLineG.SetRange("No.", ServLineL."Option Code");
        if TempServLineG.FindFirst then
            OptSerialNoG := C_INC045 + Format(TempServLineG."Line No.");
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
        VehApptL.SetRange(VIN, "Service Header".VIN);
        VehApptL.SetFilter(Status, '%1|%2|%3', VehApptL.Status::Recurring, VehApptL.Status::New, VehApptL.Status::Prepared);
        if VehApptL.FindSet then
            repeat
                VehApptTypeL.Reset;
                VehApptTypeL.SetRange(Code, VehApptL."Appointment Type");
                if IndexP = 1 then
                    VehApptTypeL.SetRange("Inspection Type", VehApptTypeL."Inspection Type"::"Main Inspection")
                else
                    VehApptTypeL.SetRange("Inspection Type", VehApptTypeL."Inspection Type"::"Emission Inspection");
                if VehApptTypeL.FindFirst then begin
                    VehApptTempL.Init;
                    VehApptTempL.Copy(VehApptL);
                    VehApptTempL.Insert;
                end;
            until VehApptL.Next = 0;

        if not VehApptTempL.IsEmpty then begin
            VehApptTempL.Reset;
            VehApptTempL.SetCurrentKey(VIN, "Next Appointment Date");
            VehApptTempL.SetFilter("Next Appointment Date", '>=%1', DocumentDateP);
            if VehApptTempL.FindFirst then
                NextApptDateR := VehApptTempL."Next Appointment Date";
        end;
        // Stop PA038228
    end;

    local procedure BOMOutputGOnPush()
    begin
        // Start EU.0000011
        if not ConsolidatePositionsOfAPackageG and BOMOutputG then begin
            Message(C_INC017);
            BOMOutputG := false;
            RequestOptionsPage.Update(false);
        end;
        // Stop EU.0000011
    end;

    [Scope('Internal')]
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA034531.18593
        exit(not ShowOutputP);
        // Stop PA034531.18593
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
        ReportSelectionG.Init;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC046;
        UserSessionG.GetRecordRef(RecordRefL);
        if RecordRefL.Number > 0 then begin
            RecordRefL.SetTable(ReportSelectionG);
            if ReportSelectionG."Print Report Title" then
                ReportTitleG := ReportSelectionG."Report Title"
            else begin
                ReportSelectionG.CalcFields("Report Caption");
                ReportTitleG := CopyStr(ReportSelectionG."Report Caption", 1, MaxStrLen(ReportTitleG));
            end;
        end;
        // Stop EU.0000011
        ReportIDTextL := CurrReport.ObjectId(false);
        while StrPos(ReportIDTextL, ' ') > 0 do
            ReportIDTextL := DelStr(ReportIDTextL, 1, StrPos(ReportIDTextL, ' '));
        Evaluate(ReportIDL, ReportIDTextL);
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
        ServHdrL.SetRange(ServHdrL."No.", "Service Header".GetFilter("No."));
        if ServHdrL.FindSet then begin
            if ServHdrL."Sell-to Customer No." <> '' then
                CustL.Get(ServHdrL."Sell-to Customer No.")
            else
                Clear(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
        end;
        // Stop PA043099
    end;

    [Scope('Internal')]
    procedure EvalHidePrintSubtotal(): Boolean
    begin
        // Start EU.0000011
        if not PrintPricesG then
            exit(false);
        if ServPreviewLineG."Line Type" <> ServPreviewLineG."Line Type"::Sum then
            exit(false);
        if PrintFixedPriceG then begin
            if ServPreviewLineG."Control Type" = ServPreviewLineG."Control Type"::Job then
                exit(true);
            exit(ServCustG."Print Service Job Fixed Price" = ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit");
        end;
        exit(true);
        // Stop EU.0000011
    end;

    local procedure SetTitles()
    var
        headerGraphicCount: Integer;
    begin
        // @ This function sets variables to  identify whether and where (not) to print Report title and document No., ... on layout
        // Start SOL.1      01.03.18 PV
        PrintDocTitleAndNoUpG := (ReportLayoutSetupG."Auth. Left Line 1" = '')
                              and (ReportLayoutSetupG."Auth. Left Line 2" = '')
                              and (ReportLayoutSetupG."Auth. Left Line 3" = '')
                              and (ReportLayoutSetupG."Auth. Left Line 4" = '')
                              and (ReportLayoutSetupG."Auth. Left Line 5" = '')
                              and (ReportLayoutSetupG."Auth. Center Line 1" = '')
                              and (ReportLayoutSetupG."Auth. Center Line 2" = '')
                              and (ReportLayoutSetupG."Auth. Center Line 3" = '')
                              and (ReportLayoutSetupG."Auth. Center Line 4" = '')
                              and (ReportLayoutSetupG."Auth. Center Line 5" = '')
                              and (ReportLayoutSetupG."Auth. Right Line 1" = '')
                              and (ReportLayoutSetupG."Auth. Right Line 2" = '')
                              and (ReportLayoutSetupG."Auth. Right Line 3" = '')
                              and (ReportLayoutSetupG."Auth. Right Line 4" = '')
                              and (ReportLayoutSetupG."Auth. Right Line 5" = '');

        //19.7.18: TitleText* variables must remain blank
        //to print Barcode instead of the header column "Auth. Left Line x"
        if PrintBarCodeG then begin
            PrintDocTitleAndNoUpG := false;
            ReportLayoutSetupG."Auth. Left Line 1" := '';
            ReportLayoutSetupG."Auth. Left Line 2" := '';
            ReportLayoutSetupG."Auth. Left Line 3" := '';
            ReportLayoutSetupG."Auth. Left Line 4" := '';
            ReportLayoutSetupG."Auth. Left Line 5" := '';
            Clear(ReportLayoutSetupG."Header Graphic Left");
        end;

        headerGraphicCount := 0;
        if PrintDocTitleAndNoUpG then begin
            if (ReportLayoutSetupG."Header Graphic Left".HasValue) then begin
                headerGraphicCount += 1;
                TitleTextLeftG := '';
                TitleTextCenterG := ReportTitleG;
                TitleTextRightG := "Service Header"."No.";
            end;
            if (ReportLayoutSetupG."Header Graphic Center".HasValue) then begin
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Service Header"."No.";
            end;
            if (ReportLayoutSetupG."Header Graphic Right".HasValue) then begin
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Service Header"."No.";
                TitleTextRightG := '';
            end;
            // Start INCCZ0012 SOL.1.0.5 PV
            if headerGraphicCount = 0 then begin //no Auth* texts, no header graphics
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Service Header"."No.";
            end;
            // Stop INCCZ0012 SOL.1.0.5 PV
        end else begin
            TitleTextLeftG := '';
            TitleTextCenterG := '';
            TitleTextRightG := '';
        end;
        if headerGraphicCount > 1 then
            PrintDocTitleAndNoUpG := false;
        // Stop SOL.1      01.03.18 PV
    end;
}
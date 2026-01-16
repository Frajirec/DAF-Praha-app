report 80034 "DPG Service Quote CZ" // 1057641 "Service Quote CZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                        Moved the VATTextLoop, VATTextLine Dataitem position as last footer.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032651   27.07.11 PR 4262653: Increased width of 'VAT Identifier' control.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA032651   21.03.12 DR 2559014: All incorrect spelling variants of Caption "To-Dos" or "To-Do" corrected.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6226703: Layout Changes for Vat
    // PA033336   10.07.12 RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Logos are not incorporated in RDLC layout due to alignment with the new Report Layout Concept.
    // PA033336   20.07.12 Bugfix
    // PA033336   22.08.12 Layout 1 and Layout 2 Concepts
    //                        - Added a new Text(1101306302) control in the Pageloop Header(2) section to show report title.
    //                        - Pageloop Header (2) Section
    //                          added pictureBox control 1101306301 & 1101306303 with visible property 'No" for Graphic Header Left&Right
    //                        - Pageloop Footer(3) Section
    //                          added pictureBox control 1101306304 & 1101306305 with visible property 'No" for Graphic Footer Left&Right
    //                        - Report Layout Setup Global Variable taken for calculating "Header Graphic Left", "Header Graphic Right",
    //                          "Footer Graphic Left" and "Footer Graphic Right" Logos.
    //                        - "Removed the fourth parameter from "Report selections".GetReportTitle function in PageHeader(2)
    //                          section to display the Report Title based on Conditions.
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm, OnOpenPage, "Service Header - OnAfterGetRecord"
    //                        "PageLoop, Footer (3) - OnPreSection()", "PageLoop, Footer (4) - OnPreSection()"
    // PA033019   23.10.12 DR 8958437: Report Service Quote - Caption: "Quote Date" was written without space
    // PA033336   05.11.12 SS 8719075: Changed the Text Constant C_INC040 to "* = Exchange Part".
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
    // PA034051   30.07.13 MF Changes to print Performed Veh. Appointments.
    //            04.11.13 AN I002281 Code Review.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA036090   11.09.14 GF 28039 RDL layout corrections.
    // PA035395   27.12.13 GD 18593 Fixed FooterLines visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   01.04.14 GF 20761 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA037341   21.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035484.20761
    // PA036549   29.01.15 GN 33245 Print Footer Line option value is copied into the report request form/page
    // PA038228   04.08.15 GN Added Header information.
    //                        Added Footer functionality.
    //                        Added detailed Service information
    // PA038228   21.08.15 GN 43667 Changed Footer functionality
    // PA037047   01.08.15 LR 44215 Wrong filters in the RDLC corrected
    // PA037047   01.08.15 LR 44214 Correct format bugs in RDLC
    // PA040669   23.05.16 GQ 61681 Report layout redesigned, bill-to customer is printed if it is different than sell-to customer
    // PA040669   30.05.16 GQ 61681 Report layout corrections
    // PA040669   01.06.16 GQ 61681 RDLC Layout corrections in order for the report title to be displayed as designed
    // PA040669   02.06.16 GQ 61681 RDLC Layout corrections
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   03.08.16 JS Merge of PA039225.51457.
    // PA041125   09.08.16 GJ 68067 RDLC Layout Modifications
    // PA041366   17.08.16 GS Determine the return status on an Item from Service Line, according to design
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   31.03.17 MS 91657 Provide Service Job Fixed Price functionality
    //            04.04.17 MS 92447 Modification to not print totals in case of service jobs with fixed prices and no service lines assigned
    // PA041187   05.04.17 BL 92840 As both option variables "Print Sent-From Line" and "Print Footer Line" are not used, they were hided on the request page.
    // --- 7.1.6 ---
    // EU.0000011 30.05.17 DR "Job Details Text Block" print enabled.
    //                        - 2 new lines in the RDLC added to print a Title and a Text Block.
    //                        - Use ReportSelectionG.INIT to set the preferred default Boolean values in the report selection.
    //                        - New Parameter "Print Job Detailed Descript." shown in the Report Request Page.
    //                        - Global variables PrintSentFromLineG, PrintFooterLineG and PrintAddrBlockG removed.
    //                        - Use the Report selection table fields for "Print Sent-From Line","Print Footer Line" and "Print Address Block"
    //                          directly as source fields in the Report Request Page.
    //                        - Use CalcBaseOrderConfirmation as a replacement for constant 0 standing for CalcBase::"Order Confirmation".
    //                        - Use Table.FIELDCAPTION(Fieldname) command for all report captions which exists as table fields.
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1.0.2  07.06.18 PV New object created as a copy of Report 5025600 Service Quote
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    //                        Final design of vehicle/contract info part of header
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceQuoteCZ.rdlc';

    Caption = 'Service Quote';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Service Order';
            column(Service_Header_Document_Type; "Document Type")
            {
            }
            column(Service_Header_No_; "No.")
            {
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
                    column(CompanyAddr_3_; CompanyAddrG[3])
                    {
                    }
                    column(CustAddr_4_; CustAddrG[4])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddrG[4])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA040669.61681';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669.61681';
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
                    column(OrderCustAddrLineG; OrderCustAddrLineG)
                    {
                        Description = 'PA040669.61681';
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
                    column(Make_Name; MakeG.Name)
                    {
                    }
                    column(Service_Advisor_; ServAdvisorG)
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(CustAddr_5_; CustAddrG[5])
                    {
                        Description = 'PA040669.61681';
                    }
                    column(CustAddr_6_; CustAddrG[6])
                    {
                        Description = 'PA040669.61681';
                    }
                    column(CustAddr_2_; CustAddrG[2])
                    {
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                    }
                    column(SalesPurch_Name_Control42; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(DataItem23; CollectiveG.TextShowOutput("Service Header".FIELDCAPTION("VAT Registration No."), "Service Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Service_Header___VAT_Registration_No__; "Service Header"."VAT Registration No.")
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
                    column(Service_Header___No__; "Service Header"."No.")
                    {
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
                    column(Service_Header__Mileage; FORMAT("Service Header".Mileage))
                    {
                        Description = 'PA040669.61681';
                    }
                    column(Service_Header___Document_Date_; FORMAT("Service Header"."Document Date"))
                    {
                        Description = 'PA033336,PA033019';
                    }
                    column(Service_Header___Due_Date_; FORMAT("Service Header"."Due Date"))
                    {
                        Description = 'PA040669.61681';
                    }
                    column(Service_Header___Model_Code_; "Service Header"."Model Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___License_No_; "Service Header"."License No.")
                    {
                    }
                    column(Service_Header___Engine_No__; "Service Header"."Engine No.")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___Labor_Type_; "Service Header"."Labor Type")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___Licence_No_; "Service Header"."License No.")
                    {
                    }
                    column(Service_Header___Initial_Registration_; FORMAT("Service Header"."Initial Registration"))
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
                    column(Service_Header___Appointment_Date_; FORMAT("Service Header"."Order Date") + ' / ' + FORMAT("Service Header"."Time of Order"))
                    {
                    }
                    column(Service_Header___Pickup_Date_; FORMAT("Service Header"."Pickup Date") + ' / ' + FORMAT("Service Header"."Pickup Time"))
                    {
                    }
                    column(Service_Header___Order_Limit_; "Service Header"."Order Limit")
                    {
                    }
                    column(Service_Header___Mileage_RunningTime_; FORMAT("Service Header".Mileage) + ' /  ' + FORMAT("Service Header"."Running Time"))
                    {
                    }
                    column(Service_Header___Engine_Code_; "Service Header"."Engine Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header___Serv_Adv_No_Pickup_; "Service Header"."Service Advisor No./Pick-Up")
                    {
                    }
                    column(MainNextAppDate_G; FORMAT(MainNextAppDateG))
                    {
                        Description = 'PA040669.61681';
                    }
                    column(EmissionNextAppDate_G; FORMAT(EmissionNextAppDateG))
                    {
                        Description = 'PA040669.61681';
                    }
                    column(Service_Contract_No; VehicleCustomerG."Contract No.")
                    {
                    }
                    column(Collective_TextShowOutput_C_INC032__PrintAddrBlock_; CollectiveG.TextShowOutput(C_INC032, ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Collective_TextShowOutput_CompanyInfo__Registration_No___PrintAddrBlock_; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(OutputNo; OutputNoG)
                    {
                        Description = 'PA033336';
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
                    column(FooterField43; RDLHideOutput(ReportSelectionG."Print Footer Line" AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'PA035395.18593,EU.0000011';
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
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61681';
                    }
                    column(FooterField44; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61681';
                    }
                    column(PageLbl; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
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
                    column(Service_Header___Initial_Registration_Caption; "Service Header".FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MileageCaption; MileageCaptionLbl)
                    {
                    }
                    column(Service_AdvisorCaption; Service_AdvisorCaptionLbl)
                    {
                    }
                    column(Sales_AdvisorCaption; Sales_AdvisorCaptionLbl)
                    {
                    }
                    column(SalesPurch_NameLbl; SalesPurch_Name_Control42CaptionLbl)
                    {
                    }
                    column(Service_Header___Document_Date_Caption; "Service Header".FIELDCAPTION("Document Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___No__Caption; ServLine2G.FIELDCAPTION("Document No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Engine_Code_Caption; "Service Header".FIELDCAPTION("Engine Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Labor_Type_Caption; "Service Header".FIELDCAPTION("Labor Type"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Engine_No__Caption; "Service Header".FIELDCAPTION("Engine No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header___Model_Code_Caption; "Service Header".FIELDCAPTION("Model Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Payments_toCaption; Payments_toCaptionLbl)
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
                    column(Due_Date_Caption; "Service Header".FIELDCAPTION("Due Date"))
                    {
                        Description = 'PA040669.61681,EU.0000011';
                    }
                    column(OrderLimitCpn; "Service Header".FIELDCAPTION("Order Limit"))
                    {
                        Description = 'EU.0000011';
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
                    column(VehicleCategoryCode_SH; "Service Header"."Vehicle Category Code")
                    {
                    }
                    column(VehicleCategoryCodeCpn_SH; "Service Header".FIELDCAPTION("Vehicle Category Code"))
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
                    column(FuelLevelCaption; FuelLevelCaptionLbl)
                    {
                    }
                    column(Service_Header___Fuel_Level_; "Service Header"."Fuel Level")
                    {
                    }
                    dataitem("Header Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Quote), "Header/Footer" = CONST(Header));
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
                        column(TotalNet; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Service_Preview_Line___Service_Job_No__; ServPreviewLineG."Service Job No.")
                        {
                        }
                        column(Service_Preview_Line__Description____________Service_Preview_Line___Description_2_; ServPreviewLineG.Description + CollectiveG.TextShowOutput(' - ', (ServPreviewLineG.Description > '') AND (ServPreviewLineG."Description 2" > '')) + ServPreviewLineG."Description 2")
                        {
                            Description = 'EU.0000011';
                        }
                        column(VehApptDescriptionG_; VehApptDescriptionG)
                        {
                        }
                        column(Service_Preview_Line__Description__________Service_Preview_Line___Description_2_; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(Service_Preview_Line__Amount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Service_Preview_Line___Line_Type_; ServPreviewLineG."Line Type")
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line__Type; ServPreviewLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(ServCustomer__Print_Fixed_Unit_Price_; ServCustG."Print Fixed Unit Price")
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
                        column(ServCustPrintFixedUnitPriceG; ServCustPrintFixedUnitPriceG)
                        {
                            Description = 'PA033336';
                        }
                        column(Service_Preview_Line__Description; ServPreviewLineG.Description)
                        {
                        }
                        column(FixedPriceLab; FixedPriceLabG)
                        {
                            Description = 'PA033336';
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
                        column(Service_Preview_Line__Amount_Control70; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Service_Preview_Line___No__; ServPreviewLineG."No.")
                        {
                        }
                        column(NoAttributes; NoAttributesG)
                        {
                        }
                        column(Service_Preview_Line___VAT_Identifier_; ServPreviewLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Service_Preview_Line__Amount_Control40; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Service_Preview_Line___Description_2_; ServPreviewLineG."Description 2")
                        {
                        }
                        column(TotalNet_Control125; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
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
                        column(ShowCurrency; ShowCurrencyG)
                        {
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLineG.VATAmountText)
                        {
                        }
                        column(TotalNet_Control88; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalVAT___SumExchTax; TotalVATG - SumExchTaxG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalNet_Control32; TotalNetG)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(VATPerceG; VATPerceG)
                        {
                            Description = 'PA033336';
                        }
                        column(VATText3; VATText4G)
                        {
                        }
                        column(SumExchAmount; SumExchAmountG)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumExchTax; SumExchTaxG)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
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
                        column(No_Caption; ServPreviewLineG.FIELDCAPTION("No."))
                        {
                            Description = 'EU.0000011';
                        }
                        column(DescriptionCaption; ServPreviewLineG.FIELDCAPTION(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(AmountCaption; ServPreviewLineG.FIELDCAPTION(Amount))
                        {
                            Description = 'EU.0000011';
                        }
                        column(VAT_IdentifierCaption; ServPreviewLineG.FIELDCAPTION("VAT Identifier"))
                        {
                            Description = 'PA033042,PA032651,EU.0000011';
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(TotalNet_Control125Caption; TotalNet_Control125CaptionLbl)
                        {
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
                        column(TotalCaption; TotalCaptionLbl)
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
                        column(ServPreviewControlTypeG; ServPreviewControlTypeG)
                        {
                            Description = 'PA041187.91511';
                        }
                        column(VATpercent_SL; ServPreviewLineG."VAT %")
                        {
                        }
                        column(VATpercentCpn_SL; ServPreviewLineG.FIELDCAPTION("VAT %"))
                        {
                        }
                        column(UnitPriceLbl; UnitPriceLbl)
                        {
                        }
                        column(NoLbl; NoLbl)
                        {
                            Description = 'PA032651';
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
                                IF ServLine3G.GET(TempServPreviewLineG."Document Type", TempServPreviewLineG."Document No.",
                                   TempServPreviewLineG."Document Line No.")
                                THEN BEGIN
                                    EUTireInformationG := EUTireSetupL.GetTireInformation(ServLine3G.Type = ServLine3G.Type::Item, ServLine3G."EU Tire Data Code");
                                END;
                                IF EUTireInformationG = '' THEN BEGIN
                                    CurrReport.BREAK;
                                END;
                                // Stop PA033765
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
                                TempServPreviewLineG.FIND('-')
                            ELSE
                                TempServPreviewLineG.NEXT;
                            ServPreviewLineG := TempServPreviewLineG;
                            // Start EU.0000011
                            TextBlockContentG := '';
                            // Start PA022363
                            IF ServPreviewLineG.Type <> ServPreviewLineG.Type::" " THEN BEGIN
                                // Stop EU.0000011
                                CLEAR(ServCustG);
                                FixedPriceLabG := FALSE;
                                // Start PA041187.91657
                                PrintFixedPriceG := FALSE;
                                // Stop PA041187.91657
                                // Start PA022298
                                NoAttributesG := '';
                                // Stop PA022298
                                // Start PA041187.91657
                                IF NOT ServLineL.GET(
                                   TempServPreviewLineG."Document Type",
                                   TempServPreviewLineG."Document No.",
                                   TempServPreviewLineG."Document Line No.")
                                THEN BEGIN
                                    IF ServJobLineL.GET(
                                       TempServPreviewLineG."Document Type",
                                       TempServPreviewLineG."Document No.",
                                       TempServPreviewLineG."Service Job No.")
                                    THEN
                                        IF (ServJobLineL."Fixed Price" <> 0) OR (ServJobLineL."Fixed Price Incl. VAT" <> 0)
                                        THEN
                                            PrintFixedPriceG := TRUE;

                                    IF ServCustG.GET(TempServPreviewLineG."Document Type", TempServPreviewLineG."Document No.", TempServPreviewLineG."Bill-to Customer No.") THEN
                                        ;

                                    // consider possible job fixed price rounding line
                                    IF "Service Header"."Includes Fixed Price" AND NOT ServPreviewLineG."Automatic Surcharge" AND
                                       (ServPreviewLineG.Type = ServPreviewLineG.Type::"G/L Account") AND
                                       (ServSetupG."Serv. Fixed Price G/L Account" <> '') AND
                                       (ServPreviewLineG."No." = ServSetupG."Serv. Fixed Price G/L Account")
                                    THEN BEGIN
                                        VATAmountLineG.INIT;
                                        VATAmountLineG."VAT Identifier" := FORMAT(ServPreviewLineG."VAT %");
                                        VATAmountLineG."Sales Amount" := ServPreviewLineG.Amount;
                                        VATAmountLineG."VAT %" := ServPreviewLineG."VAT %";
                                        VATAmountLineG."Amount Including VAT" := ServPreviewLineG."Amount Including VAT";
                                        VATAmountLineG."VAT Base" := ServPreviewLineG.Amount;
                                        VATAmountLineG.InsertLine();
                                    END;
                                    ServPreviewLineG."No." := '';
                                    CLEAR(ServLineL);
                                END ELSE BEGIN
                                    IF ServCustG.GET("Service Header"."Document Type", "Service Header"."No.", ServLineL."Bill-to Customer No.") THEN
                                        ;

                                    IF (ServLineL.Type = ServLineL.Type::Labor) AND (ServLineL."Fixed Price" <> 0) THEN
                                        FixedPriceLabG := TRUE;
                                    // Start PA041187.91657
                                    IF ServJobLineL.GET(
                                       ServLineL."Document Type",
                                       ServLineL."Document No.",
                                       ServLineL."Service Job No.")
                                    THEN
                                        IF (ServJobLineL."Fixed Price" <> 0) OR (ServJobLineL."Fixed Price Incl. VAT" <> 0) THEN
                                            PrintFixedPriceG := TRUE;

                                    VATAmountLineG.INIT;

                                    IF "Service Header"."Includes Fixed Price" THEN BEGIN
                                        VATAmountLineG."VAT Identifier" := FORMAT(ServPreviewLineG."VAT %");
                                        VATAmountLineG."Sales Amount" := ServPreviewLineG.Amount;
                                        VATAmountLineG."VAT %" := ServPreviewLineG."VAT %";
                                        VATAmountLineG."Amount Including VAT" := ServPreviewLineG."Amount Including VAT";
                                        VATAmountLineG."VAT Base" := ServPreviewLineG.Amount;
                                    END ELSE BEGIN
                                        // Start PA033011.5983155
                                        VATAmountLineG."VAT Identifier" := FORMAT(ServLineL."VAT %");
                                        VATAmountLineG."Sales Amount" := ServLineL.Amount;
                                        // Stop PA033011.5983155
                                        VATAmountLineG."VAT %" := ServLineL."VAT %";
                                        // Start PA032441
                                        // Stop PA032441
                                        VATAmountLineG."Amount Including VAT" := ServLineL."Amount Including VAT";
                                        VATAmountLineG."VAT Base" := ServLineL."VAT Base Amount";
                                    END;
                                    // Stop PA041187.91657
                                    // Start PA032441
                                    // Stop PA032441
                                    VATAmountLineG.InsertLine;
                                    // Start PA022298
                                    SetAttribute(ServLineL, ServPreviewLineG, /*NoAttributesG,*/ TRUE);
                                    // Stop PA022298
                                    // Start PA035597
                                    IF VATAmountLineG."VAT %" <> 0 THEN
                                        VATPerceG := STRSUBSTNO(C_INC044, VATAmountLineG."VAT %")
                                    ELSE
                                        VATPerceG := C_INC045;
                                    // Stop PA035597
                                    // Start PA041187.91657
                                    // Stop PA041187.91657
                                    // Start PA022298
                                END;
                                // Stop PA022298

                                IF ServPreviewLineG."Automatic Surcharge" THEN BEGIN
                                    IF ServPreviewLineG.Amount <> ServPreviewLineG."Amount Including VAT" THEN BEGIN
                                        TaxAmountL := ServPreviewLineG."Amount Including VAT" - ServPreviewLineG.Amount;
                                        TaxRateL := ROUND(((100 * TaxAmountL) / ServPreviewLineG.Amount), 0.01);
                                        VATAmountLineG.INIT;
                                        // Start PA033011.5983155
                                        VATAmountLineG."VAT Identifier" := FORMAT(TaxRateL);
                                        VATAmountLineG."Sales Amount" := ServPreviewLineG.Amount;
                                        // Stop PA033011.5983155
                                        VATAmountLineG."VAT %" := TaxRateL;
                                        // Start PA032441
                                        // Stop PA032441
                                        VATAmountLineG."Amount Including VAT" := ServPreviewLineG."Amount Including VAT";
                                        VATAmountLineG."VAT Base" := ServPreviewLineG.Amount;
                                        VATAmountLineG.InsertLine;
                                    END;
                                END;

                                // Start PA022298
                                IF ServPreviewLineG."Exch. Parts Tax Amount" <> 0 THEN BEGIN
                                    SumExchTaxG := SumExchTaxG + ServPreviewLineG."Exch. Parts Tax Amount";
                                    SumExchAmountG := SumExchAmountG + ServPreviewLineG."Exch. Parts Tax Base";
                                    ExchRateG := ServPreviewLineG."Exch. Parts VAT %";
                                END;
                                // Stop PA022298

                            END;
                            // Stop PA022363
                            // Start PA033042
                            IF ServPreviewLineG."VAT Identifier" <> '' THEN
                                IF NOT VATIdentifierTempG.GET(ServPreviewLineG."VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := ServPreviewLineG."VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042

                            // Start PA035597
                            VATText4G := STRSUBSTNO('%1%2', ExchRateG, C_INC022);

                            IF (((ServPreviewLineG.Type = ServPreviewLineG.Type::Labor) AND
                              ((FixedPriceLabG = FALSE) OR
                              (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity + Price per Unit"))) OR
                              ((ServPreviewLineG.Type = ServPreviewLineG.Type::Labor) AND
                              (FixedPriceLabG) AND
                              (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity Only")) OR
                              ((ServPreviewLineG.Type = ServPreviewLineG.Type::Labor) AND
                              (FixedPriceLabG) AND
                              (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Fixed Price Only")) OR
                              (ServPreviewLineG.Type IN [ServPreviewLineG.Type::Item,
                              ServPreviewLineG.Type::"Ext. Service", ServPreviewLineG.Type::"G/L Account"])) THEN
                                CreateTotals();

                            IF ((ServPreviewLineG."Line Discount Amount" < 0) OR (PrintWithoutDiscG)) AND
                               (NOT ProportinatelyChargingLineG) AND
                               (ServPreviewLineG.Quantity <> 0)
                            THEN BEGIN
                                ServPreviewLineG."Unit Price" := ServPreviewLineG.Amount / ServPreviewLineG.Quantity;
                                ServPreviewLineG."Line Discount %" := 0;
                            END;
                            // Start EU.0000011
                            // Stop EU.0000011
                            ServCustPrintFixedUnitPriceG := ServCustG."Print Fixed Unit Price";
                            // Stop PA035597

                            // Start PA041187.91657
                            ServPreviewControlTypeG := ServPreviewLineG."Control Type";
                            ServCustPrintFixedPriceG := ServCustG."Print Service Job Fixed Price";
                            // Stop PA041187.91657

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
                            END;
                            // Stop EU.0000011
                            // Stop PA034051
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempServPreviewLineG.SETRANGE("Suppress in Order", FALSE);
                            // Start EU.0000011
                            MakeServPreviewG.ShowJob("Service Header", TempServPreviewLineG, MakeServPreviewG.CalcBaseOrderConfirmation(), TRUE);
                            // Stop EU.0000011
                            // Start PA022298
                            IF PrintOnlyOwnPartG THEN BEGIN
                                SetCustomerAmounts();
                            END;
                            // Stop PA022298

                            CLEAR(MakeServPreviewG);

                            VATAmountLineG.DELETEALL;
                            MoreLinesG := TempServPreviewLineG.FINDLAST;

                            TempServPreviewLineG.SETRANGE("Entry No.", 0, TempServPreviewLineG."Entry No.");
                            SETRANGE(Number, 1, TempServPreviewLineG.COUNT);

                            CurrReport.CREATETOTALS(TempServPreviewLineG."Line Discount Amount", TempServPreviewLineG.Amount,
                              TempServPreviewLineG."Amount Including VAT");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrency_Control37; ShowCurrencyG)
                        {
                        }
                        column(TotalNet_Control38; TotalNetG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATText1; VATText2G)
                        {
                        }
                        column(SumExchTax_Control58; SumExchTaxG)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATText2; VATText3G)
                        {
                        }
                        column(SumExchAmount_Control14; SumExchAmountG)
                        {
                            AutoFormatExpression = "Service Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016_Control108; C_INC016)
                        {
                        }
                        column(TotalInclVATText_Control44; TotalInclVATTextG)
                        {
                        }
                        column(TotalGross_Control31; TotalGrossG)
                        {
                            AutoFormatExpression = ServPreviewLineG."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control34; TotalCaptionLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(ContinuedCaption_Control101; ContinuedCaptionLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(ContinuedCaption_Control109; ContinuedCaptionLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                            VATTextG := C_INC001;
                            // Start PA035597
                            VATText2G := STRSUBSTNO('%1%2', VATAmountLineG."VAT %", C_INC001);
                            VATText3G := STRSUBSTNO('%1%2', ExchRateG, C_INC022);
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLineG.COUNT <= 1 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Footer Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Quote), "Header/Footer" = CONST(Footer));
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
                        column(ReturnDaG; ReturnDaG)
                        {
                            Description = 'PA033336';
                        }
                        column(ProportinatelyChargingG; ProportinatelyChargingG)
                        {
                            Description = 'PA033336';
                        }
                        column(ExchangeDaG; ExchangeDaG)
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
                                    LegendTextG := C_INC033
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC033;
                            // Stop PA035597
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC042;
                                IncrG := IncrG + 1;
                                // Stop PA035597
                            end;

                            trigger OnPreDataItem()
                            begin
                                // Start PA033042
                                SETRANGE("VAT Identifier Code", VATIdentifierTempG.Code);
                                SETRANGE("Language Code", VATTextHdrG.GetLanguageCode(VATIdentifierTempG.Code, "Service Header"."Language Code"));
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
                        // Start EU.0000011
                        IF ReportSelectionG."Print Footer Line" THEN
                            // Stop EU.0000011
                            PageLoopFooterG := 1;
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
                        // Start PA033336
                        // Start PA035597
                        OutputNoG := OutputNoG + 1;
                        // Stop PA035597
                    END;
                    CurrReport.PAGENO := 1;
                    // Stop PA033336


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

                    // Start PA022298
                    ProportinatelyChargingG := FALSE;
                    // Stop PA022298
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA023215
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        ServPrintCounterG.RUN("Service Header");
                    // Stop PA032727
                    // Stop PA023215
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA043099
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    // Stop PA043099

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
                ServJobLineL: Record "Service Job Line";
                ServLineL: Record "Service Line";
                IntCustL: Code[20];
                bankAccountL: Record "Bank Account";
            begin
                //Start API.1.0.2  07.06.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1.0.2  07.06.18 PV

                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                // Start EU.0000011
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Make Code", "Location Code",
                // Stop EU.0000011
                  REPORT::"DPG Service Quote CZ"); //API.1.0.2  07.06.18 PV
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN BEGIN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Make Code", "Location Code");
                END;
                // Stop PA035395.18593

                //Start API.1.0.2  07.06.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Service Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName(USERID);
                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                "Service Header".CALCFIELDS("Driver Name");
                //Stop API.1.0.2  07.06.18 PV

                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.")
                ELSE
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();
                IF NOT LocationG.GET("Location Code") THEN
                    CLEAR(LocationG);
                IntCustL := CompanyInfoG."Internal Customer";
                IF LocationG."Internal Customer" <> '' THEN
                    IntCustL := LocationG."Internal Customer";
                IF (LocationG."Ship-to Address Code" <> '') AND
                   (OwnDelivAddressG.GET(IntCustL, LocationG."Ship-to Address Code"))
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
                //   OwnBanksG.GET(IntCustL, LocationG."Bank Code")
                // THEN
                //  BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                // ELSE
                //  BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
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
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE
                    ShowCurrencyG := "Currency Code";
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);
                VehicleFormatAddrG.ServHeaderSellTo(CustAddrG, "Service Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");

                // Start API.1.0.2  07.06.18 PV
                IF NOT PaymentMethodG.GET("Service Header"."Payment Method Code") THEN
                    PaymentMethodG.INIT;
                // Stop API.1.0.2  07.06.18 PV

                PhoneTextG := '';
                IF ("Sell-to Home Phone No." <> '') OR ("Sell-to Home Mobile Phone No." <> '') OR
                   ("Sell-to Phone No." <> '') OR ("Sell-to Mobile Phone No." <> '')
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

                ServLineL.RESET;
                ServLineL.SETRANGE("Document Type", "Service Header"."Document Type");
                ServLineL.SETRANGE("Document No.", "Service Header"."No.");
                ServLineL.SETFILTER("Line Discount %", '>%1', 0);
                IF (ServLineL.COUNT <> 0) AND (NOT PrintWithoutDiscG) THEN
                    DiscTextG := C_INC015
                ELSE
                    DiscTextG := '';

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
                // Start PA040669.61681
                IF "Service Header"."Sell-to Customer No." <> "Service Header"."Bill-to Customer No." THEN BEGIN
                    FormatServAddrG.ServHeaderBillTo(OrderCustAddrG, "Service Header");
                    OrderCustAddrLineG := C_INC008 + FormatServAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';
                // Stop PA040669.61681
                // Start PA041187.92447
                PrintTotalG := TRUE;
                // Stop PA041187.92447
                // Start PA041187.91657
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
                // Stop PA041187.91657
                // Start AH
                IF "Make Code" <> '' THEN
                    MakeG.GET("Make Code")
                ELSE
                    MakeG.INIT;

                IF "Service Advisor No." <> '' THEN BEGIN
                    EmployeeG.GET("Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                END ELSE
                    ServAdvisorG := '';

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                // Start PA041187.91657
                CALCFIELDS("Includes Fixed Price");
                // Stop PA041187.91657
                // Stop AH
                // Start PA024130
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(25) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        IF "Bill-to Customer No." <> '' THEN
                            SegMgntG.LogDocument(
                              InteractionLogL."Document Type"::"Service Quote",
                              "No.",
                              0,
                              0,
                              DATABASE::Customer,
                              "Bill-to Customer No.",
                              "Salesperson Code",
                              '',
                              "Posting Description")
                        ELSE
                            SegMgntG.LogDocument(
                              InteractionLogL."Document Type"::"Service Quote",
                              "No.",
                              0,
                              0,
                              DATABASE::Contact,
                              "Bill-to Contact No.",
                              "Salesperson Code",
                              '',
                              "Posting Description");
                    // Stop PA034256.I000009
                END;
                // Stop PA024130

                // Start PA022298
                ProportinatelyChargingG := FALSE;
                ReturnDaG := FALSE;
                ExchangeDaG := FALSE;
                // Stop PA022298
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
                group("Možnosti")
                {
                    Caption = 'Options';
                    field("No. of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                        Description = 'EU.0000011';
                    }
                    field("Print only Own Part"; PrintOnlyOwnPartG)
                    {
                        Caption = 'Print only Own Part';
                        Description = 'EU.0000011';
                    }
                    field("Print Sent-From Line"; ReportSelectionG."Print Sent-From Line")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Sent-From Line");
                        Description = 'EU.0000011';
                        Visible = false;
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
                        Visible = false;
                    }
                    field("Print Job Detailed Descript."; ReportSelectionG."Print Job Detailed Descript.")
                    {
                        CaptionClass = ReportSelectionG.FIELDCAPTION("Print Job Detailed Descript.");
                        Description = 'EU.0000011';
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
            GetReportSelection();
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
            PrintOnlyOwnPartG := FALSE;
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
        GetReportSelection();
        // Stop EU.0000011
    end;

    trigger OnPostReport()
    begin
        // Start PA029974
        IF NOT CurrReport.PREVIEW THEN
            IF RMSetupG.GET THEN BEGIN
                WindowG.OPEN('#1#################################\\' + C_INC041);
                IF RMSetupG."Create To-Do when Printing" THEN
                    IF ("Service Header"."Document Type" = "Service Header"."Document Type"::Quote) THEN BEGIN
                        ContMgtCreateActivitiesG.SetParameter(TRUE);
                        ContMgtCreateActivitiesG.RUN("Service Header");
                    END;
                WindowG.CLOSE;
            END;
        // Stop PA029974
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        ServSetupG: Record "Service Setup";
        RMSetupG: Record "Marketing Setup";
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
        SalesPurchG: Record "Salesperson/Purchaser";
        ServPreviewLineG: Record "Service Preview Line";
        ServCustG: Record "Service Customer";
        ServLine2G: Record "Service Line" temporary;
        ServLine3G: Record "Service Line";
        TextBlockG: Record "Text Block";
        PaymentTermsG: Record "Payment Terms";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        VehicleCustomerG: Record "Vehicle Customer";
        FormatAddrG: Codeunit "Format Address";
        VehicleFormatAddrG: Codeunit "Veh Format Address";
        CalcServAmtsG: Codeunit "Calculate Serv. Amounts";
        ServPrintCounterG: Codeunit "Serv. Printed";
        MakeServPreviewG: Codeunit "Make Serv. Preview";
        RTCMgmtG: Codeunit "RTC Management";
        ContMgtCreateActivitiesG: Codeunit "Create To-Do -Print Serv.Quote";
        SegMgntG: Codeunit SegManagement;
        CollectiveG: Codeunit "Collection Unit";
        ServManagementG: Codeunit "Service Management";
        UserSessionG: Codeunit "User Session Unit";
        TextBlockContentG: Text;
        ShowCurrencyG: Text[30];
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
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        VATTextG: Text[50];
        NoAttributesG: Text[30];
        DiscTextG: Text[20];
        ReferenceTextG: Text[30];
        ServAdvisorG: Text[50];
        PhoneTextG: Text[150];
        TotalInclVATTextG: Text[50];
        LegendTextG: Text[250];
        VATText2G: Text[50];
        VATText3G: Text[50];
        VATText4G: Text[50];
        VATPerceG: Text[50];
        VATLegendsG: Text[15];
        ReportTitleG: Text[100];
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        OldServJobNoG: Integer;
        IncrG: Integer;
        OutputNoG: Integer;
        PageLoopFooterG: Integer;
        [InDataSet]
        ServCustPrintFixedUnitPriceG: Integer;
        [InDataSet]
        ServCustPrintFixedPriceG: Integer;
        ServPreviewControlTypeG: Integer;
        ExchRateG: Decimal;
        TotalGrossG: Decimal;
        TotalVATG: Decimal;
        TotalNetG: Decimal;
        SumLaborG: Decimal;
        SumItemG: Decimal;
        SumExchAmountG: Decimal;
        SumExchTaxG: Decimal;
        C_INC001: Label '% VAT of';
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        SumExtServG: Decimal;
        SumOtherG: Decimal;
        FixedPriceLabG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC010: Label 'Phone:';
        C_INC011: Label 'Private';
        C_INC012: Label 'Mobile';
        C_INC013: Label 'Bus.';
        C_INC014: Label 'Mobile';
        C_INC015: Label 'Disc. %';
        C_INC016: Label '*';
        MoreLinesG: Boolean;
        PrintWithoutDiscG: Boolean;
        C_INC022: Label '% Exch. Tax from';
        C_INC029: Label 'Copy of ';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Tax No.';
        ProportinatelyChargingG: Boolean;
        ProportinatelyChargingLineG: Boolean;
        C_INC033: Label 'P = Proportionately Charged';
        PrintOnlyOwnPartG: Boolean;
        LogInteractionG: Boolean;
        C_INC039: Label 'R =Return-mandatory part';
        C_INC040: Label '* = Exchange Part';
        ReturnDaG: Boolean;
        ExchangeDaG: Boolean;
        C_INC041: Label 'Automatic creation of To-Dos...';
        IsRepSelectionSetupAvailableG: Boolean;
        [InDataSet]
        PrintFixedPriceG: Boolean;
        PrintTotalG: Boolean;
        WindowG: Dialog;
        C_INC042: Label ' =';
        C_INC043: Label 'Service Quote';
        C_INC044: Label '%1% VAT of';
        C_INC045: Label 'VAT Amount';
        EUTireInformationG: Text[1024];
        [InDataSet]
        VehApptDescriptionG: Text[50];
        C_INC046: Label '/';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        MileageCaptionLbl: Label 'Mileage / Running Time';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_Name_Control42CaptionLbl: Label 'Salesperson';
        Payments_toCaptionLbl: Label 'Payments to:';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        ContinuedCaptionLbl: Label 'Continued';
        TotalNet_Control125CaptionLbl: Label 'Sum carried forward';
        SumLaborCaptionLbl: Label 'Sum Labor';
        SumItemCaptionLbl: Label 'Sum Item';
        SumExtServCaptionLbl: Label 'Sum External Services';
        SumOtherCaptionLbl: Label 'Sum Other';
        TotalCaptionLbl: Label 'Total';
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
        OrderCustAddrLineG: Text[250];
        OrderCustAddrG: array[8] of Text[100];
        FormatServAddrG: Codeunit "Veh Format Address";
        VehicleG: Record Vehicle;
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
        FuelLevelCaptionLbl: Label 'Fuel Level';

    [Scope('Internal')]
    procedure CreateTotals()
    begin
        WITH ServPreviewLineG DO BEGIN
            CASE Type OF
                Type::Item:
                    SumItemG := SumItemG + Amount;
                Type::"Ext. Service":
                    IF ServSetupG."Output Ext. Service" THEN
                        SumExtServG := SumExtServG + Amount
                    ELSE
                        SumLaborG := SumLaborG + Amount;
                Type::Labor:
                    SumLaborG := SumLaborG + Amount;
                ELSE
                    SumOtherG := SumOtherG + Amount;
            END;
            TotalNetG := TotalNetG + Amount;
            TotalGrossG := TotalGrossG + "Amount Including VAT";
            TotalVATG := TotalVATG + ("Amount Including VAT" - Amount);
        END;
    end;

    [Scope('Internal')]
    procedure SetCustomerAmounts()
    var
        TempServPreviewLineL: Record "Service Preview Line" temporary;
        FromPreviewLineL: Integer;
        ToPreviewLineL: Integer;
    begin
        // Start PA022298
        TempServPreviewLineL.DELETEALL();
        MakeServPreviewG.ShowCustomer("Service Header", TempServPreviewLineL, 2, TRUE);

        TempServPreviewLineG.RESET;
        IF TempServPreviewLineG.FIND('-') THEN BEGIN
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
        IF TempServPreviewLineL.FIND('-') THEN BEGIN
            FromPreviewLineL := TempServPreviewLineL."Entry No.";
            TempServPreviewLineL.SETRANGE("Bill-to Customer No.");
            TempServPreviewLineL.SETFILTER("Entry No.", '>%1', FromPreviewLineL);
            TempServPreviewLineL.SETRANGE("Line Type", TempServPreviewLineL."Line Type"::Total);
            IF TempServPreviewLineL.FIND('-') THEN BEGIN
                ToPreviewLineL := TempServPreviewLineL."Entry No.";
            END;
            TempServPreviewLineL.RESET;
            IF ToPreviewLineL <> 0 THEN BEGIN
                TempServPreviewLineL.SETFILTER("Entry No.", '%1..%2', FromPreviewLineL, ToPreviewLineL);
            END ELSE BEGIN
                TempServPreviewLineL.SETFILTER("Entry No.", '>=%1', FromPreviewLineL);
            END;
            IF TempServPreviewLineL.FIND('-') THEN BEGIN
                REPEAT
                    TempServPreviewLineG.RESET;
                    IF TempServPreviewLineL.Type = TempServPreviewLineL.Type::" " THEN BEGIN
                        TempServPreviewLineG.SETRANGE("Line Type", TempServPreviewLineL."Line Type");
                        TempServPreviewLineG.SETRANGE(Description, TempServPreviewLineL.Description);
                        IF TempServPreviewLineG.FIND('-') THEN BEGIN
                            TempServPreviewLineG."Unit Price" := TempServPreviewLineG."Unit Price" + TempServPreviewLineL."Unit Price";
                            TempServPreviewLineG."Line Discount %" := TempServPreviewLineG."Line Discount %" + TempServPreviewLineL.
                              "Line Discount %";
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
                            TempServPreviewLineG.MODIFY;
                        END;
                    END ELSE BEGIN
                        TempServPreviewLineG.SETRANGE("Document Line No.", TempServPreviewLineL."Document Line No.");
                        TempServPreviewLineG.SETRANGE(Type, TempServPreviewLineL.Type);
                        TempServPreviewLineG.SETRANGE("No.", TempServPreviewLineL."No.");
                        IF TempServPreviewLineG.FIND('-') THEN BEGIN
                            TempServPreviewLineG."Unit Price" := TempServPreviewLineG."Unit Price" + TempServPreviewLineL."Unit Price";
                            TempServPreviewLineG."Line Discount %" := TempServPreviewLineG."Line Discount %" + TempServPreviewLineL.
                              "Line Discount %";
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
                            TempServPreviewLineG.MODIFY;
                        END;
                    END;
                UNTIL TempServPreviewLineL.NEXT = 0;
            END;
        END;
        TempServPreviewLineG.RESET;
        // Stop PA022298
    end;

    [Scope('Internal')]
    procedure SetAttribute(ServLineP: Record "Service Line"; var CurServPreviewLineL: Record "Service Preview Line"; /*var LinePropertyL: Text[10];*/ TotalFairDealL: Boolean)
    var
        ServLineCustL: Record "Service Line Customer";
        ItemL: Record Item;
    begin
        NoAttributesG := '';
        IF ServLineP."VAT Calculation Type" = ServLineP."VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
            NoAttributesG := C_INC016;
            ExchangeDaG := TRUE;
        END;

        // Start PA022298
        ProportinatelyChargingLineG := FALSE;
        ServLineCustL.RESET;
        ServLineCustL.SETRANGE("Document Type", "Service Header"."Document Type");
        ServLineCustL.SETRANGE("Document No.", "Service Header"."No.");
        ServLineCustL.SETRANGE("Document Line No.", ServLineP."Line No.");
        ServLineCustL.SETRANGE("Bill-to Customer No.", "Service Header"."Bill-to Customer No.");
        IF ServLineCustL.FIND('-') THEN BEGIN
            IF ServLineCustL."Portion %" <> 100 THEN BEGIN
                IF STRPOS(NoAttributesG, COPYSTR(C_INC033, 1, 1)) = 0 THEN
                    NoAttributesG := NoAttributesG + COPYSTR(C_INC033, 1, 1);
                ProportinatelyChargingG := TRUE;
                ProportinatelyChargingLineG := TRUE;
            END;
        END ELSE BEGIN
            IF STRPOS(NoAttributesG, COPYSTR(C_INC033, 1, 1)) = 0 THEN
                NoAttributesG := NoAttributesG + COPYSTR(C_INC033, 1, 1);
            ProportinatelyChargingG := TRUE;
            ProportinatelyChargingLineG := TRUE;
        END;
        IF ProportinatelyChargingLineG THEN BEGIN
            ServPreviewLineG."Unit Price" := 0;
            ServPreviewLineG."Line Discount %" := 0;
        END;

        // Flag for return part = R
        // Start PA041366
        IF ServLineP.Type = ServLineP.Type::Item THEN BEGIN
            IF ServLineP."Sending Required" IN [ServLineP."Sending Required"::Keep, ServLineP."Sending Required"::Send] THEN BEGIN
                IF STRPOS(NoAttributesG, COPYSTR(C_INC039, 1, 1)) = 0 THEN
                    NoAttributesG := NoAttributesG + COPYSTR(C_INC039, 1, 1);
                ReturnDaG := TRUE;
            END;
        END;
        // Stop PA041366
        // Stop PA022298
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
        VehApptL.SETFILTER(Status, '%1|%2|%3', VehApptL.Status::Recurring,
          VehApptL.Status::New,
          VehApptL.Status::Prepared);
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
        // Start EU.0000011
        ReportSelectionG.INIT;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC043;
        UserSessionG.GetRecordRef(RecordRefL);
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


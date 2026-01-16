report 80032 "DPG Service-Job/Pack. Cr. Memo" // 1057614 "Service - Job/Pack. Cr.Memo CZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA032178   31.12.10 PR 2305501: Changes made to print original/duplicate invoices.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   28.03.12 GB 6570305: Add functionality for Rem. Amount from Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033334   04.09.12 DR DEU Captions added N.6.1.2
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033890   08.02.13 TS I000517: RDLC Layout Created, New functions to facilitate RDLC transformation
    //                        RDLHideOutput, RDLHideOutputAsInteger, ShowOutputPrintPosBody11, ShowOutputPrintPosBody12,
    //                        ShowOutputPrintPosBody13, BOMOutputGOnPush ,CasePrintPosition.
    //                        Request Page created.OnPostSection Trigger Code reengineered.Report Layout 1,2,3.
    // PA033890   19.03.13 TS I000622: Bugfixes for Text Length issues for Custom Report Title.
    // PA034175   05.04.13 GX Invoice Explanations are only written if the the value of the
    //                        Portion % field in (Archived) Service Line Customer is <> 100 and
    //                        an actual record exists
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA035597   09.04.14 GF NAV 2013 R2 Technical Upgrade
    //                     GL Remove PDf functionality
    // PA035395   27.12.13 GD 18593 Fixed Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   01.04.14 GF 20866 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   15.01.15 GK 32459 RDLC Layout Corrections
    //                        - Page Number Alignment fixed
    //                        - incadeaSetData textbox moved to Body to fix Header Images visibility issue.
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035484.20866
    // PA037665   12.05.15 GI Added VAT Clause section.
    // PA037665   18.05.15 GI 37719 Literal VAT added in front of VAT value in the VAT Clause section.
    // PA038228   07.08.15 GN Added Header information.
    //                        Added detailed Service information
    // PA038228   24.08.15 GN 43672 Changed Footer Functionality
    // PA038218   16.09.15 KR 44716 created a funtions JobWiseTotals to calculate the totals for Job when "Consolidate Positions of a Job" selected.
    //                        - Modified code in MakeLines to correct the report display based on the selected option
    // PA038218   16.09.15 KR 45320 Modified code in function MakeLines to correct the VAT calculation.
    // PA040669   27.05.16 GV 61817 RDLC layout modifications
    //                        Move code to get the correct values MainNextAppDateG & EmissionNextAppDateG
    // PA040669   30.05.16 GQ 61817 Changed text constant C_INC018 value
    // PA040669   30.05.16 GQ 61817 RDLC corrections
    // PA040669   01.06.16 GV 61817 RDLC corrections, Rename value of Copy text constant
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA041125   16.08.16 GJ 68109 RDLC Layout modifications.
    // PA041366   17.08.16 GS Determine the return status on an Item from Service Line or Sales Credit Memo Line, according to design
    // PA041366   24.11.16 GQ 81144 Modified calculation of return items to be always executed
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   30.03.17 GD 91650 "Print Service Job Fixed Price" functionality added.
    // PA041187   03.04.17 GD 91743 Changed Column Visibility RDLC variable names.
    // PA041187   05.04.17 GD 92891 Correction in PrintPosition-OnPreDataitem() to reset filters for TempServPreviewLine2G.
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
    // EU.0000011 09.06.17 MS Complete re-structure of Service Preview Line creation and Consolidation options:
    //                        - MakeLines() former function removed and replaced by new centralized functions which handle the lines creation and consolidation options
    //                        - New Labor Consolidation option
    //                        - VAT Amount Line temporal creation removed and replaced by the centralized function
    //                        - CreateTotals() former function removed and replaced by a new centralized function
    //                        - Fair Deal and Exchange parts calculation in totals has been centralized.
    //                        - PackageBOM1 and PackageBOM2 DataItems removed and replaced by PackageBOM DataItem based on temporal records calculated on the centralized function
    //                        - Additional RDLC small changes; cleanup/renaming of some columns to improve readability
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5025625 Service - Job/Pack. Cr. Memo
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed, translation
    //                        Final design of vehicle/contract info part of header
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, Bank source, Final header design
    //                        SK legislation,
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceJobPackCrMemo.rdlc';

    Caption = 'Service Credit Memo';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Credit Memo Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Order Type" = CONST(Service));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Service Order';
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            column(Sales_Cr_Memo_Header_Cash_Register_Receipt; "Cash Register Receipt")
            {
            }
            column(AppliesToDocNo_SCH; "Sales Cr.Memo Header"."Applies-to Doc. No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoop_Number; CopyLoop.Number)
                {
                }
                column(HeaderGraphicRight; ReportLayoutSetupG."Header Graphic Right")
                {
                }
                column(HeaderGraphicRightHasValue; RDLHideOutput(ReportLayoutSetupG."Header Graphic Right".HASVALUE))
                {
                }
                column(HeaderGraphicLeftHasValue; RDLHideOutput(ReportLayoutSetupG."Header Graphic Left".HASVALUE))
                {
                }
                column(HeaderGraphicLeft; ReportLayoutSetupG."Header Graphic Left")
                {
                }
                column(DuplicateGraphic; ReportLayoutSetupG."Duplicate Graphic")
                {
                }
                column(DuplicateGraphicHasValue; RDLHideOutput(NOT ReportLayoutSetupG."Duplicate Graphic".HASVALUE))
                {
                    Description = 'PA035395.18593';
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CustAddrG1; CustAddrG[1])
                    {
                    }
                    column(CustAddrG2; CustAddrG[2])
                    {
                        Description = 'PA040669.61817';
                    }
                    column(CustAddrG3; CustAddrG[3])
                    {
                    }
                    column(CustAddrG4; CustAddrG[4])
                    {
                    }
                    column(CustAddrG5; CustAddrG[5])
                    {
                    }
                    column(CustAddrG6; CustAddrG[6])
                    {
                        Description = 'PA040669.61817';
                    }
                    column(CustAddrG7; CustAddrG[7])
                    {
                        Description = 'PA040669.61817';
                    }
                    column(CustAddrG8; CustAddrG[8])
                    {
                        Description = 'PA040669.61817';
                    }
                    column(DocumentDate_SCH; "Sales Cr.Memo Header"."Document Date")
                    {
                    }
                    column(No_SCH; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(ServiceOrderNo_SCH; "Sales Cr.Memo Header"."Service Order No.")
                    {
                    }
                    column(CompAddrG; CompAddrG)
                    {
                    }
                    column(OrderDate_SCH; ServHdrG."Order Date")
                    {
                    }
                    column(PageNo_currRep; FORMAT(CurrReport.PAGENO))
                    {
                    }
                    column(No_CustG; CustG."No.")
                    {
                    }
                    column(OrderCustAddrLineG; OrderCustAddrLineG)
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
                        Description = 'PA040669.61817';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669.61817';
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
                    column(LicenceNo_ServH; ServHdrG."License No.")
                    {
                    }
                    column(Name_Make; MakeG.Name)
                    {
                    }
                    column(Model_ServH; ServHdrG.Model)
                    {
                    }
                    column(VIN_ServH; ServHdrG.VIN)
                    {
                    }
                    column(InitialRegistration_ServH; FORMAT(ServHdrG."Initial Registration"))
                    {
                    }
                    column(Mileage_ServH; ServHdrG.Mileage)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(ServAdvisorG; ServAdvisorG)
                    {
                    }
                    column(Name_SalPurch; SalesPurchG.Name)
                    {
                    }
                    column(ReasonCode_SCH; "Sales Cr.Memo Header"."Reason Code")
                    {
                    }
                    column(CopyTextG; CopyTextG)
                    {
                    }
                    column(VATRegCpn_SCH_Coll; CollectiveG.TextShowOutput("Sales Cr.Memo Header".FIELDCAPTION("VAT Registration No."), "Sales Cr.Memo Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(VATRegistration_SCH; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(VATRegCpn_Comp_Coll; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(VATRegistration_Comp_Coll; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(TaxNoCpn_Coll; CollectiveG.TextShowOutput(C_INC_TaxNo, ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(RegistrationNo_Comp_Coll; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(ServHdrG_No; ServHdrG."No.")
                    {
                    }
                    column(ArchServHdrG_No; ArchServHdrG."No.")
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA032178';
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvG))
                    {
                    }
                    column(NoPrinted_; RDLHideOutput("Sales Cr.Memo Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(HdrInfo2; ServHdrG."Make Code")
                    {
                    }
                    column(HdrInfo4; ServHdrG.Model)
                    {
                    }
                    column(HdrInfo6; ServHdrG."Vehicle Category Code")
                    {
                    }
                    column(HdrInfo8; ServHdrG.VIN)
                    {
                    }
                    column(HdrInfo10; ServHdrG."License No.")
                    {
                    }
                    column(HdrInfo12; FORMAT(ServHdrG."Initial Registration"))
                    {
                        Description = 'PA040669.61817';
                    }
                    column(HdrInfo14; FORMAT(ServHdrG.Mileage) + ' /  ' + FORMAT(ServHdrG."Running Time"))
                    {
                    }
                    column(HdrInfo16; ServHdrG."Driver Name")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(HdrInfo18; "Sales Cr.Memo Header"."Your Reference")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(HdrInfo20; ServHdrG."Fuel Level")
                    {
                    }
                    column(HdrInfo22; ServAdvisorG)
                    {
                    }
                    column(HdrInfo24; VehicleCustomerG."Contract No.")
                    {
                    }
                    column(HdrInfo26; FORMAT(ServHdrG."Order Date") + ' / ' + FORMAT(ServHdrG."Time of Order"))
                    {
                    }
                    column(HdrInfo28; ServHdrG."Pickup DateTime")
                    {
                    }
                    column(HdrInfo30; ServHdrG."Order Limit")
                    {
                        Description = 'PA028449';
                    }
                    column(BankTextG; BankTextG)
                    {
                    }
                    column(PrintFooterLine_RS; RDLHideOutput(ReportSelectionG."Print Footer Line"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(PrintFooterLineAndNotIsRepSelectionSetupAvailableG; RDLHideOutput(ReportSelectionG."Print Footer Line" AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'PA035395.18593,EU.0000011';
                    }
                    column(Footer38; ReportLayoutSetupG."Footer 6-6")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer25; ReportLayoutSetupG."Footer 5-4")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer26; ReportLayoutSetupG."Footer 6-4")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer31; ReportLayoutSetupG."Footer 5-5")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer32; ReportLayoutSetupG."Footer 6-5")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer37; ReportLayoutSetupG."Footer 5-6")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer16; ReportLayoutSetupG."Footer 2-3")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer17; ReportLayoutSetupG."Footer 3-3")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer18; ReportLayoutSetupG."Footer 4-3")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer19; ReportLayoutSetupG."Footer 5-3")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer20; ReportLayoutSetupG."Footer 6-3")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer22; ReportLayoutSetupG."Footer 2-4")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer23; ReportLayoutSetupG."Footer 3-4")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer24; ReportLayoutSetupG."Footer 4-4")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer28; ReportLayoutSetupG."Footer 2-5")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer29; ReportLayoutSetupG."Footer 3-5")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer30; ReportLayoutSetupG."Footer 4-5")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer34; ReportLayoutSetupG."Footer 2-6")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer35; ReportLayoutSetupG."Footer 3-6")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer36; ReportLayoutSetupG."Footer 4-6")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer14; ReportLayoutSetupG."Footer 6-2")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer13; ReportLayoutSetupG."Footer 5-2")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer12; ReportLayoutSetupG."Footer 4-2")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer11; ReportLayoutSetupG."Footer 3-2")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer10; ReportLayoutSetupG."Footer 2-2")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer09; ReportLayoutSetupG."Footer 1-2")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer15; ReportLayoutSetupG."Footer 1-3")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer21; ReportLayoutSetupG."Footer 1-4")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer27; ReportLayoutSetupG."Footer 1-5")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer33; ReportLayoutSetupG."Footer 1-6")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer03; ReportLayoutSetupG."Footer 1-1")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer04; ReportLayoutSetupG."Footer 2-1")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer05; ReportLayoutSetupG."Footer 3-1")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer06; ReportLayoutSetupG."Footer 4-1")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer07; ReportLayoutSetupG."Footer 5-1")
                    {
                        Description = 'PA033052';
                    }
                    column(Footer08; ReportLayoutSetupG."Footer 6-1")
                    {
                        Description = 'PA033052';
                    }
                    column(sep1; FORMAT('-----------------------------------------------------------------------------------------'))
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61817';
                    }
                    column(FooterGraphicRightHasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Right".HASVALUE))
                    {
                    }
                    column(FooterGraphicLeftHasValue; RDLHideOutput(ReportLayoutSetupG."Footer Graphic Left".HASVALUE))
                    {
                    }
                    column(FooterGraphicRight; ReportLayoutSetupG."Footer Graphic Right")
                    {
                    }
                    column(FooterGraphicLeft; ReportLayoutSetupG."Footer Graphic Left")
                    {
                    }
                    column(IsRepSelectionSetupAvailableG; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(DocumentNoCpn_ArServL; ArchServLineG.FIELDCAPTION("Document No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(DocumentDateCpn_ArServH; ArchServHdrG.FIELDCAPTION("Document Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(AppliedToCpn; Header39Lbl)
                    {
                    }
                    column(PageCpn; Header43Lbl)
                    {
                    }
                    column(CustNoLbl; Header29Lbl)
                    {
                    }
                    column(LicenceNoCpn_ServH; ServHdrG.FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MakeCpn; Header45Lbl)
                    {
                    }
                    column(ModelDescrCpn; Header49Lbl)
                    {
                    }
                    column(VINCpn_ServH; ServHdrG.FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(InitialRegistrationCpn_ServH; ServHdrG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Mileage_ArServH; ArchServHdrG.FIELDCAPTION(Mileage))
                    {
                        Description = 'EU.0000011';
                    }
                    column(ServiceAdvisorCpn; Service_AdvisorCaptionLbl)
                    {
                        Description = 'EU.0000011';
                    }
                    column(SalesAdvisorCPn; Sales_AdvisorCaptionLbl)
                    {
                        Description = 'EU.0000011';
                    }
                    column(ReasonCode_ArServH; ArchServHdrG.FIELDCAPTION("Reason Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(ServiceOrderNoCpn; Sales_Invoice_Header___Service_Order_No__CaptionLbl)
                    {
                        Description = 'EU.0000011';
                    }
                    column(OrderDateCpn_ArServH; ArchServHdrG.FIELDCAPTION("Order Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Footer01; Footer01Lbl)
                    {
                    }
                    column(HdrInfo1; ArchServHdrG.FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo3; ArchServHdrG.FIELDCAPTION(Model))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo5; ArchServHdrG.FIELDCAPTION("Vehicle Category Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo7; ServHdrG.FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo9; ServHdrG.FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo11; ServHdrG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo13; MileageCaptionLbl)
                    {
                    }
                    column(HdrInfo15; ServHdrG.FIELDCAPTION("Driver Name"))
                    {
                    }
                    column(HdrInfo17; "Sales Cr.Memo Header".FIELDCAPTION("Your Reference"))
                    {
                    }
                    column(HdrInfo19; ServHdrG.FIELDCAPTION("Fuel Level"))
                    {
                    }
                    column(HdrInfo21; Service_AdvisorCaptionLbl)
                    {
                    }
                    column(HdrInfo23; Service_ContractLbl)
                    {
                    }
                    column(HdrInfo25; Appointment_DateLbl)
                    {
                    }
                    column(HdrInfo27; ServHdrG.FIELDCAPTION("Pickup DateTime"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo29; ArchServHdrG.FIELDCAPTION("Order Limit"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(BankName; BankNameG)
                    {
                    }
                    column(BankBranchNo; BankBranchNoG)
                    {
                    }
                    column(BankSwift; BankSwiftG)
                    {
                    }
                    column(BankIban; BankIbanG)
                    {
                    }
                    column(BankAccountNo; BankAccountNoG)
                    {
                    }
                    column(PaymentMethodCode_SCH; "Sales Cr.Memo Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SCH; "Sales Cr.Memo Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SCH; "Sales Cr.Memo Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SCH; "Sales Cr.Memo Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SCH; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SCH; "Sales Cr.Memo Header"."Tax Registration No.")
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
                    column(DueDateCpn_SCH; "Sales Cr.Memo Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SCH; "Sales Cr.Memo Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SCH; "Sales Cr.Memo Header".FIELDCAPTION("Variable Symbol"))
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
                    column(DateOfIssueLbl; DateOfIssueLbl)
                    {
                    }
                    column(PostingDate_SCH; "Sales Cr.Memo Header"."Posting Date")
                    {
                    }
                    column(DueDate_SCH; "Sales Cr.Memo Header"."Due Date")
                    {
                    }
                    column(ShipToAddrG1; ShipToAddrG[1])
                    {
                    }
                    column(ShipToAddrG2; ShipToAddrG[2])
                    {
                    }
                    column(ShipToAddrG3; ShipToAddrG[3])
                    {
                    }
                    column(ShipToAddrG4; ShipToAddrG[4])
                    {
                    }
                    column(ShipToAddrG5; ShipToAddrG[5])
                    {
                    }
                    column(ShipToAddrG6; ShipToAddrG[6])
                    {
                    }
                    column(ShipToAddrG7; ShipToAddrG[7])
                    {
                    }
                    column(ShipToAddrG8; ShipToAddrG[8])
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
                    column(Description_ReasonCode; ReasonCodeG.Description)
                    {
                    }
                    column(OrderNoG; OrderNoG)
                    {
                    }
                    column(OrderNoLbl; OrderNoLbl)
                    {
                    }
                    column(SalesPurch_NameLbl; SalesPurch_NameLbl)
                    {
                    }
                    dataitem("Header Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Header));
                        column(HeaderTextBody1_Text; Text)
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
                        column(PrintPosition_DiscCaption; DiscTextG)
                        {
                        }
                        column(HidePrintPositionHeader2; RDLHideOutputAsInteger(2))
                        {
                        }
                        column(PrintPositionNumber; PrintPosition.Number)
                        {
                        }
                        column(TotalNetG; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionBody4_ServPreviewLineGDescription_ServPreviewLineGDescription2; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(PrintPositionBody4_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintJobHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) AND (ServPreviewLineG."Service Job No." <> 0)))
                        {
                            Description = 'PA038218.44716,EU.0000011';
                        }
                        column(PrintPositionBody5_ServPreviewLineGDescription_ServPreviewLineGDescription2; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(PrintPositionBody5_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintSubtotal; RDLHideOutput(EvalHidePrintSubtotal()))
                        {
                            Description = 'PA041187.91650';
                        }
                        column(PrintPositionBody6_ServPreviewLineGServiceJobNo; ServPreviewLineG."Service Job No.")
                        {
                        }
                        column(PrintPositionBody6_ServPreviewLineGDescription_ServPreviewLineGDescription2; ServPreviewLineG.Description + CollectiveG.TextShowOutput(' - ', (ServPreviewLineG.Description > '') AND (ServPreviewLineG."Description 2" > '')) + ServPreviewLineG."Description 2")
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionBody6_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionBody7_ServPreviewLineGPackageNo; ServPreviewLineG."Package No.")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(PrintPositionBody7_ServPreviewLineGDescription_ServPreviewLineGDescription2; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(PrintPositionBody7_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintPackageHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) AND (ServPreviewLineG."Package No." <> '')))
                        {
                            Description = 'PA038218.44716,EU.0000011';
                        }
                        column(PrintPositionBody8_ServPreviewLineGDescription; ServPreviewLineG.Description)
                        {
                        }
                        column(HidePrintPosBody8; RDLHideOutput(ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Text))
                        {
                        }
                        column(PrintPositionBody9_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionBody9_ServPreviewLineGLineDiscount; ServPreviewLineG."Line Discount %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(PrintPositionBody9_ServPreviewLineGUnitPrice; ServPreviewLineG."Unit Price")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 2;
                        }
                        column(PrintPositionBody9_ServPreviewLineGUnitofMeasure; ServPreviewLineG."Unit of Measure")
                        {
                        }
                        column(PrintPositionBody9_ServPreviewLineGQuantity; ServPreviewLineG.Quantity)
                        {
                        }
                        column(PrintPositionBody9_ServPreviewLineGDescription; ServPreviewLineG.Description)
                        {
                        }
                        column(PrintPositionBody9_NoTextG; NoTextG)
                        {
                        }
                        column(PrintPositionBody9_NoPropertyG; NoPropertyG)
                        {
                        }
                        column(HidePrintGLAccount; RDLHideOutput((ServPreviewLineG.Type = ServPreviewLineG.Type::"G/L Account") AND (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line)))
                        {
                            Description = 'PA038218.44716,EU.0000011';
                        }
                        column(PrintPositionBody10_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionBody10_ServPreviewLineGUnitPrice; ServPreviewLineG."Unit Price")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 2;
                        }
                        column(PrintPositionBody10_ServPreviewLineGLineDiscount; ServPreviewLineG."Line Discount %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(PrintPositionBody10_ServPreviewLineGUnitofMeasure; ServPreviewLineG."Unit of Measure")
                        {
                        }
                        column(PrintPositionBody10_ServPreviewLineGDescription; ServPreviewLineG.Description)
                        {
                        }
                        column(PrintPositionBody10_ServPreviewLineGQuantity; ServPreviewLineG.Quantity)
                        {
                        }
                        column(PrintPositionBody10_NoTextG; NoTextG)
                        {
                        }
                        column(PrintPositionBody10_NoPropertyG; NoPropertyG)
                        {
                        }
                        column(HidePrintItemOrExtService; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line) AND ((ServPreviewLineG.Type = ServPreviewLineG.Type::Item) OR (ServPreviewLineG.Type = ServPreviewLineG.Type::"Ext. Service"))))
                        {
                            Description = 'PA038218.45320,EU.0000011';
                        }
                        column(PrintPositionBody11_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionBody11_ServPreviewLineGUnitPrice; ServPreviewLineG."Unit Price")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 2;
                        }
                        column(PrintPositionBody11_ServPreviewLineGLineDiscount; ServPreviewLineG."Line Discount %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(PrintPositionBody11_ServPreviewLineGUnitofMeasure; ServPreviewLineG."Unit of Measure")
                        {
                        }
                        column(PrintPositionBody11_ServPreviewLineGQuantity; ServPreviewLineG.Quantity)
                        {
                        }
                        column(PrintPositionBody11_ServPreviewLineGDescription; ServPreviewLineG.Description)
                        {
                        }
                        column(PrintPositionBody11_NoTextG; NoTextG)
                        {
                        }
                        column(PrintPositionBody11_NoPropertyG; NoPropertyG)
                        {
                        }
                        column(HidePrintFixedLaborQuantityPrice; RDLHideOutput(ShowOutputFixedLaborQuantityPrice()))
                        {
                            Description = 'PA038218.44716,EU.0000011';
                        }
                        column(PrintPositionBody12_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionBody12_ServPreviewLineGQuantity; ServPreviewLineG.Quantity)
                        {
                        }
                        column(PrintPositionBody12_ServPreviewLineGUnitofMeasure; ServPreviewLineG."Unit of Measure")
                        {
                        }
                        column(PrintPositionBody12_ServPreviewLineGDescription; ServPreviewLineG.Description)
                        {
                        }
                        column(PrintPositionBody12_NoTextG; NoTextG)
                        {
                        }
                        column(PrintPositionBody12_NoPropertyG; NoPropertyG)
                        {
                        }
                        column(HidePrintFixedLaborQuantityOnly; RDLHideOutput(ShowOutputFixedLaborQuantityOnly()))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionBody13_ServPreviewLineGAmount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionBody13_ServPreviewLineGDescription; ServPreviewLineG.Description)
                        {
                        }
                        column(PrintPositionBody13_NoTextG; NoTextG)
                        {
                        }
                        column(PrintPositionBody13_NoPropertyG; NoPropertyG)
                        {
                        }
                        column(HidePrintFixedLaborPriceOnly; RDLHideOutput(ShowOutputFixedLaborPriceOnly()))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionBody14_ServPreviewLineGDescription2; ServPreviewLineG."Description 2")
                        {
                        }
                        column(HidePrintPosBody14; RDLHideOutput((ServPreviewLineG."Description 2" <> '') AND NOT (ServPreviewLineG."Line Type" IN [ServPreviewLineG."Line Type"::Sum, ServPreviewLineG."Line Type"::Job, ServPreviewLineG."Line Type"::Total])))
                        {
                            Description = 'PA038218.44716';
                        }
                        column(TotalNetG_Control125; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintSubtotalBlock; RDLHideOutput(((SumLaborG <> 0) OR (SumItemG <> 0) OR (SumExtServG <> 0) OR (SumOtherG <> 0)) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionFooter17_SumLaborG; SumLaborG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintPosFooter17; RDLHideOutput((SumLaborG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionFooter18_SumItemG; SumItemG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintPosFooter18; RDLHideOutput((SumItemG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionFooter19_SumExtServG; SumExtServG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintPosFooter19; RDLHideOutput((SumExtServG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionFooter20_SumOtherG; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintPosFooter20; RDLHideOutput((SumOtherG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionFooter21_TotalTextG; TotalTextG)
                        {
                        }
                        column(PrintPositionFooter21_VATAmountLineG_VATAmountText_C_INC018; VATAmountLineG.VATAmountText + C_INC018)
                        {
                        }
                        column(PrintPositionFooter21_TotalNetG; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionFooter21_TotalVATG_ExchangeVATAmountG; TotalVATG - ExchangeVATAmountG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrintPositionFooter21_TotalNetG_2; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintPosFooter21; RDLHideOutput(VATAmountLineG.COUNT <= 1))
                        {
                        }
                        column(PrintPositionFooter22_ExchangeVATAmountG; ExchangeVATAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(PrintPositionFooter22_VATAmountLineGExchTaxAmountText_C_INC018; VATAmountLineG.ExchTaxAmountText + C_INC018)
                        {
                        }
                        column(PrintPositionFooter22_ExchangeVATBaseAmountG; ExchangeVATBaseAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(PrintPositionFooter22_C_INC016; C_INC016)
                        {
                        }
                        column(HidePrintPosFooter22; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND (ExchangeVATAmountG <> 0)))
                        {
                        }
                        column(PrintPositionFooter23_TotalInclVATTextG; TotalInclVATTextG)
                        {
                        }
                        column(PrintPositionFooter23_TotalGrossG; TotalGrossG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintPosFooter23; RDLHideOutput(VATAmountLineG.COUNT <= 1))
                        {
                        }
                        column(PrintPosition_NoCaption; PrintPosition_NoCaptionLbl)
                        {
                        }
                        column(PrintPosition_DescriptionCaption; ArchServLineG.FIELDCAPTION(Description))
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPosition_QtyCaption; PrintPosition_QtyCaptionLbl)
                        {
                        }
                        column(PrintPosition_UOMCaption; PrintPosition_UOMCaptionLbl)
                        {
                        }
                        column(PrintPosition_UnitPriceCaption; UnitPriceLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPosition_AmountCaption; ArchServLineG.FIELDCAPTION(Amount))
                        {
                            Description = 'EU.0000011';
                        }
                        column(TotalNetGCaption; ContinuedCaptionLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(PrintPositionTransFooter15_TotalNetGCaption; PrintPositionTransFooter15_TotalNetGCaptionLbl)
                        {
                        }
                        column(PrintPositionFooter17_SumLaborCaption; PrintPositionFooter17_SumLaborCaptionLbl)
                        {
                        }
                        column(PrintPositionFooter18_SumItemCaption; PrintPositionFooter18_SumItemCaptionLbl)
                        {
                        }
                        column(PrintPositionFooter19_SumExtServCaption; PrintPositionFooter19_SumExtServCaptionLbl)
                        {
                        }
                        column(PrintPositionFooter20_SumOtherCaption; PrintPositionFooter20_SumOtherCaptionLbl)
                        {
                        }
                        column(ServCustPrintFixedPriceG; ServCustPrintFixedPriceG)
                        {
                            Description = 'PA041187.91650';
                        }
                        column(PrintFixedPriceG; RDLHideOutput(PrintFixedPriceG))
                        {
                            Description = 'PA041187.91650';
                        }
                        column(HideQty; RDLHideOutput(ShowQtyG))
                        {
                            Description = 'PA041187.91650,PA041187.91743';
                        }
                        column(HideUOM; RDLHideOutput(ShowUOMG))
                        {
                            Description = 'PA041187.91650,PA041187.91743';
                        }
                        column(HideUnitPrice; RDLHideOutput(ShowUnitPriceG))
                        {
                            Description = 'PA041187.91650,PA041187.91743';
                        }
                        column(HideDiscount; RDLHideOutput(ShowDiscountG))
                        {
                            Description = 'PA041187.91650,v';
                        }
                        column(HideAmount; RDLHideOutput(ShowAmountG))
                        {
                            Description = 'PA041187.91650,PA041187.91743';
                        }
                        column(VATpercent_SCL; ServPreviewLineG."VAT %")
                        {
                        }
                        column(VATpercentCpn_SCL; ServPreviewLineG.FIELDCAPTION("VAT %"))
                        {
                        }
                        column(UnitPriceLbl; UnitPriceLbl)
                        {
                        }
                        dataitem(PackageBOM; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(PackageBOM1Body1_UnitofMeasure; TempServPreviewLineBOMG."Unit of Measure")
                            {
                            }
                            column(PackageBOM1Body1_Quantity; TempServPreviewLineBOMG.Quantity)
                            {
                            }
                            column(PackageBOM1Body1_Description; TempServPreviewLineBOMG.Description)
                            {
                            }
                            column(PackageBOM1Body1_No; TempServPreviewLineBOMG."No.")
                            {
                            }
                            column(HidePackageBOM1; RDLHideOutputAsInteger(3))
                            {
                            }
                            column(PackageBOM1_Document_Type; TempServPreviewLineBOMG."Document Type")
                            {
                            }
                            column(PackageBOM1_Document_No_; TempServPreviewLineBOMG."Document No.")
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

                                // Start EU.0000011
                                // Stop EU.0000011

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
                            ItemL: Record Item;
                            ServJobLineL: Record "Service Job Line";
                        begin
                            IF Number = 1 THEN
                                TempServPreviewLineG.FIND('-')
                            ELSE
                                TempServPreviewLineG.NEXT;
                            // Start EU.0000011
                            ServPreviewLineG := TempServPreviewLineG;
                            TextBlockContentG := '';
                            // Stop EU.0000011
                            FixedPriceLabG := FALSE;
                            // Start PA041187.91650
                            PrintFixedPriceG := FALSE;
                            // Stop PA041187.91650

                            CLEAR(ServLineG);
                            NoPropertyG := '';
                            // Start EU.0000011
                            IF SalesCrMemoLineG.GET("Sales Cr.Memo Header"."No.", ServPreviewLineG."Invoice Line No.") THEN BEGIN
                                IF GetServJobLine(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Service Job No.", ServJobLineL) THEN
                                    PrintFixedPriceG := ServJobLineL."Includes Fixed Price";
                                GetServCust(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Bill-to Customer No.");
                            END;
                            IF TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Line THEN BEGIN
                                IF (SalesCrMemoLineG."Service Order No." <> '') AND
                                   (SalesCrMemoLineG."Service Order Line No." <> 0)
                                THEN BEGIN
                                    // Start PA041187.91639
                                    IF ArchServLineG.GET(ArchServLineG."Document Type"::Order, SalesCrMemoLineG."Service Order No.",
                                         SalesCrMemoLineG."Service Order Line No.")
                                    THEN BEGIN
                                        ServLineG.TRANSFERFIELDS(ArchServLineG);
                                        // Stop PA041187.91639
                                    END ELSE BEGIN
                                        ServLineG.GET(ServLineG."Document Type"::Order, SalesCrMemoLineG."Service Order No.",
                                          SalesCrMemoLineG."Service Order Line No.");
                                    END;
                                END;
                                IF (ServLineG.Type = ServLineG.Type::Labor) AND (ServLineG."Fixed Price" <> 0) THEN
                                    FixedPriceLabG := TRUE;
                                // Stop EU.0000011

                                NoPropertyG := '';
                                NoTextG := '';

                                IF (SalesCrMemoLineG.Type = SalesCrMemoLineG.Type::Item) OR
                                   (SalesCrMemoLineG.Type = SalesCrMemoLineG.Type::"Account (G/L)")
                                THEN BEGIN
                                    NoTextG := SalesCrMemoLineG."No.";
                                    IF SalesCrMemoLineG."VAT Calculation Type" =
                                       SalesCrMemoLineG."VAT Calculation Type"::"Exch. Parts Tax"
                                    THEN BEGIN
                                        NoPropertyG := C_INC016;
                                        ExchangeDaG := TRUE;
                                    END;
                                END;

                                IF (ServLineG.Type = ServLineG.Type::Labor) AND (ServLineG."Fixed Price" <> 0) THEN
                                    FixedPriceLabG := TRUE;
                                IF ServLineG.Type IN [ServLineG.Type::Item, ServLineG.Type::"G/L Account",
                                   ServLineG.Type::"Ext. Service", ServLineG.Type::Labor]
                                THEN BEGIN
                                    NoTextG := ServLineG."No.";
                                END;
                                IF SalesCrMemoLineG."Automatic Surcharge" = FALSE THEN BEGIN
                                    // Start PA041366.81144
                                    // Stop PA041366.81144
                                    // Start PA041187.91639
                                    // Stop PA041187.91639
                                    ArchServCustLineG.RESET;
                                    ArchServCustLineG.SETRANGE("Document Type", ServLineG."Document Type");
                                    ArchServCustLineG.SETRANGE("Document No.", ServLineG."Document No.");
                                    ArchServCustLineG.SETRANGE("Document Line No.", ServLineG."Line No.");
                                    ArchServCustLineG.SETRANGE("Bill-to Customer No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                                    IF ArchServCustLineG.FIND('-') THEN BEGIN
                                        ServLineCustG.TRANSFERFIELDS(ArchServCustLineG);
                                    END ELSE BEGIN
                                        CLEAR(ServLineCustG);
                                        // Start PA041187.91639
                                        // Stop PA041187.91639
                                        ServLineCustG.RESET;
                                        ServLineCustG.SETRANGE("Document Type", ServLineG."Document Type");
                                        ServLineCustG.SETRANGE("Document No.", ServLineG."Document No.");
                                        ServLineCustG.SETRANGE("Document Line No.", ServLineG."Line No.");
                                        ServLineCustG.SETRANGE("Bill-to Customer No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                                        IF NOT ServLineCustG.FIND('-') THEN BEGIN
                                            CLEAR(ServLineCustG);
                                        END;
                                    END;
                                    // Start PA041187.91639
                                    // Stop PA041187.91639
                                    // Start PA034175
                                    IF (TempServPreviewLineG."Line Type" = TempServPreviewLineG."Line Type"::Line) AND
                                       (ServLineCustG."Portion %" <> 100)
                                    THEN BEGIN
                                        // Stop PA034175
                                        NoPropertyG := NoPropertyG + COPYSTR(C_INC041, 1, 1);
                                        ProportinatelyChargingG := TRUE;
                                    END;
                                END ELSE BEGIN
                                    ServPreviewLineG."No." := '';
                                    NoTextG := '';
                                END;
                            END;
                            // Start PA041366.81144
                            IF ServLineG.Type = ServLineG.Type::Item THEN BEGIN
                                IF ServLineG."Sending Required" IN [ServLineG."Sending Required"::Keep, ServLineG."Sending Required"::Send] THEN BEGIN
                                    NoPropertyG := NoPropertyG + C_INC034;
                                    ReturnDaG := TRUE;
                                END;
                            END;
                            // Stop PA041366.81144
                            // Start PA033890
                            IF CasePrintPosition THEN BEGIN
                                IF (PrintWithoutDiscG) OR (ServPreviewLineG."Line Discount Amount" * ServPreviewLineG.Quantity < 0) THEN BEGIN
                                    ServPreviewLineG."Unit Price" := ServPreviewLineG.Amount / ServPreviewLineG.Quantity;
                                    ServPreviewLineG."Line Discount %" := 0;
                                END;
                                ServPreviewLineG."Unit Price" := ROUND(ServPreviewLineG."Unit Price");
                            END;
                            // Start EU.0000011
                            // Stop EU.0000011
                            // Stop PA033890

                            // Start PA041187.91650
                            // Start EU.0000011
                            // Stop EU.0000011
                            ServCustPrintFixedPriceG := ServCustG."Print Service Job Fixed Price";
                            DetermineColumnVisibility();
                            // Stop PA041187.91650

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
                        end;

                        trigger OnPreDataItem()
                        var
                            VATIdDummyTempL: Record "VAT Identifier" temporary;
                            DummyFairDealL: Decimal;
                            ExchPartsVATDummyL: Decimal;
                        begin
                            // Start EU.0000011
                            VATAmountLineG.DELETEALL;

                            TempServPreviewLineG.CreateFromSalesCrMemo(ServHdrG, VATAmountLineG, VATIdDummyTempL, "Sales Cr.Memo Header"."No.");
                            TempServPreviewLineG.GetTotals(ServSetupG."Output Ext. Service", SumItemG, SumExtServG, SumLaborG, SumOtherG, DummyFairDealL);
                            VATAmountLineG.GetTotals(TotalNetG, TotalGrossG, TotalVATG);
                            // Start EU.0000011
                            TempServPreviewLineG.GetTotalExchangeParts(ExchangeVATAmountG, ExchangeVATBaseAmountG, ExchPartsVATDummyL);
                            // Stop EU.0000011
                            IF ConsolidatePositionsOfAJobG THEN
                                TempServPreviewLineG.ConsolidateJobs(TRUE);
                            IF ConsolidateNegativePosG THEN
                                TempServPreviewLineG.ConsolidateNegativePositions();
                            IF ConsolidateLaborPosG THEN
                                TempServPreviewLineG.ConsolidateByType(TempServPreviewLineG.Type::Labor, ConsolidatePositionsOfAPackageG);
                            IF ConsolidatePositionsOfAPackageG THEN
                                TempServPreviewLineG.ConsolidatePackages(ServHdrG."Document Type", ServHdrG."No.", TempServPreviewLineBOMG, OrderInArcheG, BOMOutputG, TRUE);

                            TempServPreviewLineG.SETRANGE("Suppress in Order", FALSE);
                            // Stop EU.0000011

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
                        column(VATCounterHeader1_TotalTextG; TotalTextG)
                        {
                        }
                        column(VATCounterHeader1_TotalNetG; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterHeader1; RDLHideOutput(VATAmountLineG.COUNT > 1))
                        {
                        }
                        column(VATCounterTransHeader2_VATAmountLineG_VATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounterTransHeader2_VATAmountLineG_VATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounterBody3_VATAmountLineG_VATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounterBody3_VATAmountLineG_VATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounterBody3_VATTextG; VATTextG)
                        {
                        }
                        column(HideVATCounterBody; RDLHideOutputAsInteger(5))
                        {
                        }
                        column(VATCounterTransFooter4_VATAmountLineG_VATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounterTransFooter4_VATAmountLineG_VATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounterFooter5_VATAmountLineGExchTaxAmountText_C_INC018; VATAmountLineG.ExchTaxAmountText + C_INC018)
                        {
                        }
                        column(VATCounterFooter5_C_INC016; C_INC016)
                        {
                        }
                        column(VATCounterFooter5_ExchangeVATAmountG; ExchangeVATAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATCounterFooter5_ExchangeVATBaseAmountG; ExchangeVATBaseAmountG)
                        {
                            AutoFormatExpression = SalesCrMemoLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterFooter5; RDLHideOutput((VATAmountLineG.COUNT > 1) AND (ExchangeVATAmountG <> 0)))
                        {
                        }
                        column(VATCounterFooter6_TotalInclVATTextG; TotalInclVATTextG)
                        {
                        }
                        column(VATCounterFooter6_TotalGrossG; TotalGrossG)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterFooter6; RDLHideOutput(VATAmountLineG.COUNT > 1))
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
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
                            // Start PA033890
                            VATTextG := STRSUBSTNO('%1%2', VATAmountLineG."VAT %", C_INC001);
                            // Stop PA033890
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLineG.COUNT <= 1 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Footer Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Credit Memo"), "Header/Footer" = CONST(Footer));
                        column(FooterTextBody1_Text; Text)
                        {
                        }
                        column(HideFooterTextBody1; RDLHideOutputAsInteger(6))
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
                        column(TotalBody1_LegendTextG; LegendTextG)
                        {
                        }
                        column(HideTotalBody1; RDLHideOutput(ReturnDaG OR ExchangeDaG OR ProportinatelyChargingG))
                        {
                        }
                        column(TotalBody2_PaymentTermsGDescription; PaymentTermsG.Description)
                        {
                        }
                        column(HideTotalBody2; RDLHideOutput(PaymentTermsG.Description <> ''))
                        {
                        }
                        column(TotalBody1_ExplanationsCaption; TotalBody1_ExplanationsCaptionLbl)
                        {
                        }
                        column(TotalBody2_PaymentTermsCaption; TotalBody2_PaymentTermsCaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033890
                            LegendTextG := '';
                            IF ReturnDaG THEN
                                LegendTextG := C_INC036;

                            IF ExchangeDaG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC037
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC037;

                            IF ProportinatelyChargingG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC041
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC041;
                            // Stop PA033890
                        end;
                    }
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("No.") WHERE("Type of Document to be Printed" = CONST("Sales Cr. Memo"));
                        column(PostedCashRegHdr1_Payment_In_OutCaption; "Payment (In/Out)")
                        {
                        }
                        column(PostedCashRegHdr_No; "Posted Cash Register Header"."No.")
                        {
                        }
                        column(HidePostedCashRegBody1; RDLHideOutputAsInteger(12))
                        {
                        }
                        dataitem("Cash Reg. Add Disc Split Post."; "Cash Reg. Add Disc Split Post.")
                        {
                            DataItemLink = "Applies-to ID" = FIELD("No.");
                            DataItemTableView = SORTING("Source Type", "Source No.", "Applies-to ID");
                            column(HideCashRegAddDiscHeader1; RDLHideOutputAsInteger(13))
                            {
                            }
                            column(CashRegAddDiscSplitPostBody2_PostingDate; FORMAT("Posting Date"))
                            {
                            }
                            column(CashRegAddDiscSplitPostBody2_AppltoDocumentType; "Appl.-to Document Type")
                            {
                            }
                            column(CashRegAddDiscSplitPostBody2_AppltoDocumentNo; "Appl.-to Document No.")
                            {
                            }
                            column(CashRegAddDiscSplitPostBody2_CurrencyCode; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(CashRegAddDiscSplitPostBody2_RemainingAmount; "Remaining Amount")
                            {
                            }
                            column(CashRegAddDiscSplitPostBody2_PmtDiscountTotal; "Pmt. Discount Total")
                            {
                            }
                            column(CashRegAddDiscSplitPostBody2_AmountMinusDiscG; AmountMinusDiscG)
                            {
                            }
                            column(HideCashRegAddDiscBody2; RDLHideOutputAsInteger(14))
                            {
                            }
                            column(CashRegAddDiscSplitPostHeader1_DateCaption; CashRegAddDiscSplitPostHeader1_DateCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPostHeader1_TypeCaption; CashRegAddDiscSplitPostHeader1_TypeCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPostHeader1_DocNumberCaption; CashRegAddDiscSplitPostHeader1_DocNumberCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPostHeader1_CurrencyCaption; CashRegAddDiscSplitPostHeader1_CurrencyCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPostHeader1_RemAmountCaption; CashRegAddDiscSplitPostHeader1_RemAmountCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPostHeader1_PmtDiscCaption; CashRegAddDiscSplitPostHeader1_PmtDiscCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPostHeader1_AmountCaption; ArchServLineG.FIELDCAPTION(Amount))
                            {
                                Description = 'EU.0000011';
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Entry_No_; "Entry No.")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Source_Type; "Source Type")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Document_No_; "Document No.")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post__Applies_to_ID; "Applies-to ID")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                AmountMinusDiscG := "Remaining Amount" - "Pmt. Discount Total";
                                IF ("Appl.-to Document Type" = "Appl.-to Document Type"::Payment) OR
                                   ("Appl.-to Document Type" = "Appl.-to Document Type"::" ")
                                THEN BEGIN
                                    AmountMinusDiscG := -ABS(AmountMinusDiscG);
                                    "Remaining Amount" := -ABS("Remaining Amount");
                                    "Pmt. Discount Total" := -ABS("Pmt. Discount Total");
                                END ELSE BEGIN
                                    AmountMinusDiscG := ABS(AmountMinusDiscG);
                                    "Remaining Amount" := ABS("Remaining Amount");
                                    "Pmt. Discount Total" := ABS("Pmt. Discount Total");
                                END;
                            end;
                        }
                        dataitem("Posted Cash Register Line"; "Posted Cash Register Line")
                        {
                            DataItemLink = "Document No." = FIELD("No.");
                            DataItemTableView = SORTING("Document No.", "Line No.");
                            column(PostedCashRegisterLineHeader1_CurrencyCode; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterLineHeader1_AmounttoPayLCY; -1 * "Posted Cash Register Header"."Amount to Pay (LCY)")
                            {
                            }
                            column(HidePostedCashRegLineHeader1; RDLHideOutputAsInteger(15))
                            {
                            }
                            column(PostedCashRegisterLineBody2_MeansofPaymentCode; "Means of Payment Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterLineBody2_CurrencyCode; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterLineBody2_Amount; -1 * Amount)
                            {
                            }
                            column(HidePostedCashRegLineBody2; RDLHideOutputAsInteger(16))
                            {
                            }
                            column(PostedCashRegisterLineFooter3_CurrencyCode1; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterLineFooter3_CurrencyCode; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterLineFooter3_ChangeMoney; "Posted Cash Register Header"."Change Money")
                            {
                            }
                            column(PostedCashRegisterLineFooter3_AmountGiven; "Posted Cash Register Header"."Amount Given")
                            {
                            }
                            column(PostedCashRegisterLineFooter3_RemainingAmountTextG; RemainingAmountTextG)
                            {
                            }
                            column(PostedCashRegisterLineFooter3_RemainingStatusTextG; RemainingStatusTextG)
                            {
                            }
                            column(HidePostedCashRegLineFooter3; RDLHideOutputAsInteger(17))
                            {
                            }
                            column(PostedCashRegisterLineHeader1_AmounttoPay; PostedCashRegisterLineHeader1_AmounttoPayLbl)
                            {
                            }
                            column(PostedCashRegisterLineFooter3_AmountGivenCaption; PostedCashRegisterLineFooter3_AmountGivenCaptionLbl)
                            {
                            }
                            column(PostedCashRegisterLineFooter3_ChangeMoneyCaption; PostedCashRegisterLineFooter3_ChangeMoneyCaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Line_Document_No_; "Document No.")
                            {
                            }
                            column(Posted_Cash_Register_Line_Line_No_; "Line No.")
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033086.6570305
                            RemainingStatusTextG := '';
                            RemainingAmountTextG := '';
                            IF "Posted Cash Register Header"."Rem. Outstanding Status" <> 0 THEN BEGIN
                                RemainingStatusTextG := C_INC_RemainingStatus;
                                CASE "Posted Cash Register Header"."Rem. Outstanding Status" OF
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Remaining Amount":
                                        RemainingAmountTextG := C_INC_RemainingAmount;
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Payment Tolerance":
                                        RemainingAmountTextG := C_INC_PaymTolerance;
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Payment Discount Tolerance":
                                        RemainingAmountTextG := C_INC_PaymentDiscTolerance;
                                    "Posted Cash Register Header"."Rem. Outstanding Status"::"Both Payment Tolerances":
                                        RemainingAmountTextG := C_INC_BothPaymentTolerance;
                                END;
                            END;
                            // Stop PA033086.6570305
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT PmtMethodG.GET("Sales Cr.Memo Header"."Payment Method Code") OR NOT PmtMethodG."Cash Payment" THEN BEGIN
                                CurrReport.BREAK;
                            END;
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddrG THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(VATClauseCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATClauseVATIdentifier; C_INC_VAT + VATAmountLineG."VAT Identifier")
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseCode; VATClauseG.Code)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseDescription; VATClauseG.Description)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseDescription2; VATClauseG."Description 2")
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                            Description = 'PA037665';
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentifierCap)
                        {
                            Description = 'PA037665';
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                            Description = 'PA037665';
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA037665
                            VATAmountLineG.GetLine(Number);
                            IF NOT VATClauseG.GET(VATAmountLineG."VAT Clause Code") THEN
                                CurrReport.SKIP;
                            VATClauseG.TranslateDescription("Sales Cr.Memo Header"."Language Code");
                            // Stop PA037665
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA037665
                            CLEAR(VATClauseG);
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Amount");
                            // Stop PA037665
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA032727
                    // Stop PA032727
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                    END;
                    CurrReport.PAGENO := 1;

                    ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    // Start PA033336
                    IF ("Sales Cr.Memo Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        // Start PA035395.18593
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC044
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV
                    // Stop PA035395.18593
                    // Stop PA033336

                    OldServJobNoG := 0;
                    SumLaborG := 0;
                    SumItemG := 0;
                    SumExtServG := 0;
                    SumOtherG := 0;

                    TotalNetG := 0;
                    TotalGrossG := 0;
                    TotalVATG := 0;
                    ProportinatelyChargingG := FALSE;
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrintedG.RUN("Sales Cr.Memo Header");
                    // Stop PA032727
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA043099
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    // Stop PA043099

                    CopyTextG := '';
                    // Start PA032178
                    DuplicateTextG := '';
                    // Stop PA032178

                    SETRANGE(Number, 1, NoOfLoopsG);
                end;
            }

            trigger OnAfterGetRecord()
            var
                InteractionLogL: Record "Interaction Log Entry";
                bankAccountL: Record "Bank Account";
                salesInvoiceHeaderL: Record "Sales Invoice Header";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA041187.91650
                OrderInArcheG := FALSE;
                IF NOT ServHdrG.GET(ServHdrG."Document Type"::Order, "Service Order No.") THEN BEGIN
                    IF NOT ArchServHdrG.GET(ServHdrG."Document Type"::Order, "Service Order No.") THEN
                        CLEAR(ArchServHdrG)
                    ELSE BEGIN
                        ArchServHdrG.CALCFIELDS("Includes Fixed Price");
                        ServHdrG.TRANSFERFIELDS(ArchServHdrG);
                        ServHdrG."Includes Fixed Price" := ArchServHdrG."Includes Fixed Price";
                        OrderInArcheG := TRUE;
                    END;
                END ELSE
                    ServHdrG.CALCFIELDS("Includes Fixed Price");
                // Stop PA041187.91650

                // Start PA038228
                CLEAR(MainNextAppDateG);
                CLEAR(EmissionNextAppDateG);
                MainNextAppDateG := GetNextApptDate(1, ServHdrG."Document Date");
                EmissionNextAppDateG := GetNextApptDate(2, ServHdrG."Document Date");

                CLEAR(VehicleCustomerG);
                VehicleCustomerG.SETRANGE(VIN, ServHdrG.VIN);
                VehicleCustomerG.SETRANGE(Type, VehicleCustomerG.Type::"Service Contract");
                VehicleCustomerG.SETFILTER("Beginning of Contract", '<=%1', ServHdrG."Order Date");
                VehicleCustomerG.SETFILTER("Expiration of Contract", '>=%1', ServHdrG."Order Date");
                IF VehicleCustomerG.FINDFIRST THEN
                    ;
                // Stop PA038228

                // Start PA033890
                CLEAR(ReportLayoutSetupG);
                // Start PA039225.51457
                // Stop PA039225.51457
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Service-Job/Pack. Cr. Memo"); //API.1      01.03.18 PV
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593
                // Stop PA033890

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Cr.Memo Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Cr.Memo Header"."User ID");

                IF ReasonCodeG.GET("Sales Cr.Memo Header"."Reason Code") THEN;

                IF salesInvoiceHeaderL.GET("Sales Cr.Memo Header"."Applies-to Doc. No.") THEN
                    //OrderNoG := salesInvoiceHeaderL."Applies-to Doc. No."
                    OrderNoG := salesInvoiceHeaderL."Order No."
                ELSE
                    OrderNoG := '';
                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                ServHdrG.CALCFIELDS("Driver Name");
                //Stop API.1      01.03.18 PV

                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                CurrReport.LANGUAGE := BillToCustG.PrintDocInCustLanguage();

                PrintWithoutDiscG := NOT "Sales Cr.Memo Header"."Show Discount";

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

                // Start API.1.0.2  07.06.18 PV
                //  Correct company bank info is filled when OnValidate of T36."Bank Account Code" is run.
                //  Then it is passed to posted tables, ... Ie. this info should be shown in reports.
                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccountL.RESET;
                IF bankAccountL.GET("Sales Cr.Memo Header"."Bank Account Code") THEN BEGIN
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
                // Stop API.1.0.2  07.06.18 PV

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
                END ELSE BEGIN
                    TotalTextG := STRSUBSTNO(C_INC030, "Currency Code");
                    TotalInclVATTextG := STRSUBSTNO(C_INC031, "Currency Code");
                END;

                FormatAddrG.SalesCrMemoBillTo(CustAddrG, "Sales Cr.Memo Header");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Cr.Memo Header"."Payment Method Code") THEN
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

                FormatAddrG.SalesCrMemoShipTo(ShipToAddrG, "Sales Cr.Memo Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                // Start PA041187.91650
                // Stop PA041187.91650
                // Start PA040669.61817
                // Stop PA040669.61817
                IF ServHdrG."Service Advisor No." <> '' THEN BEGIN
                    EmployeeG.GET(ServHdrG."Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                END ELSE
                    ServAdvisorG := '';

                // Start PA041187.91650
                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscTextG := FindDiscountText();
                END;
                // Stop PA041187.91650

                CredMemoLineG.RESET;
                CredMemoLineG.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                CredMemoLineG.SETFILTER("Line Discount %", '>%1', 0);
                IF (CredMemoLineG.COUNT <> 0) AND (NOT PrintWithoutDiscG) THEN
                    DiscTextG := C_INC014
                ELSE
                    DiscTextG := '';

                IF "Shortcut Dimension 2 Code" <> '' THEN
                    MakeG.GET("Shortcut Dimension 2 Code")
                ELSE
                    MakeG.INIT;

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";
                IF NOT CustG.GET("Bill-to Customer No.") THEN
                    IF NOT CustG.GET("Sell-to Customer No.") THEN
                        CustG."No." := "Sell-to Customer No.";

                IF "Sales Cr.Memo Header"."Sell-to Customer No." <> "Sales Cr.Memo Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesCrMemoCust(OrderCustAddrG, "Sales Cr.Memo Header");
                    OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';

                CLEAR(ServCustG);
                // Start PA041187.91650
                GetServCust(ServHdrG."Document Type", ServHdrG."No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                // Stop PA041187.91650

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(44) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::SrvCrMExt,
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
                IF "Shipment Method Code" = '' THEN
                    ShipTextG := C_INC042
                ELSE
                    ShipTextG := C_INC043;
                IF ("First Shipment Date" <> 0D) AND ("Last Shipment Date" <> 0D) THEN
                    IF (DATE2DMY("First Shipment Date", 2) = DATE2DMY("Last Shipment Date", 2)) AND
                       (DATE2DMY("First Shipment Date", 3) = DATE2DMY("Last Shipment Date", 3))
                    THEN
                        ShipDateG := FORMAT(DATE2DMY("First Shipment Date", 2)) + '/' + FORMAT(DATE2DMY("First Shipment Date", 3))
                    ELSE
                        ShipDateG := FORMAT(DATE2DMY("First Shipment Date", 2)) + '/' + FORMAT(DATE2DMY("First Shipment Date", 3)) + ' - ' +
                          FORMAT(DATE2DMY("Last Shipment Date", 2)) + '/' + FORMAT(DATE2DMY("Last Shipment Date", 3));
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
        Caption = 'Service - Credit Memo';
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
                    field("Print Subtotals"; PrintSubtotalsG)
                    {
                        Caption = 'Print Subtotals';
                        Description = 'EU.0000011';
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
                    field("Re-print Original Invoice"; RePrintOriginalInvG)
                    {
                        Caption = 'Re-print Original Invoice';
                        Description = 'PA032178,EU.0000011';
                        Editable = RePrintOriginalInvoiceEditable;
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
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            RePrintOriginalInvoiceEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            // Start EU.0000011
            GetReportSelection();
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
            BOMOutputG := FALSE;
            ConsolidateNegativePosG := TRUE;
            RePrintOriginalInvG := FALSE;
            IF UserSetupG.GET(USERID) THEN
                RePrintOriginalInvoiceEditable := UserSetupG."Re-print Original Invoice"
            ELSE
                RePrintOriginalInvoiceEditable := FALSE;
            // Stop EU.0000011
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        // Start EU.0000011
        CLEAR(UserSessionG);
        UserSessionUnitG.GetUserSession(UserSessionG);
        GLSetupG.GET;
        GetReportSelection();
        BOMOutputG := FALSE;
        ConsolidateNegativePosG := TRUE;
        // Stop EU.0000011
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA035597
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        ServSetupG: Record "Service Setup";
        UserSetupG: Record "User Setup";
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Service Manag. Rep. Selection";
        ArchServHdrG: Record "Archived Service Header";
        ArchServLineG: Record "Archived Service Line";
        ArchServCustG: Record "Archived Service Customer";
        ArchServCustLineG: Record "Archived Service Line Customer";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        CompanyInfoG: Record "Company Information";
        CredMemoLineG: Record "Sales Credit Memo Line";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        MakeG: Record Make;
        EmployeeG: Record Employee;
        VATAmountLineG: Record "VAT Amount Line" temporary;
        BillToCustG: Record Customer;
        TempServPreviewLineG: Record "Service Preview Line" temporary;
        TempServPreviewLineBOMG: Record "Service Preview Line" temporary;
        SalesPurchG: Record "Salesperson/Purchaser";
        SalesCrMemoLineG: Record "Sales Credit Memo Line";
        ServHdrG: Record "Service Header";
        ServPreviewLineG: Record "Service Preview Line";
        ServLineG: Record "Service Line";
        TextBlockG: Record "Text Block";
        ServCustG: Record "Service Customer";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        ServLineCustG: Record "Service Line Customer";
        VATClauseG: Record "VAT Clause";
        VehicleCustomerG: Record "Vehicle Customer";
        FormatAddrG: Codeunit "Format Address";
        SalesCrMemoCountPrintedG: Codeunit "Sales Cr. Memo-Printed";
        CollectiveG: Codeunit "Collection Unit";
        RTCMgmtG: Codeunit "RTC Management";
        SegMgntG: Codeunit SegManagement;
        UserSessionUnitG: Codeunit "User Session Unit";
        UserSessionG: Record "User Session";
        TextBlockContentG: Text;
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
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
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        VATTextG: Text[50];
        NoPropertyG: Text[30];
        NoTextG: Text[30];
        DiscTextG: Text[20];
        ReferenceTextG: Text[30];
        ServAdvisorG: Text[50];
        TotalInclVATTextG: Text[50];
        TotalTextG: Text[50];
        ShipDateG: Text[30];
        ShipTextG: Text[30];
        LegendTextG: Text[250];
        DuplicateTextG: Text[30];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        ReportTitleG: Text[100];
        IntCustG: Code[20];
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        OldServJobNoG: Integer;
        NextEntryNoG: Integer;
        AmountMinusDiscG: Decimal;
        SumLaborG: Decimal;
        SumItemG: Decimal;
        SumExtServG: Decimal;
        SumOtherG: Decimal;
        C_INC001: Label '% VAT of';
        TotalNetG: Decimal;
        TotalGrossG: Decimal;
        TotalVATG: Decimal;
        ExchangeVATAmountG: Decimal;
        ExchangeVATBaseAmountG: Decimal;
        FixedPriceLabG: Boolean;
        ShowShippingAddrG: Boolean;
        MoreLinesG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC010: Label 'Package BOMs can only be output for consolidated packages !';
        C_INC014: Label 'Disc. %';
        C_INC018: Label ' of';
        C_INC016: Label '*';
        PrintSubtotalsG: Boolean;
        C_INC029: Label 'Copy of';
        C_INC030: Label 'Total %1';
        C_INC031: Label 'Total %1 Incl. VAT';
        ExchangeDaG: Boolean;
        ReturnDaG: Boolean;
        ConsolidatePositionsOfAJobG: Boolean;
        ConsolidatePositionsOfAPackageG: Boolean;
        OrderInArcheG: Boolean;
        C_INC034: Label 'R';
        C_INC036: Label 'R = Return-mandatory part';
        C_INC037: Label '* = Replacement Part';
        C_INC038: Label 'Sum';
        C_INC039: Label 'Sum';
        C_INC_TaxNo: Label 'Tax No.';
        BOMOutputG: Boolean;
        ConsolidateNegativePosG: Boolean;
        ConsolidateLaborPosG: Boolean;
        ProportinatelyChargingG: Boolean;
        C_INC041: Label 'P = Proportionately Charged';
        LogInteractionG: Boolean;
        C_INC042: Label 'Shipment Date';
        C_INC043: Label 'Dispatch Date';
        C_INC044: Label 'D U P L I C A T E';
        RePrintOriginalInvG: Boolean;
        C_INC045: Label 'Service Credit Memo';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        [InDataSet]
        RePrintOriginalInvoiceEditable: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        Header43Lbl: Label 'Page';
        Header29Lbl: Label 'Customer No.';
        Header45Lbl: Label 'Make';
        Header49Lbl: Label 'Model Description';
        Header39Lbl: Label 'Applies-to Doc. No.';
        Footer01Lbl: Label 'Payments to:';
        PrintPosition_NoCaptionLbl: Label 'No.';
        PrintPosition_QtyCaptionLbl: Label 'Qty.';
        PrintPosition_UOMCaptionLbl: Label 'UoM';
        PrintPositionTransFooter15_TotalNetGCaptionLbl: Label 'Sum carried forward';
        PrintPositionFooter17_SumLaborCaptionLbl: Label 'Sum Labor';
        PrintPositionFooter18_SumItemCaptionLbl: Label 'Sum Item';
        PrintPositionFooter19_SumExtServCaptionLbl: Label 'Sum External Services';
        PrintPositionFooter20_SumOtherCaptionLbl: Label 'Sum Other';
        ContinuedCaptionLbl: Label 'Continued';
        TotalBody1_ExplanationsCaptionLbl: Label 'Explanations';
        TotalBody2_PaymentTermsCaptionLbl: Label 'Payment Terms';
        CashRegAddDiscSplitPostHeader1_DateCaptionLbl: Label 'Date';
        CashRegAddDiscSplitPostHeader1_TypeCaptionLbl: Label 'Type';
        CashRegAddDiscSplitPostHeader1_DocNumberCaptionLbl: Label 'Document Number';
        CashRegAddDiscSplitPostHeader1_CurrencyCaptionLbl: Label 'Currency';
        CashRegAddDiscSplitPostHeader1_RemAmountCaptionLbl: Label 'Remaining Amount';
        CashRegAddDiscSplitPostHeader1_PmtDiscCaptionLbl: Label 'PmtDisc';
        PostedCashRegisterLineHeader1_AmounttoPayLbl: Label 'Amount to Pay';
        PostedCashRegisterLineFooter3_AmountGivenCaptionLbl: Label 'Amount given';
        PostedCashRegisterLineFooter3_ChangeMoneyCaptionLbl: Label 'Change Money';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATClausesCap: Label 'VAT Clause';
        VATIdentifierCap: Label 'VAT Identifier';
        C_INC_VAT: Label 'VAT';
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        MileageCaptionLbl: Label 'Mileage / Running Time';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_NameLbl: Label 'Salesperson';
        Sales_Invoice_Header___Service_Order_No__CaptionLbl: Label 'Order No.';
        Inspection_DateLbl: Label 'Inspection Date';
        Emission_DateLbl: Label 'Emission Date';
        Appt_Service_AdvisorLbl: Label 'Appt. Service Advisor';
        Pickup_Service_AdvisorLbl: Label 'Pickup Service Advisor';
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
        PrintFixedPriceG: Boolean;
        ServCustPrintFixedPriceG: Integer;
        ServPreviewControlTypeG: Integer;
        MakeServPreviewG: Codeunit "Make Serv. Preview";
        MakeArchServPreviewG: Codeunit "Make Serv. Preview/Archive";
        ShowQtyG: Boolean;
        ShowUOMG: Boolean;
        ShowUnitPriceG: Boolean;
        ShowDiscountG: Boolean;
        ShowAmountG: Boolean;
        ShowLineSubTotalsG: Boolean;
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
        DateOfIssueLbl: Label 'Date of Issue';
        ShowTaxNoG: Boolean;
        ReasonCodeG: Record "Reason Code";
        OrderNoG: Code[20];
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        OrderNoLbl: Label 'Order No.';
        UnitPriceLbl: Label 'Unit Price';

    [Scope('Internal')]
    procedure SetAttribute(CredMemoLineLocalL: Record "Sales Credit Memo Line"; var CurServPreviewLineL: Record "Service Preview Line"; var LinePropertyL: Text[10])
    var
        ItemL: Record Item;
    begin
        // Check Exchange Part flag and set it, if required
        // Identifier for exchange part = *
        IF CredMemoLineLocalL."VAT Calculation Type" = CredMemoLineLocalL."VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
            IF STRPOS(LinePropertyL, C_INC016) = 0 THEN
                LinePropertyL := LinePropertyL + C_INC016;
            ExchangeDaG := TRUE;
        END;

        // Check if items must be returned
        // Flag for return part = R
        IF CredMemoLineLocalL.Type = CredMemoLineLocalL.Type::Item THEN BEGIN
            // Start PA041366
            IF CredMemoLineLocalL."Sending Required" IN [CredMemoLineLocalL."Sending Required"::Keep, CredMemoLineLocalL."Sending Required"::Send] THEN BEGIN
                // Stop PA041366
                IF STRPOS(LinePropertyL, C_INC034) = 0 THEN
                    LinePropertyL := LinePropertyL + C_INC034;
                ReturnDaG := TRUE;
            END;
        END;
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
        VehApptL.SETRANGE(VIN, ServHdrG.VIN);
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
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use it to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA033890
        EXIT(NOT ShowOutputP);
        // Stop PA033890
    end;

    [Scope('Internal')]
    procedure RDLHideOutputAsInteger(DummyIntegerP: Integer): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility with a dummy integer
        // @ Send different numbers to create new dataset fields
        // @ param DummyIntegerP - Integer
        // @ retval - Boolean
        // Start PA033890
        EXIT(FALSE);
        // Stop PA033890
    end;

    [Scope('Internal')]
    procedure ShowOutputFixedLaborQuantityPrice(): Boolean
    begin
        // @ Function used to determine printout condition for labor positions with Fixed Price setup to "Quantity + Price per Unit"
        // @ retval - Boolean
        // Start PA033890
        EXIT((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line) AND
            (ServPreviewLineG.Type = ServPreviewLineG.Type::Labor) AND
            (NOT FixedPriceLabG OR
            (FixedPriceLabG AND
            (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity + Price per Unit"))));
        // Stop PA033890
    end;

    [Scope('Internal')]
    procedure ShowOutputFixedLaborQuantityOnly(): Boolean
    begin
        // @ Function used to determine printout condition for labor positions with Fixed Price setup to "Quantity Only"
        // @ retval - Boolean
        // Start PA033890
        EXIT(((ServPreviewLineG.Type = ServPreviewLineG.Type::Labor) AND
            (FixedPriceLabG) AND
            (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity Only")));
        // Stop PA033890
    end;

    [Scope('Internal')]
    procedure ShowOutputFixedLaborPriceOnly(): Boolean
    begin
        // @ Function used to determine printout condition for labor positions with Fixed Price setup to "Fixed Price Only"
        // @ retval - Boolean
        // Start PA033890
        EXIT(((ServPreviewLineG.Type = ServPreviewLineG.Type::Labor) AND
          (FixedPriceLabG) AND
          (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Fixed Price Only")));
        // Stop PA033890
    end;

    local procedure BOMOutputGOnPush()
    begin
        // Start PA033890
        // Start EU.0000011
        IF NOT ConsolidatePositionsOfAPackageG AND BOMOutputG THEN BEGIN
            // Stop EU.0000011
            MESSAGE(C_INC010);
            BOMOutputG := FALSE;
            // Start EU.0000011
            RequestOptionsPage.UPDATE(FALSE);
            // Stop EU.0000011
        END;
        // Stop PA033890
    end;

    [Scope('Internal')]
    procedure CasePrintPosition(): Boolean
    begin
        // @ Determines whether to print a position
        // Start PA033890
        IF ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line THEN BEGIN
            CASE ServPreviewLineG.Type OF
                ServPreviewLineG.Type::"G/L Account",
              ServPreviewLineG.Type::Item,
              ServPreviewLineG.Type::"Ext. Service":
                    EXIT(TRUE);
                ServPreviewLineG.Type::Labor:
                    IF (NOT FixedPriceLabG OR
                       (FixedPriceLabG AND
                       (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity + Price per Unit")))
                    THEN
                        EXIT(TRUE);
            END;
        END;
        // Stop PA033890
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
        ReportTitleG := C_INC045;
        UserSessionUnitG.GetRecordRef(RecordRefL);
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
        SalesCrMemoHdrL: Record "Sales Credit Memo Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        SalesCrMemoHdrL.SETRANGE(SalesCrMemoHdrL."No.", "Sales Cr.Memo Header".GETFILTER("No."));
        IF SalesCrMemoHdrL.FINDSET THEN BEGIN
            IF NOT CustL.GET(SalesCrMemoHdrL."Bill-to Customer No.") THEN
                IF NOT CustL.GET(SalesCrMemoHdrL."Sell-to Customer No.") THEN
                    CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
        END;
        // Stop PA043099
    end;

    local procedure FindDiscountText(): Text
    var
        ServJobLineL: Record "Service Job Line";
        ServLineL: Record "Service Line";
        ArchServJobLineL: Record "Archived Service Job Line";
        ArchServLineL: Record "Archived Service Line";
    begin
        // @ Finds Discount Text
        // @ retval - Text

        // Start PA041187.91650
        DiscTextG := '';
        ServJobLineL.RESET;
        ServJobLineL.SETRANGE("Document Type", ServJobLineL."Document Type"::Order);
        ServJobLineL.SETRANGE("Document No.", "Sales Cr.Memo Header"."Service Order No.");
        ServJobLineL.SETRANGE("Includes Fixed Price", TRUE);
        IF ServJobLineL.FINDSET THEN
            REPEAT
                IF GetServCust(ServJobLineL."Document Type", ServJobLineL."Document No.", ServJobLineL."Bill-to Customer No.") THEN
                    IF ServCustG."Print Service Job Fixed Price" = ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit" THEN
                        DiscTextG := C_INC014;
            UNTIL ServJobLineL.NEXT = 0
        ELSE
            IF ArchServJobLineL.FINDSET THEN
                REPEAT
                    IF GetServCust(ArchServJobLineL."Document Type", ArchServJobLineL."Document No.", ArchServJobLineL."Bill-to Customer No.") THEN
                        IF ArchServCustG."Print Service Job Fixed Price" = ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit" THEN
                            DiscTextG := C_INC014;
                UNTIL ArchServJobLineL.NEXT = 0;

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
                        DiscTextG := C_INC014
                UNTIL (ServJobLineL.NEXT = 0) OR (DiscTextG <> '')
            ELSE BEGIN
                ServJobLineL.SETRANGE("Includes Fixed Price", FALSE);
                IF ServJobLineL.FINDSET THEN
                    REPEAT
                        ServLineL.RESET;
                        ServLineL.SETRANGE("Document Type", ServJobLineL."Document Type");
                        ServLineL.SETRANGE("Document No.", ServJobLineL."Document No.");
                        ServLineL.SETRANGE("Service Job No.", ServJobLineL."Line No.");
                        ServLineL.SETFILTER("Line Discount %", '>%1', 0);
                        IF NOT ServLineL.ISEMPTY THEN
                            DiscTextG := C_INC014
                    UNTIL (ServJobLineL.NEXT = 0) OR (DiscTextG <> '')
            END;
        END;
        IF DiscTextG = '' THEN BEGIN
            ServLineL.RESET;
            ServLineL.SETRANGE("Document Type", ServLineL."Document Type"::Order);
            ServLineL.SETRANGE("Document No.", "Sales Cr.Memo Header"."Service Order No.");
            ServLineL.SETRANGE("Service Job No.", 0);
            ServLineL.SETFILTER("Line Discount %", '>%1', 0);
            IF NOT ServLineL.ISEMPTY THEN
                DiscTextG := C_INC014
        END;
        // Stop PA041187.91650
    end;

    local procedure GetServCust(DocumentTypeP: Integer; DocumentNoP: Code[20]; BilltoCustomerNoP: Code[20]): Boolean
    begin
        // @ Gets Service Customer
        // @ param DocumentTypeP - Integer
        // @ param DocumentNoP - Code 20
        // @ param BilltoCustomerNoP - Code 20
        // @ retval - Boolean

        // Start PA041187.91650
        IF NOT ServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
            IF NOT ArchServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
                EXIT(FALSE)
            ELSE
                ServCustG.TRANSFERFIELDS(ArchServCustG);
        EXIT(TRUE);
        // Stop PA041187.91650
    end;

    [Scope('Internal')]
    procedure GetServJobLine(DocumentTypeP: Integer; DocumentNoP: Code[20]; ServJobNoP: Integer; var ServJobLineP: Record "Service Job Line"): Boolean
    var
        ArchServJobLineL: Record "Archived Service Job Line";
    begin
        // @ Gets Service Job Line
        // @ param DocumentTypeP - Integer
        // @ param DocumentNoP - Code 20
        // @ param ServJobNoP - Code 20
        // @ param ServJobLineP - Record Service Job Line ByVAR
        // @ retval - Boolean

        // Start PA041187.91650
        IF NOT ServJobLineP.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
            IF NOT ArchServJobLineL.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
                EXIT(FALSE)
            ELSE
                ServJobLineP.TRANSFERFIELDS(ArchServJobLineL);
        EXIT(TRUE);
        // Stop PA041187.91650
    end;

    [Scope('Internal')]
    procedure DetermineColumnVisibility()
    begin
        // Determines Column Visibility based on Print Service Job Fixed Price value of the current Service Customer Line
        // Start PA041187.91650
        IF NOT PrintFixedPriceG THEN BEGIN
            ShowQtyG := TRUE;
            ShowUOMG := TRUE;
            ShowUnitPriceG := TRUE;
            ShowDiscountG := TRUE;
            ShowAmountG := TRUE;
            ShowLineSubTotalsG := TRUE;
            EXIT;
        END;

        CASE ServCustPrintFixedPriceG OF
            ServCustG."Print Service Job Fixed Price"::"Fixed Price Only":
                BEGIN
                    ShowQtyG := FALSE;
                    ShowUOMG := FALSE;
                    ShowUnitPriceG := FALSE;
                    ShowDiscountG := FALSE;
                    ShowAmountG := FALSE;
                    ShowLineSubTotalsG := FALSE;
                    IF TempServPreviewLineG."Control Type" = TempServPreviewLineG."Control Type"::Job THEN
                        ShowLineSubTotalsG := TRUE;
                END;
            ServCustG."Print Service Job Fixed Price"::"Quantity Only":
                BEGIN
                    ShowQtyG := TRUE;
                    ShowUOMG := TRUE;
                    ShowUnitPriceG := FALSE;
                    ShowDiscountG := FALSE;
                    ShowAmountG := FALSE;
                    ShowLineSubTotalsG := FALSE;
                    IF TempServPreviewLineG."Control Type" = TempServPreviewLineG."Control Type"::Job THEN
                        ShowLineSubTotalsG := TRUE;
                END;
            ServCustG."Print Service Job Fixed Price"::"Quantity + Price per Unit":
                BEGIN
                    ShowQtyG := TRUE;
                    ShowUOMG := TRUE;
                    ShowUnitPriceG := TRUE;
                    ShowDiscountG := TRUE;
                    ShowAmountG := TRUE;
                    ShowLineSubTotalsG := TRUE;
                END;
        END;
        // Stop PA041187.91650
    end;

    [Scope('Internal')]
    procedure EvalHidePrintSubtotal() ValueR: Boolean
    begin
        // @ Evaluates HidePrintPosBody5 - SumLines
        // @ retval ValueR - Boolean

        // Start PA041187.91650
        // Start EU.0000011
        ValueR := (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Sum) AND PrintSubtotalsG AND ShowLineSubTotalsG;
        // Stop EU.0000011
        IF TempServPreviewLineG."Control Type" = TempServPreviewLineG."Control Type"::Job THEN
            ValueR := TRUE;
        // Stop PA041187.91650
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
                TitleTextRightG := "Sales Cr.Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Cr.Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Cr.Memo Header"."No.";
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


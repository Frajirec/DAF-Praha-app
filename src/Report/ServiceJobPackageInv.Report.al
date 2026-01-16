report 80031 "DPG Service - Job/Package Inv." // 1057613 "Service - Job/Package Inv. CZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA032144   01.09.10 MA Merge of 3.2.3.0
    // PA032178   31.12.10 PR 2305501: Changes made to print original/duplicate invoices.
    //            28.01.11 PR 2630878: Added code to avoid 'Division by Zero' error.
    // PA032589   11.04.11 YI Function IsInternalCustomer changed: now refers to new fiel in customer record, thus less loops
    // PA033041   03.03.11 PR Added code to display 'SWIFT-BIC' and 'IBAN' details.
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added new footer for pageloop dataitem
    // PA032651   29.06.11 PR 4324880: Footer (with bank details) should be printed if there is no 'Report Layout Setup'
    //                                        and vice-versa.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                                        Moved the VATTextLoop, VATTextLine Dataitem position as last footer.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032651   27.07.11 PR 4262653: Increased width of 'VAT Identifier' control.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA032651   27.07.11 PR 4242265: Corrected the text format error in C_INC046, C_INC047, C_INC007.
    // PA033041   14.12.11 PR 5913469: Modified C_INC046.
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033086   06.04.12 GE 7055966: Add functionality for Rem. Amount Status for Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6226270: Layout Changes for Vat
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
    // PA033765   21.12.12 GC EUTireData Dataitem added
    // PA033890   06.02.13 TS I000517: RDLC Layout Created, New functions to facilitate RDLC transformation
    //                        RDLHideOutput, RDLHideOutputAsInteger, ShowOutputPrintPosBody11, ShowOutputPrintPosBody12,
    //                        ShowOutputPrintPosBody13, BOMOutputGOnPush ,CasePrintPosition.
    //                        Request Page created.OnPostSection Trigger Code reengineered.
    //                        DangerousGoods Dataitem removed. Report Layout 1,2,3.
    // PA033890   19.03.13 TS I000621: Bugfixes for Text Length issues for Custom Report Title.
    // PA034175   05.04.13 GX Invoice Explanations are only written if the the value of the
    //                        Portion % field in (Archived) Service Line Customer is <> 100 and
    //                        a actual record exists
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034367   22.07.13 GX I001360 Added incaDoc to function CasePrintPosition
    // PA034051   30.07.13 MF Changes to print Performed Veh. Appointments and New Veh. Appointments.
    //            04.11.13 AN I002281 Code Review.
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA036090   11.09.14 GI 28380 RDLC layout corrections
    // PA035395   27.12.13 GD 18593 Fixed Duplicate logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035399   17.01.14 GG 19604 Field "Next Vehicle Appointments" added in request Form/Page. RDL modifications in order to
    //                              hide or not the "Next Vehicle Appointments".
    // PA035484   01.04.14 GF 20865 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   13.01.14 GD 32456 Corrected RDL Layout, Alignment for "Vat Identifier" column.
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035399.19604, PA035484.20865
    // PA036549   29.01.15 GJ 33293 Page break correction.
    //                        Add default value for PrintFooterLineG in Request Page.
    //                        Modify Layout by let the function incadeaSetDataHeader() to be executed in the Body area to fix
    //                        the problem of the images on the Header.
    // PA037665   12.01.15 GI Added VAT Clause section.
    // PA037665   18.05.15 GI 37715 VAT literal added in front of the VAT Value in VAT Clause section.
    // PA038228   10.08.15 GN Added Header information.
    //                        Added detailed Service information
    // PA037047   13.08.15 LR RDLC issue: display correctly the job descriptions.
    // PA038228   24.08.15 GN 43670 Changed Footer Functionality
    // PA037047   07.09.15 LR 44274 Correct several bugs on calculation, and on the RDLC format
    // PA038218   16.09.15 KR 44716 created a funtion JobWiseTotals to calculate the totals for Job when "Consolidate Positions of a Job" option selected.
    //                        - Modified code in MakeLines to correct the report display based on the selected option
    // PA038218   16.09.15 KR 45320 Modified code in function MakeLines to correct the VAT calculation.
    // PA039784   22.02.16 GV 45749 Do not display two times Bill-to Customer Name when the Sell-to Contact has the same value
    // PA040669   24.05.16 GP 61669 RDLC Layout Redesign and layout modificatioon of all data sections
    // PA040669   27.05.16 GQ 61669 RDLC Layout corrections
    //                        - Modified code to get service header record correctly.
    // PA040669   30.05.16 GQ 61669 RDLC Layout corrections
    // PA040669   01.06.16 GQ 61669 RDLC Layout corrections in order for the report title to be displayed as designed
    // PA040669   02.06.16 GQ 61669 RDLC Layout corrections
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   03.08.16 JS Merge of PA039225.51457.
    // PA041125   12.08.16 GN 68103 RDLC Layout Modifications
    // PA041366   17.08.16 GS Determine the return status on an Item from Service Line or Sales Invoice Line, according to design
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA043099   13.03.17 GW 90573 AddNoOfCopiesFromCust() enhanced to check also "Pre-Assigned No."
    // PA043100   15.03.17 GW 90911 Merge of PA043099.90573.
    // PA041187   29.03.17 GD 91639 "Print Service Job Fixed Price" functionality added.
    // PA041187   03.04.17 GD 91743 Removed unnecessary VATAmountLine creation merged code in PrintPosition().
    //                        Changed Column Visibility RDLC variable names.
    // PA041187   05.04.17 GD 92891 Correction in PrintPosition-OnPreDataitem() to reset filters for TempServPreviewLine2G.
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
    // EU.0000012 01.06.17 MS Complete re-structure of Service Preview Line creation and Consolidation options:
    //                        - MakeLines() former function removed and replaced by new centralized functions which handle the lines creation and consolidation options
    //                        - New Labor Consolidation option
    //                        - VAT Amount Line temporal creation removed and replaced by the centralized function
    //                        - CreateTotals() former function removed and replaced by a new centralized function
    //                        - Fair Deal and Exchange parts calculation in totals has been centralized.
    //                        - PackageBOM1 and PackageBOM2 DataItems removed and replaced by PackageBOM DataItem based on temporal records calculated on the centralized function
    //                        - Additional RDLC small changes; cleanup/renaming of some columns to improve readability
    // EU.0000011 02.06.17 MS Merge of EU.0000012
    // --- 7.2.0 ---
    // EU.0000039 15.09.17 DR Report changed to also print a "Proforma Invoice" when the report is called from an existing "Service Invoice" document.
    // EU.0005464 19.10.17 AJ 7564 Missing docu trigger
    // EU.0001175 19.10.17 AJ 8305 Missing docu trigger for EU.0005464.7564
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5025624 Service Job/Package Inv.
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed, translation
    //                        Final design of vehicle/contract info part of header
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, put VAT% instead of VAT identifier
    //                        Final design of header, Bank source, SK legislation
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceJobPackageInv.rdlc';

    Caption = 'Service Invoice';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Service Order No." = FILTER(<> ''));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Service Order';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(Sales_Invoice_Header_Cash_Register_Receipt; "Cash Register Receipt")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoopNumber; CopyLoop.Number)
                {
                }
                column(SalesInvoiceHeader_CashRegisterReceipt; "Sales Invoice Header"."Cash Register Receipt")
                {
                }
                column(LoopNo; LoopNoG)
                {
                }
                column(HeaderGraphicLeft; ReportLayoutSetupG."Header Graphic Left")
                {
                }
                column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                {
                    Description = 'PA040669';
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
                column(HeaderGraphicCenterHasValue; RDLHideOutput(ReportLayoutSetupG."Header Graphic Center".HASVALUE))
                {
                    Description = 'PA040669';
                }
                column(DuplicateGraphic; ReportLayoutSetupG."Duplicate Graphic")
                {
                }
                column(DuplicateGraphicHasValue; RDLHideOutput(NOT ReportLayoutSetupG."Duplicate Graphic".HASVALUE))
                {
                    Description = 'PA035395.18593';
                }
                column(HideDuplicate; RePrintOriginalInvG)
                {
                    Description = 'PA036090.28380';
                }
                column(HideFooter; RDLHideOutput(ReportSelectionG."Print Footer Line"))
                {
                    Description = 'PA036090.28380,EU.0000011';
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CustAddrG1; CustAddrG[1])
                    {
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
                    column(DocumentDate_SIH; "Sales Invoice Header"."Document Date")
                    {
                    }
                    column(No_SIH; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ServiceOrderNo_SIH; "Sales Invoice Header"."Service Order No.")
                    {
                    }
                    column(CompAddrGArr; CompAddrG)
                    {
                    }
                    column(DueDate_SIH; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(No_CustG; CustG."No.")
                    {
                    }
                    column(CustAddrG2; CustAddrG[2])
                    {
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
                    {
                    }
                    column(CompanyAddrG1; CompanyAddrG[1])
                    {
                    }
                    column(CompanyAddrG2; CompanyAddrG[2])
                    {
                        Description = 'PA028452 ';
                    }
                    column(CompanyAddrG3; CompanyAddrG[3])
                    {
                    }
                    column(CompanyAddrG4; CompanyAddrG[4])
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
                    column(CoTelephoneG; CoTelephoneG)
                    {
                    }
                    column(CoFaxG; CoFaxG)
                    {
                    }
                    column(CoEmailG; CoEmailG)
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddrG[5])
                    {
                        Description = 'PA040669';
                    }
                    column(CompanyAddr_6_; CompanyAddrG[6])
                    {
                        Description = 'PA040669';
                    }
                    column(ServHdrG_LicenseNo; ServHdrG."License No.")
                    {
                    }
                    column(MakeG_Name; MakeG.Name)
                    {
                    }
                    column(ServHdrG_Model; ServHdrG.Model)
                    {
                    }
                    column(ServHdrG_VIN; ServHdrG.VIN)
                    {
                    }
                    column(ServHdrG_InitialRegistration; FORMAT(ServHdrG."Initial Registration"))
                    {
                    }
                    column(ServHdrG_Mileage; ServHdrG.Mileage)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(ServAdvisorG; ServAdvisorG)
                    {
                    }
                    column(SalesPurchG_Name; SalesPurchG.Name)
                    {
                    }
                    column(CustAddrG8; CustAddrG[8])
                    {
                    }
                    column(CustAddrG7; CustAddrG[7])
                    {
                    }
                    column(CustAddrG6; CustAddrG[6])
                    {
                    }
                    column(DaysCarriedCpt; CollectiveG.TextShowOutput(ServDaysCarriedG.FIELDCAPTION("Days Carried"), PrintDaysCarriedG))
                    {
                    }
                    column(SumDaysCarriedG; CollectiveG.TextShowOutput(STRSUBSTNO('%1 %2', SumDaysCarriedG, DaysCarriedText2G), PrintDaysCarriedG))
                    {
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
                        Description = 'PA040669.61669';
                    }
                    column(HdrInfo14; FORMAT(ServHdrG.Mileage) + ' /  ' + FORMAT(ServHdrG."Running Time"))
                    {
                    }
                    column(HdrInfo16; ServHdrG."Driver Name")
                    {
                        Description = 'PA040669.61669';
                    }
                    column(HdrInfo18; "Sales Invoice Header"."Your Reference")
                    {
                        Description = 'PA040669.61669';
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
                    column(Name_SalPurch; SalesPurchG.Name)
                    {
                    }
                    column(CopyTextG; CopyTextG)
                    {
                    }
                    column(VATRegNoCpn_SIH; CollectiveG.TextShowOutput("Sales Invoice Header".FIELDCAPTION("VAT Registration No."), "Sales Invoice Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(VARRegistrationNo_SIH; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(VATRegNoCpn_Comp; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(VATRegNo_Comp; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(C_INC_TaxNo; CollectiveG.TextShowOutput(C_INC_TaxNo, ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(RegistrationNo_Comp; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", ReportSelectionG."Print Address Block"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(ShipTextG; ShipTextG)
                    {
                    }
                    column(ShipDateG; FORMAT(ShipDateG))
                    {
                    }
                    column(EUServTextG; EUServTextG)
                    {
                    }
                    column(ServHdrG_No; ServHdrG."No.")
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA032178';
                    }
                    column(ArchServHdrG_No; ArchServHdrG."No.")
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvG))
                    {
                    }
                    column(NoPrinted_; RDLHideOutput("Sales Invoice Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(Footer02; BankTextG)
                    {
                        Description = 'PA033041,PA032651';
                    }
                    column(Footer39; RDLHideOutput(ReportSelectionG."Print Footer Line"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(FooterField53; RDLHideOutput(ReportSelectionG."Print Footer Line" AND (NOT IsRepSelectionSetupAvailableG)))
                    {
                        Description = 'EU.0000011';
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
                    column(FooterField54; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; ReportLayoutSetupG."One Column Footer")
                    {
                        Description = 'PA040669';
                    }
                    column(HideOneColumnFooter; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669';
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
                    column(HdrInfo7; ArchServHdrG.FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo9; ArchServHdrG.FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo11; ArchServHdrG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo13; MileageCaptionLbl)
                    {
                    }
                    column(HdrInfo15; ServHdrG.FIELDCAPTION("Driver Name"))
                    {
                    }
                    column(HdrInfo17; "Sales Invoice Header".FIELDCAPTION("Your Reference"))
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
                    column(DocumentNoCpn_ASH; ArchServLineG.FIELDCAPTION("Document No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(DocumentDate_ASH; ArchServHdrG.FIELDCAPTION("Document Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(PageLbl; Field45Lbl)
                    {
                    }
                    column(CustNoLbl; Field31Lbl)
                    {
                    }
                    column(LicenseNoCaption; ArchServHdrG.FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MakeCaption; ArchServHdrG.FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(ModelDescriptionCaption; ArchServHdrG.FIELDCAPTION(Model))
                    {
                        Description = 'EU.0000011';
                    }
                    column(VINCaption; ArchServHdrG.FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(InitialRegistrationCaption; ArchServHdrG.FIELDCAPTION("Initial Registration"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MileageCaption; MileageCaptionLbl)
                    {
                    }
                    column(ServiceAdvisorCaption; ServiceAdvisorCaptionLbl)
                    {
                    }
                    column(SalesAdvisorCaption; SalesAdvisorCaptionLbl)
                    {
                    }
                    column(SalesPersonLbl; Field43Lbl)
                    {
                    }
                    column(OrderNoLbl; Field33Lbl)
                    {
                    }
                    column(DueDateCpn_ASH; ArchServHdrG.FIELDCAPTION("Due Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Footer01; Footer01Lbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(HideAddFooter; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                        Description = 'PA036090.28380';
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
                    column(PaymentMethodCode_SIH; "Sales Invoice Header"."Payment Method Code")
                    {
                    }
                    column(VariableSymbol_SIH; "Sales Invoice Header"."Variable Symbol")
                    {
                    }
                    column(VATDate_SIH; "Sales Invoice Header"."VAT Date")
                    {
                    }
                    column(RegistrationNo_SIH; "Sales Invoice Header"."Registration No.")
                    {
                    }
                    column(VATRegistrationNo_SIH; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SIH; "Sales Invoice Header"."Tax Registration No.")
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
                    column(DueDateCpn_SIH; "Sales Invoice Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(VATDateCpn_SIH; "Sales Invoice Header".FIELDCAPTION("VAT Date"))
                    {
                    }
                    column(VariableSymbolCpn_SIH; "Sales Invoice Header".FIELDCAPTION("Variable Symbol"))
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
                    column(SalesPurch_NameLbl; SalesPurch_NameLbl)
                    {
                    }
                    dataitem("Header Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Header));
                        column(HeaderText_Text; Text)
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
                    dataitem("Vehicle Appointment"; "Vehicle Appointment")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
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
                            SETFILTER("Next Appointment Date", '%1..', "Sales Invoice Header"."Document Date");
                            SETRANGE(VIN, ServHdrG.VIN);
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
                        column(DiscTextCaption; DiscTextG)
                        {
                            Description = 'PA032651';
                        }
                        column(HideHeaderTextPrintPosition; RDLHideOutputAsInteger(2))
                        {
                        }
                        column(PrintPositionNumber; PrintPosition.Number)
                        {
                        }
                        column(TotalNetG_Control54; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ServPreviewLineG_Description_Description_2; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(ServPreviewLineG_Amount; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintJobHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) AND (ServPreviewLineG."Service Job No." <> 0)))
                        {
                            Description = 'PA037047.44274,PA038218.44716,EU.0000012';
                        }
                        column(ServPreviewLineGLineType; ServPreviewLineG."Line Type")
                        {
                        }
                        column(ServPreviewLineG_Description_________ServPreviewLineG__Description_2_; ServPreviewLineG.Description + ' ' + ServPreviewLineG."Description 2")
                        {
                        }
                        column(ServPreviewLineG_Amount_Control63; ServPreviewLineG.Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintSubtotal; RDLHideOutput(EvalHidePrintSubtotal()))
                        {
                            Description = 'PA038218.44716,PA041187.91639,EU.0000012';
                        }
                        column(ServPreviewLineG_Description_Description_2_Body6; ServPreviewLineG.Description + CollectiveG.TextShowOutput(' - ', (ServPreviewLineG.Description > '') AND (ServPreviewLineG."Description 2" > '')) + ServPreviewLineG."Description 2")
                        {
                            Description = 'EU.0000011';
                        }
                        column(ServPreviewLineG_Service_Job_No; ServPreviewLineG."Service Job No.")
                        {
                        }
                        column(VehApptDescriptionG_; VehApptDescriptionG)
                        {
                        }
                        column(ServPreviewLineG_Package_No; ServPreviewLineG."Package No.")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(HidePrintPackageHeader; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job) AND (ServPreviewLineG."Package No." <> '')))
                        {
                            Description = 'PA037047.44274,EU.0000012';
                        }
                        column(ServPreviewLineG_Description; ServPreviewLineG.Description)
                        {
                        }
                        column(HidePrintText; RDLHideOutput((ServPreviewLineG.Description <> '') AND (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Text)))
                        {
                            Description = 'PA041125.68103,EU.0000012';
                        }
                        column(ServPreviewLineG_Description_Control65; ServPreviewLineG.Description)
                        {
                        }
                        column(ServPreviewLineG_Quantity; ServPreviewLineG.Quantity)
                        {
                        }
                        column(ServPreviewLineG_Unit_of_Measure; ServPreviewLineG."Unit of Measure")
                        {
                        }
                        column(ServPreviewLineG_UnitPrice; ServPreviewLineG."Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 2;
                        }
                        column(ServPreviewLineG_Line_Discount; ServPreviewLineG."Line Discount %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(NoTextG; NoTextG)
                        {
                        }
                        column(NoPropertyG; NoPropertyG)
                        {
                        }
                        column(ServPreviewLineG_VATIdentifier; ServPreviewLineG."VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HidePrintGLAccount; RDLHideOutput((ServPreviewLineG.Type = ServPreviewLineG.Type::"G/L Account") AND (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line)))
                        {
                            Description = 'PA038218.44716,EU.0000012';
                        }
                        column(HidePrintItemOrExtService; RDLHideOutput((ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line) AND ((ServPreviewLineG.Type = ServPreviewLineG.Type::Item) OR (ServPreviewLineG.Type = ServPreviewLineG.Type::"Ext. Service"))))
                        {
                            Description = 'PA038218.45320,EU.0000012';
                        }
                        column(HidePrintFixedLaborQuantityPrice; RDLHideOutput(ShowOutputFixedLaborQuantityPrice))
                        {
                            Description = 'PA038218.44716,EU.0000012';
                        }
                        column(HidePrintFixedLaborQuantityOnly; RDLHideOutput(ShowOutputFixedLaborQuantityOnly))
                        {
                            Description = 'EU.0000012';
                        }
                        column(HidePrintFixedLaborPriceOnly; RDLHideOutput(ShowOutputFixedLaborPriceOnly))
                        {
                            Description = 'EU.0000012';
                        }
                        column(ServPreviewLineG__Description_2_; ServPreviewLineG."Description 2")
                        {
                        }
                        column(HidePrintDescription2; RDLHideOutput((ServPreviewLineG."Description 2" <> '') AND NOT (ServPreviewLineG."Line Type" IN [ServPreviewLineG."Line Type"::Sum, ServPreviewLineG."Line Type"::Job, ServPreviewLineG."Line Type"::Total])))
                        {
                            Description = 'PA037047.44274,EU.0000012';
                        }
                        column(HidePrintSubtotalBlock; RDLHideOutput((SumLaborG <> 0) OR (SumItemG <> 0) OR (SumExtServG <> 0) OR (SumOtherG <> 0)))
                        {
                            Description = 'EU.0000012';
                        }
                        column(SumLaborG; SumLaborG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintSumLabor; RDLHideOutput((SumLaborG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011,EU.0000012';
                        }
                        column(SumItemG; SumItemG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintSumItem; RDLHideOutput((SumItemG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011,EU.0000012';
                        }
                        column(SumExtServG; SumExtServG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintSumExtService; RDLHideOutput((SumExtServG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011,EU.0000012';
                        }
                        column(SumOtherG; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintSumOther; RDLHideOutput((SumOtherG <> 0) AND (NOT (ConsolidatePositionsOfAJobG OR ConsolidatePositionsOfAPackageG))))
                        {
                            Description = 'EU.0000011,EU.0000012';
                        }
                        column(ShowCurrencyG; ShowCurrencyG)
                        {
                        }
                        column(VATAmountLineG_VATAmountText_C_INC018; VATAmountLineG.VATAmountText + C_INC050)
                        {
                            Description = 'PA040669.61669';
                        }
                        column(TotalNetG; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalVATG_ExchangeVATAmountG; TotalVATG - ExchangeVATAmountG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumFairDealG; SumFairDealG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC033; C_INC033)
                        {
                        }
                        column(HidePrintFairDeal; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND ((ServCustG."Show Fair Deal") AND (SumFairDealG <> 0))))
                        {
                            Description = 'EU.0000012';
                        }
                        column(VATAmountLineGCount; VATAmountLineG.COUNT)
                        {
                        }
                        column(TotalNetG_Control89; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalNetG_Control145; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintNoFairDeal; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND ((ServCustG."Show Fair Deal" = FALSE) OR (SumFairDealG = 0))))
                        {
                            Description = 'EU.0000012';
                        }
                        column(ExchangeVATAmountG; ExchangeVATAmountG)
                        {
                            AutoFormatExpression = SalesInvLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG_ExchTaxAmountText_C_INC018; VATAmountLineG.ExchTaxAmountText + C_INC018)
                        {
                        }
                        column(ExchangeVATBaseAmountG; ExchangeVATBaseAmountG)
                        {
                            AutoFormatExpression = SalesInvLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(HidePrintExchangeVATAmount; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND (ExchangeVATAmountG <> 0)))
                        {
                        }
                        column(TotalInclVATTextG; TotalInclVATTextG)
                        {
                        }
                        column(TotalGrossG; TotalGrossG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HidePrintVATAmountLine; RDLHideOutput(VATAmountLineG.COUNT <= 1))
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
                        column(QtyCaption; QtyCaptionLbl)
                        {
                        }
                        column(UOMCaption; UOMCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; ServPreviewLineG.FIELDCAPTION("Unit Price"))
                        {
                            Description = 'EU.0000011';
                        }
                        column(AmountCaption; ServPreviewLineG.FIELDCAPTION(Amount))
                        {
                            Description = 'EU.0000011';
                        }
                        column(VATIdentifierCaption; ServPreviewLineG.FIELDCAPTION("VAT Identifier"))
                        {
                            Description = 'PA033042,PA032651,EU.0000011';
                        }
                        column(TotalNetGCaption; TotalNetGCaptionLbl)
                        {
                        }
                        column(SumLaborGCaption; SumLaborGCaptionLbl)
                        {
                        }
                        column(SumItemGCaption; SumItemGCaptionLbl)
                        {
                        }
                        column(SumExtServGCaption; SumExtServGCaptionLbl)
                        {
                        }
                        column(SumOtherGCaption; SumOtherGCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(FairDealAmountCaption; FairDealAmountCaptionLbl)
                        {
                        }
                        column(ServCustPrintFixedPriceG; ServCustPrintFixedPriceG)
                        {
                            Description = 'PA041187.91639';
                        }
                        column(PrintFixedPriceG; RDLHideOutput(PrintFixedPriceG))
                        {
                            Description = 'PA041187.91639';
                        }
                        column(HideQty; RDLHideOutput(ShowQtyG))
                        {
                            Description = 'PA041187.91639,PA041187.91743';
                        }
                        column(HideUOM; RDLHideOutput(ShowUOMG))
                        {
                            Description = 'PA041187.91639,PA041187.91743';
                        }
                        column(HideUnitPrice; RDLHideOutput(ShowUnitPriceG))
                        {
                            Description = 'PA041187.91639,PA041187.91743';
                        }
                        column(HideDiscount; RDLHideOutput(ShowDiscountG))
                        {
                            Description = 'PA041187.91639,PA041187.91743';
                        }
                        column(HideAmount; RDLHideOutput(ShowAmountG))
                        {
                            Description = 'PA041187.91639,PA041187.91743';
                        }
                        column(VATpercent_SIL; ServPreviewLineG."VAT %")
                        {
                        }
                        column(VATpercentCpn_SIL; ServPreviewLineG.FIELDCAPTION("VAT %"))
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
                            column(HideEUTireDataBody1; RDLHideOutputAsInteger(3))
                            {
                                Description = 'PA033336';
                            }
                            column(ServPreviewLineG_InvoiceLineNo; TempServPreviewLineG."Invoice Line No.")
                            {
                                Description = 'PA033336';
                            }
                            column(EUTireData_Number; Number)
                            {
                            }

                            trigger OnPreDataItem()
                            var
                                EUTireSetupL: Record "EU Tire Setup";
                                SalesInvoiceLineL: Record "Sales Invoice Line";
                            begin
                                // Start PA033765
                                CLEAR(EUTireInformationG);
                                IF SalesInvoiceLineL.GET("Sales Invoice Header"."No.", TempServPreviewLineG."Invoice Line No.") THEN BEGIN
                                    EUTireInformationG := EUTireSetupL.GetTireInformation(SalesInvoiceLineL.Type = SalesInvoiceLineL.Type::Item,
                                      SalesInvoiceLineL."EU Tire Data Code");
                                END;
                                IF EUTireInformationG = '' THEN BEGIN
                                    CurrReport.BREAK;
                                END;
                                // Stop PA033765
                            end;
                        }
                        dataitem(PackageBOM; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(PackageBOM_UnitOfMeasure; TempServPreviewLineBOMG."Unit of Measure")
                            {
                            }
                            column(PackageBOM_Quantity; TempServPreviewLineBOMG.Quantity)
                            {
                            }
                            column(PackageBOM_Description; TempServPreviewLineBOMG.Description)
                            {
                            }
                            column(PackageBOM_No; TempServPreviewLineBOMG."No.")
                            {
                            }
                            column(PackageBOM_VATId; TempServPreviewLineBOMG."VAT Identifier")
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(HidePackageBOM; RDLHideOutputAsInteger(3))
                            {
                                Description = 'PA033336';
                            }
                            column(PackageBOM_DocumentType; TempServPreviewLineBOMG."Document Type")
                            {
                            }
                            column(PackageBOM_DocumentNo; TempServPreviewLineBOMG."Document No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start EU.0000012
                                IF Number = 1 THEN
                                    TempServPreviewLineBOMG.FINDSET
                                ELSE
                                    TempServPreviewLineBOMG.NEXT;
                                // Stop EU.0000012
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT BOMOutputG THEN
                                    CurrReport.BREAK;

                                // Start EU.0000012
                                // Stop EU.0000012

                                IF (ServPreviewLineG."Line Type" <> ServPreviewLineG."Line Type"::Job) OR
                                   (ServPreviewLineG."Service Job No." <> 0) OR (ServPreviewLineG."Package No." = '')
                                THEN
                                    CurrReport.BREAK;

                                // Start EU.0000012
                                TempServPreviewLineBOMG.RESET;
                                TempServPreviewLineBOMG.SETRANGE("Package No.", ServPreviewLineG."Package No.");
                                TempServPreviewLineBOMG.SETRANGE("Suppress in Order", FALSE);
                                IF TempServPreviewLineBOMG.ISEMPTY THEN
                                    CurrReport.BREAK;
                                SETRANGE(Number, 1, TempServPreviewLineBOMG.COUNT);
                                // Stop EU.0000012
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            ServLineL: Record "Service Line";
                            ItemL: Record Item;
                            ServHdrL: Record "Service Header";
                            ServJobLineL: Record "Service Job Line";
                        begin
                            IF Number = 1 THEN
                                TempServPreviewLineG.FIND('-')
                            ELSE
                                TempServPreviewLineG.NEXT;
                            // Start EU.0000012
                            // Stop EU.0000012
                            ServPreviewLineG := TempServPreviewLineG;
                            // Start EU.0000011
                            TextBlockContentG := '';
                            // Stop EU.0000011
                            FixedPriceLabG := FALSE;
                            // Start PA041187.91639
                            PrintFixedPriceG := FALSE;
                            // Stop PA041187.91639

                            CLEAR(ServLineL);
                            NoPropertyG := '';
                            // Start EU.0000012
                            IF SalesInvLineG.GET("Sales Invoice Header"."No.", ServPreviewLineG."Invoice Line No.") THEN BEGIN
                                IF GetServJobLine(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Service Job No.", ServJobLineL) THEN
                                    PrintFixedPriceG := ServJobLineL."Includes Fixed Price";
                                GetServCust(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Bill-to Customer No.");
                            END;

                            IF ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line THEN BEGIN
                                IF (SalesInvLineG."Service Order No." <> '') AND
                                   (SalesInvLineG."Service Order Line No." <> 0)
                                THEN BEGIN
                                    IF OrderInArcheG THEN BEGIN
                                        ArchServLineG.GET(ArchServLineG."Document Type"::Order, SalesInvLineG."Service Order No.",
                                          SalesInvLineG."Service Order Line No.");
                                        ServLineL.TRANSFERFIELDS(ArchServLineG);
                                    END ELSE BEGIN
                                        ServLineL.GET(ServLineL."Document Type"::Order, SalesInvLineG."Service Order No.",
                                          SalesInvLineG."Service Order Line No.");
                                    END;
                                END;
                                IF (ServLineL.Type = ServLineL.Type::Labor) AND (ServLineL."Fixed Price" <> 0) THEN
                                    FixedPriceLabG := TRUE;
                                // Stop EU.0000012

                                NoPropertyG := '';
                                NoTextG := SalesInvLineG."No.";
                                IF (SalesInvLineG.Type = SalesInvLineG.Type::Item) AND (SalesInvLineG."VAT Calculation Type" =
                                   SalesInvLineG."VAT Calculation Type"::"Exch. Parts Tax")
                                THEN BEGIN
                                    NoPropertyG := C_INC016;
                                    ExchangeDaG := TRUE;
                                END;

                                IF NOT ServLineL.GET(ServHdrG."Document Type", ServHdrG."No.",
                                   SalesInvLineG."Service Order Line No.")
                                THEN BEGIN
                                    IF NOT ArchServLineG.GET(ServHdrG."Document Type", ServHdrG."No.",
                                       SalesInvLineG."Service Order Line No.")
                                    THEN BEGIN
                                        CLEAR(ServLineL);
                                    END ELSE BEGIN
                                        ServLineL.TRANSFERFIELDS(ArchServLineG);
                                        // Start EU.0000011
                                        // Stop EU.0000011
                                    END;
                                END;
                                // Start EU.0000011
                                // Stop EU.0000011

                                FixedPriceLabG := FALSE;
                                IF (ServLineL.Type = ServLineL.Type::Labor) AND (ServLineL."Fixed Price" <> 0) THEN
                                    FixedPriceLabG := TRUE;
                                IF ServLineL.Type IN [ServLineL.Type::Item, ServLineL.Type::"G/L Account",
                                   ServLineL.Type::"Ext. Service", ServLineL.Type::Labor]
                                THEN BEGIN
                                    NoTextG := ServLineL."No.";
                                END;

                                IF ServPreviewLineG."Fair Deal" AND (ServCustG."Show Fair Deal") THEN BEGIN
                                    NoPropertyG := NoPropertyG + C_INC033;
                                    FairDealDaG := TRUE;
                                END;

                                // Check if items must be returned
                                IF ServLineL.Type = ServLineL.Type::Item THEN BEGIN
                                    // Start PA041366
                                    IF ServLineL."Sending Required" IN [ServLineL."Sending Required"::Keep, ServLineL."Sending Required"::Send] THEN BEGIN
                                        // Stop PA041366
                                        NoPropertyG := NoPropertyG + C_INC034;     // Flag for return part = R
                                        ReturnDaG := TRUE;
                                    END;
                                END;

                                IF OrderInArcheG THEN BEGIN
                                    ArchServCustLineG.RESET;
                                    ArchServCustLineG.SETRANGE("Document Type", ServLineL."Document Type");
                                    ArchServCustLineG.SETRANGE("Document No.", ServLineL."Document No.");
                                    ArchServCustLineG.SETRANGE("Document Line No.", ServLineL."Line No.");
                                    ArchServCustLineG.SETRANGE("Bill-to Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                                    IF ArchServCustLineG.FIND('-') THEN BEGIN
                                        ServLineCustG.TRANSFERFIELDS(ArchServCustLineG);
                                    END ELSE BEGIN
                                        CLEAR(ServLineCustG);
                                    END;
                                END ELSE BEGIN
                                    ServLineCustG.RESET;
                                    ServLineCustG.SETRANGE("Document Type", ServLineL."Document Type");
                                    ServLineCustG.SETRANGE("Document No.", ServLineL."Document No.");
                                    ServLineCustG.SETRANGE("Document Line No.", ServLineL."Line No.");
                                    ServLineCustG.SETRANGE("Bill-to Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                                    IF NOT ServLineCustG.FIND('-') THEN BEGIN
                                        CLEAR(ServLineCustG);
                                    END;
                                END;

                                // Start PA034175
                                IF (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Line) AND
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

                            IF (SalesInvLineG.Quantity <> 0) AND
                               (SalesInvLineG."Additional Item" = SalesInvLineG."Additional Item"::Deposit)
                            THEN BEGIN
                                MARK(TRUE);
                            END;
                            // Start PA033890
                            // Stop PA033890
                            // Start PA033042
                            // Start EU.0000012
                            // Stop EU.0000012
                            // Stop PA033042
                            // Start PA033890
                            IF CasePrintPosition THEN BEGIN
                                IF (PrintWithoutDiscG) OR (ServPreviewLineG."Line Discount Amount" * ServPreviewLineG.Quantity < 0) THEN BEGIN
                                    ServPreviewLineG."Unit Price" := ServPreviewLineG.Amount / ServPreviewLineG.Quantity;
                                    ServPreviewLineG."Line Discount %" := 0;
                                END;
                                ServPreviewLineG."Unit Price" := ROUND(ServPreviewLineG."Unit Price");
                            END;
                            // Start EU.0000012
                            // Stop EU.0000012
                            // Stop PA033890

                            // Start PA041187.91639
                            // Start EU.0000012
                            // Stop EU.0000012
                            ServCustPrintFixedPriceG := ServCustG."Print Service Job Fixed Price";
                            DetermineColumnVisibility();
                            // Stop PA041187.91639

                            // Start PA034051
                            VehApptDescriptionG := '';
                            IF ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Job THEN
                                IF ServJobLineL.GET(ServPreviewLineG."Document Type", ServPreviewLineG."Document No.", ServPreviewLineG."Service Job No.") THEN
                                    IF (ServJobLineL."Veh. Appointment Code" <> '') AND
                                       (ServJobLineL."Veh. Appointment Status" <> ServJobLineL."Veh. Appointment Status"::New)
                                    THEN
                                        VehApptDescriptionG := ServMgmtG.CreateApptDescription(ServJobLineL);
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
                        var
                            ExchPartsVATDummyL: Decimal;
                        begin
                            // Start EU.0000012
                            VATAmountLineG.DELETEALL;

                            TempServPreviewLineG.CreateFromSalesInvoice(ServHdrG, VATAmountLineG, VATIdentifierTempG, "Sales Invoice Header"."No.");
                            TempServPreviewLineG.GetTotals(ServSetupG."Output Ext. Service", SumItemG, SumExtServG, SumLaborG, SumOtherG, SumFairDealG);
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
                            // Stop EU.0000012

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
                        column(VATCounter_ShowCurrencyG; ShowCurrencyG)
                        {
                        }
                        column(VATCounter_TotalNetG; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_SumFairDealG; SumFairDealG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_C_INC033; C_INC033)
                        {
                        }
                        column(HideVATCounterHeader1; RDLHideOutput((VATAmountLineG.COUNT > 1) AND (ServCustG."Show Fair Deal") AND (SumFairDealG <> 0)))
                        {
                        }
                        column(HideVATCounterHeader2; RDLHideOutput((VATAmountLineG.COUNT > 1) AND ((ServCustG."Show Fair Deal" = FALSE) OR (SumFairDealG = 0))))
                        {
                        }
                        column(VATAmountLineG__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG_VATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG_VATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATTextG; VATTextG)
                        {
                        }
                        column(HideVATCounterBody; RDLHideOutput(TRUE))
                        {
                        }
                        column(VATCounter_VATAmountLineG_ExchTaxAmountText_C_INC018; VATAmountLineG.ExchTaxAmountText + C_INC018)
                        {
                        }
                        column(VATCounter_C_INC016; C_INC016)
                        {
                        }
                        column(VATCounter_ExchangeVATAmountG; ExchangeVATAmountG)
                        {
                            AutoFormatExpression = SalesInvLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATCounter_ExchangeVATBaseAmountG; ExchangeVATBaseAmountG)
                        {
                            AutoFormatExpression = SalesInvLineG.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterFooter6; RDLHideOutput((VATAmountLineG.COUNT > 1) AND (ExchangeVATAmountG <> 0)))
                        {
                        }
                        column(VATCounter_TotalInclVATTextG; TotalInclVATTextG)
                        {
                        }
                        column(VATCounter_TotalGrossG; TotalGrossG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterFooter7; RDLHideOutput(VATAmountLineG.COUNT > 1))
                        {
                        }
                        column(VATCounter_TotalCaption; TotalCaptionLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(VATCounter_FairDealAmountCaption; FairDealAmountCaptionLbl)
                        {
                            Description = 'EU.0000011';
                        }
                        column(VATCounter_Header2_TotalCaption; TotalCaptionLbl)
                        {
                            Description = 'EU.0000011';
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
                            // Start EU.0000011
                            VATTextG := STRSUBSTNO('%1%2', VATAmountLineG."VAT %", C_INC001);
                            // Stop EU.0000011
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
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Footer));
                        column(FooterText_Text; Text)
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
                    dataitem("No Charge"; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(HideNoChargeBody1; RDLHideOutputAsInteger(7))
                        {
                        }
                        column(PoswithoutChargesCaption; PoswithoutChargesCaptionLbl)
                        {
                        }
                        column(No_Charge_Number; Number)
                        {
                        }
                        dataitem(LinesWithoutCharges1; "Service Line")
                        {
                            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                            column(LinesWithoutCharges1_UnitofMeasure; LinesWithoutCharges1."Unit of Measure")
                            {
                            }
                            column(LinesWithoutCharges1_Description; LinesWithoutCharges1.Description)
                            {
                            }
                            column(LinesWithoutCharges1_No; LinesWithoutCharges1."No.")
                            {
                            }
                            column(FreePctG; FreePctG)
                            {
                                DecimalPlaces = 2 : 2;
                            }
                            column(C_INC009; C_INC009)
                            {
                            }
                            column(LinesWithoutCharges1_Quantity; LinesWithoutCharges1.Quantity)
                            {
                                DecimalPlaces = 2 : 2;
                            }
                            column(HideLineswithoutCharge1Body1; RDLHideOutputAsInteger(8))
                            {
                            }
                            column(LinesWithoutCharges1_Description2; LinesWithoutCharges1."Description 2")
                            {
                            }
                            column(HideLineswithoutCharge1Body2; RDLHideOutput(LinesWithoutCharges1."Description 2" <> ''))
                            {
                            }
                            column(HideLinesWithoutCharge1Footer; RDLHideOutputAsInteger(9))
                            {
                            }
                            column(LinesWithoutCharges1_Document_Type; "Document Type")
                            {
                            }
                            column(LinesWithoutCharges1_Document_No_; "Document No.")
                            {
                            }
                            column(LinesWithoutCharges1_Line_No_; "Line No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                FreeServLineCustG.SETRANGE("Document Line No.", LinesWithoutCharges1."Line No.");
                                FreePctG := 0;
                                IF FreeServLineCustG.FIND('-') THEN
                                    REPEAT
                                        FreeServCustG.SETRANGE("Bill-to Customer No.", FreeServLineCustG."Bill-to Customer No.");
                                        IF FreeServCustG.FIND('-') THEN
                                            FreePctG := FreePctG + FreeServLineCustG."Portion %";
                                    UNTIL FreeServLineCustG.NEXT = 0;

                                IF FreePctG = 0 THEN
                                    CurrReport.SKIP;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF OrderInArcheG THEN
                                    CurrReport.BREAK;

                                LinesWithoutCharges1.RESET;
                                LinesWithoutCharges1.SETRANGE("Document Type", ServHdrG."Document Type");
                                LinesWithoutCharges1.SETRANGE("Document No.", ServHdrG."No.");
                                LinesWithoutCharges1.SETRANGE("Suppress in Order", FALSE);
                                FreeServLineCustG.RESET;
                                FreeServLineCustG.SETRANGE("Document Type", ServHdrG."Document Type");
                                FreeServLineCustG.SETRANGE("Document No.", ServHdrG."No.");
                                FreeServLineCustG.SETFILTER("Bill-to Customer No.", '<>%1', "Sales Invoice Header"."Bill-to Customer No.");
                            end;
                        }
                        dataitem(LinesWithoutCharge2; "Archived Service Line")
                        {
                            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                            column(FreePctG_Control225; FreePctG)
                            {
                                DecimalPlaces = 2 : 2;
                            }
                            column(C_INC009_Control226; C_INC009)
                            {
                            }
                            column(LinesWithoutCharge2_UnitofMeasure; LinesWithoutCharge2."Unit of Measure")
                            {
                            }
                            column(LinesWithoutCharge2_Quantity; LinesWithoutCharge2.Quantity)
                            {
                                DecimalPlaces = 2 : 2;
                            }
                            column(LinesWithoutCharge2_Description; LinesWithoutCharge2.Description)
                            {
                            }
                            column(LinesWithoutCharge2_No; LinesWithoutCharge2."No.")
                            {
                            }
                            column(HideLineswithoutCharge2Body1; RDLHideOutputAsInteger(10))
                            {
                            }
                            column(LinesWithoutCharge2_Description2; LinesWithoutCharge2."Description 2")
                            {
                            }
                            column(HideLinewithoutCharge2Body2; RDLHideOutput(LinesWithoutCharge2."Description 2" <> ''))
                            {
                            }
                            column(HideLinesWithoutCharge2Footer; RDLHideOutputAsInteger(11))
                            {
                            }
                            column(LinesWithoutCharge2_Document_Type; "Document Type")
                            {
                            }
                            column(LinesWithoutCharge2_Document_No_; "Document No.")
                            {
                            }
                            column(LinesWithoutCharge2_Line_No_; "Line No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                FreeArchServLineCustG.SETRANGE("Document Line No.", LinesWithoutCharge2."Line No.");
                                FreePctG := 0;
                                IF FreeArchServLineCustG.FIND('-') THEN
                                    REPEAT
                                        FreeArchServCustG.SETRANGE("Bill-to Customer No.", FreeArchServLineCustG."Bill-to Customer No.");
                                        IF FreeServCustG.FIND('-') THEN
                                            FreePctG := FreePctG + FreeArchServLineCustG."Portion %";
                                    UNTIL FreeArchServLineCustG.NEXT = 0;

                                IF FreePctG = 0 THEN
                                    CurrReport.SKIP;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT OrderInArcheG THEN
                                    CurrReport.BREAK;

                                LinesWithoutCharge2.RESET;
                                LinesWithoutCharge2.SETRANGE("Document Type", ServHdrG."Document Type");
                                LinesWithoutCharge2.SETRANGE("Document No.", ServHdrG."No.");
                                LinesWithoutCharge2.SETRANGE("Suppress in Order", FALSE);
                                FreeArchServLineCustG.RESET;
                                FreeArchServLineCustG.SETRANGE("Document Type", ServHdrG."Document Type");
                                FreeArchServLineCustG.SETRANGE("Document No.", ServHdrG."No.");
                                FreeArchServLineCustG.SETFILTER("Bill-to Customer No.", '<>%1', "Sales Invoice Header"."Bill-to Customer No.");
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT FreeOutputG THEN
                                CurrReport.BREAK;

                            IF OrderInArcheG THEN BEGIN
                                IF ArchServCustG.GET(ServHdrG."Document Type", ServHdrG."No.",
                                   "Sales Invoice Header"."Bill-to Customer No.")
                                THEN
                                    ServCustG.TRANSFERFIELDS(ArchServCustG);
                            END ELSE BEGIN
                                IF ServCustG.GET(ServHdrG."Document Type", ServHdrG."No.",
                                   "Sales Invoice Header"."Bill-to Customer No.")
                                THEN
                                    ;
                            END;

                            IF NOT ServCustG."Show No-Charge Lines" THEN
                                CurrReport.BREAK;

                            IF OrderInArcheG THEN BEGIN
                                FreeArchServLineG.RESET;
                                FreeArchServLineG.SETRANGE("Document Type", ServHdrG."Document Type");
                                FreeArchServLineG.SETRANGE("Document No.", ServHdrG."No.");
                                FreeArchServCustG.RESET;
                                FreeArchServCustG.SETRANGE("Document Type", ServHdrG."Document Type");
                                FreeArchServCustG.SETRANGE("Document No.", ServHdrG."No.");
                                FreeArchServCustG.SETRANGE("Customer for No-Charge Lines", TRUE);
                                FreeArchServCustG.SETFILTER("Bill-to Customer No.", '<>%1', "Sales Invoice Header"."Bill-to Customer No.");
                                IF NOT FreeArchServCustG.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE BEGIN
                                FreeServLineG.RESET;
                                FreeServLineG.SETRANGE("Document Type", ServHdrG."Document Type");
                                FreeServLineG.SETRANGE("Document No.", ServHdrG."No.");
                                FreeServCustG.RESET;
                                FreeServCustG.SETRANGE("Document Type", ServHdrG."Document Type");
                                FreeServCustG.SETRANGE("Document No.", ServHdrG."No.");
                                FreeServCustG.SETRANGE("Customer for No-Charge Lines", TRUE);
                                FreeServCustG.SETFILTER("Bill-to Customer No.", '<>%1', "Sales Invoice Header"."Bill-to Customer No.");
                                IF NOT FreeServCustG.FIND('-') THEN
                                    CurrReport.BREAK;
                            END;
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(LegendTextG; LegendTextG)
                        {
                        }
                        column(HideTotalBody1; RDLHideOutput(FairDealDaG OR ReturnDaG OR ExchangeDaG OR ProportinatelyChargingG))
                        {
                        }
                        column(PaymentTermsG_Description; PaymentTermsG.Description)
                        {
                        }
                        column(HideTotalBody2; RDLHideOutput(PaymentTermsG.Description <> ''))
                        {
                        }
                        column(ExplanationsCaption; ExplanationsCaptionLbl)
                        {
                        }
                        column(PaymentTermsG_Caption; PaymentTermsG_CaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033890
                            LegendTextG := '';
                            IF FairDealDaG THEN
                                LegendTextG := C_INC035;
                            IF ReturnDaG THEN BEGIN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC036
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC036;
                            END;
                            IF ExchangeDaG THEN BEGIN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC037
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC037;
                            END;
                            IF ProportinatelyChargingG THEN BEGIN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC041
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC041;
                            END;
                            // Stop PA033890
                        end;
                    }
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("No.") WHERE("Type of Document to be Printed" = CONST("Sales Invoice"));
                        column(PostedCashRegisterHeader_PaymentInOut; "Payment (In/Out)")
                        {
                        }
                        column(HidePostedCashRegBody1; RDLHideOutputAsInteger(12))
                        {
                        }
                        column(PostedCashRegHdr_No; "Posted Cash Register Header"."No.")
                        {
                        }
                        dataitem("Cash Reg. Add Disc Split Post."; "Cash Reg. Add Disc Split Post.")
                        {
                            DataItemLink = "Applies-to ID" = FIELD("No.");
                            DataItemTableView = SORTING("Source Type", "Source No.", "Applies-to ID");
                            column(HideCashRegAddDiscHeader1; RDLHideOutputAsInteger(13))
                            {
                            }
                            column(CashRegAddDiscSplitPost_PostingDate; FORMAT("Posting Date"))
                            {
                            }
                            column(CashRegAddDiscSplitPost_AppltoDocumentType; "Appl.-to Document Type")
                            {
                            }
                            column(CashRegAddDiscSplitPost_AppltoDocumentNo; "Appl.-to Document No.")
                            {
                            }
                            column(CashRegAddDiscSplitPost_CurrencyCode; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(CashRegAddDiscSplitPost_RemainingAmount; "Remaining Amount")
                            {
                            }
                            column(CashRegAddDiscSplitPost_PmtDiscountTotal; "Pmt. Discount Total")
                            {
                            }
                            column(CashRegAddDiscSplitPost_AmountMinusDiscG; AmountMinusDiscG)
                            {
                            }
                            column(HideCashRegAddDiscBody2; RDLHideOutputAsInteger(14))
                            {
                            }
                            column(CashRegAddDiscSplitPost_AppliestoID; "Cash Reg. Add Disc Split Post."."Applies-to ID")
                            {
                            }
                            column(CashRegAddDiscSplitPost_PostingDateCaption; CashRegAddDiscSplitPost_PostingDateCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPost_AppltoDocumentTypeCaption; CashRegAddDiscSplitPost_AppltoDocumentTypeCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPost_AppltoDocumentNoCaption; CashRegAddDiscSplitPost_AppltoDocumentNoCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPost_CurrencyCode_Caption; CashRegAddDiscSplitPost_CurrencyCode_CaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPost_RemainingAmountCaption; CashRegAddDiscSplitPost_RemainingAmountCaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPost_PmtDiscount_Caption; CashRegAddDiscSplitPost_PmtDiscount_CaptionLbl)
                            {
                            }
                            column(CashRegAddDiscSplitPost_AmountMinusDiscGCaption; CashRegAddDiscSplitPost_AmountMinusDiscGCaptionLbl)
                            {
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
                            column(PostedCashRegisterHeader_CurrencyCode; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterHeader_AmounttoPayLCY; "Posted Cash Register Header"."Amount to Pay (LCY)")
                            {
                            }
                            column(HidePostedCashRegLineHeader1; RDLHideOutputAsInteger(15))
                            {
                            }
                            column(PostedCashRegisterLine_MeansofPaymentCode; "Means of Payment Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterLine_CurrencyCode; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(PostedCashRegisterLine_Amount; Amount)
                            {
                            }
                            column(HidePostedCashRegLineBody2; RDLHideOutputAsInteger(16))
                            {
                            }
                            column(PostedCashRegisterHeader_AmountGiven; "Posted Cash Register Header"."Amount Given")
                            {
                            }
                            column(PostedCashRegisterHeader_ChangeMoney; "Posted Cash Register Header"."Change Money")
                            {
                            }
                            column(PostedCashRegisterHeader_RemainingStatusTextG; RemainingStatusTextG)
                            {
                            }
                            column(PostedCashRegisterHeader_RemainingAmountTextG; RemainingAmountTextG)
                            {
                            }
                            column(HidePostedCashRegLineFooter3; RDLHideOutputAsInteger(17))
                            {
                            }
                            column(PostedCashRegisterHeader_AmounttoPayLCYCaption; PostedCashRegisterHeader_AmounttoPayLCYCaptionLbl)
                            {
                            }
                            column(PostedCashRegisterHeader_AmountGivenCaption; PostedCashRegisterHeader_AmountGivenCaptionLbl)
                            {
                            }
                            column(PostedCashRegisterHeader_ChangeMoneyCaption; PostedCashRegisterHeader_ChangeMoneyCaptionLbl)
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
                            // Start PA033086.7055966
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
                            // Stop PA033086.7055966
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT PmtMethodG.GET("Sales Invoice Header"."Payment Method Code") OR NOT PmtMethodG."Cash Payment" THEN BEGIN
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
                    dataitem(VATTextLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(HideVATTextBody1; RDLHideOutputAsInteger(18))
                        {
                        }
                        column(VATTextLoop_Number; Number)
                        {
                        }
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
                            column(HideVATTextBody2; RDLHideOutput(VATLegendsG <> ''))
                            {
                                Description = 'PA035395.18593';
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
                                // Start PA033890
                                VATLegendsG := '';
                                IF IncrG = 1 THEN
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC048;
                                IncrG := IncrG + 1;
                                ;
                                // Stop PA033890
                            end;

                            trigger OnPreDataItem()
                            begin
                                // Start PA033042
                                SETRANGE("VAT Identifier Code", VATIdentifierTempG.Code);
                                SETRANGE("Language Code", VATTextHdrG.GetLanguageCode(VATIdentifierTempG.Code, "Sales Invoice Header"."Language Code"));
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
                            // Stop PA03246

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
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
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
                            VATClauseG.TranslateDescription("Sales Invoice Header"."Language Code");
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
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                    END;

                    // Start PA033336
                    // Start PA035597
                    // Stop PA035597
                    ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    IF ("Sales Invoice Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        // Start PA035395.18593
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC045
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV

                    // Stop PA035395.18593
                    // Stop PA033336

                    // Start PA033890
                    LoopNoG += 1;
                    // Stop PA033890
                    OldServJobNoG := 0;
                    SumLaborG := 0;
                    SumItemG := 0;
                    SumExtServG := 0;
                    SumOtherG := 0;
                    SumFairDealG := 0;
                    TotalNetG := 0;
                    TotalGrossG := 0;
                    TotalVATG := 0;
                    ProportinatelyChargingG := FALSE;
                end;

                trigger OnPostDataItem()
                begin
                    // Start EU.0000039
                    IF ProformaInvoiceRecPositionG = '' THEN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesInvCountPrintedG.RUN("Sales Invoice Header");
                    // Stop EU.0000039
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
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA040669.61669
                // Stop PA040669.61669

                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                // Start PA039225.51457
                // Stop PA039225.51457
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Service - Job/Package Inv.");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Invoice Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Invoice Header"."User ID");

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                ServHdrG.CALCFIELDS("Driver Name");
                //Stop API.1      01.03.18 PV

                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                CurrReport.LANGUAGE := BillToCustG.PrintDocInCustLanguage();
                PrintWithoutDiscG := NOT "Sales Invoice Header"."Show Discount";

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
                IF bankAccountL.GET("Sales Invoice Header"."Bank Account Code") THEN BEGIN
                    BankNameG := bankAccountL.Name;
                    BankBranchNoG := bankAccountL."Bank Branch No."; //not used on layout
                                                                     //vapa??
                                                                     //  IF BankAccountNoG = '' THEN BEGIN
                                                                     //    BankAccountNoG := bankAccountL."Bank Account No.";
                                                                     //    BankIbanG:= bankAccountL.IBAN;
                                                                     //    BankSwiftG := bankAccountL."SWIFT Code";
                                                                     //  END;
                END;
                // // Start PA033041
                // IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                //   OwnBanksG.GET(IntCustG, LocationG."Bank Code") THEN
                //  BEGIN // Start API.1      01.03.18 PV
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // Stop API.1      01.03.18 PV
                // // Start EU.0000011
                //    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No." +
                //      C_INC046 + OwnBanksG."SWIFT-BIC" + C_INC047 + OwnBanksG.IBAN
                //  END // Start API.1      01.03.18 PV
                // ELSE
                //  BEGIN
                //    BankNameG := CompanyInfoG."Bank Name";
                //    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                //    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                //    BankIbanG := CompanyInfoG.IBAN;
                //    BankAccountNoG := CompanyInfoG."Bank Account No.";
                //    // Stop API.1      01.03.18 PV
                //    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No." +
                //      C_INC046 + CompanyInfoG."SWIFT-BIC" + C_INC047 + CompanyInfoG.IBAN;
                //  END; // API.1      01.03.18 PV
                // // Stop EU.0000011
                // // Stop PA033041
                // Start API.1.0.2  07.06.18 PV

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

                // Start PA039784.45749
                FormatAddrG.SetCustNo("Sales Invoice Header"."Bill-to Customer No.");
                // Stop PA039784.45749
                FormatAddrG.SalesInvBillTo(CustAddrG, "Sales Invoice Header");
                // Start PA039784.45749
                FormatAddrG.SetCustNo('');
                // Stop PA039784.45749

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Sales Invoice Header"."Payment Method Code") THEN
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

                FormatAddrG.SalesInvShipTo(ShipToAddrG, "Sales Invoice Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                OrderInArcheG := FALSE;
                // Start PA041187.91639
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
                // Stop PA041187.91639

                // Start PA040669.61669
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
                // Stop PA040669.61669

                IF ServHdrG."Service Advisor No." <> '' THEN BEGIN
                    EmployeeG.GET(ServHdrG."Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                END ELSE
                    ServAdvisorG := '';

                // Start PA041187.91639
                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscTextG := FindDiscountText();
                END;
                // Stop PA041187.91639

                SumDaysCarriedG := 0;
                DaysCarriedText2G := '';
                IF PrintDaysCarriedG THEN BEGIN
                    ServDaysCarriedG.RESET;
                    ServDaysCarriedG.SETRANGE("Document Type", ServDaysCarriedG."Document Type"::Order);
                    ServDaysCarriedG.SETRANGE("Document No.", "Service Order No.");
                    IF NOT ServDaysCarriedG.FIND('-') THEN BEGIN
                        ArchServDaysCarriedG.RESET;
                        ArchServDaysCarriedG.SETRANGE("Document Type", ArchServDaysCarriedG."Document Type"::Order);
                        ArchServDaysCarriedG.SETRANGE("Document No.", "Service Order No.");
                        IF ArchServDaysCarriedG.FIND('-') THEN
                            REPEAT
                                SumDaysCarriedG := SumDaysCarriedG + ArchServDaysCarriedG."Days Carried";
                            UNTIL ArchServDaysCarriedG.NEXT = 0;
                    END ELSE BEGIN
                        REPEAT
                            SumDaysCarriedG := SumDaysCarriedG + ServDaysCarriedG."Days Carried";
                        UNTIL ServDaysCarriedG.NEXT = 0;
                    END;
                    IF SumDaysCarriedG = 1 THEN
                        DaysCarriedText2G := C_INC021
                    ELSE
                        DaysCarriedText2G := C_INC022;
                END;

                InvLineG.RESET;
                InvLineG.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                InvLineG.SETFILTER("Line Discount %", '>%1', 0);
                IF (InvLineG.COUNT <> 0) AND (NOT PrintWithoutDiscG) THEN
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

                IF "Sales Invoice Header"."Sell-to Customer No." <> "Sales Invoice Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesInvCust(OrderCustAddrG, "Sales Invoice Header");
                    //OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);  //API.1.0.1  09.05.18 PV
                    OrderCustAddrLineG := FormatAddrG.GetWindowAddress(C_INC005);  //API.1.0.1  09.05.18 PV
                END ELSE
                    OrderCustAddrLineG := '';

                CLEAR(ServCustG);
                // Start PA041187.91639
                GetServCust(ServHdrG."Document Type", ServHdrG."No.", "Sales Invoice Header"."Bill-to Customer No.");
                // Stop PA041187.91639

                WarrCustG := MakeG."Factory Warranty Customer";

                FairDealDaG := FALSE;
                ReturnDaG := FALSE;
                ExchangeDaG := FALSE;
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(42) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::SrvInvExt,
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
                CLEAR(EUServTextG);
                SalesInvLine2G.RESET;
                SalesInvLine2G.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                IF SalesInvLine2G.FIND('-') THEN
                    REPEAT
                        IF VATPostingSetupG.IsEUService(
                           SalesInvLine2G."VAT Bus. Posting Group",
                           SalesInvLine2G."VAT Prod. Posting Group")
                        THEN
                            EUServTextG := C_INC044;
                    UNTIL (SalesInvLine2G.NEXT = 0) OR (EUServTextG <> '');
            end;

            trigger OnPostDataItem()
            begin
                // Start EU.0000039
                IF ProformaInvoiceRecPositionG > '' THEN
                    SalesInvHdrG.DELETE(TRUE);
                // Stop EU.0000039
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                ServSetupG.GET();
                // Start EU.0000039
                IF ProformaInvoiceRecPositionG > '' THEN BEGIN
                    ServMgmtG.CreateProformaInvoice(SalesHdrG, SalesInvHdrG);
                    SETRANGE("No.", SalesInvHdrG."No.");
                END;
                // Stop EU.0000039
            end;
        }
    }

    requestpage
    {
        Caption = 'Service - Invoice';
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
                    field("Print Days Carried"; PrintDaysCarriedG)
                    {
                        Caption = 'Print Days Carried';
                        Description = 'EU.0000011';
                    }
                    field("Output Positions without Charges"; FreeOutputG)
                    {
                        Caption = 'Output Positions without Charges';
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
                    Description = 'EU.0000012';
                    field("Consolidate Negative Positions"; ConsolidateNegativePosG)
                    {
                        Caption = 'Consolidate Negative Positions';
                    }
                    field("Consolidate Positions of a Job"; ConsolidatePositionsOfAJobG)
                    {
                        Caption = 'Consolidate Positions of a Job';

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

                        trigger OnValidate()
                        begin
                            BOMOutputGOnPush;
                        end;
                    }
                    field("Consolidate Labor Positions"; ConsolidateLaborPosG)
                    {
                        Caption = 'Consolidate Labor Positions';
                        Description = 'EU.0000012';

                        trigger OnValidate()
                        begin
                            // Start EU.0000012
                            IF ConsolidateLaborPosG THEN
                                ConsolidatePositionsOfAJobG := FALSE;
                            // Stop EU.0000012
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
            // Start PA033890
            RePrintOriginalInvoiceEditable := TRUE;
            // Stop PA033890
        end;

        trigger OnOpenPage()
        begin
            // Start EU.0000011
            GetReportSelection();
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
            PrintDaysCarriedG := FALSE;
            FreeOutputG := FALSE;
            BOMOutputG := FALSE;
            ConsolidateNegativePosG := TRUE;
            RePrintOriginalInvG := FALSE;
            IF UserSetupG.GET(USERID) THEN
                RePrintOriginalInvoiceEditable := UserSetupG."Re-print Original Invoice"
            ELSE
                RePrintOriginalInvoiceEditable := FALSE;
            // Stop EU.0000011
            // Start EU.0000039
            ProformaInvoiceRecPositionG := "Sales Invoice Header".GETFILTER("Special Control Parameters");
            IF STRPOS(ProformaInvoiceRecPositionG, '/PROFORMA-INVOICE-FOR:') > 0 THEN BEGIN
                ProformaInvoiceRecPositionG := COPYSTR(ProformaInvoiceRecPositionG, STRPOS(ProformaInvoiceRecPositionG, '/PROFORMA-INVOICE-FOR:') + 22);
                ProformaInvoiceRecPositionG := COPYSTR(ProformaInvoiceRecPositionG, 1, STRLEN(ProformaInvoiceRecPositionG) - 1);
                SalesHdrG.SETPOSITION(ProformaInvoiceRecPositionG);
                SalesHdrG.FIND('=');
                ReportTitleG := STRSUBSTNO(C_INC_Proforma, ReportTitleG);
            END ELSE
                ProformaInvoiceRecPositionG := '';
            "Sales Invoice Header".SETRANGE("Special Control Parameters");
            // Stop EU.0000039
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetupG.GET;
        // Start EU.0000011
        GetReportSelection();
        PrintDaysCarriedG := FALSE;
        FreeOutputG := FALSE;
        BOMOutputG := FALSE;
        ConsolidateNegativePosG := TRUE;
        PrintNextVehicleAppointmentsG := TRUE;
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
        VATPostingSetupG: Record "VAT Posting Setup";
        UserSetupG: Record "User Setup";
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Service Manag. Rep. Selection";
        ArchServHdrG: Record "Archived Service Header";
        ArchServLineG: Record "Archived Service Line";
        ArchServDaysCarriedG: Record "Arch. Service Days Carried";
        ArchServCustG: Record "Archived Service Customer";
        ArchServCustLineG: Record "Archived Service Line Customer";
        FreeServLineG: Record "Service Line";
        FreeServCustG: Record "Service Customer";
        FreeServLineCustG: Record "Service Line Customer";
        FreeArchServLineG: Record "Archived Service Line";
        FreeArchServCustG: Record "Archived Service Customer";
        FreeArchServLineCustG: Record "Archived Service Line Customer";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        MakeG: Record Make;
        EmployeeG: Record Employee;
        VATAmountLineG: Record "VAT Amount Line" temporary;
        BillToCustG: Record Customer;
        SalesHdrG: Record "Sales Header";
        SalesInvHdrG: Record "Sales Invoice Header";
        InvLineG: Record "Sales Invoice Line";
        TempServPreviewLineG: Record "Service Preview Line" temporary;
        TempServPreviewLineBOMG: Record "Service Preview Line" temporary;
        SalesPurchG: Record "Salesperson/Purchaser";
        ServHdrG: Record "Service Header";
        ServCustG: Record "Service Customer";
        ServDaysCarriedG: Record "Service Days Carried";
        ServLineCustG: Record "Service Line Customer";
        ServPreviewLineG: Record "Service Preview Line";
        SalesInvLineG: Record "Sales Invoice Line";
        TextBlockG: Record "Text Block";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        SalesInvLine2G: Record "Sales Invoice Line";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        VATClauseG: Record "VAT Clause";
        VehicleCustomerG: Record "Vehicle Customer";
        FormatAddrG: Codeunit "Format Address";
        SalesInvCountPrintedG: Codeunit "Sales Inv.-Printed";
        RTCMgmtG: Codeunit "RTC Management";
        CollectiveG: Codeunit "Collection Unit";
        SegMgntG: Codeunit SegManagement;
        ServMgmtG: Codeunit "Service Management";
        UserSessionG: Codeunit "User Session Unit";
        TextBlockContentG: Text;
        ShowCurrencyG: Text[30];
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
        LegendTextG: Text[250];
        ShipToAddrG: array[8] of Text[50];
        CompAddrG: Text[250];
        VATNoTextG: Text[30];
        VATTextG: Text[50];
        NoPropertyG: Text[30];
        NoTextG: Text[30];
        DiscTextG: Text[20];
        ServAdvisorG: Text[50];
        DaysCarriedText2G: Text[20];
        TotalInclVATTextG: Text[50];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        ShipDateG: Text[30];
        ShipTextG: Text[30];
        EUServTextG: Text[100];
        DuplicateTextG: Text[30];
        VATLegendsG: Text[15];
        EUTireInformationG: Text[1024];
        ProformaInvoiceRecPositionG: Text[100];
        ReportTitleG: Text[100];
        WarrCustG: Code[20];
        IntCustG: Code[20];
        SumLaborG: Decimal;
        SumItemG: Decimal;
        SumExtServG: Decimal;
        SumFairDealG: Decimal;
        SumOtherG: Decimal;
        SumDaysCarriedG: Decimal;
        TotalNetG: Decimal;
        TotalGrossG: Decimal;
        TotalVATG: Decimal;
        AmountMinusDiscG: Decimal;
        ExchangeVATAmountG: Decimal;
        ExchangeVATBaseAmountG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        OldServJobNoG: Integer;
        NextEntryNoG: Integer;
        C_INC001: Label '% VAT of';
        IncrG: Integer;
        LoopNoG: Integer;
        FixedPriceLabG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No.:';
        ShowShippingAddrG: Boolean;
        MoreLinesG: Boolean;
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC009: Label '%';
        C_INC010: Label 'Package BOMs can only be output for consolidated packages !';
        C_INC014: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC018: Label ' from';
        PrintDaysCarriedG: Boolean;
        C_INC021: Label 'Day';
        C_INC022: Label 'Days';
        PrintSubtotalsG: Boolean;
        C_INC029: Label 'Copy of';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC033: Label 'k';
        ReturnDaG: Boolean;
        FairDealDaG: Boolean;
        ExchangeDaG: Boolean;
        C_INC034: Label 'R';
        C_INC035: Label 'F = Fair Deal Position';
        C_INC036: Label 'R = Return-mandatory part';
        C_INC037: Label '* = Replacement Part';
        ConsolidatePositionsOfAJobG: Boolean;
        ConsolidatePositionsOfAPackageG: Boolean;
        OrderInArcheG: Boolean;
        C_INC038: Label 'Sum';
        C_INC039: Label 'Sum';
        C_INC_TaxNo: Label 'Tax No.';
        FreeOutputG: Boolean;
        FreePctG: Decimal;
        BOMOutputG: Boolean;
        ConsolidateNegativePosG: Boolean;
        C_INC041: Label 'P = Proportionately Charged';
        ConsolidateLaborPosG: Boolean;
        ProportinatelyChargingG: Boolean;
        LogInteractionG: Boolean;
        RePrintOriginalInvG: Boolean;
        C_INC042: Label 'Shipment Date';
        C_INC043: Label 'Dispatch Date';
        C_INC044: Label 'The benefit recipient is the VAT debtor!';
        C_INC045: Label 'D U P L I C A T E';
        C_INC046: Label ' - SWIFT-BIC :';
        C_INC047: Label '- IBAN:';
        C_INC048: Label ' =';
        C_INC049: Label 'Service Invoice';
        C_INC_Proforma: Label 'Proforma %1';
        C_INC050: Label ' of';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        [InDataSet]
        RePrintOriginalInvoiceEditable: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        [InDataSet]
        VehApptDescriptionG: Text[50];
        PrintNextVehicleAppointmentsG: Boolean;
        Field45Lbl: Label 'Page';
        Field31Lbl: Label 'Customer No.';
        ServiceAdvisorCaptionLbl: Label 'Service Advisor';
        SalesAdvisorCaptionLbl: Label 'Sales Advisor';
        Field43Lbl: Label 'Salesperson';
        Field33Lbl: Label 'Order No.';
        Footer01Lbl: Label 'Payments to:';
        Next_Vehicle_Appointments__CaptionLbl: Label 'Next Vehicle Appointments:';
        QtyCaptionLbl: Label 'Qty.';
        UOMCaptionLbl: Label 'UoM';
        TotalNetGCaptionLbl: Label 'Continued';
        TotalNetG_Control125CaptionLbl: Label 'Sum carried forward';
        SumLaborGCaptionLbl: Label 'Sum Labor';
        SumItemGCaptionLbl: Label 'Sum Item';
        SumExtServGCaptionLbl: Label 'Sum External Services';
        SumOtherGCaptionLbl: Label 'Sum Other';
        TotalCaptionLbl: Label 'Total';
        FairDealAmountCaptionLbl: Label 'Fair Deal Amount';
        ContinuedCaptionLbl: Label 'Continued';
        PoswithoutChargesCaptionLbl: Label 'Positions without Charges';
        ExplanationsCaptionLbl: Label 'Explanations';
        PaymentTermsG_CaptionLbl: Label 'Payment Terms';
        CashRegAddDiscSplitPost_PostingDateCaptionLbl: Label 'Date';
        CashRegAddDiscSplitPost_AppltoDocumentTypeCaptionLbl: Label 'Type';
        CashRegAddDiscSplitPost_AppltoDocumentNoCaptionLbl: Label 'Document Number';
        CashRegAddDiscSplitPost_CurrencyCode_CaptionLbl: Label 'Currency';
        CashRegAddDiscSplitPost_RemainingAmountCaptionLbl: Label 'Remaining Amount';
        CashRegAddDiscSplitPost_PmtDiscount_CaptionLbl: Label 'Payment Discount';
        CashRegAddDiscSplitPost_AmountMinusDiscGCaptionLbl: Label 'Amount';
        PostedCashRegisterHeader_AmounttoPayLCYCaptionLbl: Label 'Amount to Pay';
        PostedCashRegisterHeader_AmountGivenCaptionLbl: Label 'Amount given';
        PostedCashRegisterHeader_ChangeMoneyCaptionLbl: Label 'Change Money';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATClausesCap: Label 'VAT Clause';
        VATIdentifierCap: Label 'VAT Identifier';
        C_INC_VAT: Label 'VAT';
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        MileageCaptionLbl: Label 'Mileage / Running Time';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_Name_Control87CaptionLbl: Label 'Salesperson';
        Sales_Invoice_Header___Service_Order_No__CaptionLbl: Label 'Order No.';
        Inspection_DateLbl: Label 'Inspection Date';
        Emission_DateLbl: Label 'Emission Date';
        Appt_Service_AdvisorLbl: Label 'Appt. Service Advisor';
        Pickup_Service_AdvisorLbl: Label 'Pickup Service Advisor';
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
        PrintFixedPriceG: Boolean;
        ServCustPrintFixedPriceG: Integer;
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
        ShowTaxNoG: Boolean;
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
        NoLbl: Label 'No.';
        SalesPurch_NameLbl: Label 'Salesperson';

    [Scope('Internal')]
    procedure SetAttribute(InvLineLocalL: Record "Sales Invoice Line"; var CurServPreviewLineL: Record "Service Preview Line"; var LinePropertyL: Text[10])
    var
        ItemL: Record Item;
    begin
        // Check Exchange Part flag and set it, if required
        // Identifier for exchange part = *
        IF InvLineLocalL."VAT Calculation Type" = InvLineLocalL."VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
            IF STRPOS(LinePropertyL, C_INC016) = 0 THEN
                LinePropertyL := LinePropertyL + C_INC016;
            ExchangeDaG := TRUE;
        END;

        // Check if items must be returned
        // Flag for return part = R
        IF InvLineLocalL.Type = InvLineLocalL.Type::Item THEN BEGIN
            // Start PA041366
            IF InvLineLocalL."Sending Required" IN [InvLineLocalL."Sending Required"::Keep, InvLineLocalL."Sending Required"::Send] THEN BEGIN
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
        // Start PA033765
        EXIT(FALSE);
        // Stop PA033765
    end;

    [Scope('Internal')]
    procedure ShowOutputFixedLaborQuantityPrice(): Boolean
    begin
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
        // Start PA033890
        EXIT(((ServPreviewLineG.Type = ServPreviewLineG.Type::Labor) AND
            (FixedPriceLabG) AND
            (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity Only")));
        // Stop PA033890
    end;

    [Scope('Internal')]
    procedure ShowOutputFixedLaborPriceOnly(): Boolean
    begin
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
        ReportTitleG := C_INC049;
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
        SalesInvHdrL: Record "Sales Invoice Header";
    begin
        // @ This function sets the number of copies from Customer Card.

        // Start PA043099
        SalesInvHdrL.SETRANGE(SalesInvHdrL."No.", "Sales Invoice Header".GETFILTER("No."));
        IF SalesInvHdrL.FINDFIRST THEN BEGIN
            IF NOT CustL.GET(SalesInvHdrL."Bill-to Customer No.") THEN
                IF NOT CustL.GET(SalesInvHdrL."Sell-to Customer No.") THEN
                    CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
            // Start PA043099.90573
        END ELSE BEGIN
            SalesInvHdrL.SETRANGE(SalesInvHdrL."No.");
            SalesInvHdrL.SETRANGE(SalesInvHdrL."Pre-Assigned No.", "Sales Invoice Header".GETFILTER("Pre-Assigned No."));
            IF SalesInvHdrL.FINDFIRST THEN BEGIN
                IF NOT CustL.GET(SalesInvHdrL."Bill-to Customer No.") THEN
                    IF NOT CustL.GET(SalesInvHdrL."Sell-to Customer No.") THEN
                        CLEAR(CustL);
                NoOfCopiesG += CustL."Invoice Copies";
            END;
            // Stop PA043099.90573
        END;
        // Stop PA043099
    end;

    [Scope('Internal')]
    procedure FindDiscountText(): Text
    var
        ServJobLineL: Record "Service Job Line";
        ServLineL: Record "Service Line";
        ArchServJobLineL: Record "Archived Service Job Line";
        ArchServLineL: Record "Archived Service Line";
    begin
        // @ Finds Discount Text
        // @ retval - Text

        // Start PA041187.91639
        DiscTextG := '';
        ServJobLineL.RESET;
        ServJobLineL.SETRANGE("Document Type", ServJobLineL."Document Type"::Order);
        ServJobLineL.SETRANGE("Document No.", "Sales Invoice Header"."Service Order No.");
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
                //lala
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
            ServLineL.SETRANGE("Document No.", "Sales Invoice Header"."Service Order No.");
            ServLineL.SETRANGE("Service Job No.", 0);
            ServLineL.SETFILTER("Line Discount %", '>%1', 0);
            IF NOT ServLineL.ISEMPTY THEN
                DiscTextG := C_INC014
        END;
        // Stop PA041187.91639
    end;

    local procedure GetServCust(DocumentTypeP: Integer; DocumentNoP: Code[20]; BilltoCustomerNoP: Code[20]): Boolean
    begin
        // @ Gets Service Customer
        // @ param DocumentTypeP - Integer
        // @ param DocumentNoP - Code 20
        // @ param BilltoCustomerNoP - Code 20
        // @ retval - Boolean

        // Start PA041187.91639
        IF NOT ServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
            IF NOT ArchServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
                EXIT(FALSE)
            ELSE
                ServCustG.TRANSFERFIELDS(ArchServCustG);
        EXIT(TRUE);
        // Stop PA041187.91639
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

        // Start PA041187.91639
        IF NOT ServJobLineP.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
            IF NOT ArchServJobLineL.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
                EXIT(FALSE)
            ELSE
                ServJobLineP.TRANSFERFIELDS(ArchServJobLineL);
        EXIT(TRUE);
        // Stop PA041187.91639
    end;

    [Scope('Internal')]
    procedure DetermineColumnVisibility()
    begin
        // Determines Column Visibility based on Print Service Job Fixed Price value of the current Service Customer Line
        // Start PA041187.91639
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
        // Stop PA041187.91639
    end;

    [Scope('Internal')]
    procedure EvalHidePrintSubtotal() ValueR: Boolean
    begin
        // @ Evaluates HidePrintPosBody5 - SumLines
        // @ retval ValueR - Boolean

        // Start PA041187.916
        // Start EU.0000012
        ValueR := (ServPreviewLineG."Line Type" = ServPreviewLineG."Line Type"::Sum) AND (PrintSubtotalsG) AND (ShowLineSubTotalsG);
        // Stop EU.0000012
        IF TempServPreviewLineG."Control Type" = TempServPreviewLineG."Control Type"::Job THEN
            ValueR := TRUE;
        // Stop PA041187.91639
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
                TitleTextRightG := "Sales Invoice Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Invoice Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Invoice Header"."No.";
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


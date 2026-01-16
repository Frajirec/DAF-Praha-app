report 80030 "DPG Service Invoice CZ" // 1057608 "Service Invoice CZ"
{
    // // @ Area ServiceManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   05.08.10 Changes made to print original/duplicate invoices.
    // PA032178   27.10.10 DD 1798176 docu trigger and version list corrected.
    // PA033041   03.03.11 PR Added code to display 'SWIFT-BIC' and 'IBAN' details.
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA033052   05.05.11 PR Added code and image controls in report section to print company logo and make logo's.
    //                        Added code to print the report title from 'Report Selection' setup.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                        Moved the VATTextLoop, VATTextLine Dataitem position as last footer.
    //                        Increased width of 'VAT Identifier' control and right aligned.
    // PA032443   11.11.11 SS Print PDF Document
    //                        - Added Code in OnPreReport() trigger
    // PA032651   27.07.11 PR 4242265: Corrected the text format error in C_INC007.
    // PA033041   14.12.11 PR 5913469: Modified C_INC040.
    // PA032651   16.01.12 SS 6098924 - Division by zero error - Changed "Sales Invoice Line - OnAfterGetRecord()"
    // PA033011   31.01.12 GB 5983155: VAT legend is not printed correctly
    // PA033136   01.03.12 TS Merge of 3.2.5.0 | PA032723
    // PA033086   28.03.12 GB 6570305: Add functionality for Rem. Amount from Cash Registers
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033019   18.06.12 GB 6221937: Layout Changes for Vat
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033336   21.09.12    RDLC Development
    //                        - Conversion to RDLC Format
    //                        - RequestPage created
    //                        - Standardizing Font size across all controls
    //                        - Transheader, Transfooter not supported in RDLC
    //                        - DataSetFieldName generated for all controls
    //                        - Layout 1 and Layout 2 ,Layout 3 concepts incorporated.
    //                        - added textbox control in the pageloop header(2) section for ReportTitle
    // PA033336   03.10.12 8781423: In RDLC layout, "VAT Total" control width is increased and "Can Grow" property is set 'False'.
    //                        ReportTitle Aligned
    // PA033336   17.10.12 SS 8746211
    //                        - Modified Report - OnInitReport, OnOpenForm, OnOpenPage "Sales Header - OnAfterGetRecord()",
    //                        - "PageLoop, Footer (4) - OnPreSection()"
    // PA033336   29.10.12 SS 8719075: Changed the Text Constant C_INC037 to "* = Exchange Part".
    // PA033336   09.11.12 SS 8590628: Removed logo fields and its references
    //                        - "Report Make Logo 1st Page"
    //                        - "Make Logo 2nd / Following Page"
    //                        - "Report Duplicate Text Logo"
    //                        - "Report Header Image"
    //                        - "Report Footer Image"
    // PA033019   14.11.12 SM 9277732: Changed Layout to show the Service line with type "".
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA033765   21.12.12 GC EUTireData Dataitem added
    // PA034949   29.08.13 GF Modified RDL layout, by changing size of incadeaImageHeaderLeft Image.
    // PA035597   10.02.14 GC - NAV 2013 R2 Technical Upgrade
    //                        - Remove PDf functionality
    // PA035395   27.12.13 GD 18593 Fixed "Header Graphic Right" Overlap and Duplicate Logo visibility in RTC
    // PA035395   27.12.13 GF 18593 Fixed Print Footer Line functionality.
    // PA035484   17.01.13 GF 20145 Added code to set Usage & parameters for printing Deposit Ticket report.
    // PA035484   01.04.14 GF 20763 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   13.01.15 GD 32455 Fixed Company Information Email layout issue in actual print (not preview).
    // PA037341   21.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035395.18593, PA035484.20145, PA035484.20763
    // PA036549   29.01.15 GN 33258 Print Footer Line option value is copied into the report request form/page
    // PA038228   07.08.15 GN Added Header information.
    //                        Added detailed Service information
    // PA037047   13.08.15 LR RDLC issue: display correctly the job descriptions.
    // PA038228   21.08.15 GN 43669 Changed Footer functionality
    // PA039784   22.02.16 GV 45749 Do not display two times Bill-to Customer Name when the Sell-to Contact has the same value
    // PA040587   22.04.16 GU 59405 RDLC Modifications in order to print report correctly
    // PA040589   05.05.16 GS Merge of PA040587
    // PA040669   26.05.16 GP 61763 RDLC Redesign , data sections layout modifications
    // PA040669   30.05.16 GV 61763 RDLC layout modifications
    //                        Move code in order to get the correct values for Main Next App. Date & Emission Next App. Date
    //                        Format Date values
    //                        Rename value of Copy text constant
    //                        RDLC Layout corrections
    // PA040070   23.06.16 AK 60438 RDLC Condition changed to allow
    //                        showing "Total COMPANY incl. VAT" when there are more than 1 VAT Base and one of that VAT Amounts is zero.
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA040837   19.07.16 KR 66157 Layout modified to Print total amount inc vat if sum of VAT amount and VAT base of "VAT Amount Line" is not
    //                        equals to zero.
    // PA041179   07.09.16 DR Merge of PA040837.66154
    // PA041125   12.08.16 GV 68116 RDLC Layout Modifications
    // PA041366   17.08.16 GS Determine the return status on an Item from Service Line, according to design
    // PA042076   29.11.16 WZ Updated Report to identify Fixed Price and show report based on new setups
    // PA041187   13.02.17 MS 87564 Modifications to consider Service Job fixed price possible rounding line on 'Other' subtotal.
    // PA043099   06.03.17 GY AddNoOfCopiesFromCust() created to take the NoOfCopiesG from Customer.
    // PA043100   07.03.17 GW Merge of PA043099.
    // PA041187   13.03.17 GV 89231 Fix filter of table which display the SumOthers.
    // PA043099   13.03.17 GW 90573 AddNoOfCopiesFromCust() enhanced to check also "Pre-Assigned No."
    // PA043100   15.03.17 GW 90911 Merge of PA043099.90573.
    // PA041187   29.03.17 GD 91743 "Print Service Job Fixed Price" functionality added.
    // PA043635   08.05.17 GY RDLC modifications in order to print "VAT Registration No".
    // --- 7.1.6 ---
    // EU.0000011 30.05.17 DR "Job Details Text Block" print enabled.
    //                        - 2 new lines in the RDLC added to print a Title and a Text Block.
    //                        - Use ReportSelectionG.INIT to set the preferred default Boolean values in the report selection.
    //                        - New Parameter "Print Job Detailed Descript." shown in the Report Request Page.
    //                        - Global variables PrintSentFromLineG, PrintAddrBlockG and PrintFooterLineG removed.
    //                        - Use the Report selection table fields for "Print Sent-From Line", "Print Address Block" and "Print Footer Line"
    //                          directly as source fields in the Report Request Page.
    //                        - Use CalcBaseOrderConfirmation as a replacement for constant 2 standing for CalcBase::"Order Confirmation".
    //                        - All single changed in which a SETFILTER can be replaced by a SETRANGE
    //                        - All Data Items which are not in used in the Report RDLC have been removed.
    //                        - Use Table.FIELDCAPTION(Fieldname) command for all report captions which exists as table fields.
    // EU.0002138 27.06.17 AK 2111 Merge of PA043635
    // EU.0004372 18.08.17 GL Technical NAV 2017 Uplift
    // --- 7.2.0 ---
    // EU.0000039 15.09.17 DR Report changed to also print a "Proforma Invoice" when the report is called from an existing "Service Invoice" document.
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5025604 Service Invoice
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed, translation
    //                        Final design of vehicle/contract info part of header
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, put VAT% instead of VAT identifier
    //                        Final design of header, Bank source, SK legislation,
    //                        Advance Letter Payments, VAT Specification
    // API.1.0.3  07.08.18 PV RDLC Layout changed - VAT recap. table column size
    // API.1.0.4  30.10.18 DV Exclude unposted advance
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServiceInvoiceCZ.rdlc';

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
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CustAddr_1_; CustAddrG[1])
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
                        Description = 'PA040669.61763';
                    }
                    column(HdrInfo14; FORMAT(ServHdrG.Mileage) + ' /  ' + FORMAT(ServHdrG."Running Time"))
                    {
                    }
                    column(HdrInfo16; ServHdrG."Driver Name")
                    {
                        Description = 'PA040669.61763';
                    }
                    column(HdrInfo18; "Sales Invoice Header"."Your Reference")
                    {
                        Description = 'PA040669.61763';
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
                    column(Sales_Invoice_Header___Document_Date_; "Sales Invoice Header"."Document Date")
                    {
                        Description = 'PA033336';
                    }
                    column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Invoice_Header___Service_Order_No__; "Sales Invoice Header"."Service Order No.")
                    {
                    }
                    column(CompAddr; CompAddrG)
                    {
                    }
                    column(Sales_Invoice_Header___Order_Date_; "Sales Invoice Header"."Due Date")
                    {
                        Description = 'PA033336';
                    }
                    column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
                    {
                    }
                    column(Cust__No__; CustG."No.")
                    {
                    }
                    column(CustAddr_2_; CustAddrG[2])
                    {
                    }
                    column(OrderCustAddrLine; OrderCustAddrLineG)
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddrG[1])
                    {
                    }
                    column(CompanyAddr_2_S; CompanyAddrG[2])
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
                        Description = 'PA040669';
                    }
                    column(CompanyAddr_6_S; CompanyAddrG[6])
                    {
                        Description = 'PA040669';
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
                    column(Service_Header___Licence_No__; ServHdrG."License No.")
                    {
                    }
                    column(Make_Name; MakeG.Name)
                    {
                    }
                    column(Service_Header__Model; ServHdrG.Model)
                    {
                    }
                    column(Service_Header__VIN; ServHdrG.VIN)
                    {
                    }
                    column(Service_Header__VATRegNo; ServHdrG."VAT Registration No.")
                    {
                        Description = 'PA043339';
                    }
                    column(Service_Header___Initial_Registration_; FORMAT(ServHdrG."Initial Registration"))
                    {
                        Description = 'PA033336';
                    }
                    column(Service_Header__Mileage; ServHdrG.Mileage)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(Service_Advisor_; ServAdvisorG)
                    {
                    }
                    column(SalesPurch_Name; SalesPurchG.Name)
                    {
                    }
                    column(CustAddr_8_; CustAddrG[8])
                    {
                    }
                    column(CustAddr_7_; CustAddrG[7])
                    {
                    }
                    column(CustAddr_6_; CustAddrG[6])
                    {
                    }
                    column(CollectionUnitG_TextShowOutput_ServDaysCarried_FIELDCAPTION__Days_Carried____PrintDaysCarried_; CollectionUnitG.TextShowOutput(ServDaysCarriedG.FIELDCAPTION("Days Carried"), PrintDaysCarriedG))
                    {
                    }
                    column(CollectionUnitG_TextShowOutput_STRSUBSTNO___1__2___SumDaysCarried__DaysCarriedText2___PrintDaysCarried_; CollectionUnitG.TextShowOutput(STRSUBSTNO('%1 %2', SumDaysCarriedG, DaysCarriedText2G), PrintDaysCarriedG))
                    {
                    }
                    column(SalesPurch_Name_Control87; SalesPurchG.Name)
                    {
                    }
                    column(CopyText; CopyTextG)
                    {
                    }
                    column(ShowAppText; ShowAppTextG)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA031550';
                    }
                    column(DataItem1115000010_ReportTitle; ReportTitleG)
                    {
                        Description = 'PA035484.20145';
                    }
                    column(OutputNoG; OutputNoG)
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA033336';
                    }
                    column(ReportLayoutSetupG__Duplicate_Graphic1_; ReportLayoutSetupG."Duplicate Graphic")
                    {
                        Description = 'PA033336';
                    }
                    column(RePrintOriginalInvG_; RDLHideOutput(RePrintOriginalInvG))
                    {
                    }
                    column(NoPrinted_; RDLHideOutput("Sales Invoice Header"."No. Printed" > 0))
                    {
                        Description = 'PA035395.18593';
                    }
                    column(BankText; BankTextG)
                    {
                        Description = 'PA033041,PA032651';
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
                    column(ReportLayoutSetupG__Footer_5_6_; ReportLayoutSetupG."Footer 5-6")
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
                    column(ReportLayoutSetupG__Footer_5_4_; ReportLayoutSetupG."Footer 5-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_6_4_; ReportLayoutSetupG."Footer 6-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_4_; ReportLayoutSetupG."Footer 4-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_5_; ReportLayoutSetupG."Footer 4-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_4_6_; ReportLayoutSetupG."Footer 4-6")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_4_; ReportLayoutSetupG."Footer 3-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_5_; ReportLayoutSetupG."Footer 3-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_3_6_; ReportLayoutSetupG."Footer 3-6")
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
                    column(ReportLayoutSetupG__Footer_2_3_; ReportLayoutSetupG."Footer 2-3")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_4_; ReportLayoutSetupG."Footer 2-4")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_5_; ReportLayoutSetupG."Footer 2-5")
                    {
                        Description = 'PA033052';
                    }
                    column(ReportLayoutSetupG__Footer_2_6_; ReportLayoutSetupG."Footer 2-6")
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
                    column(Sales_Invoice_Header___No__Caption; ServLineG.FIELDCAPTION("Document No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Invoice_DateCaption; ServHdrG.FIELDCAPTION("Document Date"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(FORMAT_CurrReport_PAGENO_Caption; FORMAT_CurrReport_PAGENO_CaptionLbl)
                    {
                    }
                    column(Cust__No__Caption; Cust__No__CaptionLbl)
                    {
                    }
                    column(Service_Header___Licence_No__Caption; ServHdrG.FIELDCAPTION("License No."))
                    {
                        Description = 'EU.0000011';
                    }
                    column(MakeCaption; ServHdrG.FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Model_DescriptionCaption; ServHdrG.FIELDCAPTION(Model))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header__VINCaption; ServHdrG.FIELDCAPTION(VIN))
                    {
                        Description = 'EU.0000011';
                    }
                    column(Service_Header__VATRegNo_Caption; ServHdrG.FIELDCAPTION("VAT Registration No."))
                    {
                        Description = 'PA043339';
                    }
                    column(Service_Header___Initial_Registration_Caption; ServHdrG.FIELDCAPTION("Initial Registration"))
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
                    column(SalesPurch_NameLbl; SalesPurch_NameLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Service_Order_No__Caption; Sales_Invoice_Header___Service_Order_No__CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Order_Date_Caption; Sales_Invoice_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(Payments_to_Caption; Payments_to_CaptionLbl)
                    {
                    }
                    column(HdrInfo1; ServHdrG.FIELDCAPTION("Make Code"))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo3; ServHdrG.FIELDCAPTION(Model))
                    {
                        Description = 'EU.0000011';
                    }
                    column(HdrInfo5; ServHdrG.FIELDCAPTION("Vehicle Category Code"))
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
                    column(HdrInfo29; ServHdrG.FIELDCAPTION("Order Limit"))
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
                    column(FuelLevel_SH; ServHdrG."Fuel Level")
                    {
                    }
                    column(FuelLevelCpn_SH; ServHdrG.FIELDCAPTION("Fuel Level"))
                    {
                    }
                    column(DriverName_SH; ServHdrG."Driver Name")
                    {
                    }
                    column(DriverNameCpn_SH; ServHdrG.FIELDCAPTION("Driver Name"))
                    {
                    }
                    column(PickupDateTime_SH; ServHdrG."Pickup DateTime")
                    {
                    }
                    column(PickupDateTimeCpn_SH; ServHdrG.FIELDCAPTION("Pickup DateTime"))
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
                    column(LetterAmount; LetterAmountG)
                    {
                    }
                    column(AmountWithoutLetter; AmountWithoutLetterG)
                    {
                    }
                    column(PaymentsLbl; PaymentsLbl)
                    {
                    }
                    column(AmountIncludingVAT_SIH; "Sales Invoice Header"."Amount Including VAT")
                    {
                    }
                    column(CurrencyCode_SIH; "Sales Invoice Header"."Currency Code")
                    {
                    }
                    column(CalculatedExchRate; CalculatedExchRate)
                    {
                    }
                    column(ExchRateText; ExchRateText)
                    {
                    }
                    column(ToDateLbl; ToDateLbl)
                    {
                    }
                    column(PostingDate_SIH; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(LCYCode_GLS; GLSetupG."LCY Code")
                    {
                    }
                    column(ShowCurrency; ShowCurrencyG)
                    {
                    }
                    column(WithoutVATLbl; WithoutVATLbl)
                    {
                    }
                    dataitem("Header Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Header));
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
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE("Prepayment Line" = CONST(false));
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
                        column(Service_Line__Type; ServLineG.Type)
                        {
                            Description = 'PA033336';
                        }
                        column(ServCustPrintG; ServCustPrintG)
                        {
                            Description = 'PA033336';
                        }
                        column(TotalNet; TotalNetG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Type; Type)
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(PrintSubtotals; PrintSubtotalsG)
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line_Subtotal; Subtotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Description; Description)
                        {
                        }
                        column(SalesInvLine_TypeG; ("Sales Invoice Line".Type + 0))
                        {
                            Description = 'PA033336,EU.0000011';
                        }
                        column(Sales_Invoice_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 2;
                        }
                        column(Sales_Invoice_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoText; NoTextG)
                        {
                        }
                        column(NoProperty; NoPropertyG)
                        {
                        }
                        column(Sales_Invoice_Line__VAT_Identifier_; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(FixedPriceLab; FixedPriceLabG)
                        {
                            Description = 'PA033336';
                        }
                        column(ServCustomer__Print_Fixed_Unit_Price_; ServCustG."Print Fixed Unit Price")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line__Description_2_; "Sales Invoice Line"."Description 2")
                        {
                            Description = 'EU.0000011';
                        }
                        column(SumLabor; SumLaborG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItem; SumItemG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumExtServ; SumExtServG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOther; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalTextG)
                        {
                        }
                        column(VATAmountLine_VATAmountText___C_INC018; VATAmountLineG.VATAmountText + C_INC018)
                        {
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line__Amount; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line___Amount_Including_VAT_____Sales_Invoice_Line__Amount____Exch__Parts_Tax_Amount_; "Amount Including VAT" - Amount - "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line___VAT_Base_Amount_; "VAT Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(FairDealText; FairDealTextG)
                        {
                        }
                        column(SumFairDeal; SumFairDealG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC033; C_INC033)
                        {
                        }
                        column(VATAmountLine_COUNT; VATAmountLineG.COUNT)
                        {
                            Description = 'PA033336';
                        }
                        column(ServCustomer__Show_Fair_Deal_; ServCustG."Show Fair Deal")
                        {
                            Description = 'PA033336';
                        }
                        column(Sales_Invoice_Line__Exch__Parts_Tax_Amount_; "Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_ExchTaxAmountText___C_INC018; VATAmountLineG.ExchTaxAmountText + C_INC018)
                        {
                        }
                        column(Sales_Invoice_Line__Exch__Parts_Tax_Base_; "Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATTextG)
                        {
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line___Amount_Including_VAT_; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(No_Caption; FIELDCAPTION("No."))
                        {
                        }
                        column(DescriptionCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
                        {
                        }
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; FIELDCAPTION("Unit Price"))
                        {
                        }
                        column(AmountCaption; FIELDCAPTION(Amount))
                        {
                        }
                        column(VAT_IdentifierCaption; FIELDCAPTION("VAT Identifier"))
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(TotalNetCaption; ContinuedCaptionLbl)
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
                        column(Inv__Discount_Amount_Caption; Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_; "Line No.")
                        {
                        }
                        column(ServCustPrintFixedPriceG; ServCustPrintFixedPriceG)
                        {
                        }
                        column(PrintFixedPriceG; PrintFixedPriceG)
                        {
                        }
                        column(HideSumLine; RDLHideOutput(EvalHideSumLine()))
                        {
                            Description = 'PA041187.91743';
                        }
                        column(HideQty; RDLHideOutput(ShowQtyG))
                        {
                            Description = 'PA041187.91743';
                        }
                        column(HideUOM; RDLHideOutput(ShowUOMG))
                        {
                            Description = 'PA041187.91743';
                        }
                        column(HideUnitPrice; RDLHideOutput(ShowUnitPriceG))
                        {
                            Description = 'PA041187.91743';
                        }
                        column(HideDiscount; RDLHideOutput(ShowDiscountG))
                        {
                            Description = 'PA041187.91743';
                        }
                        column(HideAmount; RDLHideOutput(ShowAmountG))
                        {
                            Description = 'PA041187.91743';
                        }
                        column(VATpercent_SIL; "Sales Invoice Line"."VAT %")
                        {
                        }
                        column(VATpercentCpn_SIL; "Sales Invoice Line".FIELDCAPTION("VAT %"))
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
                                EUTireInformationG := EUTireSetupL.GetTireInformation("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item,
                                  "Sales Invoice Line"."EU Tire Data Code");
                                IF EUTireInformationG = '' THEN BEGIN
                                    CurrReport.BREAK;
                                END;
                                // Stop PA033765
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemL: Record Item;
                            ServJobLineL: Record "Service Job Line";
                            ArchServJobLineL: Record "Archived Service Job Line";
                            TotalsLineL: Record "Sales Invoice Line";
                            DealAmountL: Decimal;
                            FactorL: Decimal;
                            T113Fnc: Codeunit "ET111,112,113,114,115,6661";
                        begin
                            //Start API.1.0.2
                            T113Fnc.T113_CalcPrintVATAmtLines("Sales Invoice Line", VATAmountLineG, VATPctG, ExchTaxPctG);
                            /*
                            VATAmountLineG.INIT;
                            // Start PA033011.5983155
                            VATAmountLineG."VAT Identifier" := FORMAT("VAT %");
                            VATAmountLineG."Sales Amount" := Amount;
                            // Stop PA033011.5983155
                            VATAmountLineG."VAT %" := "VAT %";
                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."VAT Base" := "VAT Base Amount";
                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLineG.InsertLine;
                            */
                            //Stop API.1.0.2

                            NoPropertyG := '';
                            NoTextG := '';
                            // Start EU.0000011
                            TextBlockContentG := '';
                            // Stop EU.0000011
                            IF Type = Type::Item THEN BEGIN
                                NoTextG := "No.";
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
                                    NoPropertyG := C_INC016;
                                    ExchangeDaG := TRUE;
                                END;
                            END;
                            IF NOT ServLineG.GET(ServHdrG."Document Type", ServHdrG."No.", "Service Order Line No.") THEN BEGIN
                                IF NOT ArchServLineG.GET(ServHdrG."Document Type", ServHdrG."No.", "Service Order Line No.") THEN BEGIN
                                    CLEAR(ServLineG);
                                END ELSE BEGIN
                                    ServLineG.TRANSFERFIELDS(ArchServLineG);
                                    IF ArchServCustLineG.GET(
                                       ServLineG."Document Type",
                                       ServLineG."Document No.",
                                       ServLineG."Line No.",
                                       "Sales Invoice Header"."Bill-to Customer No.")
                                    THEN BEGIN
                                        // Start PA032651
                                        IF ArchServCustLineG."Portion %" <> 0 THEN
                                            FactorL := Amount / ArchServCustLineG."Portion %";
                                        // Stop PA032651
                                        ArchServCustLineG.RESET;
                                        ArchServCustLineG.SETRANGE("Document Type", ServLineG."Document Type");
                                        ArchServCustLineG.SETRANGE("Document No.", ServLineG."Document No.");
                                        ArchServCustLineG.SETRANGE("Document Line No.", ServLineG."Line No.");
                                        IF WarrCustG <> '' THEN
                                            ArchServCustLineG.SETFILTER("Bill-to Customer No.", '%1|%2', IntCustG, WarrCustG)
                                        ELSE
                                            ArchServCustLineG.SETRANGE("Bill-to Customer No.", IntCustG);
                                        IF ArchServCustLineG.FIND('-') THEN
                                            REPEAT
                                                DealAmountL := DealAmountL + (FactorL * ArchServCustLineG."Portion %");
                                            UNTIL ArchServCustLineG.NEXT = 0;
                                    END;
                                END;
                            END ELSE BEGIN
                                IF ServLineCustG.GET(
                                   ServLineG."Document Type",
                                   ServLineG."Document No.",
                                   ServLineG."Line No.",
                                   "Sales Invoice Header"."Bill-to Customer No.")
                                THEN BEGIN
                                    // Start PA032651
                                    IF ServLineCustG."Portion %" <> 0 THEN
                                        FactorL := Amount / ServLineCustG."Portion %";
                                    // Stop PA032651

                                    ServLineCustG.RESET;
                                    ServLineCustG.SETRANGE("Document Type", ServLineG."Document Type");
                                    ServLineCustG.SETRANGE("Document No.", ServLineG."Document No.");
                                    ServLineCustG.SETRANGE("Document Line No.", ServLineG."Line No.");
                                    IF WarrCustG <> '' THEN
                                        ServLineCustG.SETFILTER("Bill-to Customer No.", '%1|%2', IntCustG, WarrCustG)
                                    ELSE
                                        ServLineCustG.SETRANGE("Bill-to Customer No.", IntCustG);
                                    IF ServLineCustG.FIND('-') THEN
                                        REPEAT
                                            DealAmountL := DealAmountL + (FactorL * ServLineCustG."Portion %");
                                        UNTIL ServLineCustG.NEXT = 0;
                                END;
                            END;

                            // Start PA041187.87564
                            // consider possible job fixed price rounding line
                            IF (Type = Type::"Account (G/L)") AND ServHdrG."Includes Fixed Price" AND
                               (ServSetupG."Serv. Fixed Price G/L Account" <> '') AND
                               ("No." = ServSetupG."Serv. Fixed Price G/L Account")
                            THEN
                                ServLineG.Type := ServLineG.Type::"G/L Account";
                            // Stop PA041187.87564

                            FixedPriceLabG := FALSE;
                            // Start PA042076
                            PrintFixedPriceG := FALSE;
                            // Stop PA042076
                            IF ServLineG.Type <> ServLineG.Type::" " THEN BEGIN
                                NoTextG := ServLineG."No.";
                                IF ServLineG.Type = ServLineG.Type::Labor THEN
                                    IF ServLineG."Fixed Price" > 0 THEN
                                        FixedPriceLabG := TRUE;

                                // Start PA042076
                                IF NOT ServJobLineL.GET(
                                   ServLineG."Document Type",
                                   ServLineG."Document No.",
                                   ServLineG."Service Job No.")
                                THEN
                                    IF ArchServJobLineL.GET(
                                     ServLineG."Document Type",
                                     ServLineG."Document No.",
                                     ServLineG."Service Job No.")
                                    THEN
                                        ServJobLineL.TRANSFERFIELDS(ArchServJobLineL);

                                IF (ServJobLineL."Fixed Price" <> 0) OR (ServJobLineL."Fixed Price Incl. VAT" <> 0) AND
                                   (ServLineG."Fixed Price" = 0)
                                THEN
                                    PrintFixedPriceG := TRUE;
                                // Stop PA042076
                            END;
                            IF (DealAmountL > 0) AND (ServCustG."Show Fair Deal") THEN BEGIN
                                NoPropertyG := NoPropertyG + C_INC033;
                                SumFairDealG := SumFairDealG + DealAmountL;
                                FairDealDaG := TRUE;
                            END;

                            // Check if the items are return-mandatory
                            IF ServLineG.Type = ServLineG.Type::Item THEN BEGIN
                                // Start PA041366
                                IF ServLineG."Sending Required" IN [ServLineG."Sending Required"::Keep, ServLineG."Sending Required"::Send] THEN BEGIN
                                    // Stop PA041366
                                    NoPropertyG := NoPropertyG + C_INC034;     // Flag for return part = R
                                    ReturnDaG := TRUE;
                                END;
                            END;

                            IF (Quantity <> 0) AND ("Additional Item" = "Additional Item"::Deposit) THEN BEGIN
                                MARK(TRUE);
                            END;

                            IF ConsolidateNegativePosG THEN BEGIN
                                // Start EU.0000011
                                IF (Type <> Type::" ") AND
                                   ((Amount <> 0) OR ("Amount Including VAT" <> 0))
                                THEN BEGIN
                                    TotalsLineL.RESET;
                                    TotalsLineL.SETCURRENTKEY("Document No.", Type, "No.", Description);
                                    TotalsLineL.SETRANGE("Document No.", "Document No.");
                                    TotalsLineL.SETRANGE(Type, Type);
                                    TotalsLineL.SETRANGE("No.", "No.");
                                    TotalsLineL.SETRANGE(Description, Description);
                                    TotalsLineL.SETRANGE("Unit Price", "Unit Price");
                                    // Stop EU.0000011
                                    TotalsLineL.CALCSUMS(Amount, "Amount Including VAT");
                                    IF (TotalsLineL.Amount = 0) AND (TotalsLineL."Amount Including VAT" = 0) THEN
                                        CurrReport.SKIP;
                                END;
                            END;
                            // Start PA033042
                            IF ("VAT Identifier" <> '') AND (Quantity <> 0) THEN
                                IF NOT VATIdentifierTempG.GET("VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := "VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042
                            // Start EU.0000011
                            // Stop EU.0000011
                            ServCustPrintG := ServCustG."Print Fixed Unit Price";
                            // Start PA042076
                            ServCustPrintFixedPriceG := ServCustG."Print Service Job Fixed Price";
                            // Stop PA042076

                            // Start PA041187.91743
                            DetermineColumnVisibility();
                            // Stop PA041187.91743

                            // Start PA035597
                            // Start EU.0000011
                            IF (Type = Type::"Account (G/L)") AND
                              ((NOT FixedPriceLabG) OR ((FixedPriceLabG) AND
                            // Stop EU.0000011
                              (ServCustG."Print Fixed Unit Price" = ServCustG."Print Fixed Unit Price"::"Quantity + Price per Unit")))
                            THEN BEGIN
                                IF ((PrintWithoutDiscG) OR (("Line Discount Amount" < 0) AND (Quantity > 0)) OR
                                  (("Line Discount Amount" > 0) AND (Quantity < 0)))
                                THEN BEGIN
                                    "Unit Price" := Amount / Quantity;
                                    "Line Discount %" := 0;
                                END;
                                "Unit Price" := ROUND("Unit Price");
                            END;
                            // Start EU.0000011
                            IF (Type = Type::Item) OR (Type = Type::Resource) THEN BEGIN
                                // Stop EU.0000011
                                IF ((PrintWithoutDiscG) OR (("Line Discount Amount" < 0) AND (Quantity > 0)) OR
                                  (("Line Discount Amount" > 0) AND (Quantity < 0)))
                                THEN BEGIN
                                    "Unit Price" := Amount / Quantity;
                                    "Line Discount %" := 0;
                                END;
                                "Unit Price" := ROUND("Unit Price");
                            END;
                            CreateTotals();
                            // Stop PA035597
                            // Stop PA033336
                            // Start EU.0000011
                            IF Type = Type::" " THEN BEGIN
                                IF "Job Details Text Block" > 0 THEN BEGIN
                                    IF NOT ReportSelectionG."Print Job Detailed Descript." THEN
                                        CurrReport.SKIP;
                                    IF NOT TextBlockG.GET("Job Details Text Block") THEN
                                        CurrReport.SKIP;
                                    TextBlockContentG := TextBlockG.GetTextBlock();
                                    Description := '';
                                    TextBlockG."Headline Text" := '';
                                    "Description 2" := '          '; // Add a Blank line in the end
                                END;
                            END;
                            // Stop EU.0000011

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            CurrReport.CREATETOTALS("Line Discount Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Exch. Parts Tax Amount",
                              "Exch. Parts Tax Base", "VAT Base Amount");
                            // Start EU.0000011
                            // Stop EU.0000011
                            // Start PA041187.91743
                            IF ArchServHdrG."No." = '' THEN
                                // Start EU.0000011
                                MakeServPreviewG.ShowJob(ServHdrG, ServPrevLineTempG, MakeServPreviewG.CalcBaseOrderConfirmation(), TRUE)
                            ELSE
                                MakeArchServPreviewG.ShowJob(ArchServHdrG, ServPrevLineTempG, MakeArchServPreviewG.CalcBaseOrderConfirmation(), TRUE);
                            // Stop EU.0000011
                            // Stop PA041187.91743
                        end;
                    }
                    dataitem(SalesInvoiceAdvance; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE("Prepayment Line" = CONST(true), "Letter No." = FILTER(<> ''));
                        column(Count_SILAdv; SalesInvoiceAdvanceCountG)
                        {
                        }
                        column(LetterNoCpn_SILAdv; FIELDCAPTION("Letter No."))
                        {
                        }
                        column(LetterNo_SILAdv; "Letter No.")
                        {
                        }
                        column(AmountIncludingVAT_SILAdv; "Amount Including VAT")
                        {
                        }
                        column(VATDocLetterNoCpn_SILAdv; FIELDCAPTION("VAT Doc. Letter No."))
                        {
                        }
                        column(VATDocLetterNo_SILAdv; "VAT Doc. Letter No.")
                        {
                        }
                        column(PostingDate_SIHAdv; SalesInvHeader."Posting Date")
                        {
                        }
                        column(PostingDateCpn_SIHAdv; SalesInvHeader.FIELDCAPTION("Posting Date"))
                        {
                        }
                        column(AmountIncludingVATCpn_SIHAdv; SalesInvoiceAdvance.FIELDCAPTION("Amount Including VAT"))
                        {
                        }
                        column(VATAmountLetter; VATAmountLetterG)
                        {
                        }
                        column(SumAdvancePaymentsLbl; SumAdvancePaymentsLbl)
                        {
                        }
                        column(RestToPayLbl; RestToPayLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //API.1.0.2
                            IF "VAT Doc. Letter No." <> '' THEN
                                IF NOT SalesInvHeader.GET("VAT Doc. Letter No.") THEN
                                    SalesInvHeader.INIT;
                            SalesInvHeader.CALCFIELDS("Amount Including VAT", Amount);
                            //When document has more then one line then "VAT Doc. Letter No." can have the same value
                            //and thus also VATAmountLetterG is shown more then once
                            IF PreviousVATDocLetterNoG = "VAT Doc. Letter No." THEN BEGIN
                                VATAmountLetterG := 0;
                            END
                            ELSE BEGIN
                                PreviousVATDocLetterNoG := "VAT Doc. Letter No.";
                                VATAmountLetterG := SalesInvHeader.Amount;
                            END;
                        end;

                        trigger OnPreDataItem()
                        var
                            SalesInvoiceLineL: Record "Sales Invoice Line";
                            SumAmountIncludingVATL: Decimal;
                        begin
                            //API.1.0.2
                            PreviousVATDocLetterNoG := '';

                            // Start API.1.0.4
                            SumAmountIncludingVATL := 0;
                            SalesInvoiceLineL.SETCURRENTKEY("Document No.", "Line No.");
                            SalesInvoiceLineL.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            SalesInvoiceLineL.SETRANGE("Prepayment Line", TRUE);
                            SalesInvoiceLineL.SETFILTER("Letter No.", '<>%1', '');
                            IF SalesInvoiceLineL.FINDSET THEN
                                REPEAT
                                    SumAmountIncludingVATL := SumAmountIncludingVATL + SalesInvoiceLineL."Amount Including VAT";
                                UNTIL SalesInvoiceLineL.NEXT = 0;

                            IF SumAmountIncludingVATL = 0 THEN
                                SalesInvoiceAdvanceCountG := 0
                            ELSE
                                SalesInvoiceAdvanceCountG := SalesInvoiceAdvance.COUNT;
                            // Stop API.1.0.4
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrency_VATC; ShowCurrencyG)
                        {
                        }
                        column(AmountIncludingVAT_VAL; TempVATAmountLineG."Amount Including VAT")
                        {
                        }
                        column(AmountIncludingVATCpn_VAL; TempVATAmountLineG.FIELDCAPTION("Amount Including VAT"))
                        {
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLineG."VAT Identifier")
                        {
                        }
                        column(VATAmtLineVATBase; TempVATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; TempVATAmountLineG."VAT %")
                        {
                        }
                        column(VATAmtLineVATBaseLCY; TempVATAmountLineG."VAT Base (LCY)")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtLCY; TempVATAmountLineG."VAT Amount (LCY)")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATLCY_VAL; TempVATAmountLineG."Amount Including VAT (LCY)")
                        {
                        }
                        column(VATIdentLbl; VATIdentLbl)
                        {
                        }
                        column(VATPercentLbl; VATPercentLbl)
                        {
                        }
                        column(VATBaseLbl; VATBaseLbl)
                        {
                        }
                        column(VATAmtLbl; VATAmtLbl)
                        {
                        }
                        column(TotalLbl; TotalLbl)
                        {
                        }
                        column(Number_VATC; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //API.1.0.2
                            TempVATAmountLineG.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            //API.1.0.2
                            SETRANGE(Number, 1, TempVATAmountLineG.COUNT);
                        end;
                    }
                    dataitem(VATCounter2; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TotalText_VATC2; TotalTextG)
                        {
                        }
                        column(Amount_SIL_VATC2; "Sales Invoice Line".Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumFairDeal_VATC2; SumFairDealG)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(FairDealText_VATC2; FairDealTextG)
                        {
                        }
                        column(C_INC033_Control167; C_INC033)
                        {
                        }
                        column(VATAmountLineVATBase; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATText; VATTextG)
                        {
                        }
                        column(ExchPartsTaxAmount_SIL_VATC2; "Sales Invoice Line"."Exch. Parts Tax Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ExchPartsTaxBase_SIL_VATC2; "Sales Invoice Line"."Exch. Parts Tax Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_VATC2; TotalInclVATTextG)
                        {
                        }
                        column(Amount_IncludingVAT_SIL_VATC2; "Sales Invoice Line"."Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                            VATTextG := C_INC001;
                            // Start PA035597
                            VATTextG := STRSUBSTNO('%1%2', VATAmountLineG."VAT %", C_INC001);
                            // Stop PA035597
                        end;

                        trigger OnPreDataItem()
                        begin
                            //API.1.0.2
                            //original VATCounter renamed to VATCounter2
                            IF VATAmountLineG.COUNT <= 1 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            //CurrReport.CREATETOTALS(VATAmountLineG."VAT Base",VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Footer Text"; "Posted Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Invoice), "Header/Footer" = CONST(Footer));
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
                        column(FairDealDa; FairDealDaG)
                        {
                            Description = 'PA033336';
                        }
                        column(ReturnDa; ReturnDaG)
                        {
                            Description = 'PA033336';
                        }
                        column(ExchangeDa; ExchangeDaG)
                        {
                            Description = 'PA033336';
                        }
                        column(PaymentTerms_Description; PaymentTermsG.Description)
                        {
                        }
                        column(Total_Total_Number; Total.Number)
                        {
                            Description = 'PA033336';
                        }
                        column(ExplanationsCaption; ExplanationsCaptionLbl)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA035597
                            LegendTextG := '';
                            IF FairDealDaG THEN
                                LegendTextG := C_INC035;
                            IF ReturnDaG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC036
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC036;
                            IF ExchangeDaG THEN
                                IF LegendTextG = '' THEN
                                    LegendTextG := C_INC037
                                ELSE
                                    LegendTextG := LegendTextG + ',  ' + C_INC037;
                            // Stop PA035597
                        end;
                    }
                    dataitem("Posted Cash Register Header"; "Posted Cash Register Header")
                    {
                        DataItemLink = "No." = FIELD("Cash Register Receipt");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("No.") WHERE("Type of Document to be Printed" = CONST("Sales Invoice"));
                        column(Posted_Cash_Register_Header__Payment__In_Out__; "Payment (In/Out)")
                        {
                        }
                        column(Posted_Cash_Register_Header_No_; "No.")
                        {
                        }
                        dataitem("Cash Reg. Add Disc Split Post."; "Cash Reg. Add Disc Split Post.")
                        {
                            DataItemLink = "Applies-to ID" = FIELD("No.");
                            DataItemTableView = SORTING("Source Type", "Source No.", "Applies-to ID");
                            column(Cash_Reg__Add_Disc_Split_Post___Posting_Date_; FORMAT("Posting Date"))
                            {
                                Description = 'PA033336';
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_; "Appl.-to Document Type")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__; "Appl.-to Document No.")
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Currency_Code_; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(ABS__Remaining_Amount__; ABS("Remaining Amount"))
                            {
                            }
                            column(ABS__Pmt__Discount_Total__; ABS("Pmt. Discount Total"))
                            {
                            }
                            column(ABS_AmountMinusDiscount_; ABS(AmountMinusDiscG))
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Posting_Date_Caption; Cash_Reg__Add_Disc_Split_Post___Posting_Date_CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_Caption; Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__Caption; Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__CaptionLbl)
                            {
                            }
                            column(Cash_Reg__Add_Disc_Split_Post___Currency_Code_Caption; Cash_Reg__Add_Disc_Split_Post___Currency_Code_CaptionLbl)
                            {
                            }
                            column(ABS__Remaining_Amount__Caption; ABS__Remaining_Amount__CaptionLbl)
                            {
                            }
                            column(ABS__Pmt__Discount_Total__Caption; ABS__Pmt__Discount_Total__CaptionLbl)
                            {
                            }
                            column(ABS_AmountMinusDiscount_Caption; ABS_AmountMinusDiscount_CaptionLbl)
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
                            column(Cash_Reg__Add_Disc_Split_Post__Applies_to_ID; "Applies-to ID")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                AmountMinusDiscG := "Cash Reg. Add Disc Split Post."."Remaining Amount" - "Cash Reg. Add Disc Split Post.".
                                  "Pmt. Discount Total";
                            end;
                        }
                        dataitem("Posted Cash Register Line"; "Posted Cash Register Line")
                        {
                            DataItemLink = "Document No." = FIELD("No.");
                            DataItemTableView = SORTING("Document No.", "Line No.");
                            column(Posted_Cash_Register_Header___Currency_Code_; "Posted Cash Register Header"."Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Header___Amount_to_Pay__LCY__; "Posted Cash Register Header"."Amount to Pay (LCY)")
                            {
                            }
                            column(Posted_Cash_Register_Line__Posted_Cash_Register_Line___Document_No__; "Posted Cash Register Line"."Document No.")
                            {
                                Description = 'PA033336';
                            }
                            column(Posted_Cash_Register_Line__Means_of_Payment_Code_; "Means of Payment Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Line__Currency_Code_; "Currency Code")
                            {
                                AutoFormatExpression = 'JMD';
                            }
                            column(Posted_Cash_Register_Line_Amount; Amount)
                            {
                            }
                            column(Posted_Cash_Register_Header___Change_Money_; "Posted Cash Register Header"."Change Money")
                            {
                                AutoFormatExpression = "Posted Cash Register Header"."Currency Code";
                                AutoFormatType = 1;
                                Description = 'PA040669.61763';
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_; "Posted Cash Register Header"."Amount Given")
                            {
                            }
                            column(RemainingAmountTextG; RemainingAmountTextG)
                            {
                            }
                            column(RemainingStatusTextG; RemainingStatusTextG)
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_to_Pay__LCY__Caption; Posted_Cash_Register_Header___Amount_to_Pay__LCY__CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Header___Change_Money_Caption; Posted_Cash_Register_Header___Change_Money_CaptionLbl)
                            {
                            }
                            column(Posted_Cash_Register_Header___Amount_Given_Caption; Posted_Cash_Register_Header___Amount_Given_CaptionLbl)
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
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC043;
                                IncrG := IncrG + 1;
                                // Stop PA035597
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
                dataitem(Deposit; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    trigger OnAfterGetRecord()
                    var
                        DepositReportL: Report "Deposit Ticket";
                    begin
                        IF PrintDepositTicketsG THEN BEGIN
                            "Sales Invoice Line".MARKEDONLY(TRUE);
                            IF "Sales Invoice Line".FIND('-') THEN BEGIN
                                REPEAT
                                    ;
                                    IF ("Sales Invoice Line"."Printed Deposit Tickets" > 0) OR
                                       (DepositReportL.SalInvoiceLinePrintQty("Sales Invoice Line") > 0)
                                    THEN BEGIN
                                        // Start PA035484.20145
                                        UserSessionG.SetUsage(ReportSelectionG.Usage::"Service Checklist");
                                        DepositReportL.DefParameters("Sales Invoice Line".TABLECAPTION, CopyTextG,
                                          CopyLoop.Number - 1, 2);
                                        // Stop PA035484.20145
                                        DepositReportL.SETTABLEVIEW("Sales Invoice Line");
                                        DepositReportL.RUNMODAL();
                                        "Sales Invoice Line".FINDLAST;
                                    END;
                                UNTIL "Sales Invoice Line".NEXT = 0;
                            END;
                        END;
                    end;
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

                    CurrReport.PAGENO := 1;

                    ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    IF ("Sales Invoice Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                            DuplicateTextG := C_INC039
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV
                    // Stop PA033336

                    OldServJobNoG := 0;
                    SumLaborG := 0;
                    SumItemG := 0;
                    SumExtServG := 0;
                    SumOtherG := 0;
                    SumFairDealG := 0;
                    TotalNetG := 0;
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
                    // Start PA031550
                    DuplicateTextG := '';
                    // Stop PA031550

                    SETRANGE(Number, 1, NoOfLoopsG);

                    // Start PA035597
                    OutputNoG := 1;
                    // Stop PA035597
                end;
            }

            trigger OnAfterGetRecord()
            var
                bankAccountL: Record "Bank Account";
                salesInvLineL: Record "Sales Invoice Line";
                T113Fnc: Codeunit "ET111,112,113,114,115,6661";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA040669.61763
                IF NOT ServHdrG.GET(ServHdrG."Document Type"::Order, "Service Order No.") THEN BEGIN
                    IF NOT ArchServHdrG.GET(ServHdrG."Document Type"::Order, "Service Order No.") THEN
                        CLEAR(ArchServHdrG);
                    ServHdrG.TRANSFERFIELDS(ArchServHdrG);
                END;
                // Stop PA040669.61763

                // Start PA041187.87564
                IF ArchServHdrG."No." = '' THEN
                    ServHdrG.CALCFIELDS("Includes Fixed Price")
                ELSE BEGIN
                    ArchServHdrG.CALCFIELDS("Includes Fixed Price");
                    ServHdrG."Includes Fixed Price" := ArchServHdrG."Includes Fixed Price";
                END;
                // Stop PA041187.87564

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

                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042
                // Start PA035395.18593
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Service Invoice CZ");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");
                // Stop PA035395.18593
                // Start PA035484.20145
                // Start PA039225.51457
                // Stop PA039225.51457
                // Stop PA035484.20145

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Invoice Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Sales Invoice Header"."User ID");

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                ServHdrG.CALCFIELDS("Driver Name");

                "Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                AmountIncludingVAT_SIH := "Sales Invoice Header"."Amount Including VAT";

                salesInvLineL.SETRANGE("Document No.", "No.");
                salesInvLineL.SETFILTER("Letter No.", '%1', '');
                salesInvLineL.CALCSUMS(Amount, "Amount Including VAT");
                AmountWithoutLetterG := salesInvLineL.Amount;
                "Amount Including VAT" := salesInvLineL."Amount Including VAT";
                salesInvLineL.SETFILTER("Letter No.", '<>%1', '');
                salesInvLineL.CALCSUMS("Amount Including VAT");
                LetterAmountG := salesInvLineL."Amount Including VAT";

                TempVATAmountLineG.DELETEALL;
                T113Fnc.T113_CalcVATAmountLines("Sales Invoice Header", TempVATAmountLineG);
                //Stop API.1      01.03.18 PV

                IF NOT BillToCustG.GET("Bill-to Customer No.") THEN
                    CLEAR(BillToCustG);
                IF LangG.GET(BillToCustG."Language Code") THEN
                    // Start EU.0004372
                    CurrReport.LANGUAGE := LangG."Windows Language ID"
                // Stop EU.0004372
                ELSE
                    CurrReport.LANGUAGE := GLOBALLANGUAGE;
                CustLedgEntrG.RESET;
                CustLedgEntrG.SETCURRENTKEY("Applies-to Doc. No.", "Applies-to Doc. Type");
                CustLedgEntrG.SETRANGE("Applies-to Doc. Type", CustLedgEntrG."Applies-to Doc. Type"::Invoice);
                CustLedgEntrG.SETRANGE("Applies-to Doc. No.", "No.");
                IF NOT CustLedgEntrG.FINDLAST THEN BEGIN
                    CLEAR(ShowAppTextG);
                END ELSE
                    ShowAppTextG := COPYSTR(C_INC038 + ' ' + FORMAT(CustLedgEntrG."Document Type") + ' ' + CustLedgEntrG."Document No.", 1, 50);
                IF CurrReport.PREVIEW THEN
                    PrintDepositTicketsG := FALSE;
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
                //
                // // Start PA033041
                // IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                //   OwnBanksG.GET(IntCustG, LocationG."Bank Code")
                // THEN
                //  BEGIN // Start API.1      01.03.18 PV
                //    BankNameG := OwnBanksG.Name;
                //    BankBranchNoG := OwnBanksG."Bank Branch No.";
                //    BankSwiftG := OwnBanksG."SWIFT-BIC";
                //    BankIbanG := OwnBanksG.IBAN;
                //    BankAccountNoG := OwnBanksG."Bank Account No.";
                //    // Stop API.1      01.03.18 PV
                //    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No." +
                //      C_INC040 + OwnBanksG."SWIFT-BIC" + C_INC041 + OwnBanksG.IBAN
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
                //      C_INC040 + CompanyInfoG."SWIFT-BIC" + C_INC041 + CompanyInfoG.IBAN;
                //  END; // API.1      01.03.18 PV
                // // Stop PA033041
                // Stop API.1.0.2  07.06.18 PV

                IF "VAT Registration No." = '' THEN
                    VATNoTextG := ''
                ELSE
                    VATNoTextG := FIELDCAPTION("VAT Registration No.");

                //Start API.1.0.2
                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE BEGIN
                    ShowCurrencyG := "Currency Code";
                END;
                // IF "Currency Code" = '' THEN BEGIN
                //  GLSetupG.TESTFIELD("LCY Code");
                //  TotalTextG := STRSUBSTNO(C_INC030,GLSetupG."LCY Code");
                //  TotalInclVATTextG := STRSUBSTNO(C_INC031,GLSetupG."LCY Code");
                //  FairDealTextG := STRSUBSTNO(C_INC032,GLSetupG."LCY Code");
                // END ELSE BEGIN
                //  TotalTextG := STRSUBSTNO(C_INC030,"Currency Code");
                //  TotalInclVATTextG := STRSUBSTNO(C_INC031,"Currency Code");
                //  FairDealTextG := STRSUBSTNO(C_INC032,"Currency Code");
                // END;
                TotalTextG := STRSUBSTNO(C_INC030, ShowCurrencyG);
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);
                FairDealTextG := STRSUBSTNO(C_INC032, ShowCurrencyG);
                //Stop API.1.0.2

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

                // Start PA040669.61763
                // Stop PA040669.61763

                IF ServHdrG."Service Advisor No." <> '' THEN BEGIN
                    EmployeeG.GET(ServHdrG."Service Advisor No.");
                    ServAdvisorG := EmployeeG.Name;
                END ELSE
                    ServAdvisorG := '';

                // Start PA041187.91743
                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscTextG := FindDiscountText();
                END;
                // Stop PA041187.91743

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

                CLEAR(OrderCustAddrG); //API.1.0.1  09.05.18 PV
                IF "Sales Invoice Header"."Sell-to Customer No." <> "Sales Invoice Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesInvCust(OrderCustAddrG, "Sales Invoice Header");
                    //OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005); //API.1.0.1  09.05.18 PV
                    OrderCustAddrLineG := FormatAddrG.GetWindowAddress(C_INC005);  //API.1.0.1  09.05.18 PV
                END ELSE
                    OrderCustAddrLineG := '';

                CLEAR(ServCustG);
                // Start PA041187.91743
                GetServCust(ServHdrG."Document Type", ServHdrG."No.", "Sales Invoice Header"."Bill-to Customer No.");
                // Stop PA041187.91743

                WarrCustG := MakeG."Factory Warranty Customer";

                FairDealDaG := FALSE;
                ReturnDaG := FALSE;
                ExchangeDaG := FALSE;
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
                    ServMgntG.CreateProformaInvoice(SalesHdrG, SalesInvHdrG);
                    "Sales Invoice Header".SETRANGE("No.", SalesInvHdrG."No.");
                END;
                // Stop EU.0000039
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
                group(Options)
                {
                    Caption = 'Options';
                    field("No. of Copies"; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';
                    }
                    field("Print Subtotals"; PrintSubtotalsG)
                    {
                        Caption = 'Print Subtotals';
                    }
                    field("Consolidate Negative Positions"; ConsolidateNegativePosG)
                    {
                        Caption = 'Consolidate Negative Positions';
                    }
                    field("Print Deposit Tickets"; PrintDepositTicketsG)
                    {
                        Caption = 'Print Deposit Tickets';
                    }
                    field("Print Days Carried"; PrintDaysCarriedG)
                    {
                        Caption = 'Print Days Carried';
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
                        Editable = ReqRePrintControlG;
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
            IF InvtSetupG.GET THEN
                PrintDepositTicketsG := InvtSetupG."Print Deposit Tickets"
            ELSE
                PrintDepositTicketsG := FALSE;
            GetReportSelection();
            // Start PA043099
            AddNoOfCopiesFromCust();
            // Stop PA043099
            PrintDaysCarriedG := FALSE;
            ConsolidateNegativePosG := TRUE;
            RePrintOriginalInvG := FALSE;
            ReqRePrintControlG := FALSE;
            IF UserSetupG.GET(USERID) THEN BEGIN
                IF UserSetupG."Re-print Original Invoice" = TRUE THEN
                    ReqRePrintControlG := TRUE
                ELSE
                    ReqRePrintControlG := FALSE;
            END;
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
        // Start EU.0000011
        GLSetupG.GET;
        GetReportSelection();
        // Stop EU.0000011
        PrintDaysCarriedG := FALSE;
        IF InvtSetupG.GET THEN
            PrintDepositTicketsG := InvtSetupG."Print Deposit Tickets"
        ELSE
            PrintDepositTicketsG := FALSE;
        ConsolidateNegativePosG := TRUE;
    end;

    trigger OnPreReport()
    begin
        // Start PA035597
        // Stop PA035597
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        InvtSetupG: Record "Inventory Setup";
        ServSetupG: Record "Service Setup";
        UserSetupG: Record "User Setup";
        ReportLayoutSetupG: Record "Report Layout Setup";
        ReportSelectionG: Record "Service Manag. Rep. Selection";
        PrinterSelectionG: Record "Printer Selection";
        ArchServHdrG: Record "Archived Service Header";
        ArchServLineG: Record "Archived Service Line";
        ArchServDaysCarriedG: Record "Arch. Service Days Carried";
        ArchServCustG: Record "Archived Service Customer";
        ArchServCustLineG: Record "Archived Service Line Customer";
        CustG: Record Customer;
        CustLedgEntrG: Record "Cust. Ledger Entry";
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
        LangG: Record Language;
        SalesPurchG: Record "Salesperson/Purchaser";
        ServHdrG: Record "Service Header";
        ServLineG: Record "Service Line";
        ServCustG: Record "Service Customer";
        ServDaysCarriedG: Record "Service Days Carried";
        ServLineCustG: Record "Service Line Customer";
        PaymentTermsG: Record "Payment Terms";
        PmtMethodG: Record "Payment Method";
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        VehicleCustomerG: Record "Vehicle Customer";
        ServPrevLineTempG: Record "Service Preview Line" temporary;
        TextBlockG: Record "Text Block";
        FormatAddrG: Codeunit "Format Address";
        SalesInvCountPrintedG: Codeunit "Sales Inv.-Printed";
        CollectionUnitG: Codeunit "Collection Unit";
        RTCMgmtG: Codeunit "RTC Management";
        UserSessionG: Codeunit "User Session Unit";
        MakeServPreviewG: Codeunit "Make Serv. Preview";
        MakeArchServPreviewG: Codeunit "Make Serv. Preview/Archive";
        ServMgntG: Codeunit "Service Management";
        TextBlockContentG: Text;
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        ShowAppTextG: Text[50];
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
        FairDealTextG: Text[50];
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
        TotalTextG: Text[50];
        LegendTextG: Text[250];
        DuplicateTextG: Text[30];
        VATLegendsG: Text[15];
        RemainingAmountTextG: Text[5];
        RemainingStatusTextG: Text[30];
        ReportTitleG: Text[100];
        EUTireInformationG: Text[1024];
        ProformaInvoiceRecPositionG: Text[100];
        WarrCustG: Code[20];
        IntCustG: Code[20];
        AmountMinusDiscG: Decimal;
        TotalNetG: Decimal;
        SumLaborG: Decimal;
        SumItemG: Decimal;
        SumExtServG: Decimal;
        SumFairDealG: Decimal;
        SumOtherG: Decimal;
        SumDaysCarriedG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        OldServJobNoG: Integer;
        C_INC001: Label '% VAT of';
        OutputNoG: Integer;
        IncrG: Integer;
        [InDataSet]
        ServCustPrintG: Integer;
        PageLoopFooterG: Integer;
        [InDataSet]
        ServCustPrintFixedPriceG: Integer;
        ExchangeDaG: Boolean;
        FixedPriceLabG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No:';
        PrintDepositTicketsG: Boolean;
        FairDealDaG: Boolean;
        ShowShippingAddrG: Boolean;
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC014: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC018: Label ' of';
        ReturnDaG: Boolean;
        PrintDaysCarriedG: Boolean;
        C_INC021: Label 'Day';
        C_INC022: Label 'Days';
        PrintSubtotalsG: Boolean;
        C_INC029: Label 'Copy of';
        C_INC030: Label 'Total %1';
        C_INC031: Label 'Total %1 Incl. VAT';
        C_INC032: Label 'Fair deal amount %1';
        C_INC033: Label 'k';
        C_INC034: Label 'R';
        C_INC035: Label 'F = Fair Deal Position';
        C_INC036: Label 'R =Return-mandatory part';
        C_INC037: Label '* = Exchange Part';
        C_INC038: Label 'Closed with';
        ConsolidateNegativePosG: Boolean;
        RePrintOriginalInvG: Boolean;
        [InDataSet]
        ReqRePrintControlG: Boolean;
        C_INC039: Label 'D U P L I C A T E';
        C_INC040: Label ' - SWIFT-BIC :';
        C_INC041: Label ' - IBAN:';
        C_INC043: Label ' =';
        C_INC044: Label 'Service Invoice';
        C_INC_Proforma: Label 'Proforma %1';
        C_INC_RemainingStatus: Label 'Remaining Status';
        C_INC_RemainingAmount: Label 'RA';
        C_INC_PaymTolerance: Label 'PT';
        C_INC_PaymentDiscTolerance: Label 'DT';
        C_INC_BothPaymentTolerance: Label 'BT';
        IsRepSelectionSetupAvailableG: Boolean;
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Cust__No__CaptionLbl: Label 'Customer No.';
        MileageCaptionLbl: Label 'Mileage / Running Time';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        SalesPurch_NameLbl: Label 'Salesperson';
        Sales_Invoice_Header___Service_Order_No__CaptionLbl: Label 'Order No.';
        Sales_Invoice_Header___Order_Date_CaptionLbl: Label 'Due Date';
        Payments_to_CaptionLbl: Label 'Payments to:';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        SumLaborCaptionLbl: Label 'Sum Labor';
        SumItemCaptionLbl: Label 'Sum Item';
        SumExtServCaptionLbl: Label 'Sum External Services';
        SumOtherCaptionLbl: Label 'Sum Other';
        Inv__Discount_Amount_CaptionLbl: Label 'Invoice Discount';
        ContinuedCaptionLbl: Label 'Continued';
        ExplanationsCaptionLbl: Label 'Explanations';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        Cash_Reg__Add_Disc_Split_Post___Posting_Date_CaptionLbl: Label 'Date';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_Type_CaptionLbl: Label 'Type';
        Cash_Reg__Add_Disc_Split_Post___Appl__to_Document_No__CaptionLbl: Label 'Document Number';
        Cash_Reg__Add_Disc_Split_Post___Currency_Code_CaptionLbl: Label 'Currency';
        ABS__Remaining_Amount__CaptionLbl: Label 'Remaining Amount';
        ABS__Pmt__Discount_Total__CaptionLbl: Label 'PmtDisc';
        ABS_AmountMinusDiscount_CaptionLbl: Label 'Amount';
        Posted_Cash_Register_Header___Amount_to_Pay__LCY__CaptionLbl: Label 'Amount to Pay';
        Posted_Cash_Register_Header___Change_Money_CaptionLbl: Label 'Change Money';
        Posted_Cash_Register_Header___Amount_Given_CaptionLbl: Label 'Amount given';
        [InDataSet]
        PrintFixedPriceG: Boolean;
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        Inspection_DateLbl: Label 'Inspection Date';
        Emission_DateLbl: Label 'Emission Date';
        Appt_Service_AdvisorLbl: Label 'Appt. Service Advisor';
        Pickup_Service_AdvisorLbl: Label 'Pickup Service Advisor';
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
        Order_Limit_LCYLbl: Label 'Order Limit';
        ShowQtyG: Boolean;
        ShowUOMG: Boolean;
        ShowUnitPriceG: Boolean;
        ShowDiscountG: Boolean;
        ShowAmountG: Boolean;
        ShowLineSubTotalsG: Boolean;
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
        AmountWithoutLetterG: Decimal;
        LetterAmountG: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        VATAmountLetterG: Decimal;
        PreviousVATDocLetterNoG: Code[20];
        AmountIncludingVAT_SIH: Decimal;
        ExchRateText: Text[50];
        CalculatedExchRate: Decimal;
        TempVATAmountLineG: Record "VAT Amount Line" temporary;
        ExchPartsTaxAmountSumG: Decimal;
        VATPctG: Decimal;
        ExchTaxPctG: Decimal;
        PaymentsLbl: Label 'Payments List';
        VATIdentLbl: Label 'VAT Recapitulation';
        VATPercentLbl: Label 'VAT %';
        VATBaseLbl: Label 'VAT Base';
        VATAmtLbl: Label 'VAT Amount';
        TotalLbl: Label 'total';
        VATLbl: Label 'VAT';
        ToDateLbl: Label 'to date';
        SumAdvancePaymentsLbl: Label 'Sum Advance Payments';
        RestToPayLbl: Label 'Rest to pay';
        WithoutVATLbl: Label 'without VAT';
        ShowCurrencyG: Text[30];
        SalesInvoiceAdvanceCountG: Integer;

    [Scope('Internal')]
    procedure CreateTotals()
    begin
        // CreateTotals
        WITH "Sales Invoice Line" DO BEGIN
            CASE ServLineG.Type OF
                ServLineG.Type::Item:
                    SumItemG := SumItemG + Amount + "Inv. Discount Amount";
                ServLineG.Type::"Ext. Service":
                    IF ServSetupG."Output Ext. Service" THEN
                        SumExtServG := SumExtServG + Amount + "Inv. Discount Amount"
                    ELSE
                        SumLaborG := SumLaborG + Amount + "Inv. Discount Amount";
                ServLineG.Type::Labor:
                    SumLaborG := SumLaborG + Amount + "Inv. Discount Amount";
                ELSE
                    SumOtherG := SumOtherG + Amount + "Inv. Discount Amount";
            END;
            TotalNetG := TotalNetG + Amount + "Inv. Discount Amount";
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
        ReportSelectionL: Record "Report Selection";
    begin
        // @ This function sets request page filters from Report Selection setup through User Session Unit.
        // Start PA039225.51457
        // Start EU.0000011
        ReportSelectionG.INIT;
        ReportTitleG := C_INC044;
        UserSessionG.GetRecordRef(RecordRefL);
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            if RecordRefL.Number = Database::"Report Selection" then begin
                RecordRefL.SETTABLE(ReportSelectionL);
                ReportSelectionG."Print Report Title" := ReportSelectionL."Print Report Title";
                ReportSelectionG."Report Title" := ReportSelectionL."Report Title";
                ReportSelectionG."Report ID" := ReportSelectionL."Report ID";
                ReportSelectionG."Print Footer Line" := ReportSelectionL."Print Footer Line";
                //ReportSelectionG."Print Job Detailed Descript." := ReportSelectionL."Print Job Detailed Descript.";
                ReportSelectionG."Print Footer Line" := ReportSelectionL."Print Footer Line";
                ReportSelectionG."Print Sent-From Line" := ReportSelectionL."Print Sent-From Line";
                ReportSelectionG."Print Address Block" := ReportSelectionL."Print Address Block";
            end else
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
        IF SalesInvHdrL.FINDSET THEN BEGIN
            IF NOT CustL.GET(SalesInvHdrL."Bill-to Customer No.") THEN
                IF NOT CustL.GET(SalesInvHdrL."Sell-to Customer No.") THEN
                    CLEAR(CustL);
            NoOfCopiesG += CustL."Invoice Copies";
            // Start PA043099.90573
        END ELSE BEGIN
            SalesInvHdrL.SETRANGE(SalesInvHdrL."No.");
            SalesInvHdrL.SETRANGE(SalesInvHdrL."Pre-Assigned No.", "Sales Invoice Header".GETFILTER("Pre-Assigned No."));
            IF SalesInvHdrL.FINDSET THEN BEGIN
                IF NOT CustL.GET(SalesInvHdrL."Bill-to Customer No.") THEN
                    IF NOT CustL.GET(SalesInvHdrL."Sell-to Customer No.") THEN
                        CLEAR(CustL);
                NoOfCopiesG += CustL."Invoice Copies";
            END;
            // Stop PA043097.90573
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

        // Start PA041187.91743
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
        // Stop PA041187.91743
    end;

    local procedure GetServCust(DocumentTypeP: Integer; DocumentNoP: Code[20]; BilltoCustomerNoP: Code[20]): Boolean
    begin
        // @ Gets Service Customer
        // @ param DocumentTypeP - Integer
        // @ param DocumentNoP - Code 20
        // @ param BilltoCustomerNoP - Code 20
        // @ retval - Boolean

        // Start PA041187.91743
        IF NOT ServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
            IF NOT ArchServCustG.GET(DocumentTypeP, DocumentNoP, BilltoCustomerNoP) THEN
                EXIT(FALSE)
            ELSE
                ServCustG.TRANSFERFIELDS(ArchServCustG);
        EXIT(TRUE);
        // Stop PA041187.91743
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

        // Start PA041187.91743
        IF NOT ServJobLineP.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
            IF NOT ArchServJobLineL.GET(DocumentTypeP, DocumentNoP, ServJobNoP) THEN
                EXIT(FALSE)
            ELSE
                ServJobLineP.TRANSFERFIELDS(ArchServJobLineL);
        EXIT(TRUE);
        // Stop PA041187.91743
    end;

    [Scope('Internal')]
    procedure DetermineColumnVisibility()
    begin
        // @ Determines Column Visibility based on Print Service Job Fixed Price value of the current Service Customer
        // @ Applies only to Fixed Price related lines.
        // Start PA041187.91743

        // Consider Service Job Fixed Price Rounding Line
        IF ("Sales Invoice Line"."Service Order No." = '') AND ("Sales Invoice Line"."Service Order Line No." = 0) AND
           ServHdrG."Includes Fixed Price" AND
           ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Account (G/L)") AND
           (ServSetupG."Serv. Fixed Price G/L Account" <> '') AND
           ("Sales Invoice Line"."No." = ServSetupG."Serv. Fixed Price G/L Account") AND
           NOT "Sales Invoice Line"."Automatic Surcharge"
        THEN BEGIN
            ServPrevLineTempG.RESET;
            ServPrevLineTempG.SETRANGE("Automatic Surcharge", FALSE);
            ServPrevLineTempG.SETRANGE(Type, ServPrevLineTempG.Type::"G/L Account");
            ServPrevLineTempG.SETRANGE("No.", "Sales Invoice Line"."No.");
            ServPrevLineTempG.SETRANGE("Line Type", ServPrevLineTempG."Line Type"::Line);
            ServPrevLineTempG.SETRANGE("Document Line No.", 0);
            IF NOT ServPrevLineTempG.ISEMPTY THEN
                PrintFixedPriceG := TRUE;
        END;

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
                    IF IsFixedPriceSumLine() THEN
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
                    IF IsFixedPriceSumLine() THEN
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
        // Stop PA041187.91743
    end;

    [Scope('Internal')]
    procedure EvalHideSumLine() ValueR: Boolean
    begin
        // @ Evaluates Sum Line Visibility
        // @ retval ValueR - Boolean

        // Start PA041187.91743
        ValueR := ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"End-Total") AND PrintSubtotalsG AND ShowLineSubTotalsG;
        IF IsFixedPriceSumLine() THEN
            ValueR := TRUE;
        // Stop PA041187.91743
    end;

    local procedure IsFixedPriceSumLine(): Boolean
    begin
        // @ Checks  if current Sales Invoice Line is a Fixed Price Sum Line
        // @ retval - Boolean

        // Start PA041187.91743
        ServPrevLineTempG.RESET;
        ServPrevLineTempG.SETRANGE("Control Type", ServPrevLineTempG."Control Type"::Job);
        ServPrevLineTempG.SETRANGE(Description, "Sales Invoice Line".Description);
        EXIT(NOT ServPrevLineTempG.ISEMPTY);
        // Stop PA041187.91743
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


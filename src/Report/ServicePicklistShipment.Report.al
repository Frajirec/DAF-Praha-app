report 80033 "DPG Service Picklist/Shipment" // 1057630 "Service Picklist/Shipment CZ"
{
    // // @ Area Service
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033052   05.05.11 PR  Added code to print the report title from 'Report Selection' setup.
    // PA032727   12.07.11 PR  Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033336   30.10.12 SS 8719075:
    //                        - Added Text Constant C_INC016 to "*".
    //                        - Added Text Constant C_INC037 to "* = Exchange Part".
    //                        - Code changes in "Service Shipment Line - OnPreDataItem()"
    //                        - Code changes in "Service Shipment Line - OnAfterGetRecord()"
    //                        - New Section Total, Body (1) to print Exchange Part footer Note.
    // PA033890   06.12.12 GC 9272400: RDL Layout Created
    // PA033890   11.01.13 GC 9863128: RDL Layout Modified
    // PA034256   02.07.13 DT I000009 Call to function LogDocument adapted to the new option values of Segment Line.
    // PA034057   04.06.13 NB R-E-T Assignment of Resources: Additional field 'Resource Name' (optionally)
    // PA034731   19.12.13 DR Option and CaptionML of field "Document Type" corrected.
    // PA035484   20.01.13 GF 20145 Added code to set Usage & parameters for printing Deposit Ticket report.
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036547   20.11.14 GJ Merge N.6.1.4 to N.7.1.0 - PA035484.20145.
    // PA036549   15.01.15 GD 32533 RDLC Laytout to show Resource Name in "Service Shipment Line" dataitem.
    // PA038228   07.08.15 GN Added Header information.
    //                        Added Footer functionality.
    //                        Added detailed Service information
    // PA038228   21.08.15 GN 43635 Changed Footer fields sequence.
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   03.08.16 JS Merge of PA039225.51457
    // PA042484   28.12.16 PT Added the code to print word Duplicate if its not a original invoice
    // PA042484   20.01.17 PT 85335 Added the text box in RDLC to print word "DUPLICATE"
    // PA042485   10.05.17 PT 95156 Added the code to print word Duplicate in layout
    //                        -  Added the check on NoOfCopies value if its less than 0
    // PA040669   26.05.16 GV 61738 RDLC layout modifications
    // PA040669   01.06.16 GV 61738 Rename value of Copy text constant
    //                              RDLC Layout Corrections
    // PA041125   12.08.16 GN 68181 RDLC Layout corrections
    // --- 7.1.6 ---
    // EU.0002138 28.06.17 AK 2101 Merge of PA042484 & PA042485.95156
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    // --- NAVCZ ---
    // API.1      01.03.18 PV New object created as a copy of Report 5025608 Service Picklist/Shipment
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.1  25.04.18 PV RDLC Layout changed
    //                        Final design of vehicle/contract info part of header
    // API.1.0.2  07.06.18 PV RDLC Layout changed, translation of req.page, Final header design
    // API.1.0.3  07.08.18 PV RDLC Layout changed - duplicity text/graphic
    // --- API Customization ---
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ServicePicklistShipment.rdlc';

    Caption = 'Service Picklist/Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Service Shipment Header"; "Service Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Service Order';
            column(Service_Shipment_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(LoopNo; CopyLoopNoG)
                {
                    Description = 'PA042484';
                }
                column(HideSrvLineBody1; RDLHideOutput("Service Shipment Line".Type = "Service Shipment Line".Type::Item))
                {
                }
                column(HideSrvLineBody2; RDLHideOutput(HideServLineBody2G))
                {
                }
                column(Dangerous; PrintDangerousG)
                {
                }
                column(ForGroupingOnly; "Service Shipment Header"."No.")
                {
                }
                column(CopyLoopNo; CopyLoop.Number)
                {
                }
                column(CustAddr_1_; CustAddrG[1])
                {
                }
                column(CustAddr_2_; CustAddrG[2])
                {
                    Description = 'PA040669.61738';
                }
                column(CustAddr_3_; CustAddrG[3])
                {
                    Description = 'PA040669.61738';
                }
                column(CustAddr_4_; CustAddrG[4])
                {
                    Description = 'PA040669.61738';
                }
                column(CustAddr_5_; CustAddrG[5])
                {
                    Description = 'PA040669.61738';
                }
                column(CustAddr_6_; CustAddrG[6])
                {
                    Description = 'PA040669.61738';
                }
                column(CustAddr_7_; CustAddrG[7])
                {
                    Description = 'PA040669.61738';
                }
                column(CustAddr_8_; CustAddrG[8])
                {
                    Description = 'PA040669.61738';
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
                    Description = 'PA040669.61738';
                }
                column(CompanyAddr_5_; CompanyAddrG[5])
                {
                    Description = 'PA040669.61738';
                }
                column(CompanyAddr_6_; CompanyAddrG[6])
                {
                    Description = 'PA040669.61738';
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CoTelephoneG; CoTelephoneG)
                    {
                    }
                    column(CoFaxG; CoFaxG)
                    {
                    }
                    column(No_SSH; "Service Shipment Header"."No.")
                    {
                    }
                    column(CoEmailG; CoEmailG)
                    {
                    }
                    column(CompAddrG; CompAddrG)
                    {
                    }
                    column(No_Cust; CustG."No.")
                    {
                    }
                    column(CoFaxTextG; CoFaxTextG)
                    {
                    }
                    column(CoEmailTextG; CoEmailTextG)
                    {
                    }
                    column(CoTelephoneTextG; CoTelephoneTextG)
                    {
                    }
                    column(HidePrintFooterLineG; RDLHideOutput(IsRepSelectionSetupAvailableG))
                    {
                    }
                    column(HideFooterLineG; RDLHideOutput(IsRepSelectionSetupAvailableG AND NOT ReportLayoutSetupG."One Column Footer"))
                    {
                    }
                    column(HideOneColumnFooter; RDLHideOutput(IsRepSelectionSetupAvailableG AND ReportLayoutSetupG."One Column Footer"))
                    {
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
                    column(sep1; FORMAT('--'))
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Duplicate_Graphic_; ReportLayoutSetupG."Duplicate Graphic")
                    {
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__One_Column_Footer_; RDLHideOutput(ReportLayoutSetupG."One Column Footer"))
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
                    {
                        Description = 'PA040669.61738';
                    }
                    column(SignaturesLbl; SignaturesLbl)
                    {
                        Description = 'PA040669.61738';
                    }
                    column(No_ServH; ServHdrG."No.")
                    {
                    }
                    column(OrderDate_ServH; FORMAT(ServHdrG."Order Date"))
                    {
                    }
                    column(TimeOfOrder_ServH; FORMAT(ServHdrG."Time of Order", 0, '<Hours24,2>:<Minutes,2>'))
                    {
                    }
                    column(PickupDate_ServH; FORMAT(ServHdrG."Pickup Date"))
                    {
                    }
                    column(PickupTime_ServH; FORMAT(ServHdrG."Pickup Time", 0, '<Hours24,2>:<Minutes,2>'))
                    {
                    }
                    column(Name_SalPur; SalesPurchG.Name)
                    {
                    }
                    column(CopyTextG; CopyTextG)
                    {
                    }
                    column(VATRegistrationNo1_SSH; "Service Shipment Header"."VAT Registration No.")
                    {
                    }
                    column(VATRegistrationNoCpn_SSH; CollUnitG.TextShowOutput("Service Shipment Header".FIELDCAPTION("VAT Registration No."), "Service Shipment Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(VATRegistrationNoCpn_Comp; CollUnitG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(VATRegistrationNo1_Comp; CollUnitG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(TaxNoCpn; CollUnitG.TextShowOutput(C_INC032, PrintAddrBlockG))
                    {
                    }
                    column(RegistrationNo1_Comp; CollUnitG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(GuideNo_ServH; ServHdrG."Guide No.")
                    {
                    }
                    column(ReportTitleG; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(BillToAddrLineG; BillToAddrLineG)
                    {
                    }
                    column(ServHdrG__Engine_Code_; ServHdrG."Engine Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(ServHdrG__License_No__; ServHdrG."License No.")
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
                    column(ServHdrG__Labor_Type_; ServHdrG."Labor Type")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(ServHdrG__Initial_Registration_; ServHdrG."Initial Registration")
                    {
                    }
                    column(ServHdrG_Mileage; ServHdrG.Mileage)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(ServHdrG__Engine_No__; ServHdrG."Engine No.")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(ServAdvisorG; ServAdvisorG)
                    {
                    }
                    column(SalesPurchG_Name_Control57; SalesPurchG.Name)
                    {
                    }
                    column(ServHdrG__Model_Code_; ServHdrG."Model Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header_Make_Code; ServHdrG."Make Code")
                    {
                    }
                    column(Service_Header__Model; ServHdrG.Model)
                    {
                    }
                    column(Service_Header___Model_Code_; ServHdrG."Model Code")
                    {
                        AutoFormatExpression = 'JMD';
                    }
                    column(Service_Header__VIN; ServHdrG.VIN)
                    {
                    }
                    column(Service_Header___Licence_No_; ServHdrG."License No.")
                    {
                    }
                    column(Service_Header___Initial_Reg_; FORMAT(ServHdrG."Initial Registration"))
                    {
                        Description = 'PA040669.61738';
                    }
                    column(Service_Header___Appointment_Date_; FORMAT(ServHdrG."Order Date") + ' / ' + FORMAT(ServHdrG."Time of Order"))
                    {
                    }
                    column(Service_Header___Pickup_Date_; FORMAT(ServHdrG."Pickup Date") + ' / ' + FORMAT(ServHdrG."Pickup Time"))
                    {
                    }
                    column(Service_Header___Mileage_RunningTime_; FORMAT(ServHdrG.Mileage) + ' /  ' + FORMAT(ServHdrG."Running Time"))
                    {
                    }
                    column(Service_Header__Mileage; ServHdrG.Mileage)
                    {
                    }
                    column(MainNextAppDate_G; FORMAT(MainNextAppDateG))
                    {
                        Description = 'PA040669.61738';
                    }
                    column(EmissionNextAppDate_G; FORMAT(EmissionNextAppDateG))
                    {
                        Description = 'PA040669.61738';
                    }
                    column(Service_Header___Appt_Serv_Adv_; ServHdrG."Service Advisor No.")
                    {
                    }
                    column(Service_Header___PickupServiceAdv_; ServHdrG."Service Advisor No./Pick-Up")
                    {
                    }
                    column(Service_Header___Order_Limit_; ServHdrG."Order Limit")
                    {
                        Description = 'PA028449';
                    }
                    column(Service_Contract_No; VehicleCustomerG."Contract No.")
                    {
                    }
                    column(PageLbl; Field44Lbl)
                    {
                    }
                    column(CustomerNoLbl; Field28Lbl)
                    {
                    }
                    column(PickupApptLbl; Field41Lbl)
                    {
                    }
                    column(DocumentNoLbl; Field37Lbl)
                    {
                    }
                    column(SalespersonLbl; Field39Lbl)
                    {
                    }
                    column(OrderNoLbl; Field30Lbl)
                    {
                    }
                    column(DocumentDate1Lbl; Field34Lbl)
                    {
                    }
                    column(GuideNoLbl; Field32Lbl)
                    {
                    }
                    column(ServHdrG__Engine_Code_Caption; ServHdrG__Engine_Code_CaptionLbl)
                    {
                    }
                    column(ServHdrG__License_No__Caption; ServHdrG__License_No__CaptionLbl)
                    {
                    }
                    column(MakeCaption; MakeCaptionLbl)
                    {
                    }
                    column(Model_DescriptionCaption; Model_DescriptionCaptionLbl)
                    {
                    }
                    column(ServHdrG_VINCaption; ServHdrG_VINCaptionLbl)
                    {
                    }
                    column(ServHdrG__Labor_Type_Caption; ServHdrG__Labor_Type_CaptionLbl)
                    {
                    }
                    column(ServHdrG__Initial_Registration_Caption; ServHdrG__Initial_Registration_CaptionLbl)
                    {
                    }
                    column(MileageCaption; MileageCaptionLbl)
                    {
                    }
                    column(ServHdrG__Engine_No__Caption; ServHdrG__Engine_No__CaptionLbl)
                    {
                    }
                    column(Service_AdvisorCaption; Service_AdvisorCaptionLbl)
                    {
                    }
                    column(Sales_AdvisorCaption; Sales_AdvisorCaptionLbl)
                    {
                    }
                    column(ServHdrG__Model_Code_Caption; ServHdrG__Model_Code_CaptionLbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(No_Caption; No_CaptionLbl)
                    {
                    }
                    column(QuantityCaption; QuantityCaptionLbl)
                    {
                    }
                    column(UoMCaption; UoMCaptionLbl)
                    {
                    }
                    column(LocationCaption; LocationCaptionLbl)
                    {
                    }
                    column(ShelfCaption; ShelfCaptionLbl)
                    {
                    }
                    column(BinCaption; BinCaptionLbl)
                    {
                    }
                    column(Service_Header___Model_Code_Caption; Service_Header___Model_Code_CaptionLbl)
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
                    column(Pickup_Date_Time; Pickup_Date_TimeLbl)
                    {
                    }
                    column(Order_Limit_LCY; FORMAT(Order_Limit_LCYLbl))
                    {
                    }
                    column(Guide_No_Caption; Guide_No_CaptionLbl)
                    {
                        Description = 'PA029090';
                    }
                    column(Service_Header___Order_Date_Caption; Service_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(Service_Header___Order_Limit_Caption; Service_Header___Order_Limit_CaptionLbl)
                    {
                        Description = 'PA028449,PA031318';
                    }
                    column(Service_Header__VINCaption; Service_Header__VINCaptionLbl)
                    {
                    }
                    column(Service_Header___License_No__Caption; Service_Header___License_No__CaptionLbl)
                    {
                    }
                    column(Service_Header___Initial_Registration_Caption; Service_Header___Initial_Registration_CaptionLbl)
                    {
                    }
                    column(FootNotes; NotesLbl)
                    {
                    }
                    column(FootName; NameLbl)
                    {
                    }
                    column(FootDateVisa; DateVisaLbl)
                    {
                    }
                    column(DuplicateTextG; DuplicateTextG)
                    {
                        Description = 'PA042484';
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
                    column(PaymentMethodCode_SSH; "Service Shipment Header"."Payment Method Code")
                    {
                    }
                    column(RegistrationNo_SSH; RegistrationNoCustG)
                    {
                    }
                    column(VATRegistrationNo_SSH; "Service Shipment Header"."VAT Registration No.")
                    {
                    }
                    column(TaxRegistrationNo_SSH; TaxRegistrationNoCustG)
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
                    column(SellToAddr1; BillToAddrG[1])
                    {
                    }
                    column(SellToAddr2; BillToAddrG[2])
                    {
                    }
                    column(SellToAddr3; BillToAddrG[3])
                    {
                    }
                    column(SellToAddr4; BillToAddrG[4])
                    {
                    }
                    column(SellToAddr5; BillToAddrG[5])
                    {
                    }
                    column(SellToAddr6; BillToAddrG[6])
                    {
                    }
                    column(SellToAddr7; BillToAddrG[7])
                    {
                    }
                    column(SellToAddr8; BillToAddrG[8])
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
                    column(DocumentDate_SSH; "Service Shipment Header"."Document Date")
                    {
                    }
                    column(DueDateCpn_SSH; "Service Shipment Header".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(DueDate_SSH; "Service Shipment Header"."Due Date")
                    {
                    }
                    column(VATDateCpn_SSH; 'Service Shipment Header.FIELDCAPTION(VAT Date)')
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
                    column(YourReferenceCpn_SH; "Service Shipment Header".FIELDCAPTION("Your Reference"))
                    {
                    }
                    column(YourReference_SH; "Service Shipment Header"."Your Reference")
                    {
                    }
                    column(VehicleCategoryCode_SH; ServHdrG."Vehicle Category Code")
                    {
                    }
                    column(VehicleCategoryCodeCpn_SH; ServHdrG.FIELDCAPTION("Vehicle Category Code"))
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
                    dataitem("Service Shipment Line"; "Service Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Service Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Service_Shipment_Line__No__; "No.")
                        {
                        }
                        column(Service_Shipment_Line_Description; Description)
                        {
                        }
                        column(Service_Shipment_Line_Quantity; Quantity)
                        {
                        }
                        column(Service_Shipment_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Service_Shipment_Line__Location_Code_; "Location Code")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(Service_Shipment_Line__Bin_Code_; "Bin Code")
                        {
                            AutoFormatExpression = 'JMD';
                        }
                        column(ShelfNoG; ShelfNoG)
                        {
                        }
                        column(NoPropertyG; NoPropertyG)
                        {
                        }
                        column(HideServiceShipmentLineBody1; RDLHideOutput(TRUE))
                        {
                        }
                        column(Service_Shipment_Line__Description_2_; "Description 2")
                        {
                        }
                        column(ResourceName_ServiceShipmentLine; "Resource Name")
                        {
                        }
                        column(Service_Shipment_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Service_Shipment_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            LocationL: Record Location;
                            ShelfDefaultL: Option "Shelf No.(Item)","Shelf No.(Item Location)",Bin;
                            ItemL: Record Item;
                            RefMasterL: Record "Reference Master";
                        begin
                            // Start PA033336
                            NoPropertyG := '';
                            IF Type = Type::Item THEN BEGIN
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN BEGIN
                                    NoPropertyG := C_INC016;
                                    ExchangePartG := TRUE;
                                END;
                                // Stop PA033336
                                IF ItemG.GET("No.") THEN
                                    ;
                                LocationL.SETRANGE(Code, "Service Shipment Line"."Location Code");
                                IF LocationL.FIND('-') THEN BEGIN
                                    ShelfDefaultL := LocationL."Shelf/Bin Default";
                                    CASE ShelfDefaultL OF
                                        LocationL."Shelf/Bin Default"::"Shelf No.(Item)":
                                            ShelfNoG := ItemG."Shelf No.";
                                        LocationL."Shelf/Bin Default"::"Shelf No.(Item Location)":
                                            BEGIN
                                                ItemLocationsG.SETRANGE("Item No.", "No.");
                                                ItemLocationsG.SETRANGE("Location Code", "Service Shipment Line"."Location Code");
                                                IF ItemLocationsG.FIND('-') THEN
                                                    ShelfNoG := ItemLocationsG."Shelf No.";
                                            END;
                                        LocationL."Shelf/Bin Default"::Bin:
                                            ShelfNoG := '';
                                    END;
                                END;
                            END;
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
                                        IF RefMasterL.FIND('-') THEN
                                            DangerousGoodsListTG."Text 02" := RefMasterL.Description;
                                        DangerousGoodsListTG.INSERT;
                                    END;
                                END;
                            END;

                            // Start PA036549.32533
                            HideServLineBody2G := ("Service Shipment Line".Type = "Service Shipment Line".Type::Item) AND ("Service Shipment Line"."Description 2" <> '') OR
                              (("Service Shipment Line".Type = Type::Item) AND ("Service Shipment Line"."Resource Name" <> '') AND PrintResourceNameG)
                            // Stop PA036549.32533
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA033336
                            ExchangePartG := FALSE;
                            // Stop PA033336
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(C_INC037; C_INC037)
                        {
                        }
                        column(HideTotalBody1; RDLHideOutput(ExchangePartG))
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
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
                }
                dataitem(Deposit; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    trigger OnAfterGetRecord()
                    var
                        DepositReportL: Report "Deposit Ticket";
                    begin
                        IF PrintDepositTicketsG THEN BEGIN
                            "Service Shipment Line".MARKEDONLY(TRUE);
                            IF "Service Shipment Line".FIND('-') THEN BEGIN
                                REPEAT
                                    ;
                                    IF ("Service Shipment Line"."Printed Deposit Tickets" > 0) OR
                                       (DepositReportL.ServShipLinePrintCount("Service Shipment Line") > 0)
                                    THEN BEGIN
                                        // Start PA035484.20145
                                        UserSessionG.SetUsage(ReportSelectionsG.Usage::"Service Checklist");
                                        DepositReportL.DefParameters("Service Shipment Line".TABLENAME, CopyTextG,
                                          CopyLoop.Number - 1, 0);
                                        // Stop PA035484.20145
                                        DepositReportL.SETTABLEVIEW("Service Shipment Line");
                                        DepositReportL.RUNMODAL();
                                        "Service Shipment Line".FIND('+');
                                    END;
                                UNTIL "Service Shipment Line".NEXT = 0;
                            END;
                        END;
                    end;
                }
                dataitem(DangerousGoods; "Integer")
                {
                    DataItemTableView = SORTING(Number);
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
                    column(PrintDangerous; RDLHideOutput(TRUE))
                    {
                    }
                    column(DescriptionCaption_Control1109400044; DescriptionCaption_Control1109400044Lbl)
                    {
                    }
                    column(Dangerous_Goods_CodeCaption; Dangerous_Goods_CodeCaptionLbl)
                    {
                    }
                    column(Qty_Caption; Qty_CaptionLbl)
                    {
                    }
                    column(DescriptionCaption_Control1109400047; DescriptionCaption_Control1109400047Lbl)
                    {
                    }
                    column(No_Caption_Control1109400048; No_Caption_Control1109400048Lbl)
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
                        // Start PA033890.9272400
                        IF DangerousGoods.Number = 1 THEN BEGIN
                            // Start PA042484
                            CopyLoopNoG := CopyLoopNoG + 1;
                            // Stop PA042484
                            PrintDangerousG := TRUE;
                        END;
                        // Stop PA033890.9272400
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
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    // Start PA042484
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;

                    ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    IF ("Service Shipment Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                        IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN //  API.1      01.03.18 PV
                            DuplicateTextG := C_INC_DuplicateText
                        ELSE // Start API.1      01.03.18 PV
                            ShowDuplicateImageG := TRUE;
                    END; // Stop API.1      01.03.18 PV

                    CopyLoopNoG := CopyLoopNoG + 1;
                    // Stop PA042484
                    // Start PA035597
                    // Stop PA035597
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        ServShipPrintCounterG.RUN("Service Shipment Header");
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
            var
                InteractionLogL: Record "Interaction Log Entry";
            begin
                //Start API.1      01.03.18 PV
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");
                //Stop API.1      01.03.18 PV

                // Start PA038228
                IsRepSelectionSetupAvailableG := ReportSelectionsG.GetFooterDetails(ReportLayoutSetupG, "Make Code", "Location Code",
                  REPORT::"DPG Service Picklist/Shipment");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Make Code", "Location Code");

                //Start API.1      01.03.18 PV
                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Service Shipment Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName("Service Shipment Header"."User ID");

                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;
                ServHdrG.CALCFIELDS("Driver Name");
                //Stop API.1      01.03.18 PV

                // Start PA040669.61738
                IF NOT ServHdrG.GET(ServHdrG."Document Type"::Order, "Order No.") THEN BEGIN
                    IF NOT ArchServHdrG.GET(ArchServHdrG."Document Type"::Order, "Order No.") THEN
                        CLEAR(ArchServHdrG);
                    ServHdrG.TRANSFERFIELDS(ArchServHdrG);
                END;
                // Stop PA040669.61738

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

                // Start PA032727
                // Stop PA032727
                DangerousGoodsListTG.DELETEALL;

                IF CurrReport.PREVIEW THEN
                    PrintDepositTicketsG := FALSE;

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

                IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                  OwnBanksG.GET(IntCustG, LocationG."Bank Code")
                THEN BEGIN // Start API.1      01.03.18 PV
                    BankNameG := OwnBanksG.Name;
                    BankBranchNoG := OwnBanksG."Bank Branch No.";
                    BankSwiftG := OwnBanksG."SWIFT-BIC";
                    BankIbanG := OwnBanksG.IBAN;
                    BankAccountNoG := OwnBanksG."Bank Account No.";
                    // Stop API.1      01.03.18 PV
                    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                END // Start API.1      01.03.18 PV
                ELSE BEGIN
                    BankNameG := CompanyInfoG."Bank Name";
                    BankBranchNoG := CompanyInfoG."Bank Branch No.";
                    BankSwiftG := CompanyInfoG."SWIFT-BIC";
                    BankIbanG := CompanyInfoG.IBAN;
                    BankAccountNoG := CompanyInfoG."Bank Account No.";
                    // Stop API.1      01.03.18 PV
                    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";
                END; // API.1      01.03.18 PV


                VehicleFormatAddrG.ServShptHeaderSellTo(CustAddrG, "Service Shipment Header");

                // Start API.1      01.03.18 PV
                IF NOT PaymentMethodG.GET("Service Shipment Header"."Payment Method Code") THEN
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

                // Start AH

                IF "Make Code" <> '' THEN
                    MakeG.GET("Make Code")
                ELSE
                    MakeG.INIT;


                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                IF "Sell-to Customer No." <> '' THEN BEGIN
                    CustG.GET("Sell-to Customer No.");
                    //Start API.1.0.2  07.06.18 PV
                    TaxRegistrationNoCustG := CustG."Tax Registration No.";
                    RegistrationNoCustG := CustG."Registration No.";
                END;
                //StopAPI.1.0.2  07.06.18 PV
                // Stop AH

                IF "Service Shipment Header"."Sell-to Customer No." <> "Service Shipment Header"."Bill-to Customer No." THEN BEGIN
                    VehicleFormatAddrG.ServShptHeaderBillTo(BillToAddrG, "Service Shipment Header");
                    BillToAddrLineG := C_INC008 + VehicleFormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    BillToAddrLineG := '';
                // Start PA040669.61738
                // Stop PA040669.61738
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(46) <> '';
                    IF LogInteractionG THEN
                        // Start PA034256.I000009
                        SegMgntG.LogDocument(
                      InteractionLogL."Document Type"::SrvShpt,
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
                // Start PA042484
                CopyLoopNoG := 0;
                // Stop PA042484
            end;
        }
    }

    requestpage
    {
        Caption = 'Service - Picklist/Ship';
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
                    field(PrntDangerousGoodsListG; PrntDangerousGoodsListG)
                    {
                        Caption = 'Print Dangerous Goods List';
                    }
                    field(PrintResourceNameG; PrintResourceNameG)
                    {
                        Caption = 'Print Resource Name';
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
            // Start PA032727
            IF InvSetupG.GET THEN
                PrintDepositTicketsG := InvSetupG."Print Deposit Tickets"
            ELSE
                PrintDepositTicketsG := FALSE;
            // Start PA039225.51457
            // Start PA033890.9272400
            // Stop PA033890.9272400
            // Start PA033890.9272400
            // Stop PA033890.9272400
            // Stop PA032727
            GetReportSelection();
            // Stop PA039225.51457
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
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        GetReportSelection();
        // Stop PA039225.51457
        IF InvSetupG.GET THEN
            PrintDepositTicketsG := InvSetupG."Print Deposit Tickets"
        ELSE
            PrintDepositTicketsG := FALSE;
        //Stop PA032727
    end;

    var
        ArchServHdrG: Record "Archived Service Header";
        ItemG: Record Item;
        ReportSelectionsG: Record "Service Manag. Rep. Selection";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnBanksG: Record "Customer Bank Account";
        OwnDelivAddressG: Record "Ship-to Address";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        InvSetupG: Record "Inventory Setup";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        MakeG: Record Make;
        SalesPurchG: Record "Salesperson/Purchaser";
        ServHdrG: Record "Service Header";
        PaymentTermsG: Record "Payment Terms";
        ItemLocationsG: Record "Item Location";
        VehicleCustomerG: Record "Vehicle Customer";
        ReportLayoutSetupG: Record "Report Layout Setup";
        FormatAddrG: Codeunit "Format Address";
        VehicleFormatAddrG: Codeunit "Veh Format Address";
        CollUnitG: Codeunit "Collection Unit";
        ServShipPrintCounterG: Codeunit "Printed Service Shipment";
        UserSessionG: Codeunit "User Session Unit";
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
        CompAddrG: Text[250];
        BillToAddrG: array[8] of Text[50];
        BillToAddrLineG: Text[250];
        ServAdvisorG: Text[30];
        NoPropertyG: Text[30];
        ReportTitleG: Text[100];
        DuplicateTextG: Text[100];
        IntCustG: Code[20];
        NoOfCopiesG: Integer;
        PrintSentFromLineG: Boolean;
        IsRepSelectionSetupAvailableG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintDepositTicketsG: Boolean;
        ShowShippingAddrG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        C_INC008: Label 'Bill-to:';
        C_INC016: Label '*';
        C_INC029: Label 'Copy';
        C_INC032: Label 'Tax No.';
        SegMgntG: Codeunit SegManagement;
        LogInteractionG: Boolean;
        ShelfNoG: Code[10];
        PrntDangerousGoodsListG: Boolean;
        DangerousGoodsListTG: Record "Temporary Statistics" temporary;
        ReportSelectionG: Record "Service Manag. Rep. Selection";
        C_INC033: Label 'Service Picklist';
        C_INC037: Label '* = Exchange Part';
        ExchangePartG: Boolean;
        CopyLoopNoG: Integer;
        PrintDangerousG: Boolean;
        PrintResourceNameG: Boolean;
        C_INC_DuplicateText: Label 'D U P L I C A T E';
        C_INC_NoOfCopiesValue: Label 'Please enter value greater than 0 or equal to 0';
        Field44Lbl: Label 'Page';
        Field28Lbl: Label 'Customer No.';
        Field41Lbl: Label 'Pickup Appt.';
        Field37Lbl: Label 'Document No.';
        Field39Lbl: Label 'Salesperson';
        Field30Lbl: Label 'Order No.';
        Field34Lbl: Label 'Document Date';
        Field32Lbl: Label 'Guide No.';
        ServHdrG__Engine_Code_CaptionLbl: Label 'Engine Code';
        ServHdrG__License_No__CaptionLbl: Label 'Licence No.';
        MakeCaptionLbl: Label 'Make Code';
        Model_DescriptionCaptionLbl: Label 'Model';
        ServHdrG_VINCaptionLbl: Label 'VIN';
        ServHdrG__Labor_Type_CaptionLbl: Label 'Labor Type';
        ServHdrG__Initial_Registration_CaptionLbl: Label 'Initial Registration';
        MileageCaptionLbl: Label 'Mileage / Running Time';
        ServHdrG__Engine_No__CaptionLbl: Label 'Engine No.';
        Service_AdvisorCaptionLbl: Label 'Service Advisor';
        Sales_AdvisorCaptionLbl: Label 'Sales Advisor';
        ServHdrG__Model_Code_CaptionLbl: Label 'Model Code';
        DescriptionCaptionLbl: Label 'Description';
        No_CaptionLbl: Label 'No.';
        QuantityCaptionLbl: Label 'Quantity';
        UoMCaptionLbl: Label 'UoM';
        LocationCaptionLbl: Label 'Location';
        ShelfCaptionLbl: Label 'Shelf';
        BinCaptionLbl: Label 'Bin';
        DField27Lbl: Label 'Dangerous Goods';
        DField28Lbl: Label 'Customer No.';
        DField30Lbl: Label 'Order No.';
        DField34Lbl: Label 'Document Date';
        DField37Lbl: Label 'Document No.';
        DField39Lbl: Label 'Salesperson';
        DField41Lbl: Label 'Pickup Appt.';
        DField44Lbl: Label 'Page';
        DescriptionCaption_Control1109400044Lbl: Label 'Description';
        Dangerous_Goods_CodeCaptionLbl: Label 'Dangerous Goods Code';
        Qty_CaptionLbl: Label 'Qty.';
        DescriptionCaption_Control1109400047Lbl: Label 'Description';
        No_Caption_Control1109400048Lbl: Label 'No.';
        HideServLineBody2G: Boolean;
        RePrintOriginalInvG: Boolean;
        MainNextAppDateG: Date;
        EmissionNextAppDateG: Date;
        Inspection_DateLbl: Label 'Inspection Date';
        Emission_DateLbl: Label 'Emission Date';
        Appt_Service_AdvisorLbl: Label 'Appt. Service Advisor';
        Pickup_Service_AdvisorLbl: Label 'Pickup Service Advisor';
        Service_ContractLbl: Label 'Service Contract';
        Appointment_DateLbl: Label 'Appointment Date';
        Pickup_Date_TimeLbl: Label 'Pickup Date';
        Order_Limit_LCYLbl: Label 'Order Limit';
        Guide_No_CaptionLbl: Label 'Guide No.';
        Service_Header___Order_Date_CaptionLbl: Label 'Document Date';
        Service_Header___Order_Limit_CaptionLbl: Label 'Order Limit';
        FORMAT_CurrReport_PAGENO_CaptionLbl: Label 'Page';
        Service_Header___Model_Code_CaptionLbl: Label 'Model Code';
        Service_Header__VINCaptionLbl: Label 'VIN';
        Service_Header___License_No__CaptionLbl: Label 'License No.';
        Service_Header___Initial_Registration_CaptionLbl: Label 'Initial Registration';
        NotesLbl: Label 'Notes';
        NameLbl: Label 'Name';
        DateVisaLbl: Label 'Date / Visa';
        SignaturesLbl: Label 'Signatures';
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
        UnitPriceLbl: Label 'Unit Price';
        NoLbl: Label 'No.';
        NameSalesPurchLbl: Label 'Salesperson';
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
    procedure GetReportSelection()
    var
        RecordRefL: RecordRef;
        ReportIDTextL: Text;
        ReportIDL: Integer;
    begin
        // @ This function sets request page filters from Report Selection setup through User Session Unit.
        // Start PA039225.51457
        ReportSelectionsG."Print Sent-From Line" := TRUE;
        ReportSelectionsG."Print Address Block" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC033;
        UserSessionG.GetRecordRef(RecordRefL);
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionsG);
            IF ReportSelectionsG."Print Report Title" THEN
                ReportTitleG := ReportSelectionsG."Report Title"
            ELSE BEGIN
                ReportSelectionsG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionsG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;

        PrintSentFromLineG := ReportSelectionsG."Print Sent-From Line";
        PrintAddrBlockG := ReportSelectionsG."Print Address Block";
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
                TitleTextRightG := "Service Shipment Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Service Shipment Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Service Shipment Header"."No.";
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


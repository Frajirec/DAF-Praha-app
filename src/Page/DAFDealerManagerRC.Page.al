page 80014 "DPG DAF Dealer Manager RC"
{
    // // @ Area Vehicle
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   09.02.10 New object
    // PA032111   12.08.10 (BRL): Object renumbering changes due to Microsoft Agreement.
    // PA031550   10.09.10 SS Added Tasks in Role Center Actions
    // PA032178   15.10.10 DD 1606137: Call of Actions -> Quick Customer Creation corrected
    // PA032103   21.04.11 AA Added "My Web Places" to Home menu
    // PA032814   11.11.11 BL MenuItem "Anticipated/Inventory Vehicles", "Vehicle Status Change List" and
    //                        "Vehicle Branch Order List" added under Menu Home, "Posted Vehicle Status Changes"
    //                        and "Arch. Branch Orders Vehicles" added under Menu Purchase History.
    // PA032651   29.12.11 SS 4889933 - Changed the caption of Report "Top Cust. Total Busi. Analysis"
    // PA032651   12.01.12 DR 5175462: Page remaned to "Vehicle Sales Assistant RC" to be sync to the Incadea Profile selector.
    //                        - Page Layout changed to show full captions in Menu Buttos in design mode.
    // PA032651   23.01.12 DR 6012646: Captions changed.
    //                        "Vehicle Status Change List" -> "Vehicle Status Changes"
    //                        "Vehicle Branch Order List" -> "Vehicle Branch Orders"
    //                        "Posted Vehicle Purch. Credit Memos" -> "Posted Vehicle Purchase Credit Memos"
    //                        "Arch. Branch Orders Vehicles" -> "Archived Vehicle Branch Orders"
    //                        "Service Posted Invoices" -> "Posted Service Invoices"
    //                        "Service Posted Credit Memos" -> "Posted Service Credit Memos"
    // PA032651   25.01.12 SS 4582443: Rolled back the caption changes from Defect5175462.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA032871   26.01.12 GL Action "Time Clock" added
    // PA033187   26.03.12 GL Merge of RET to Ongoing 611 objects
    // PA033328   19.06.12 KC Merge of RET to Ongoing 612 objects
    // PA033259   18.09.12 DR Variable names changed according to incadea style guide
    // PA033328   21.06.12 GL New Homepart: My Time Clock Status
    // PA033387   23.11.12 GB New Menu Item Added "incadea.BI Links"
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA034029   18.02.13 DD Added Homepart Location Info Frame
    // PA033895   16.04.13 GE Added new homepart for Special Functions
    // PA034389   06.08.13 AN New Menu Item Added "Lead Buffer Worksheet" (Actions)
    // PA034074   11.09.13 GM Added new homepart My Cockpit Vehicle Purchase
    // PA034402   23.09.13 GM New action 'To-Do' added
    //            09.10.13 LR I002032 Open the 'To-Do' in blank
    // PA034402   23.09.13 GM Added new Homepart 'My Open To-Dos'
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036090   07.07.14 GD 24092 Removed Action call reference to report 5025480-"Salesperson - Sales Statistics"
    // PA036090   07.07.14 GD 24094 Removed Action call reference to report 5025573-"Open Vehicle Sales Quotes"
    // PA035903   03.10.14 LR NAV 2013 UI Enhancement
    // PA035903   03.10.14 LR 29719 NAV 2013 UI Enhancement Hide Report "Top Cust. Total Busi. Analysis"
    // PA036547   07.11.14 MC Merge N.6.1.4 to N.7.1.0
    // PA036549   07.11.14 TS 28023 My Web Places moved from Home Items to Action Items.
    // PA036549   13.01.15 LR 32490 Delete reference to Contact Search because object has been deleted
    // PA036549   05.02.15 LR 33577 Create Address Search and hide Web Places in ribbon
    // PA036869   16.01.15 GE "Lead Buffer Worksheet" MenuItem removed from Actions
    // PA037758   06.04.15 GE Merge PA036869
    // PA037533   23.11.15 UX GUI Enhancements for a default Page viewing.
    // PA041960   12.01.17 GN Added new activities page hidden by default
    // PA042846   01.02.17 JM Added new Homepart "Not completed Trade-ins"
    // PA042814   31.01.17 SD Replaced "Address Search" with "Contact / Vehicle Search"
    // --- 7.2.0 ---
    // EU.0005464 18.09.17 JV Added Part "Role Center Picture" to display company logo on Role center
    // EU.0027972 04.06.18 DG Changed RefreshOnActivate property of the parent page to Yes and UpdatePropagation property of the subpage to Both
    // EU.0021021 21.06.18 LL Added "Service Planner" action, visible FALSE.
    //            19.09.18 LL Added "New Service Appointment" action, visible FALSE.
    // EU.0047698 10.12.18 KK Merge of Feature 21021
    // EU.0049875 03.01.19 GI Removed Change Location Page Part and added corresponding Action instead

    Caption = 'Dealer Manager RC';
    Description = 'PA032651,EU.0027972';
    PageType = RoleCenter;
    RefreshOnActivate = true;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control1100167006; "Account Manager Activities")
                {
                }
                part(Control1100167000; "Dealer Parts Activities")
                {
                }
                part(Control1100167001; "DPG DAF GDPR Activities")
                {
                }
                part(Control1100167005; "DPG DAF Case Activities")
                {
                }
                part(Control1100167004; "Service Advisor Activities")
                {
                }
                part(Control1100167002; "Dealer Warranty Activities")
                {
                }
                systempart(Control1901420308; Outlook)
                {
                    Visible = false;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control1000000006; "Role Center Picture")
                {
                    Caption = 'Role Center Picture';
                    Description = 'EU.0005464';
                }
                systempart(Control1901377608; MyNotes)
                {
                }
                part(Control1000000004; "My Special Functions HomePart")
                {
                }
                part(Control1000000003; "My Time Clock Status")
                {
                    Description = 'EU.0027972';
                    UpdatePropagation = Both;
                }
                part(Control1000000001; "My Open To-do's")
                {
                }
                part(Control1100167003; "My Open Opportunities")
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Action1109400000)
            {
                Caption = 'Inventory';
                separator(Action1119432070)
                {
                    Caption = 'Inventory';
                    IsHeader = true;
                }
                action(Action1119432023)
                {
                    Caption = '&Vehicle Inventory Valuation';
                    Image = "Report";
                    RunObject = Report "Vehicle Inventory Valuation";
                }
                action(Action1109400021)
                {
                    Caption = 'Vehicle &Wash Out';
                    Image = "Report";
                    RunObject = Report "Vehicle Wash Out";
                }
                action(Action1119432025)
                {
                    Caption = 'Days &Carried Analysis';
                    Image = "Report";
                    RunObject = Report "Days Carried Analysis";
                }
            }
            group(Action1109400022)
            {
                Caption = 'Sales';
                separator(Action1119432071)
                {
                    Caption = 'Sales';
                    IsHeader = true;
                }
                action(Action1119432032)
                {
                    Caption = 'Sales Invoice &Overview';
                    Image = "Report";
                    RunObject = Report "Sales Invoice Overview";
                }
                action(Action1119432035)
                {
                    Caption = 'Vehicle Sales / &Gross Profit';
                    Image = "Report";
                    RunObject = Report "Veh. Sales / Gross Profit";
                }
                action(Action1109400039)
                {
                    Caption = 'Analysis View List Sales';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "Analysis View List Sales";
                    Visible = false;
                }
            }
            group(Action1109400023)
            {
                Caption = 'Analysis';
                separator(Action1119432072)
                {
                    Caption = 'Analysis';
                    IsHeader = true;
                }
                action(Action1119432024)
                {
                    Caption = 'Vehicle &Analysis Overview';
                    Image = "Report";
                    RunObject = Report "Vehicle Analysis Overview";
                }
                action(Action1119432034)
                {
                    Caption = '&Top Cust. Total Busi. Analysis';
                    Image = "Report";
                    RunObject = Report "Top Cust. Total Busi. Analysis";
                    Visible = false;
                }
            }
            group(Action1109400024)
            {
                Caption = 'VAT';
                Visible = false;
                separator(Action1119432073)
                {
                    Caption = 'VAT';
                    IsHeader = true;
                }
                action(Action1119432048)
                {
                    Caption = 'Reconciliation of Diff. &Tax.';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Reconciliation of Diff. Tax";
                }
            }
            group(Action1109400027)
            {
                Caption = 'Contact';
                Description = 'PA037533';
                action(Action1109400028)
                {
                    Caption = 'Contact - Labels';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Contact - Labels";
                    Visible = false;
                }
                action(Action1109400037)
                {
                    Caption = 'Contact - List';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Contact - List";
                    Visible = false;
                }
                action(Action1109400038)
                {
                    Caption = 'Contact Person - List';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Contact Person - List";
                    Visible = false;
                }
            }
            group(Action1109400029)
            {
                Caption = 'Purchase';
                Description = 'PA037533';
                action(Action1109400030)
                {
                    Caption = 'Analysis View List Purchase';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "Analysis View List Purchase";
                    Visible = false;
                }
            }
            group(Action1109400031)
            {
                Caption = 'Vehicle';
                Description = 'PA037533';
                action(Action1109400033)
                {
                    Caption = 'New Vehicle';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "New Vehicles";
                    Visible = false;
                }
                action(Action1109400032)
                {
                    Caption = 'Used Vehicle';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Used Vehicles";
                    Visible = false;
                }
            }
            group(Action1109400034)
            {
                Caption = 'Analysis';
                Description = 'PA037533';
                action(Action1109400035)
                {
                    Caption = 'Model Sales Analysis View List';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "Model Sales Analysis View List";
                    Visible = false;
                }
                action(Action1109400036)
                {
                    Caption = 'Model Purch Analysis View List';
                    Description = 'PA037533';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "Model Purch Analysis View List";
                    Visible = false;
                }
            }
        }
        area(embedding)
        {
            action(Action1119432005)
            {
                Caption = 'Vehicles';
                Image = LinkWithExisting;
                RunObject = Page "Vehicle List";
            }
            action(Action1119432094)
            {
                Caption = 'Anticipated/Inventory Vehicles';
                Image = LinkWithExisting;
                RunObject = Page "Anticipated/Inventory Vehicles";
            }
            action(Action1119432004)
            {
                Caption = 'Vendors';
                Image = TeamSales;
                RunObject = Page "Vendor List";
            }
            action(Action1119432062)
            {
                Caption = 'Vehicle Purchase Orders';
                RunObject = Page "Vehicle Purch. Order List";
            }
            action(Action1119432065)
            {
                Caption = 'Vehicle Purchase Receipts';
                RunObject = Page "Vehicle Purch. Receipt List";
            }
            action(Action1119432063)
            {
                Caption = 'Vehicle Purchase Invoices';
                RunObject = Page "Vehicle Purch. Invoice List";
            }
            action(Action1119432064)
            {
                Caption = 'Vehicle Purchase Credit Memos';
                RunObject = Page "Vehicle Purch. Cr. Memo List";
            }
            action("Open Trade-Ins")
            {
                Caption = 'Open Trade-Ins';
                Description = 'PA042846';
                RunObject = Page "Open Trade-Ins";
            }
            action(Action1119432049)
            {
                Caption = 'Contacts';
                Image = ExportSalesPerson;
                RunObject = Page "Contact List";
            }
            action(Action1119432061)
            {
                Caption = 'Customers';
                Image = TeamSales;
                RunObject = Page "Customer List";
            }
            action(Action1119432066)
            {
                Caption = 'Vehicle Sales Quotes';
                RunObject = Page "Vehicle Sales Quote List";
            }
            action(Action1119432067)
            {
                Caption = 'Vehicle Sales Orders';
                RunObject = Page "Vehicle Sales Order List";
            }
            action(Action1119432068)
            {
                Caption = 'Vehicle Sales Invoices';
                RunObject = Page "Vehicle Sales Invoice List";
            }
            action(Action1119432069)
            {
                Caption = 'Vehicle Sales Credit Memos';
                RunObject = Page "Vehicle Sales Cr. Memos List";
            }
            action(Action1119432095)
            {
                Caption = 'Vehicle Status Changes';
                Description = 'PA032651';
                RunObject = Page "Vehicle Status Change List";
            }
            action(Action1119432096)
            {
                Caption = 'Vehicle Branch Orders';
                Description = 'PA032651';
                RunObject = Page "Branch Order Vehicle List";
            }
        }
        area(sections)
        {
            group(Action1119432008)
            {
                Caption = 'Purchase History';
                Image = FiledPosted;
                action(Action1119432009)
                {
                    Caption = 'Posted Vehicle Purchase Receipts';
                    RunObject = Page "Posted Veh. Purchase Receipts";
                }
                action(Action1119432010)
                {
                    Caption = 'Posted Vehicle Purchase Invoices';
                    RunObject = Page "Posted Veh. Purchase Invoices";
                }
                action(Action1119432011)
                {
                    Caption = 'Posted Vehicle Return Shipments';
                    RunObject = Page "Posted Veh. Return Shipments";
                }
                action(Action1119432012)
                {
                    Caption = 'Posted Vehicle Purchase Credit Memos';
                    Description = 'PA032651';
                    RunObject = Page "Posted Veh. Purch. Cr. Memos";
                }
                action(Action1119432097)
                {
                    Caption = 'Posted Vehicle Status Changes';
                    RunObject = Page "Posted Veh. Status Change List";
                }
                action(Action1119432098)
                {
                    Caption = 'Archived Vehicle Branch Orders';
                    Description = 'PA032651';
                    RunObject = Page "Arch Branch Order Vehicle List";
                }
            }
            group(Action1119432054)
            {
                Caption = 'Sales History';
                Image = Sales;
                action(Action1119432055)
                {
                    Caption = 'Posted Vehicle Sales Shipments';
                    RunObject = Page "Posted Veh. Sales Shipments";
                }
                action(Action1119432056)
                {
                    Caption = 'Posted Vehicle Sales Invoices';
                    RunObject = Page "Posted Veh. Sales Invoices";
                }
                action(Action1119432057)
                {
                    Caption = 'Posted Vehicle Sales Return Receipts';
                    RunObject = Page "Posted Veh. Return Receipts";
                }
                action(Action1119432058)
                {
                    Caption = 'Posted Vehicle Sales Credit Memos';
                    RunObject = Page "Posted Veh. Sales Credit Memos";
                }
            }
            group(Action1119432001)
            {
                Caption = 'Service';
                Image = HumanResources;
                action(Action1119432015)
                {
                    Caption = 'Service Orders';
                    Image = Document;
                    RunObject = Page "Service Order List";
                    Visible = false;
                }
                action(Action1119432078)
                {
                    Caption = 'Archived Service Orders';
                    RunObject = Page "Archived Service Orders List";
                }
                action(Action1119432079)
                {
                    Caption = 'Posted Service Invoices';
                    Description = 'PA032651';
                    RunObject = Page "Posted Service Sales Invoices";
                }
                action(Action1119432080)
                {
                    Caption = 'Posted Service Credit Memos';
                    Description = 'PA032651';
                    RunObject = Page "Posted Service Sales Cr.Memos";
                }
            }
            group(Action1119432006)
            {
                Caption = 'Vehicle Management';
                Image = ReferenceData;
                action(Action1119432050)
                {
                    Caption = 'Models';
                    Image = Splitlines;
                    RunObject = Page "Model List";
                }
                action(Action1119432051)
                {
                    Caption = 'Manufacturer Options';
                    Image = ProdBOMMatrixPerVersion;
                    RunObject = Page "Manufacturer Option List";
                }
                action(Action1119432052)
                {
                    Caption = 'Own Options';
                    Image = Delegate;
                    RunObject = Page "Own Options List";
                }
                action(Action1119432053)
                {
                    Caption = 'Transfer Fees';
                    RunObject = Page "Transfer Fees List";
                }
                action(Action1119432081)
                {
                    Caption = 'Calculated Costs Setup';
                    RunObject = Page "Calculated Costs Setup";
                }
                action(Action1119432082)
                {
                    Caption = 'Vehicle Sales Incentives';
                    RunObject = Page "Sales Incentives List";
                }
                action(Action1119432083)
                {
                    Caption = 'Salespeople';
                    Image = ExportSalesPerson;
                    RunObject = Page "Salespeople/Purchasers";
                }
                action(Action1119432092)
                {
                    Caption = 'Teams';
                    Image = TeamSales;
                    RunObject = Page Teams;
                }
            }
            group(BIButton)
            {
                Caption = 'incadea.bi';
                Image = Dimensions;
                Visible = false;
                action(Action1101329809)
                {
                    Caption = 'incadea.bi Links';
                    RunObject = Page "BI Main URL Page List";
                }
            }
        }
        area(processing)
        {
            group(Action1109400020)
            {
                Caption = 'Customer';
                action(Action1109400002)
                {
                    Caption = 'Contact / Vehicle Search';
                    Description = 'PA042814';
                    Image = Find;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Contact/Vehicle Search";
                }
                action(Action1119432027)
                {
                    Caption = '&Vehicle';
                    Image = LinkWithExisting;
                    RunObject = Page "Vehicle Card";
                    RunPageMode = Create;
                    Visible = false;
                }
                action(Action1119432037)
                {
                    Caption = '&Model';
                    Image = Splitlines;
                    RunObject = Page "Veh. Model Card";
                    RunPageMode = Create;
                    Visible = false;
                }
                action(Action1119432017)
                {
                    Caption = 'C&ontact';
                    Image = ExportSalesPerson;
                    RunObject = Page "Contact Card";
                    RunPageMode = Create;
                }
                action(Action1119432028)
                {
                    Caption = '&Customer';
                    Image = TeamSales;
                    RunObject = Page "Customer Card";
                    RunPageMode = Create;
                }
            }
            group(Action1109400003)
            {
                Caption = 'Purchase';
                action(Action1109400008)
                {
                    Caption = 'Vehicle Purchase &Order';
                    Image = Document;
                    RunObject = Page "Vehicle Purchase Order";
                    RunPageMode = Create;
                }
                action(Action1109400007)
                {
                    Caption = 'Vehicle Purchase &Receipt';
                    Image = NewWarehouseReceipt;
                    RunObject = Page "Vehicle Purchase Receipt";
                    RunPageMode = Create;
                }
                action(Action1109400006)
                {
                    Caption = 'Vehicle Purchase &Invoice';
                    Image = Invoice;
                    RunObject = Page "Vehicle Purchase Invoice";
                    RunPageMode = Create;
                }
                action(Action1109400005)
                {
                    Caption = 'Vehicle Purchase &Return Order';
                    Image = ReturnOrder;
                    RunObject = Page "Vehicle Purchase Return Order";
                    RunPageMode = Create;
                    Visible = false;
                }
            }
            group(Action1109400009)
            {
                Caption = 'Sale';
                action(Action1109400014)
                {
                    Caption = 'Vehicle Sales &Quote';
                    Image = Document;
                    RunObject = Page "Vehicle Sales Quote";
                    RunPageMode = Create;
                }
                action(Action1109400013)
                {
                    Caption = 'Vehicle &Sales Order';
                    Image = Document;
                    RunObject = Page "Vehicle Sales Order";
                    RunPageMode = Create;
                }
                action(Action1109400012)
                {
                    Caption = 'Vehicle Sales In&voice';
                    Image = Invoice;
                    RunObject = Page "Vehicle Sales Invoice";
                    RunPageMode = Create;
                }
                action(Action1109400011)
                {
                    Caption = 'Vehicle Sales Ret&urn Order';
                    Image = ReturnOrder;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Vehicle Sales Return Order";
                    RunPageMode = Create;
                    Visible = false;
                }
            }
            group(Action1109400015)
            {
                Caption = 'Credit Memo';
                action(Action1109400016)
                {
                    Caption = 'Vehicle Purchase &Credit Memo';
                    Image = CreditMemo;
                    RunObject = Page "Vehicle Purchase Credit Memo";
                    RunPageMode = Create;
                }
                action(Action1109400004)
                {
                    Caption = 'Vehicle Sales Cre&dit Memo';
                    Image = CreditMemo;
                    RunObject = Page "Vehicle Sales Credit Memo";
                    RunPageMode = Create;
                }
            }
            group(Action1109400010)
            {
                Caption = 'Vehicle';
                action(Action1109400019)
                {
                    Caption = 'Vehicle &Journals';
                    Image = Journals;
                    RunObject = Page "Vehicle Journal";
                    RunPageMode = Create;
                    Visible = false;
                }
                action(Action1109400018)
                {
                    Caption = 'Vehicle Status &Change';
                    Image = ChangeStatus;
                    RunObject = Page "Branch Order Veh. Stat. Change";
                    RunPageMode = Create;
                }
                action(Action1109400017)
                {
                    Caption = '&Branch Order Vehicle';
                    Image = SwitchCompanies;
                    RunObject = Page "Branch Order Vehicle";
                    RunPageMode = Create;
                }
            }
            group(Action1119432088)
            {
                Caption = '&Quick Creation';
                Visible = false;
                action(Action1119432089)
                {
                    Caption = 'Quick &Contact';
                    Image = AddAction;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Quick Contact Card";
                    RunPageMode = Create;
                }
                action(Action1119432091)
                {
                    Caption = 'Quick &Vehicle';
                    Image = AddAction;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Quick Vehicle Card";
                    RunPageMode = Create;
                }
                action(Action1119432090)
                {
                    Caption = '&Quick Customer';
                    Image = AddAction;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Quick Customer Card";
                    RunPageMode = Create;
                }
            }
            action(Action1101140604)
            {
                Caption = 'To-Do';
                Image = TaskList;
                RunObject = Page "To-do List";
                Visible = false;
            }
            action(Action1119432085)
            {
                Caption = '&Anticipated/Inventory Vehicles';
                Image = LinkWithExisting;
                RunObject = Page "Anticipated/Inventory Vehicles";
                Visible = false;
            }
            action(Action1119432087)
            {
                Caption = 'Vehicle &Registers';
                Image = RegisteredDocs;
                RunObject = Page "Vehicle Registers";
                Visible = false;
            }
            action(Action1119432030)
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
            action(Action1109400001)
            {
                Caption = 'Time Clock';
                Description = 'PA032871';
                Image = History;
                RunObject = Page "Administrative Time Clock";
                Visible = false;
            }
            separator(Action1109400026)
            {
            }
            action(Action1109400025)
            {
                Caption = 'My Web Pl@ces';
                Description = 'PA036549.33557';
                Image = LinkWeb;
                RunObject = Page "My Web Places";
                Visible = false;
            }
            /*
            group(Action2102100)
            {
                Caption = 'Scheduling';
                Description = 'EU.0021021';
                Visible = false;
                action(Action2102102)
                {
                    Caption = 'Service Planner';
                    Description = 'EU.0021021';
                    Image = ServiceLedger;
                    RunObject = Codeunit "Start Service Planner";
                    Visible = false;
                }
                action(Action2102101)
                {
                    Caption = 'New Service Appointment';
                    Description = 'EU.0021021';
                    Image = NewOrder;
                    RunObject = Codeunit "WebApp New Service Appointment";
                    Visible = false;
                }
            }
            */
            group(Action3182301)
            {
                Caption = 'Location';
                action("Change Location")
                {
                    Caption = 'Change location';
                    Description = 'EU.0049875';
                    Image = Change;
                    RunObject = Codeunit "Re-Login User to New Location";
                }
            }
        }
    }
}


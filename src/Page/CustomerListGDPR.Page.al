page 80010 "DPG Customer List GDPR"
{
    // --- API Customization ---
    // 79027073    27.08.20 RK DAFCZ.1 new object

    Caption = 'Customer List';
    CardPageID = "Customer Card";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Customer;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                FreezeColumn = Name;
                ShowCaption = false;
                field("No."; "No.")
                {
                }
                field("Registered Name"; "Registered Name")
                {
                    ToolTip = 'Specifies the registered name of company.';
                    Visible = false;
                }
                field(Name; Name)
                {
                }
                field(Address; Address)
                {
                }
                field(City; City)
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Salesperson Parts"; "CVM Salesperson Parts")
                {
                }
                field("Salesperson Trucks"; "CVM Salesperson Trucks")
                {
                }
                field("Salesperson Service"; "CVM Salesperson Service")
                {
                }
                field("Salesperson Vans"; "CVM Salesperson Vans")
                {
                    Caption = 'Salesperson Contracts';
                }
                field("Service Advisor No."; "Service Advisor No.")
                {
                }
                field(Contact; Contact)
                {
                }
                field("Name 2"; "Name 2")
                {
                    Visible = false;
                }
                field("Post Code"; "Post Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Fax No."; "Fax No.")
                {
                    Visible = false;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                    Visible = false;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Reminder Terms Code"; "Reminder Terms Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Fin. Charge Terms Code"; "Fin. Charge Terms Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Language Code"; "Language Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
                    Visible = false;
                }
                field("Title Code"; "Title Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Last Name"; "Last Name")
                {
                    Visible = false;
                }
                field("First Name"; "First Name")
                {
                    Visible = false;
                }
                field("Address 2"; "Address 2")
                {
                    Visible = false;
                }
                field("Address Salutation Code"; "Address Salutation Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Customer Type"; "Customer Type")
                {
                    Visible = false;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Visible = false;
                }
                field(Blocked; Blocked)
                {
                    Visible = false;
                }
                field("Sales (LCY)"; "Sales (LCY)")
                {
                    Visible = false;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    Visible = false;
                }
                field("Credit Limit (LCY)"; "Credit Limit (LCY)")
                {
                }
                field("Date 1"; "Date 1")
                {
                    Visible = false;
                }
                field("Date 2"; "Date 2")
                {
                    Visible = false;
                }
                field("Extra Code 1"; "Extra Code 1")
                {
                    Visible = false;
                }
                field("Extra Code 2"; "Extra Code 2")
                {
                    Visible = false;
                }
                field("Extra Code 3"; "Extra Code 3")
                {
                    Visible = false;
                }
                field("Text 1"; "Text 1")
                {
                    Visible = false;
                }
                field("Text 2"; "Text 2")
                {
                    Visible = false;
                }
                field("Text 3"; "Text 3")
                {
                    Visible = false;
                }
                field("Text 4"; "Text 4")
                {
                    Visible = false;
                }
                field("Text 5"; "Text 5")
                {
                    Visible = false;
                }
                field("Text 6"; "Text 6")
                {
                    Visible = false;
                }
                field("Home Page"; "Home Page")
                {
                    Visible = false;
                }
                field("Letter Salutation Code"; "Letter Salutation Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Home Fax No."; "Home Fax No.")
                {
                    Visible = false;
                }
                field("Home Phone No."; "Home Phone No.")
                {
                    Visible = false;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Home Page 2"; "Home Page 2")
                {
                    Visible = false;
                }
                field("Home E-Mail"; "Home E-Mail")
                {
                    Visible = false;
                }
                field("Home Mobile Phone No."; "Home Mobile Phone No.")
                {
                    Visible = false;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Bulk Customer No."; "Bulk Customer No.")
                {
                    Visible = false;
                }
                field("Combine Shipments"; "Combine Shipments")
                {
                    Visible = false;
                }
                field("Labor Price Group"; "Labor Price Group")
                {
                    Visible = false;
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    Visible = false;
                }
                field("Registration No."; "Registration No.")
                {
                }
                field("Tax Registration No."; "Tax Registration No.")
                {
                }
                field("Application Method"; "Application Method")
                {
                    Visible = false;
                }
                field("Last Statement No."; "Last Statement No.")
                {
                    Visible = false;
                }
                field("Print Statements"; "Print Statements")
                {
                    Visible = false;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    AutoFormatExpression = 'JMD';
                    Visible = false;
                }
                field("Ext. Service Price Group"; "Ext. Service Price Group")
                {
                    Visible = false;
                }
                field("Item Sales Price Group"; "Item Sales Price Group")
                {
                    Visible = false;
                }
                field("Disable Remarks"; "Disable Remarks")
                {
                    Visible = false;
                }
                field("Invoice Copies"; "Invoice Copies")
                {
                    Visible = false;
                }
                field(Reserve; Reserve)
                {
                    Visible = false;
                }
                field("Branch Posting Group"; "Branch Posting Group")
                {
                    Visible = false;
                }
                field("Messaging App ID"; "Messaging App ID")
                {
                    Description = 'PA038224';
                    Editable = false;
                    Visible = false;
                }
                field("Message Notification"; "Message Notification")
                {
                    Description = 'PA032455,PA038224,PA038224.47253';
                    Editable = false;
                    Visible = false;
                }
                field("Action Discount"; "CVM Action Discount")
                {
                    Description = 'HIT00098.1';
                }
                field("Address Source"; "Address Source")
                {
                    Importance = Additional;
                }
                field("Updated by User ID"; "Updated by User ID")
                {
                    Description = 'EU.0054211';
                }
            }
            part(Control1119462091; "Vehicle List Subform")
            {
                SubPageLink = "Customer No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(SpecialFunctionFactBox; "Special Function FactBox")
            {
                Caption = 'Special &Functions';
                Description = 'PA038456,PA039776,PA042019.80035';
                SubPageLink = "Source Table ID" = CONST(18), "Source Page" = CONST(22), "Code 1" = FIELD("No.");
                SubPageView = WHERE("Source Page" = CONST(22));
                Visible = false;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                Description = 'PA035597';
                SubPageLink = "No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Global Dimension 1 Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Global Dimension 2 Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter")), "Ship-to Filter" = FIELD(FILTER("Ship-to Filter")), "Item Filter" = FIELD(FILTER("Item Filter")), "Location Filter" = FIELD(FILTER("Location Filter")), "Bin Filter" = FIELD(FILTER("Bin Filter"));
            }
            part(Control1903223507; "Customer Stat. Sell-to FactBox")
            {
                Description = 'PA035597';
                SubPageLink = "No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Global Dimension 1 Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Global Dimension 2 Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter")), "Ship-to Filter" = FIELD(FILTER("Ship-to Filter")), "Item Filter" = FIELD(FILTER("Item Filter")), "Location Filter" = FIELD(FILTER("Location Filter")), "Bin Filter" = FIELD(FILTER("Bin Filter"));
            }
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                Description = 'PA035597';
                SubPageLink = "No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Global Dimension 1 Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Global Dimension 2 Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter")), "Ship-to Filter" = FIELD(FILTER("Ship-to Filter")), "Item Filter" = FIELD(FILTER("Item Filter")), "Location Filter" = FIELD(FILTER("Location Filter")), "Bin Filter" = FIELD(FILTER("Bin Filter"));
            }
            part(Control1903468107; "RTC Standard Map View")
            {
                SubPageLink = "Address No." = FIELD("Address No.");
                Visible = false;
            }
            part(Control1902018507; "Customer Stat. Bill-to FactBox")
            {
                Description = 'PA035597';
                SubPageLink = "No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Global Dimension 1 Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Global Dimension 2 Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter")), "Ship-to Filter" = FIELD(FILTER("Ship-to Filter")), "Item Filter" = FIELD(FILTER("Item Filter")), "Location Filter" = FIELD(FILTER("Location Filter")), "Bin Filter" = FIELD(FILTER("Bin Filter"));
                Visible = false;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                Description = 'PA035597';
                SubPageLink = "No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Global Dimension 1 Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Global Dimension 2 Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter")), "Ship-to Filter" = FIELD(FILTER("Ship-to Filter")), "Item Filter" = FIELD(FILTER("Item Filter")), "Location Filter" = FIELD(FILTER("Location Filter")), "Bin Filter" = FIELD(FILTER("Bin Filter"));
                Visible = false;
            }
            part(Control1904237407; "Internat. Data Privacy FactBox")
            {
                SubPageLink = "Customer No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Department Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Make Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter"));
                Visible = false;
            }
            part(Control1901312607; "Customer Prepmt Stat. FactBox")
            {
                Description = 'PA035597';
                SubPageLink = "No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Global Dimension 1 Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Global Dimension 2 Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter")), "Ship-to Filter" = FIELD(FILTER("Ship-to Filter")), "Item Filter" = FIELD(FILTER("Item Filter")), "Location Filter" = FIELD(FILTER("Location Filter")), "Bin Filter" = FIELD(FILTER("Bin Filter"));
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Description = 'PA042019.80035';
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Položky")
            {
                Caption = 'Entries';
                action("Po&ložky")
                {
                    Caption = 'Ledger E&ntries';
                    Description = 'Defect8582610';
                    Image = MaintenanceLedgerEntries;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Posting Date", "Currency Code");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group(Dokumenty)
            {
                Caption = 'Documents';
                action("&Použití")
                {
                    Caption = '&Where-Used';
                    Description = 'PA036542';
                    Image = "Where-Used";

                    trigger OnAction()
                    var
                        TrackDocsL: Page "Where-Used";
                    begin
                        // Start PA036542.31843
                        TrackDocsL.SetName(Name);
                        // Stop PA036542.31843
                        TrackDocsL.SetCustomer(Rec);
                        TrackDocsL.RUN;
                        CLEAR(TrackDocsL);
                    end;
                }
                action("Vydané &upomínky")
                {
                    Caption = 'Issued &Reminders';
                    Image = Reminder;
                    RunObject = Page "Issued Reminder";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Posting Date");
                }
                action("Vydaná &penále")
                {
                    Caption = 'Issued &Finance Charge Memos';
                    Image = FinChargeMemo;
                    RunObject = Page "Issued Finance Charge Memo";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Posting Date");
                }
            }
            group("Zá&kazník")
            {
                Caption = '&Customer';
                Visible = false;
                action("Pozná&mky")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
                }
                group(Dimenze)
                {
                    Caption = 'Dimensions';
                    Description = 'PA035597';
                    Image = Dimensions;
                    action("Dimenze-jedna")
                    {
                        Caption = 'Dimensions-Single';
                        Description = 'PA035597';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(18), "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimenze-&více")
                    {
                        Caption = 'Dimensions-&Multiple';
                        Description = 'PA035597';
                        Image = DimensionSets;

                        trigger OnAction()
                        var
                            Cust: Record Customer;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Cust);
                            DefaultDimMultiple.SetMultiCust(Cust);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Výrobce Vztahy")
                {
                    Caption = 'Manufacturer Relations';
                    Image = AddToHome;
                    RunObject = Page "Addresses/Manuf. Relations";
                    RunPageLink = "Address No." = FIELD("Address No.");
                }
                separator(Action1220001)
                {
                }
                action("Země/oblasti registrace")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&gistration Country';
                    Image = CountryRegion;
                    RunObject = Page "Registration Country/Region";
                    RunPageLink = Type = CONST(Customer), "No." = FIELD("No.");
                    ToolTip = 'Opens registration country page';
                }
                separator(Action59)
                {
                }
                action("St&atistika")
                {
                    Caption = '&Statistics';
                    Image = Statistics;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("Statistika dle &měn")
                {
                    Caption = 'Statistics by C&urrencies';
                    Image = Statistics;
                    RunObject = Page "Customer Stats. by Currencies";
                    RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Date Filter" = FIELD("Date Filter");
                }
                action("S&tatistika položek")
                {
                    Caption = 'Entr&y Statistics';
                    Image = Statistics;
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                separator(Action64)
                {
                }
                action("&Připomínky")
                {
                    Caption = '&Remarks';
                    Image = Alerts;
                    RunObject = Page "Vehicle Addtl Texts";
                    RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
                }
                separator(Action1109400000)
                {
                }
                action(DPQuery)
                {
                    Caption = 'Data Privacy &Query';
                    Enabled = EnableDataPrivacyG;
                    Image = CarryOutActionMessage;

                    trigger OnAction()
                    begin
                        // Start PA036373
                        DataPrivManagementG.ShowAvailableDataPrivList(
                          DataPrivSetupG."Check Modus"::CheckQuery,
                          FALSE,
                          DATABASE::Customer,
                          "No.",
                          FALSE);
                        // Stop PA036373
                    end;
                }
                action(DPQueryLog)
                {
                    Caption = 'Data Privac&y Log File';
                    Enabled = EnableDataPrivacyG;
                    Image = Track;

                    trigger OnAction()
                    begin
                        // Start PA036373
                        DataPrivManagementG.ShowAvailableDataPrivList(
                          DataPrivSetupG."Check Modus"::CheckLog,
                          FALSE,
                          DATABASE::Customer,
                          "No.",
                          FALSE);
                        // Stop PA036373
                    end;
                }
                action("Preferované způsoby komunikace")
                {
                    Caption = 'Preferred Ways of Contact';
                    Description = 'PA033305';

                    trigger OnAction()
                    var
                        PrefWayOfContactL: Record "Data Priv. Pref. Way of Cont.";
                    begin
                        // Start PA033305
                        PrefWayOfContactL.DrilldownPrefWayOfContact(GetContact("No."), "No.");
                        CurrPage.UPDATE(FALSE);
                        // Stop PA033305
                    end;
                }
            }
            group("&Prodej")
            {
                Caption = 'S&ales';
                Visible = false;
                action("Fa&kturační slevy")
                {
                    Caption = 'Invoice &Discounts';
                    Image = ActivateDiscounts;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    Visible = false;
                }
                action("Nabídky")
                {
                    Caption = '&Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quote";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.", "No.");
                    Visible = false;
                }
                action("&Hromadné objednávky")
                {
                    Caption = '&Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Sales Order";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.", "No.");
                    Visible = false;
                }
                action("Objednávky")
                {
                    Caption = '&Orders';
                    Image = Document;
                    RunObject = Page "Sales Order";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.", "No.");
                    Visible = false;
                }
                separator(Action85)
                {
                }
                action("Historie zboží")
                {
                    Caption = '&Parts Legacy History';
                    Description = 'PA041681';
                    Image = History;
                    RunObject = Page "DataMig Parts Legacy Doc. List";
                    RunPageLink = "Sell-to/Buy-from No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to/Buy-from No.", VIN, "Order No.", "Document No.") WHERE("Main Area" = FILTER("Parts Sales"));
                }
                action("Historie vozidla")
                {
                    Caption = '&Vehicle Legacy History';
                    Description = 'PA041681';
                    Image = History;
                    RunObject = Page "DataMig Veh. Legacy Doc. List";
                    RunPageLink = "Sell-to/Buy-from No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to/Buy-from No.", VIN, "Order No.", "Document No.") WHERE("Main Area" = CONST("Vehicle Sales"));
                }
                action("Servisní historie")
                {
                    Caption = '&Service Legacy History';
                    Description = 'PA041681';
                    Image = History;
                    RunObject = Page "DataMig Serv. Legacy Doc. List";
                    RunPageLink = "Sell-to/Buy-from No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to/Buy-from No.", VIN, "Order No.", "Document No.") WHERE("Main Area" = CONST("Service Sales"));
                }
            }
            action("&Kontakt")
            {
                Caption = 'C&ontact';
                Description = 'INC';
                Image = ExportSalesPerson;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Contact List";
                RunPageLink = "Address No." = FIELD("Address No."), "Customer No." = FIELD("No.");
                RunPageView = SORTING("Address No.");
            }
            group(Vozidla)
            {
                Caption = 'Vehicles';
                action("Vo&zidla")
                {
                    Caption = 'Ve&hicles';
                    Image = LinkWithExisting;
                    RunObject = Page "Vehicle List";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("Zájem o model/vozidlo")
                {
                    Caption = 'Model/Vehicles of Interest';
                    Image = ResourceLedger;

                    trigger OnAction()
                    var
                        ModelVehofInterestL: Record "Model/Vehicle of Interest";
                    begin
                        // Start PA036869
                        ModelVehofInterestL.RESET;
                        ModelVehofInterestL.SETCURRENTKEY("Address No.");
                        ModelVehofInterestL.FILTERGROUP(2);
                        ModelVehofInterestL.SETRANGE("Address No.", "Address No.");
                        ModelVehofInterestL.FILTERGROUP(0);
                        PAGE.RUN(0, ModelVehofInterestL);
                        // Stop PA036869
                    end;
                }
            }
            action(Action1109400021)
            {
                Caption = 'S&ales';
                Image = Statistics;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Customer Sales";
                RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
        }
        area(processing)
        {
            group("Nový doklad")
            {
                Caption = 'New Document';
                Visible = false;
                action("Rychlý zákazník")
                {
                    Caption = 'Quick Customer';
                    Description = 'PA032651';
                    Image = AddAction;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Quick Customer Card";
                    RunPageMode = Create;
                    Visible = false;
                }
                action("Rychlá poptávka zboží")
                {
                    Caption = 'Quick Item Inquiry';
                    Description = 'PA032651';
                    Image = AddAction;
                    Promoted = true;
                    RunObject = Page "Quick Item Inquiry";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageMode = Create;
                    Visible = false;
                }
                action("Rychlé vozidlo")
                {
                    Caption = 'Quick Vehicle';
                    Description = 'PA032651';
                    Image = AddAction;
                    Promoted = true;
                    RunObject = Page "Quick Vehicle Card";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageMode = Create;
                    Visible = false;
                }
                action("Prodejní faktura vozidla")
                {
                    Caption = 'Vehicle Sales Invoice';
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        VehicleCollectionUnitG.CreateVehicleSalesDocument(DocumentTypeG::Invoice, "No.", FALSE);
                        // Stop PA032473
                    end;
                }
                action("Prodejní vratka objednávky vozidla")
                {
                    Caption = 'Vehicle Sales Return Order';
                    Image = ReturnOrder;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        VehicleCollectionUnitG.CreateVehicleSalesDocument(DocumentTypeG::"Return Order", "No.", FALSE);
                        // Stop PA032473
                    end;
                }
                action("Prodejní dobropis vozidla")
                {
                    Caption = 'Vehicle Sales Credit Memo';
                    Image = CreditMemo;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        VehicleCollectionUnitG.CreateVehicleSalesDocument(DocumentTypeG::"Credit Memo", "No.", FALSE);
                        // Stop PA032473
                    end;
                }
                action("Servisní dobropis")
                {
                    Caption = 'Service Credit Memo';
                    Image = CreditMemo;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        ServMgmtG.CreateServiceCreditMemoDoc(DocumentTypeG::"Credit Memo", "No.");
                        // Stop PA032473
                    end;
                }
                action("Prodejní faktura zboží")
                {
                    Caption = 'Parts Sales Invoice';
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        // Start PA041187.88726
                        CreatePartsSalesDocument(DocumentTypeG::Invoice, "No.", '');
                        // Stop PA041187.88726
                        // Stop PA032473
                    end;
                }
                action("Objednávka prodejní vratky zboží")
                {
                    Caption = 'Parts Sales Return Order';
                    Image = ReturnOrder;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        // Start PA041187.88726
                        CreatePartsSalesDocument(DocumentTypeG::"Return Order", "No.", '');
                        // Start PA041187.88726
                        // Stop PA032473
                    end;
                }
                action("Prodejní dobropis zboží")
                {
                    Caption = 'Parts Sales Credit Memo';
                    Image = CreditMemo;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        // Start PA041187.88726
                        CreatePartsSalesDocument(DocumentTypeG::"Credit Memo", "No.", '');
                        // Start PA041187.88726
                        // Stop PA032473
                    end;
                }
            }
            group("F&unkce")
            {
                Caption = 'F&unctions';
                action("&Speciální funkce")
                {
                    Caption = 'Special &Functions';
                    Description = 'PA038218.44712';
                    Image = ImportExport;

                    trigger OnAction()
                    begin
                        // Start PA036705
                        SpecialFunctionsCall();
                        // Stop PA036705
                    end;
                }
                action("Pokladny zákazníka")
                {
                    Caption = 'Cash Register Customer';
                    Description = 'PA034252.I000071';
                    Image = CashReceiptJournal;

                    trigger OnAction()
                    begin
                        // Start PA034252.I000071
                        CashRegisterFunctionsG.CreateCustVendCashRegister("No.", TRUE);
                        // Stop PA034252.I000071
                    end;
                }
                action("Contact / Vehicle Search")
                {
                    Caption = 'Contact / Vehicle Search';
                    Description = 'PA042814';
                    Image = Find;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ContactVehicleSearchBufferRecL: Record "Contact/Vehicle Search Buffer";
                        ContactVehicleSearchPageL: Page "Contact/Vehicle Search";
                    begin
                        // Start PA041187.90270
                        ContactVehicleSearchPageL.LOOKUPMODE(TRUE);
                        IF ContactVehicleSearchPageL.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            ContactVehicleSearchPageL.GETRECORD(ContactVehicleSearchBufferRecL);
                            IF (ContactVehicleSearchBufferRecL."Customer No." <> '') AND (ContactVehicleSearchBufferRecL.Company = COMPANYNAME) THEN
                                SETFILTER("No.", ContactVehicleSearchBufferRecL."Customer No.");
                        END;
                        // Stop PA041187.90270
                    end;
                }
                action("Vehicle Locator")
                {
                    Caption = 'Vehicle Locator';
                    Description = 'PA038126.50429,PA042814';
                    Image = FindCreditMemo;
                    ShortCutKey = 'Ctrl+Q';

                    trigger OnAction()
                    begin
                        // Start PA038126.50429
                        AddressLnkG.RESET;
                        AddressLnkG.SETRANGE(AddressLnkG."Address No.", Rec."Address No.");
                        AddressLnkG.SETRANGE(AddressLnkG.Type, AddressLnkG.Type::Contact);
                        IF AddressLnkG.FINDFIRST THEN
                            ContactG.GET(AddressLnkG."No.");
                        CLEAR(VehicleSearchG);
                        VehicleSearchG.SetCutomerContactInfo("No.", ContactG."No.");
                        VehicleSearchG.RUNMODAL;
                        // Stop PA038126.50429
                    end;
                }
            }
            action("Pokladní doklady zkazníka")
            {
                Caption = 'Customer Cash Registers';
                Image = CashReceiptJournal;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Customer Cash Registers";
                RunPageLink = "Source No." = FIELD("No.");
            }
            group("&Zboží")
            {
                Caption = '&Parts';
                action("Prodejní nabídka zboží")
                {
                    Caption = 'Parts Sales Quote';
                    Image = Quote;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        // Start PA041187.88726
                        CreatePartsSalesDocument(DocumentTypeG::Quote, "No.", '');
                        // Start PA041187.88726
                        // Stop PA032473
                    end;
                }
                action("Prodejní objednávka zboží")
                {
                    Caption = 'Parts Sales Order';
                    Image = Document;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        // Start PA041187.88726
                        CreatePartsSalesDocument(DocumentTypeG::Order, "No.", '');
                        // Start PA041187.88726
                        // Stop PA032473
                    end;
                }
            }
            group(Action1109400010)
            {
                Caption = 'Vehicles';
                action("Prodejní &nabídka vozidla")
                {
                    Caption = '&Vehicle Sales Quote';
                    Image = Document;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        VehicleCollectionUnitG.CreateVehicleSalesDocument(DocumentTypeG::Quote, "No.", FALSE);
                        // Stop PA032473
                    end;
                }
                action("Prodejní objednávka vozidla")
                {
                    Caption = 'Vehicle Sales Order';
                    Image = Document;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        VehicleCollectionUnitG.CreateVehicleSalesDocument(DocumentTypeG::Order, "No.", FALSE);
                        // Stop PA032473
                    end;
                }
            }
            group(Servis)
            {
                Caption = 'Service';
                action("Servsiní &nabídka")
                {
                    Caption = 'Service &Quote';
                    Image = Quote;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        ServMgmtG.CreateServDocfromCustInterface(ServiceDocTypeG::Quote, "No.", FALSE);
                        // Stop PA032473
                    end;
                }
                action("&Předobjednávka")
                {
                    Caption = '&Scheduling Order';
                    Image = WorkCenterLoad;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        ServMgmtG.CreateServDocfromCustInterface(ServiceDocTypeG::Scheduling, "No.", FALSE);
                        // Stop PA032473
                    end;
                }
                action("Servisní objednávka")
                {
                    Caption = 'Service &Order';
                    Image = Document;
                    RunPageMode = Create;

                    trigger OnAction()
                    begin
                        // Start PA032473
                        ServMgmtG.CreateServDocfromCustInterface(ServiceDocTypeG::Order, "No.", FALSE);
                        // Stop PA032473
                    end;
                }
            }
            group("Zákazník")
            {
                Caption = 'Customer';
                action("&Bankovní konta")
                {
                    Caption = '&Bank Accounts';
                    Image = NewBank;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("Adresa příjemce")
                {
                    Caption = 'Ship-&to Addresses';
                    Description = 'EU.0000048';
                    Image = AddToHome;
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
            }
        }
        area(reporting)
        {
            action("Stav účtu")
            {
                Caption = 'Statement';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report Statement;
            }
            group("Analýzy")
            {
                Caption = 'Analysis';
                action("Zákazník prodejní analýza")
                {
                    Caption = 'Customer Business Analysis';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Top Cust. Total Busi. Analysis";
                }
                action("Detailní zkušební bilance zákazníka")
                {
                    Caption = 'Customer Detail Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Detail Trial Bal.";
                }
            }
            group(Splatnost)
            {
                Caption = 'Aging';
                action("Zákazník splatné saldo")
                {
                    Caption = 'Customer Summary Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Summary Aging";
                }
                action("Zákazník - detailní splatnost")
                {
                    Caption = 'Customer Detailed Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer Detailed Aging";
                }
            }
            action("Přehled prod. faktur dobropisů")
            {
                Caption = 'Sales Invoice Overview';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Invoice Overview";
                Visible = false;
            }
            action("Vratky zboží zákazníka")
            {
                Caption = 'Customer Parts Backorder';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Customer Parts Backorder List";
                Visible = false;
            }
            action("Souhrnné informace o zákaznících")
            {
                Caption = 'Customer Information Mgmt.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Customer Information Mgmt.";
                Visible = false;
            }
            action("Odsouhlasení salda")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance Reconciliation';
                Image = Balance;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Customer - Bal. Reconciliation";
                ToolTip = 'Open the report for customer''s balance reconciliation.';
            }
        }
    }

    var
        _INCADEA_: Integer;
        DataPrivSetupG: Record "Data Privacy Setup";
        ContactG: Record Contact;
        AddressLnkG: Record "Address Link";
        VehicleSearchG: Page "Multicompany Vehicle Search";
        DataPrivManagementG: Codeunit "Data Privacy Management";
        ServMgmtG: Codeunit "Service Management";
        VehicleCollectionUnitG: Codeunit "Vehicle Collection Unit";
        CashRegisterFunctionsG: Codeunit "Cash Register Functions";
        InternatDataPrivacyCheckG: Codeunit "Internat. Data Privacy Check";
        UserSessionG: Codeunit "User Session Unit";
        DocumentTypeG: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        ServiceDocTypeG: Option Quote,"Order",,,,,,Scheduling;
        [InDataSet]

        EnableDataPrivacyG: Boolean;
        RecRefG: RecordRef;

    [Scope('Internal')]
    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        SelectionFilter := '';
        CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
            Cust.FINDSET;
            WHILE CustCount > 0 DO BEGIN
                CustCount := CustCount - 1;
                Cust.MARKEDONLY(FALSE);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                WHILE More DO
                    IF Cust.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Cust.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            IF CustCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstCust = LastCust THEN
                    SelectionFilter := SelectionFilter + FirstCust
                ELSE
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                IF CustCount > 0 THEN BEGIN
                    Cust.MARKEDONLY(TRUE);
                    Cust.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    [Scope('Internal')]
    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;

    [Scope('Internal')]
    procedure SpecialFunctionsCall()
    var
        RecordReferenceL: RecordRef;
        PageSpecialFunctionsL: Page "My Special Functions";
    begin
        // Start PA036705
        CLEAR(RecordReferenceL);
        RecordReferenceL.GETTABLE(Rec);
        CLEAR(PageSpecialFunctionsL);
        PageSpecialFunctionsL.SetParameters(PAGE::"Customer List", RecordReferenceL, '', '');
        PageSpecialFunctionsL.RUNMODAL;
        // Stop PA036705
    end;

    /*
    local procedure EnableDataPrivacy()
    begin
        // @ this function enables Data Privacy Actions
        // Start EU.0006288
        IF NOT InternatDataPrivacyCheckG.CheckIncludeBusinessContacts("Customer Type") THEN
            EnableDataPrivacyG := FALSE
        ELSE BEGIN
            CALCFIELDS("Exclude from Data Privacy");
            EnableDataPrivacyG := NOT "Exclude from Data Privacy";
        END;
        // Stop EU.0006288
    end;
    */

    [Scope('Internal')]
    procedure InitRec(var CustomerP: Record Customer temporary)
    begin
        IF CustomerP.FINDSET THEN
            REPEAT
                INIT;
                Rec := CustomerP;
                INSERT;
            UNTIL CustomerP.NEXT = 0;

        IF FINDFIRST THEN;
    end;
}


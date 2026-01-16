table 80007 "DPG DAF Truck Sales Cue"
{
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   09.02.10 New Object
    // PA032111   12.08.10 (BRL): Object renumbering changes due to Microsoft Agreement.
    // PA032651   12.01.12 DR 5175462: Use more performing que for filters for Counting FlowFields in "My ..." fields.
    //                        - Cue field Names and Captions corrected.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2

    Caption = 'DAF Truck Sales Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Vehicles To Order"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('TEBESTELLEN')));
            Caption = 'Voertuigen Te Bestellen';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Vehicles Ordered"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('BESTELD')));
            Caption = 'Voertuigen Besteld';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Vehicles Received"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('AUTOBINNEN')));
            Caption = 'Voertuigen Binnen';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Vehicles Shipped"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('GELEVERD')));
            Caption = 'Voertuigen Geleverd';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Vehicles Purch Ordered"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('BESTELD')));
            Caption = 'Voertuigen Inkoop Besteld';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Vehicles Purch To Receive"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('TEONTVANGEN')));
            Caption = 'Voertuigen Inkoop Te Ontvangen';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Vehicles Purch To Invoice"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('TEFACT')));
            Caption = 'Voertuigen Inkoop Te Factureren';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Vehicles Purch Stock"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Location Code" = FIELD("Location Filter"), "Order Type" = CONST("Vehicle Sales & Purchases"), "Document Type" = CONST(Order), "Status Code" = CONST('VOORRAAD')));
            Caption = 'Voertuigen Inkoop Voorraad';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Vehicles Stock New"; Integer)
        {
            CalcFormula = Count(Vehicle WHERE("Location Code" = CONST('10'), "Vehicle Status" = CONST("New Vehicle")));
            Caption = 'Voertuigen Voorraad Nieuw';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Vehicles Stock Occasion"; Integer)
        {
            CalcFormula = Count(Vehicle WHERE("Location Code" = FIELD("Location Filter"), "Vehicle Status" = CONST("Used Vehicle")));
            Caption = 'Voertuigen Voorraad Gebruikt';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "PO Veh. Transfer to create"; Integer)
        {
            CalcFormula = Count("Sales Line" WHERE("Location Code" = FIELD("Location Filter"), "Document Type" = CONST(Order), "Order Type" = CONST("Vehicle Sales & Purchases"), Type = CONST(Item), "Item Type" = CONST("Veh. Transfer"), "From Purch. Document No." = FILTER(''), VIN = FILTER(<> '')));
            Caption = 'PO Veh. Transfer to create';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Service Order lines to create"; Integer)
        {
            CalcFormula = Count("Sales Line" WHERE("Location Code" = FIELD("Location Filter"), "Document Type" = CONST(Order), "Order Type" = CONST("Vehicle Sales & Purchases"), Type = CONST(Item), "Item Type" = CONST("Own Option"), "Service Order No." = FILTER(''), VIN = FILTER(<> '')));
            Caption = 'Service Order lines to create';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Salesperson/Purchaser Filter"; Code[10])
        {
            Caption = 'Salesperson/Purchaser Filter';
            FieldClass = FlowFilter;
        }
        field(41; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Demo vehicles"; Integer)
        {
            CalcFormula = Count(Vehicle WHERE("Location Code" = CONST('15'), "Vehicle Status" = CONST("Demo Vehicle")));
            Caption = 'Demo vozidla';
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Customers with credit limit"; Integer)
        {
            CalcFormula = Count(Customer WHERE("Credit Limit (LCY)" = FILTER(> 1)));
            Caption = 'Zákazníci s kreditním limitem';
            Editable = false;
            FieldClass = FlowField;
        }
        field(44; "Customers with GDPR approved"; Integer)
        {
            CalcFormula = Count("Internat. Data Priv. Query Log" WHERE("Consent for Marketing Purpose" = CONST(true), "Consent Expiration Date" = FIELD("Data Filter")));
            Caption = 'Customers with GDPR approved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Customers with expired GDPR"; Integer)
        {
            CalcFormula = Count("Internat. Data Priv. Query Log" WHERE("Consent Expiration Date" = FIELD("Data Filter")));
            FieldClass = FlowField;
        }
        field(46; "Data Filter"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


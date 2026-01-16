table 80005 "DPG DAF Case Cue I"
{
    // // @ Area RelationshipManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA038391   27.08.15 LR New object
    // PA038392   27.10.15 LR 48022 New field for escalated field
    // PA037938   08.12.15 LR 50889 Filter "Not Assigned" by "Case Origin" <> Retail
    // PA042019   02.11.16 GI Added "Case Cat. 5 Filter" field.

    Caption = 'Case Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Not Assigned"; Integer)
        {
            CalcFormula = Count("Case Buffer" WHERE("Case No." = FILTER(''), "Case Origin" = FILTER(<> Retail), "Case Status Code" = FIELD("Status Filter"), "Creation Date" = FIELD("Date Filter"), "Case Type Code" = FIELD("Case Type Filter"), "Case Source Code" = FIELD("Case Source Filter"), "Case Category 1 Code" = FIELD("Case Cat. 1 Filter"), "Case Category 2 Code" = FIELD("Case Cat. 2 Filter"), "Case Category 3 Code" = FIELD("Case Cat. 3 Filter"), "Case Category 4 Code" = FIELD("Case Cat. 4 Filter"), "Case Category 5 Code" = FIELD("Case Cat. 5 Filter")));
            Caption = 'Not Assigned';
            Description = 'PA038391.45830,PA037938.50877,PA037938.50889,PA042019';
            FieldClass = FlowField;
        }
        field(3; Open; Integer)
        {
            CalcFormula = Count(Case WHERE(Closed = CONST(false), Status = FIELD("Status Filter"), "Date of Creation" = FIELD("Date Filter"), "Case Type Code" = FIELD("Case Type Filter"), "Case Source Code" = FIELD("Case Source Filter"), "Category 1 Code" = FIELD("Case Cat. 1 Filter"), "Category 2 Code" = FIELD("Case Cat. 2 Filter"), "Category 3 Code" = FIELD("Case Cat. 3 Filter"), "Category 4 Code" = FIELD("Case Cat. 4 Filter"), "Category 5 Code" = FIELD("Case Cat. 5 Filter")));
            Caption = 'Open';
            Description = 'PA038391.45830,PA042019';
            FieldClass = FlowField;
        }
        field(4; Escalated; Integer)
        {
            CalcFormula = Count(Case WHERE("No of Escalations" = FILTER(> 0), Status = FIELD("Status Filter"), "Date of Creation" = FIELD("Date Filter"), "Case Type Code" = FIELD("Case Type Filter"), "Case Source Code" = FIELD("Case Source Filter"), "Category 1 Code" = FIELD("Case Cat. 1 Filter"), "Category 2 Code" = FIELD("Case Cat. 2 Filter"), "Category 3 Code" = FIELD("Case Cat. 3 Filter"), "Category 4 Code" = FIELD("Case Cat. 4 Filter"), "Category 5 Code" = FIELD("Case Cat. 5 Filter"), Closed = FILTER(false)));
            Caption = 'Escalated';
            Description = 'PA038391.45830,PA038392.48022,PA042019';
            FieldClass = FlowField;
        }
        field(5; Closed; Integer)
        {
            CalcFormula = Count(Case WHERE(Closed = FILTER(true), Status = FIELD("Status Filter"), "Date of Creation" = FIELD("Date Filter"), "Case Type Code" = FIELD("Case Type Filter"), "Case Source Code" = FIELD("Case Source Filter"), "Category 1 Code" = FIELD("Case Cat. 1 Filter"), "Category 2 Code" = FIELD("Case Cat. 2 Filter"), "Category 3 Code" = FIELD("Case Cat. 3 Filter"), "Category 4 Code" = FIELD("Case Cat. 4 Filter"), "Category 5 Code" = FIELD("Case Cat. 5 Filter")));
            Caption = 'Closed';
            Description = 'PA038391.45830,PA042019';
            FieldClass = FlowField;
        }
        field(8; "Status Filter"; Code[50])
        {
            Caption = 'Status Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(10; "Owner Filter"; Code[50])
        {
            Caption = 'Owner Filter';
            FieldClass = FlowFilter;
        }
        field(11; "Case Type Filter"; Code[20])
        {
            Caption = 'Case Type Filter';
            FieldClass = FlowFilter;
        }
        field(12; "Case Source Filter"; Code[20])
        {
            Caption = 'Case Source Filter';
            FieldClass = FlowFilter;
        }
        field(13; "Case Cat. 1 Filter"; Code[20])
        {
            Caption = 'Case Cat. 1 Filter';
            FieldClass = FlowFilter;
        }
        field(14; "Case Cat. 2 Filter"; Code[20])
        {
            Caption = 'Case Cat. 2 Filter';
            FieldClass = FlowFilter;
        }
        field(15; "Case Cat. 3 Filter"; Code[20])
        {
            Caption = 'Case Cat. 3 Filter';
            FieldClass = FlowFilter;
        }
        field(16; "Case Cat. 4 Filter"; Code[20])
        {
            Caption = 'Case Cat. 4 Filter';
            FieldClass = FlowFilter;
        }
        field(17; "Case Cat. 5 Filter"; Code[25])
        {
            Caption = 'Case Cat. 5 Filter';
            Description = 'PA042019';
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


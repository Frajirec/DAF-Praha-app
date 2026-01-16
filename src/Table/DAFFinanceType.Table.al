table 80006 "DPG DAF Finance Type"
{
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // 
    // 
    // --- DAFCZ ---
    // DAFCZ0010  01.12.20 FJC New table for DAF Finance Type on Vehicle Sales Order for DAF Truck Sales module

    Caption = 'DAF Finance Type';
    DrillDownPageID = "DPG DAF Finance Type";
    LookupPageID = "DPG DAF Finance Type";

    fields
    {
        field(1; "Code"; Code[40])
        {
            Caption = 'Code';
            Description = 'DAF Action Name';
            NotBlank = true;
        }
        field(10; Description; Text[80])
        {
            Caption = 'Description';
            Description = 'DAF Action Name Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}


table 80008 "DPG DAF Vehicle Location"
{
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // 
    // 
    // --- DAFCZ ---
    // DAFCZ0010  01.12.20 FJC New table for Vehicle Location on Vehicle Sales Order for DAF Truck Sales module

    Caption = 'Extra Code 2';
    DrillDownPageID = "DPG DAF Vehicle Location";
    LookupPageID = "DPG DAF Vehicle Location";

    fields
    {
        field(1; "Code"; Code[40])
        {
            Caption = 'Code';
            Description = 'Extra Code 2';
            NotBlank = true;
        }
        field(10; Description; Text[80])
        {
            Caption = 'Description';
            Description = 'Extra Code 2 Description';
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


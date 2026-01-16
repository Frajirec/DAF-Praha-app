table 80000 "DPG Ares Setup" // 1058090 "Ares Setup"
{
    // --- NML SOL ---
    // --- DAFCZ ---
    // DAFCZ0004  29.08.21 MG DAFCZ.1 NEW OBJECT

    Caption = 'Rebilling Setup';
    DrillDownPageID = "DPG Rebilling Setup";
    LookupPageID = "DPG Rebilling Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(21; "Last Request Date"; Date)
        {
            Caption = 'Last Request Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Daily Request Limit"; Integer)
        {
            Caption = 'Daily Request Limit';
            DataClassification = ToBeClassified;
        }
        field(23; "Count of Used Request"; Integer)
        {
            Caption = 'Count of Used Request';
            DataClassification = ToBeClassified;
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


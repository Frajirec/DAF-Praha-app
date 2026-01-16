table 80009 "DPG Rebilling Setup"
{
    // --- API Customization ---
    // --- DAFCZ ---
    // 79021056   27.05.20 RH DAFCZ.1 New object

    Caption = 'Rebilling Setup';
    DrillDownPageID = "DPG Rebilling Setup";
    LookupPageID = "DPG Rebilling Setup";

    fields
    {
        field(1; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(21; "Rebilling Customer No."; Code[10])
        {
            Caption = 'Rebilling Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(22; "Rebilling Payment Method Code"; Code[10])
        {
            Caption = 'Rebilling Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
    }

    keys
    {
        key(Key1; "Payment Method Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


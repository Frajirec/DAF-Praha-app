table 80001 "DPG Ares Excluded Cust./Vendor" // 1058089 "Ares Excluded Customer/Vendor"
{
    // --- NML SOL ---
    // --- DAFCZ ---
    // DAFCZ0004  11.10.21 MG DAFCZ.1 new OBJECT
    Caption = 'Ares Excluded Customer/Vendor';


    fields
    {
        field(1; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(2; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor;
        }
    }

    keys
    {
        key(Key1; "Account Type", "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


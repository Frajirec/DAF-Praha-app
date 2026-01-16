table 80010 "DAF BIC Codes"
{
    //FJC        21.10.25 FJC           New object

    Caption = 'BIC Codes';
    DrillDownPageID = "DAF BIC codes";
    LookupPageID = "DAF BIC codes";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Branch No."; Text[4])
        {
            Caption = 'Bank Branch No.';
        }
        field(2; "Bank Branch Name"; Text[100])
        {
            Caption = 'Bank Branch Name';
        }
        field(3; BIC; Text[20])
        {
            Caption = 'BIC';
        }
    }
    keys
    {
        key(PK; "Bank Branch No.")
        {
            Clustered = true;
        }
    }
}

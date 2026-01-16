tableextension 80008 "DPG Cust. Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    fields
    {
        field(80000; "DPG Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
    }
}

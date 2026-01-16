tableextension 80011 "DPG Check Ledger Entry Ext" extends "Check Ledger Entry"
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
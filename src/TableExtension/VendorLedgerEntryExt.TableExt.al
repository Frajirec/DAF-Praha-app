tableextension 80009 "DPG Vendor Ledger Entry Ext" extends "Vendor Ledger Entry"
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

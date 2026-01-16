tableextension 80010 "DPG Bank Acc. Ledger Entry Ext" extends "Bank Account Ledger Entry"
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
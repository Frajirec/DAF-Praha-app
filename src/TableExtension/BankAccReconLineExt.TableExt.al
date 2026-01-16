tableextension 80012 "DPG Bank Acc. Recon. Line Ext" extends "Bank Acc. Reconciliation Line"
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
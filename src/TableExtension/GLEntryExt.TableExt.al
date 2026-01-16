tableextension 80006 "DPG G/L Entry Ext" extends "G/L Entry"
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

tableextension 80002 "DPG Registration Log Ext" extends "Registration Log"
{
    fields
    {
        field(80000; "DPG Up to Date"; Boolean)
        {
            Caption = 'Up to Date';
            DataClassification = ToBeClassified;
        }
    }
}
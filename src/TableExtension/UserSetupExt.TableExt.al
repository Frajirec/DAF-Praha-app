tableextension 80003 "DPG User Setup Ext" extends "User Setup"
{
    fields
    {
        field(80000; "DPG Allow Change Payment Met."; Boolean)
        {
            Caption = 'Allow Change Payment Method';
            DataClassification = ToBeClassified;
        }
    }
}
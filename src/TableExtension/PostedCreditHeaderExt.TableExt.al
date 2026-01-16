tableextension 80000 "DPG Posted Credit Header Ext" extends "Posted Credit Header"
{
    fields
    {
        field(80000; "DPG Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
    }
}
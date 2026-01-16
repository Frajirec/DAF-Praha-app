tableextension 80001 "DPG Credit Header Ext" extends "Credit Header"
{
    fields
    {
        field(80000; "DPG Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    begin
        "DPG Due Date" := WORKDATE;
    end;
}
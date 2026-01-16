tableextension 80005 "DPG Service Posting Group Ext" extends "Service Posting Group"
{
    fields
    {
        field(80000; "DPG Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(80001; "DPG Model No. Filter"; Code[80])
        {
            Caption = 'Model No. Filter';
            DataClassification = ToBeClassified;
        }
    }
}
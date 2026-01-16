tableextension 80014 "DPG Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(80000; "DPG Finance Type"; Code[40])
        {
            Caption = 'Finance Type';
            TableRelation = "DPG DAF Finance Type";
            DataClassification = ToBeClassified;
        }
        field(80001; "DPG Action Name"; Code[40])
        {
            Caption = 'Action Name';
            TableRelation = "DPG DAF Action Name";
            DataClassification = ToBeClassified;
        }
        field(80002; "DPG Vehicle Location"; Code[40])
        {
            Caption = 'Vehicle Location';
            TableRelation = "DPG DAF Vehicle Location";
            DataClassification = ToBeClassified;
        }
        field(80003; "DPG DTP Fleet/Retail"; Option)
        {
            Caption = 'DTP Fleet/Retail';
            OptionMembers = " ","DTP-FLT","DTP-RET","OTHER","SUPERFLT";
            DataClassification = ToBeClassified;
        }
        field(80004; "DPG Vehicle Group DAF"; Option)
        {
            Caption = 'Vehicle Group DAF';
            OptionMembers = " ","CFXF Tractor","CFXF Rigid","LF under 15","LF above 15";
            DataClassification = ToBeClassified;
        }
        field(80011; "DPG PDASS"; Date)
        {
            Caption = 'PDASS';
            DataClassification = ToBeClassified;
        }
        field(80012; "DPG Vehicle Stock Date"; Date)
        {
            Caption = 'Vehicle Stock Date';
            DataClassification = ToBeClassified;
        }
        field(80007; "DPG Reservation"; Date)
        {
            Caption = 'Reservation';
            DataClassification = ToBeClassified;
        }
        field(80008; "DPG Finance Contract End"; Date)
        {
            Caption = 'Finance Contract End';
            DataClassification = ToBeClassified;
        }
        field(80009; "DPG Body Delivery"; Date)
        {
            Caption = 'Body Delivery';
            DataClassification = ToBeClassified;
        }
        // do not use field's no. 80005, 80006, 80010 and 80015
    }
}
table 80002 "DPG Consent Level Cue"
{
    // --- API Customization ---
    // 79027073    27.08.20 RK DAFCZ.1 new object    
    Caption = 'Consent Level Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(11; "Business Agreed"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('BUSINESS'), "Consent Expiration Date" = FIELD("Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
            Caption = 'Business Agreed';
        }
        field(12; "Marketing Agreed"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('MARKETING'), "Consent Expiration Date" = FIELD("Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(13; "MAX Agreed"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('MAX'), "Consent Expiration Date" = FIELD("Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(14; "Business Expired"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('BUSINESS'), "Consent Expiration Date" = FIELD("Expired Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(15; "Marketing Expired"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('MARKETING'), "Consent Expiration Date" = FIELD("Expired Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(16; "MAX Expired"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('MAX'), "Consent Expiration Date" = FIELD("Expired Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(17; "No Business Consent Level"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(18; "No Marketing Consent Level"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(19; "No MAX Consent Level"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(20; "Business Expire within X Days"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('BUSINESS'), "Consent Expiration Date" = FIELD("Expired X Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(21; "Marketing Expire within X Days"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('MARKETING'), "Consent Expiration Date" = FIELD("Expired X Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(22; "MAX Expire within X Days"; Integer)
        {
            CalcFormula = Count("Internat. Data Privacy Query" WHERE("Consent Level Code" = CONST('MAX'), "Consent Expiration Date" = FIELD("Expired X Date Filter"), "Customer Disagreement" = CONST(false)));
            FieldClass = FlowField;
        }
        field(100; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(101; "Expired Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(102; "Expired X Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


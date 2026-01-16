tableextension 80017 "CustBankAccountExt.TableExt" extends "Customer Bank Account"
{
    fields
    {
        field(11791; "Customer VAT Registration No."; Text[20])
        {

            Caption = 'Customer VAT Registration No.';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."VAT Registration No." WHERE("No." = FIELD("Customer No.")));
        }
        field(11792; "Third Party Bank Account"; Boolean)
        {
            Caption = 'Third Party Bank Account';
            DataClassification = ToBeClassified;
        }
    }
}

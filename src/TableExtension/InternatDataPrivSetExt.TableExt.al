tableextension 80004 "DPG Internat.Data Priv.Set.Ext" extends "Internat. Data Privacy Setup"
{
    fields
    {
        field(80000; "DPG Consent Expiration Calc."; DateFormula)
        {
            Caption = 'Consent Expiration Calculation';
            DataClassification = ToBeClassified;
        }
    }
}
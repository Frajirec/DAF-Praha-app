pageextension 80037 CustomerBankAccountListPageExt extends "Customer Bank Account List"
{

    layout
    {
        addafter("Bank Account No.")
        {
            field("Public Bank Account";
            UncPayerMgt.IsPublicBankAccount("Customer No.", "Customer VAT Registration No.", "Bank Account No.", IBAN))
            {
                ToolTip = 'Specifies if the customers bank account is public.';
                ApplicationArea = Basic, Suite;
                Editable = false;

            }

            field("DAF Third Party Bank Account"; "Third Party Bank Account")
            {
                ToolTip = 'Specifies if the account is third party bank account.';
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
        }
    }
    Trigger OnAfterGetRecord()
    Begin
        CalcFields("Customer VAT Registration No.")
    End;


    var
        UncPayerMgt: Codeunit "Unc. Payer Mgt.";
}
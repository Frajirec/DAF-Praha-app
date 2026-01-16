pageextension 80002 "DPG Customer List Ext" extends "Customer List"
{
    layout
    {
        addafter("Balance (LCY)")
        {
            field("DPG Credit Limit (LCY)"; "Credit Limit (LCY)")
            {
            }
            field("Creation Date"; "Creation Date")
            {
            }
        }
        addafter(Control1901312607)
        {
            part("DPG Data Privacy FactBox"; "DPG Data Privacy FactBox")
            {
                SubPageLink = "Customer No." = FIELD("No."), "Date Filter" = FIELD(FILTER("Date Filter")), "Department Filter" = FIELD(FILTER("Global Dimension 1 Filter")), "Make Filter" = FIELD(FILTER("Global Dimension 2 Filter")), "Currency Filter" = FIELD(FILTER("Currency Filter"));
            }
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
    }
    actions

    {

        modify("&Bank Accounts")
        {
            Visible = false;
        }
        addafter("&Bank Accounts")

        {

            action(BankAccounts)

            {

                ApplicationArea = all;

                Image = NewBank;

                Caption = 'Bank Accounts';

                RunObject = page "Customer Bank Account List";
                RunPageLink = "Customer No." = FIELD("No.");

            }
        }
    }
}
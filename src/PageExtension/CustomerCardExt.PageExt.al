pageextension 80001 "DPG Customer Card Ext" extends "Customer Card"
{
    layout
    {
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

            action("DAF BankAccounts")

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
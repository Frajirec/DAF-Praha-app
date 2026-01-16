pageextension 80003 "DPG Cust. Ledger Entries Ext" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Description")
        {
            field("DPG Description 2"; "DPG Description 2")
            {
                Editable = false;
            }
            field("DAF Sell-to Customer No."; "Sell-to Customer No.")
            {
                Editable = false;
            }
        }
    }
}
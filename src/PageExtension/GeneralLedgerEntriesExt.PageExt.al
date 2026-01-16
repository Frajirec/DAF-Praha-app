pageextension 80000 "DPG General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        addafter("Description")
        {
            field("DPG Description 2"; "DPG Description 2")
            {
            }
        }
    }
}
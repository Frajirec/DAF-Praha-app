pageextension 80004 "DPG Vendor Ledger Entries Ext" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Description")
        {
            field("DPG Description 2"; "DPG Description 2")
            {
                Editable = false;
            }
        }
    }
}
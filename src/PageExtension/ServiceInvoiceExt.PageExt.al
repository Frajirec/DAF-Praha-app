pageextension 80014 "DPG Service Invoice Ext" extends "Service Invoice"
{
    layout
    {
        modify("Posting Date")
        {
            Editable = true;
        }
        modify("VAT Date")
        {
            Editable = true;
        }
        modify("Document Date")
        {
            Editable = true;
        }
    }
}

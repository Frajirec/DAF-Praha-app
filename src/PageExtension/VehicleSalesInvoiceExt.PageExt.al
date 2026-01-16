pageextension 80010 "DPG Vehicle Sales Invoice Ext" extends "Vehicle Sales Invoice"
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

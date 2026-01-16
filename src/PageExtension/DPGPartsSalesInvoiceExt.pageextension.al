pageextension 80018 "DPG Parts Sales Invoice Ext" extends "Parts Sales Invoice"
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

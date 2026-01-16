pageextension 80016 "DPG Parts Purchase Order Ext" extends "Parts Purchase Order"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("DPG VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
            }
        }
    }
}
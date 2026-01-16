pageextension 80017 "DPG Parts Purch. Cr. Memo Ext" extends "Parts Purchase Credit Memo"
{
    layout
    {
        addafter("Vendor Posting Group")
        {
            field("DPG VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
            }
            //NOTE: VAT Reg. No.
            field("DPG VAT Registration No."; "VAT Registration No.")
            {
            }
        }
    }
}
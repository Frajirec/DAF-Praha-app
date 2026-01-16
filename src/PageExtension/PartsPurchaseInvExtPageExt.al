pageextension 80038 "PartsPurchaseInvExt.PageExt" extends "Parts Purchase Invoice"
{
    layout
    {
        addafter("VAT Bus. Posting Group")
        {
            //NOTE: VAT Reg. No.
            field("DPG VAT Registration No."; "VAT Registration No.")
            {
            }
        }
    }
}

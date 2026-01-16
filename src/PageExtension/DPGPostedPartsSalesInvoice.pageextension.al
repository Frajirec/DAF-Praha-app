pageextension 80031 "DPG Posted Parts Sales Invoice" extends "Posted Parts Sales Invoices"
{
    layout
    {
        addafter("Posting Date")
        {
            field("DAF Payment Method Code"; "Payment Method Code")
            {
            }
        }
    }
}

pageextension 80032 "DPG Posted Service Sales Inv." extends "Posted Service Sales Invoices"
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

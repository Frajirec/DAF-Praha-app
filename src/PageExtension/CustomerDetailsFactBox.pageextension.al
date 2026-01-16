pageextension 80039 "DAF Customer Details FactBox" extends "Customer Details FactBox"
{
    //NOTE: Credit Limit 
    layout
    {
        addafter("Contact")
        {
            field("DPG Credit Limit (LCY)"; "Credit Limit (LCY)")
            {
            }

        }
    }
}
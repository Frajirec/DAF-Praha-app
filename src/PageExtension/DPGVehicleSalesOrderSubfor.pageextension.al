pageextension 80035 "DPG Vehicle Sales Order Subfor" extends "Vehicle Sales Order Subform"
{
    layout
    {
        addafter("VAT Base Amount")
        {
            field("DAF Currency Code"; "Currency Code")
            {
            }
        }
    }
}
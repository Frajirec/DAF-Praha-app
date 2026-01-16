pageextension 80039 "ServiceSchedulingOrderExt.Page" extends "Service Scheduling Order"
{
    layout
    {
        addafter("CVM Fleet No.")
        {
            //NOTE: Target Price
            field("DPG Target Price"; "CVM Target Price")
            {
            }
        }
    }
}

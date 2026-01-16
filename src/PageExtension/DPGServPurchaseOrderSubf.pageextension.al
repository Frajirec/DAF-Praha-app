pageextension 80033 "DPG Serv. Purchase Order Subf." extends "Serv. Purchase Order Subf."
{
    layout
    {
        addafter(Amount)
        {
            field("DAF VIN"; "VIN")
            {
            }
        }
    }
}
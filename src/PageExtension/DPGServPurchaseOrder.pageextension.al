pageextension 80034 "DAF DPG Serv. Purchase Order" extends "Serv. Purchase Order"
{
    layout
    {
        addafter("Posting Date")
        {
            field("DAF Supply VIN"; "Supply VIN")
            {
            }
        }
    }
}
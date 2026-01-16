pageextension 80030 "DPG Vehicle Archived Order Ext" extends "Vehicle Archived Order"
{
    layout
    {
        addafter("Free")
        {
            group("DPG Truck Sales")
            {
                Caption = 'Truck Sales';

                field("DPG Finance Type"; "DPG Finance Type")
                {
                }
                field("DPG Action Name"; "DPG Action Name")
                {
                }
                field("DPG Vehicle Location"; "DPG Vehicle Location")
                {
                }
                field("DPG DTP Fleet/Retail"; "DPG DTP Fleet/Retail")
                {
                }
                field("DPG Vehicle Group DAF"; "DPG Vehicle Group DAF")
                {
                }
                field("DPG PDASS"; "DPG PDASS")
                {
                }
                field("DPG Vehicle Stock Date"; "DPG Vehicle Stock Date")
                {
                }
                field("DPG Reservation"; "DPG Reservation")
                {
                }
                field("DPG Finance Contract End"; "DPG Finance Contract End")
                {
                }
                field("DPG Body Delivery"; "DPG Body Delivery")
                {
                }
            }
        }
    }
}
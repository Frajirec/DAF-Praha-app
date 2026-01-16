pageextension 80005 "DPG Recur. General Journal Ext" extends "Recurring General Journal"
{
    layout
    {
        addafter("Specific Symbol")
        {
            field("DPG VIN"; "VIN")
            {
            }
        }
    }
}
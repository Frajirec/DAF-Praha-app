pageextension 80020 "DPG Contact Person List Ext" extends "Contact Person List"
{
    layout
    {
        addafter("Mobile Phone No.")
        {
            field("DPG E-Mail"; "E-Mail")
            {
            }
            field("DPG Position Code"; "Position Code")
            {
            }
        }
    }
}
pageextension 80023 "DPG Accounting Manager RC Ext" extends "Accounting Manager RC"
{
    layout
    {
        addafter("Control1903428308")
        {
            part("DPG DAF Customer Activities"; "DPG DAF Customer Activities")
            {
            }
            part("DPG DAF Case Activities"; "DPG DAF Case Activities")
            {
            }
        }
        modify("Control1907763808")
        {
            Visible = false;
        }
    }
}
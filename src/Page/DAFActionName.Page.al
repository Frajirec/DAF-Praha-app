page 80003 "DPG DAF Action Name" // 50018 "DAF Action Name"
{
    // 
    // --- DAFCZ ---
    // DAFCZ0010  02.12.20 FJC New object for DAF Truck sales module

    PageType = List;
    SourceTable = "DPG DAF Action Name";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}


page 80002 "DPG DAF Finance Type" // 50019 "DAF Finance Type"
{
    // 
    // --- DAFCZ ---
    // DAFCZ0010  02.12.20 FJC New object for DAF Truck sales module

    PageType = List;
    SourceTable = "DPG DAF Finance Type";

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


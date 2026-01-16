page 80001 "DPG DAF Vehicle Location" // 50017 "DAF Vehicle Location"
{
    // 
    // 
    // --- DAFCZ ---
    // DAFCZ0010  02.12.20 FJC New object for DAF Truck sales module

    PageType = List;
    SourceTable = "DPG DAF Vehicle Location";

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


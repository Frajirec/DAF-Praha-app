page 80007 "DPG Vehicle Main Group WS" // 50012 "Vehicle Main Group WS"
{
    PageType = List;
    SourceTable = "Vehicle Main Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Make Code"; "Make Code")
                {
                }
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Description 2"; "Description 2")
                {
                }
                field("No. of Subgroups"; "No. of Subgroups")
                {
                }
                field("Division Code"; "Division Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}


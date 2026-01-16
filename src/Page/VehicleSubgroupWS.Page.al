page 80031 "DPG Vehicle Subgroup WS"
{
    PageType = List;
    SourceTable = "Vehicle Subgroup";

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
                field("Attached to Main Group"; "Attached to Main Group")
                {
                }
                field(Description; Description)
                {
                }
                field("Description 2"; "Description 2")
                {
                }
                field("Line Group Count"; "Line Group Count")
                {
                }
            }
        }
    }

    actions
    {
    }
}


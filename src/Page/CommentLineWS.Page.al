page 80008 "DPG Comment Line WS"
{
    PageType = List;
    SourceTable = "Comment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Name"; "Table Name")
                {
                }
                field("No."; "No.")
                {
                }
                field("Line No."; "Line No.")
                {
                }
                field(Date; Date)
                {
                }
                field("Code"; Code)
                {
                }
                field(Comment; Comment)
                {
                }
            }
        }
    }

    actions
    {
    }
}


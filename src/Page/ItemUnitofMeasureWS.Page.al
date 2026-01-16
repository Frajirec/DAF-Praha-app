page 80023 "DPG Item Unit of Measure WS"
{
    PageType = List;
    SourceTable = "Item Unit of Measure";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                }
                field("Code"; Code)
                {
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                }
                field("Intrastat Default"; "Intrastat Default")
                {
                }
                field("Indivisible Unit"; "Indivisible Unit")
                {
                }
            }
        }
    }

    actions
    {
    }
}


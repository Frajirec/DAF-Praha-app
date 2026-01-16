page 80033 "DAF BIC codes"
{
    //FJC        21.10.25 FJC           New page for BIC Codes table

    Caption = 'BIC codes';
    PageType = List;
    SourceTable = "DAF BIC Codes";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Bank Branch No."; "Bank Branch No.")
                {

                }
                field("Bank Branch Name"; "Bank Branch Name")
                {

                }
                field(BIC; "BIC")
                {
                }
            }
        }
    }
}

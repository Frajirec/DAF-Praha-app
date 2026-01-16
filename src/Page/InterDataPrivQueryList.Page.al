page 80021 "DPG Inter.Data Priv.Query List"
{
    // --- API Customization ---
    // 79027073    27.08.20 RK DAFCZ.1 new object
    // 79027073    06.10.20 VB DAFCZ.1 added action cutomer card

    PageType = List;
    SourceTable = "Internat. Data Privacy Query";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Consent Level Code"; "Consent Level Code")
                {
                }
                field("Contact / Contact Person No."; "Contact / Contact Person No.")
                {
                }
                field("Customer No."; "Customer No.")
                {
                }
                field("CustomerG.Name"; CustomerG.Name)
                {
                }
                field("Data Privacy Status"; "Data Privacy Status")
                {
                }
                field("Customer Disagreement"; "Customer Disagreement")
                {
                }
                field("Signature Date"; "Signature Date")
                {
                }
                field("Consent Expiration Date"; "Consent Expiration Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Customer Card")
            {
                Caption = 'Customer Card';
                RunObject = Page "Customer Card";
                RunPageLink = "No." = FIELD("Customer No.");
                RunPageView = SORTING("No.") ORDER(Ascending);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT CustomerG.GET("Customer No.") THEN
            CustomerG.INIT;
    end;

    var
        CustomerG: Record Customer;
}


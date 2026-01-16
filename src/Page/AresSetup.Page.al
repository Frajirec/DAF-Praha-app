page 80005 "DPG Ares Setup" // 1057713 "Ares Setup"
{
    // --- NML SOL ---
    // --- DAFCZ ---
    // DAFCZ0004  11.10.21 MG DAFCZ.1 new OBJECT

    Caption = 'Ares Setup';
    PageType = Card;
    SourceTable = "DPG Ares Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Last Request Date"; "Last Request Date")
                {
                    Editable = false;
                }
                field("Daily Request Limit"; "Daily Request Limit")
                {
                }
                field("Count of Used Request"; "Count of Used Request")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;
}


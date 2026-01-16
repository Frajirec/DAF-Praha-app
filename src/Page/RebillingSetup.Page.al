page 80000 "DPG Rebilling Setup" // 50015 "Rebilling Setup"
{
    // --- API Customization ---
    // --- DAFCZ ---
    // 79021056   27.05.20 RH DAFCZ.1 New object

    Caption = 'Rebilling Setup';
    PageType = List;
    SourceTable = "DPG Rebilling Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Method Code"; "Payment Method Code")
                {
                }
                field("Rebilling Customer No."; "Rebilling Customer No.")
                {
                }
                field("Rebilling Payment Method Code"; "Rebilling Payment Method Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}


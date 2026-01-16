page 80006 "DPG Ares Excl.Cust./Vend. List" // 1057715 "Ares Excluded Cust./Vend. List"
{
    // --- NML SOL ---
    // --- DAFCZ ---
    // DAFCZ0004  11.10.21 MG DAFCZ.1 new OBJECT

    Caption = 'Ares Excluded Cust./Vend. List';
    PageType = List;
    SourceTable = "DPG Ares Excluded Cust./Vendor";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; "Account Type")
                {
                }
                field("Account No."; "Account No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}


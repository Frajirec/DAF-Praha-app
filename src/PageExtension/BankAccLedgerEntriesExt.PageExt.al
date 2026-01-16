pageextension 80006 "DPG Bank Acc.Ledger EntriesExt" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Description")
        {
            field("DPG Description 2"; "DPG Description 2")
            {
                Editable = false;
            }
        }
    }
}
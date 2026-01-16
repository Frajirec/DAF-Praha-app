pageextension 80008 "DPG Payment Recon. Journal Ext" extends "Payment Reconciliation Journal"
{
    layout
    {
        addafter("DescAppliedEntry")
        {
            field("DPG Description 2"; "DPG Description 2")
            {
                ToolTip = 'Specifies the Description 2 to be passed to Vendor or Customer ledger Entries.';
            }
        }
    }
}
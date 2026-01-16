pageextension 80009 "DPG Credit Card Ext" extends "Credit Card"
{
    layout
    {
        addafter("Posting Date")
        {
            field("DPG Due Date 2"; "DPG Due Date")
            {
            }
        }
    }
    actions
    {
        addafter("P&ost")
        {
            action("DPG Post and Print")
            {
                ApplicationArea = All;
                Caption = 'Post and &Print';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = 'Shift+F9';

                trigger OnAction()
                begin
                    Post(CODEUNIT::"DPG Credit - Post + Print");
                end;
            }
        }
    }
}
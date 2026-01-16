codeunit 80002 "DPG Credit - Post + Print"
{
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1  22.10.18 DV DAFCZ.1 New object

    TableNo = "Credit Header";

    trigger OnRun()
    begin
        CreditHeader.COPY(Rec);
        Code;
        Rec := CreditHeader;
    end;

    var
        CreditHeader: Record "Credit Header";
        //CreditReportSelections: Record "Credit Report Selections";
        CreditPost: Codeunit "Credit - Post";
    //PostedCreditHeader: Record "Posted Credit Header";

    local procedure "Code"()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchasePostViaJobQueue: Codeunit "Purchase Post via Job Queue";
        PurchBookingPageL: Page "Purch. Posting Prompt";
    begin
        WITH CreditHeader DO BEGIN
            PurchSetup.GET;
            CreditPost.RUN(CreditHeader);
            GetReport(CreditHeader);
        END;
    end;

    [Scope('Internal')]
    procedure GetReport(var CreditHeaderP: Record "Credit Header")
    var
        GLEntryL: Record "G/L Entry";
        AccountingSheetsL: Report "DPG Accounting Sheets";
    begin
        WITH CreditHeaderP DO BEGIN
            //PostedCreditHeader.SETRECFILTER;
            GLEntryL.SETRANGE("Document No.", CreditHeaderP."No.");
            AccountingSheetsL.SETTABLEVIEW(GLEntryL);
            AccountingSheetsL.USEREQUESTPAGE(FALSE);
            AccountingSheetsL.RUNMODAL;
            //PrintReport(CreditReportSelections.Usage::"Posted Credit");
        END;
    end;

    /*
    local procedure PrintReport(ReportUsage: Integer)
    begin
        CreditReportSelections.RESET;
        CreditReportSelections.SETRANGE(Usage, ReportUsage);
        REPEAT
            CreditReportSelections.TESTFIELD("Report ID");
            CASE ReportUsage OF
                CreditReportSelections.Usage::"Posted Credit":
                    REPORT.RUN(CreditReportSelections."Report ID", FALSE, FALSE, PostedCreditHeader);
            END;
        UNTIL CreditReportSelections.NEXT = 0;
    end;
    */
}


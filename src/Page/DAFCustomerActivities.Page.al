page 80013 "DPG DAF Customer Activities"
{
    // // @ Area Vehicle
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // ---- DAF ----
    // 
    // 22.5.2020 FJC - new page

    Caption = 'Customer Activities';
    PageType = CardPart;
    SourceTable = "DPG DAF Truck Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup(Control1119432000)
            {
                ShowCaption = false;
                field("Customers with credit limit"; "Customers with credit limit")
                {
                }
                field("Customers with GDPR approved"; "Customers with GDPR approved")
                {
                }
                field("Customers with expired GDPR"; "Customers with expired GDPR")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRefL: RecordRef;
                begin
                    // Start EU.0004372
                    CueRecordRefL.GETTABLE(Rec);
                    CueSetupG.OpenCustomizePageForCurrentUser(CueRecordRefL.NUMBER);
                    // Stop EU.0004372
                end;
            }
            action(Action1119432002)
            {
                Caption = 'Change View...';
                Image = EditFilter;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Salesperson/Purchaser,Service Advisor,Location,Branch,Department,Make
                    IF RTCMgmtG.ChangeView(PAGE::"DPG DAF Truck Sales Activities", FALSE, FALSE, TRUE, FALSE, FALSE, FALSE,
                       FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
                       FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
                       FALSE)
                    THEN
                        ApplyFilters();
                end;
            }
            action(Action1119432003)
            {
                Caption = 'Restore Default View';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RTCMgmtG.RestoreDefaultView(PAGE::"DPG DAF Truck Sales Activities");
                    ApplyFilters();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Start PA033019
        ExitPointUnitG.ResetLevel();
        // Stop PA033019

        IF NOT GET THEN
            INSERT;
        ApplyFilters();
    end;

    var
        CueSetupG: Codeunit "Cue Setup";
        RTCMgmtG: Codeunit "RTC Management";
        ExitPointUnitG: Codeunit "Exit Point Unit";

    [Scope('Internal')]
    procedure ApplyFilters()
    begin
        RTCMgmtG.ResetRTCView();
        SETFILTER("Location Filter", RTCMgmtG.GetRCFilters(PAGE::"DPG DAF Truck Sales Activities", 3));
    end;
}


page 80012 "DPG DAF Case Activities"
{
    // // @ Area RelationshipManagement
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA038391   28.08.15 SR New Object
    // PA038391   15.09.15 LR 45061 Deleted the GridLayout
    // PA038391   21.09.15 UX 45532 Make visible/invisible the field "Allow Case Creation" depending of "User Setup".
    // PA038391   28.09.15 UX 45531 Call to a temporary Table for New Case in Activities.
    // PA038391   28.09.15 LR 45830 Correct display this page. Correct the amounts. Correct the filters
    // PA038392   26.10.15 LR 47757 Multiply the value by 100
    // PA038392   27.10.15 LR 48022 Update the page correctly
    // PA037937   30.11.15 CH 50476 incadoc corrections.
    // PA042019   02.11.16 GI Added Category 5 Code.
    // PA041187   09.03.17 UX 89020 Correct the call including a missed parameter CaseCat5CodeVisibleP "Case 5 Filter".
    // EU.0004372 17.08.17 GL Action "Set Up Cues" added.
    // --- 7.2.0 ---
    // EU.0010168 17.10.18 LL Added paramter for "Customer Waiting Line Bar" to FALSE
    // EU.0021021 18.10.18 LL Downmerge 10168 from 730
    // EU.0047698 10.12.18 KK Merge of Feature 21021

    Caption = 'Case Activities';
    Description = 'PA038391,PA038392.48022';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "DPG DAF Case Cue";

    layout
    {
        area(content)
        {
            cuegroup("Moje případy")
            {
                Caption = 'My Cases';
                field("Not Assigned"; "Not Assigned")
                {
                }
                field(Open; Open)
                {
                }
                field(Escalated; Escalated)
                {
                }
                field(Closed; Closed)
                {
                }

                actions
                {
                    action("Nový případ")
                    {
                        Caption = 'New Case';
                        Visible = NewCaseVisibleG;

                        trigger OnAction()
                        var
                            TempCaseL: Record "Case" temporary;
                        begin
                            // @ This function is used to create a case from the case buffer worksheet
                            // Start PA038391.45531
                            TempCaseL.DELETEALL;
                            TempCaseL.INIT;
                            TempCaseL."Date of Creation" := TODAY;

                            TempCaseL.INSERT;
                            COMMIT;
                            PAGE.RUNMODAL(PAGE::"Create Case", TempCaseL);
                            // Stop PA038391.45531
                        end;
                    }
                    action("Vyhledávání adresy")
                    {
                        Caption = 'Address Search';
                        RunObject = Page "Address Search";
                    }
                }
            }
            fixed(Statistika)
            {
                Caption = 'Statistics';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                group(Control1000000011)
                {
                    ShowCaption = false;
                    field(CalculatePercClosedFld; CalculatePercClosed)
                    {
                        Caption = '% Closed';
                        DecimalPlaces = 0 : 0;
                        Description = 'PA038391.45830';
                    }
                    field(CalculateAverageFld; CalculateAverage)
                    {
                        Caption = 'Turn Around Time (days)';
                        DecimalPlaces = 0 : 0;
                        Description = 'PA038391.45830';
                    }
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
            action("Změnit pohled")
            {
                Caption = 'Change View';
                Image = EditFilter;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    // Start PA038391
                    // Start PA041187.89020
                    IF RTCMgmtG.ChangeView(PAGE::"Case Activities", FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE,
                    // Start EU.0010168
                       FALSE)
                    // Stop EU.0010168
                     THEN
                        // Stop PA041187.89020
                        ApplyFilters();
                end;
            }
            action("Obnovit výchozí pohled")
            {
                Caption = 'Restore Default View';
                Image = ReOpen;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    RTCMgmtG.RestoreDefaultView(PAGE::"Case Activities");
                    ApplyFilters();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Start PA038391.45532
        NewCaseVisibleG := UserSetupG."Allow Case Creation";
        // Stop PA038391.45532
    end;

    trigger OnOpenPage()
    begin
        // Start PA038391.45532
        UserSetupG.GET(USERID);
        NewCaseVisibleG := UserSetupG."Allow Case Creation";
        // Stop PA038391.45532
        // Start PA038391.45830
        IF NOT GET THEN
            INSERT;
        ApplyFilters();
        CalculateAverage();
        // Stop PA038391.45830
    end;

    var
        UserSetupG: Record "User Setup";
        CueSetupG: Codeunit "Cue Setup";
        RTCMgmtG: Codeunit "RTC Management";
        NewCaseVisibleG: Boolean;
        TotalDaysG: Integer;
        TotalNumberofCasesG: Integer;

    [Scope('Internal')]
    procedure ApplyFilters()
    begin
        // @ Applies various filters to source record based on the role center setup.
        RTCMgmtG.ResetRTCView();
        SETFILTER("Date Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 13));
        // Start PA038391.45830
        SETFILTER("Owner Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 14));
        SETFILTER("Case Type Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 15));
        SETFILTER("Case Source Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 16));
        SETFILTER("Case Cat. 1 Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 17));
        SETFILTER("Case Cat. 2 Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 18));
        SETFILTER("Case Cat. 3 Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 19));
        SETFILTER("Case Cat. 4 Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 20));
        // Stop PA038391.45830
        // Start PA042019
        SETFILTER("Case Cat. 5 Filter", RTCMgmtG.GetRCFilters(PAGE::"Case Activities", 21));
        // Stop PA042019
    end;

    [Scope('Internal')]
    procedure CalculateAverage(): Decimal
    var
        CaseL: Record "Case";
    begin
        // @ This function calculates the average of days for closing a case
        // @ retval - Decimal

        // Start PA038391.45830
        TotalNumberofCasesG := 0;
        TotalDaysG := 0;
        CaseL.RESET;
        // Start PA042019
        CaseL.SETCURRENTKEY(Closed, Status, "Date of Creation", "Owned By", "Case Type Code", "Case Source Code",
          "Category 1 Code", "Category 2 Code", "Category 3 Code", "Category 4 Code", "Category 5 Code");
        // Stop PA042019
        CaseL.SETRANGE(Closed, TRUE);
        CaseL.SETFILTER(Status, "Status Filter");
        CaseL.SETFILTER("Date of Creation", FORMAT("Date Filter"));
        CaseL.SETFILTER("Owned By", "Owner Filter");
        CaseL.SETFILTER("Case Type Code", "Case Type Filter");
        CaseL.SETFILTER("Case Source Code", "Case Source Filter");
        CaseL.SETFILTER("Category 1 Code", "Case Cat. 1 Filter");
        CaseL.SETFILTER("Category 2 Code", "Case Cat. 2 Filter");
        CaseL.SETFILTER("Category 3 Code", "Case Cat. 3 Filter");
        CaseL.SETFILTER("Category 4 Code", "Case Cat. 4 Filter");
        // Start PA042019
        CaseL.SETFILTER("Category 5 Code", "Case Cat. 5 Filter");
        // Stop PA042019
        IF CaseL.FINDSET THEN
            REPEAT
                TotalNumberofCasesG := TotalNumberofCasesG + 1;
                TotalDaysG := TotalDaysG + (CaseL."Date of Closing" - CaseL."Date of Creation");
            UNTIL CaseL.NEXT = 0;

        IF TotalNumberofCasesG = 0 THEN
            EXIT(0);
        EXIT(TotalDaysG / TotalNumberofCasesG);
        // Stop PA038391.45830
    end;

    [Scope('Internal')]
    procedure CalculatePercClosed(): Decimal
    begin
        // @ This fucntion calculates de % of closed Cases
        CALCFIELDS(Closed, Open);
        IF Closed + Open = 0 THEN
            EXIT(0);
        // Start PA038392.47757
        EXIT(ROUND(Closed / (Closed + Open) * 100, 1));
        // Stop PA038392.47757
    end;
}


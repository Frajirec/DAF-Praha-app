page 80018 "DPG DAF Truck Sales Stock"
{
    // // @ Area Vehicle
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA031550   09.02.10 New object
    // PA032111   12.08.10 (BRL): Object renumbering changes due to Microsoft Agreement.
    // PA031550   10.09.10 SS Added Quick Vehicle Card action
    // PA032848   17.08.11 PR No modification in the form. Checked-in only to help configuration manager to handle changed
    //                        object list in site for page transformation.
    // PA032839   03.08.11 GL New Menuitem "Anticipated/Inventory Vehicles"
    // PA032656   11.08.11 PR 4587310: Modified the form caption.
    // PA032651   20.01.12 DR 6012646: Name changed to "Available Vehicle Activities" and Caption changed to "Available Vehicles"
    // PA032651   23.01.12 DR 6012646: Show cue fields in following sequence: 1-New Vehicles , 2-Demo Vehicles , 3-Used Vehicles
    // PA032651   02.02.12 BL 6334916: Name/Caption changed to "Vehicle In Stock Activities"/"My Vehicles in Stock Activities".
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   30.05.12 GM 7460062: Function call added in OnOpenForm trigger to avoid overflow in the Exit Point Unit
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033251   16.10.12 GE 8756836: ChangeView function call modified to use 3 more parameters for IMM
    // PA034402   15.10.13 LR I002077 Use the new parameter for ChangeView function
    // PA036369   20.11.14 GL New parameters for the ChangeView function
    // PA037562   26.05.15 GK 37518 New parameters for the ChangeView function
    // PA038391   28.09.15 LR 45830 Correct the call includding the new parameters
    // PA041187   09.03.17 UX 89020 Correct the call including a missed parameter CaseCat5CodeVisibleP "Case 5 Filter".
    // EU.0004372 17.08.17 GL Action "Set Up Cues" added.
    // --- 7.2.0 ---
    // EU.0010168 17.10.18 LL Added paramter for "Customer Waiting Line Bar" to FALSE
    // EU.0021021 18.10.18 LL Downmerge 10168 from 730
    // EU.0047698 10.12.18 KK Merge of Feature 21021

    Caption = 'Truck Sales Stock';
    PageType = CardPart;
    SourceTable = "DPG DAF Truck Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup(Control1119432000)
            {
                ShowCaption = false;
                field("Vehicles Purch Stock"; "Vehicles Purch Stock")
                {
                    DrillDownPageID = "Vehicle Purch. Order List";
                }
                field("Vehicles Stock New"; "Vehicles Stock New")
                {
                    DrillDownPageID = "Vehicle List";
                }
                field("Vehicles Stock Occasion"; "Vehicles Stock Occasion")
                {
                    DrillDownPageID = "Vehicle List";
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


page 80004 "DPG Ares Update Logs" // 1057714 "Ares Update Logs"
{
    // --- NML SOL ---
    // --- DAFCZ ---
    // DAFCZ0004  11.10.21 MG DAFCZ.1 new OBJECT

    Caption = 'Ares Update Logs';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Registration Log";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Registration No."; "Registration No.")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Account Type"; "Account Type")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Account No."; "Account No.")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("User ID"; "User ID")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field(Status; Status)
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified Name"; "Verified Name")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified Address"; "Verified Address")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified City"; "Verified City")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified Post Code"; "Verified Post Code")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified VAT Registration No."; "Verified VAT Registration No.")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified Date"; "Verified Date")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified Result"; "Verified Result")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Verified Tax Registration No."; "Verified Tax Registration No.")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
                field("Up to date"; "DPG Up to Date")
                {
                    Style = Favorable;
                    StyleExpr = ActualDataG;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            /*action(ExcludedList)
            {
                Caption = 'Excluded List';
                Image = Excise;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Page50021;
            }*/
            action(OpenCard)
            {
                Caption = 'Open Card';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AresManagementG.OpenCard(Rec);
                end;
            }
            /*action(RunUpdate)
            {
                Caption = 'Run Update';
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report Report50010;
            }*/
            action(UpdateRecords)
            {
                Caption = 'Update Records';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RegistrationLogL: Record "Registration Log";
                begin
                    CurrPage.SETSELECTIONFILTER(RegistrationLogL);
                    AresManagementG.MassiveUpdate(SelectionFilterManagementG.GetSelectionFilterForVariant(RegistrationLogL, RegistrationLogL.FIELDNO("Entry No.")));
                end;
            }
            action(ExcludeCustomerVendor)
            {
                Caption = 'Exclude Customer or Vendor';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF "Account Type" = "Account Type"::Customer THEN
                        AresManagementG.ExcludeCustomerOrVendor("Account No.", DATABASE::Customer);
                    IF "Account Type" = "Account Type"::Vendor THEN
                        AresManagementG.ExcludeCustomerOrVendor("Account No.", DATABASE::Vendor);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ActualDataG := "DPG Up to Date";
    end;

    var
        ActualDataG: Boolean;
        AresManagementG: Codeunit "DPG Ares Management";
        SelectionFilterManagementG: Codeunit SelectionFilterManagement;
}


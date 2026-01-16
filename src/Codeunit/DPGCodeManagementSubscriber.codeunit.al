codeunit 1058096 "DPG Code Management Subscriber"
{
    EventSubscriberInstance = StaticAutomatic;

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SOL Code Management", 'OnGetDealerCode', '', false, false)]
    local procedure OnGetDealerCode(var DealerCodeP: Text)
    var
        SOLCodeManagementL: Codeunit "SOL Code Management";
    begin
        SOLCodeManagementL.TestEmptyDealerCode(DealerCodeP);
        DealerCodeP := 'DAF-Praha';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SOL Code Management", 'OnIsCurrencyGLEntryActive', '', false, false)]
    local procedure OnIsChangeDescrGLEntryActive(var IsActiveP: Boolean)
    begin
        IsActiveP := true;
    end;

    //NOTE: Update Document Status

    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'OnAfterValidateEvent', 'Text 6', true, true)]
    local procedure OnAfterValidateText6(var Rec: Record "Service Header"; var xRec: Record "Service Header")
    // CurrFieldNo: Integer)
    begin
        if Rec."Text 6" <> '' then begin
            Rec."Status Code" := 'ZARUKA ODESLANA';
            Rec.Modify(true);
        end;
    end;
}
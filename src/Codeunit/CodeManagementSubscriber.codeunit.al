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
}
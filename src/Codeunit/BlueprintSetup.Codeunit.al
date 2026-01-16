codeunit 80001 "DPG Blueprint Setup"
{
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1            31.10.18 RH DAFCZ.1 New object
    // MERGE_API_104_105  29.07.19 RH DAFCZ.1.01 mod EventSubscriber "OnPostBlueprintSetup", new EventSubscriber "C1057634_OnGetCustLayerRequirementCode"


    trigger OnRun()
    begin
        ERROR(C_INC_TextRunError);
    end;

    var
        C_INC_TextRunError: Label 'You must run the Report 1058099 "IncadeaCZ Blueprint Setup" for settings.';

    [EventSubscriber(ObjectType::Report, 1058099, 'OnProcessCustomizationLayer', '', false, false)]
    //local procedure OnPostBlueprintSetup(LayerCodeP: Code[10]; RequirementCodeP: Code[30]; EPCommentP: Text[100]; DeleteExistingP: Boolean; InitializeCompanyP: Boolean; ReportSelectionSetupP: Option Skip,Initialize,Overwrite)
    local procedure OnProcessCustomizationLayer(var CounterP: Integer; var IncadeaCZBlueprintSetupP: Record "IncadeaCZ Blueprint Setup")
    var
        NAVCZBlueprintSetupL: Report "IncadeaCZ Blueprint Setup";
        SpecialFunctionAssignmentL: Record "Special Function Assignment";
        OrigLangL: Integer;
        BlueprintEventHelperL: Codeunit "Blueprint & Event Helper";
        C_INC_CreatedBy: Label 'Created by DAFCZ Blueprint Setup', Locked = true;
        LayerCodeL: Code[10];
        RequirementCodeL: Code[30];
        SalesSetupL: Record "Sales & Receivables Setup";
    begin
        CounterP += 1;
        // Start MERGE_API_104_105 DAFCZ.1.01 RH
        BlueprintEventHelperL.GetCustLayerRequirementCode(LayerCodeL, RequirementCodeL);
        // Stop MERGE_API_104_105 DAFCZ.1.01 RH

        NAVCZBlueprintSetupL.LayerRequirementDeleteExisting(LayerCodeL, RequirementCodeL, IncadeaCZBlueprintSetupP."Delete Existing");
        IF IncadeaCZBlueprintSetupP."Delete Existing" THEN BEGIN
            SpecialFunctionAssignmentL.SETRANGE("Assignment Type", SpecialFunctionAssignmentL."Assignment Type"::User);
            SpecialFunctionAssignmentL.DELETEALL(FALSE);
        END;

        AddExitPointSetup(LayerCodeL, RequirementCodeL, C_INC_CreatedBy);
        OrigLangL := GLOBALLANGUAGE;
        //AddSpecialFunctionSetup(LayerCodeP,RequirementCodeP,EPCommentP);
        GLOBALLANGUAGE := OrigLangL;

        if IncadeaCZBlueprintSetupP."Base Setup" then
            if SalesSetupL.Get() then
                if SalesSetupL."VAT Country Code" = SalesSetupL."VAT Country Code"::" " then begin
                    SalesSetupL."VAT Country Code" := SalesSetupL."VAT Country Code"::"Bill-to Customer No.";
                    SalesSetupL.Modify(true);
                end;

    end;

    local procedure AddExitPointSetup(LayerCodeP: Code[10]; RequirementCodeP: Code[30]; EPCommentP: Text[100])
    var
        ExitPointSetupL: Record "Exit Point Setup";
    begin
        // Start DAFCZ.1
        //T5025624 "Service Header"
        ExitPointSetupL.AddOneEPSetupWhenMissing(
          ExitPointSetupL."Object Type"::Table, DATABASE::"Service Header", ExitPointSetupL."Trigger"::"Function", ExitPointSetupL.Type::Post, 'InitRecord', '', '', 0, TRUE,
          CODEUNIT::"DPG Event/ExitPoint Handler 2", EPCommentP, LayerCodeP, RequirementCodeP);
        // Stop DAFCZ.1
        ExitPointSetupL.AddOneEPSetupWhenMissing(
          ExitPointSetupL."Object Type"::Codeunit, Codeunit::"Make Serv. Invoice", ExitPointSetupL."Trigger"::"Function", ExitPointSetupL.Type::"Inside 2", 'InsertSalesInvLine', '', '', 0, TRUE,
          CODEUNIT::"DPG Event/ExitPoint Handler 2", EPCommentP, LayerCodeP, RequirementCodeP);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1057634, 'OnGetCustLayerRequirementCode', '', false, false)]
    local procedure C1057634_OnGetCustLayerRequirementCode(var Sender: Codeunit "Blueprint & Event Helper"; var LayerCodeP: Code[10]; var RequirementCodeP: Code[30])
    begin
        // Start MERGE_API_104_105 DAFCZ.1.01 RH
        LayerCodeP := 'DAFCZ';
        RequirementCodeP := 'NAVCZ';
        // Stop MERGE_API_104_105 DAFCZ.1.01 RH
    end;
}


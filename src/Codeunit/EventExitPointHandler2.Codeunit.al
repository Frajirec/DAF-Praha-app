codeunit 80004 "DPG Event/ExitPoint Handler 2"
{
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1    01.11.18 RH DAFCZ.1 new object, exit point and event subscribers for T5025624 "Service Header", T5025634 "Service Posting Group"
    // DAFCZ.1    11.12.18 RH DAFCZ.1.01 new fnc "C12_OnInsertGLEntryInside10"
    // 79017839   25.04.19 RH DAFCZ.1.02 new EventSubscriber "C1057616_OnSuppressDateChange"
    // 79017841   01.03.19 DV DAFCZ.1.03 Posting of service gate payment method (OTRS Ticket 79017841)
    // 79017841   21.05.19 RH DAFCZ.1.04 mod fnc "C80_OnOnRunInsideAfterPostCLE"
    // 79021056   27.05.20 RH DAFCZ.1.05 mod fnc "C80_OnOnRunInsideAfterPostCLE"
    // #20955     15.10.24 BH            mod fnc "C80_OnOnRunInsideAfterPostCLE"      

    TableNo = "Exit Point Setup";

    trigger OnRun()
    begin
        // Start DAFCZ.1
        CASE TRUE OF
            ("Object Type" = "Object Type"::Table) AND ("Object ID" = DATABASE::"Service Header"):
                BEGIN
                    EPUnitG.GetParams(RecRefG, RecRef2G, ExitPointIDG, EPParamG, FALSE);
                    T5025624_DoExitPoint(Rec);
                    EPUnitG.SetParams(RecRefG, RecRef2G, EPParamG, ExitPointIDG, FALSE);
                END;
            ("Object Type" = "Object Type"::Codeunit) AND ("Object ID" = Codeunit::"Make Serv. Invoice"):
                BEGIN
                    EPUnitG.GetParams(RecRefG, RecRef2G, ExitPointIDG, EPParamG, FALSE);
                    C5025620_DoExitPoint(Rec);
                    EPUnitG.SetParams(RecRefG, RecRef2G, EPParamG, ExitPointIDG, FALSE);
                END;
        END;
        // Stop DAFCZ.1
    end;

    var
        EPParamG: Record "Exit Point Parameter";
        EPUnitG: Codeunit "Exit Point Unit";
        RecRefG: RecordRef;
        RecRef2G: RecordRef;
        ExitPointIDG: Text[30];

    local procedure T5025624_DoExitPoint(var Rec: Record "Exit Point Setup")
    begin
        // Start DAFCZ.1
        CASE TRUE OF
            (Rec."Trigger" = Rec."Trigger"::"Function") AND (Rec.Type = Rec.Type::Post) AND (Rec."Exit Point ID" = 'InitRecord'):
                T5025624_OnPostInitRecord;
        END;
        // Stop DAFCZ.1
    end;

    local procedure C5025620_DoExitPoint(var Rec: Record "Exit Point Setup")
    begin
        CASE TRUE OF
            (Rec."Trigger" = Rec."Trigger"::"Function") AND (Rec.Type = Rec.Type::"Inside 2") AND (Rec."Exit Point ID" = 'InsertSalesInvLine'):
                C5025620_OnInsertSalesInvLineInside2();
        END;
    end;

    local procedure T5025624_OnPostInitRecord()
    var
        ServiceHeaderL: Record "Service Header";
    begin
        // Start DAFCZ.1
        RecRefG.SETTABLE(ServiceHeaderL);
        IF T5025624_SetServicePostingGroup(ServiceHeaderL."Bill-to Customer No.", ServiceHeaderL, ServiceHeaderL."Service Posting Group") THEN
            ServiceHeaderL.VALIDATE("Service Posting Group");
        RecRefG.GETTABLE(ServiceHeaderL);
        // Stop DAFCZ.1
    end;

    local procedure C5025620_OnInsertSalesInvLineInside2()
    var
        SalesLineL: Record "Sales Line";
    begin
        RecRefG.SetTable(SalesLineL);
        if (SalesLineL."System-Created Entry") then begin
            SalesLineL."System-Created Entry" := false;
            SalesLineL.Validate("Prepayment %", 100);
        end;
        RecRefG.GetTable(SalesLineL);
    end;

    [EventSubscriber(ObjectType::Table, 5025624, 'OnAfterValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure T5025624_OnAfterValidateBillToCustomerNo(var Rec: Record "Service Header"; var xRec: Record "Service Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ.1
        IF T5025624_SetServicePostingGroup(Rec."Bill-to Customer No.", Rec, Rec."Service Posting Group") THEN
            Rec.VALIDATE("Service Posting Group");
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 5025624, 'OnAfterValidateEvent', 'VIN', false, false)]
    local procedure T5025624_OnAfterValidateVIN(var Rec: Record "Service Header"; var xRec: Record "Service Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ.1
        IF T5025624_SetServicePostingGroup(Rec."Bill-to Customer No.", Rec, Rec."Service Posting Group") THEN
            Rec.VALIDATE("Service Posting Group");
        // Stop DAFCZ.1
    end;

    local procedure T5025624_SetServicePostingGroup(CustNoP: Code[20]; var ServiceHeaderP: Record "Service Header"; var ServPostGrpP: Code[10]): Boolean
    var
        ServicePostingGroupL: Record "Service Posting Group";
        NameValueBufferTmpL: Record "Name/Value Buffer" temporary;
        i: Integer;
    begin
        // Start DAFCZ.1
        IF (ServiceHeaderP."Document Type" <> ServiceHeaderP."Document Type"::Order) OR (CustNoP = '') OR (ServiceHeaderP."Model No." = '') THEN
            EXIT(FALSE);
        ServicePostingGroupL.SETRANGE("DPG Customer No.", CustNoP);
        ServicePostingGroupL.SETFILTER("DPG Model No. Filter", '<>''''');
        IF ServiceHeaderP."Make Code" <> '' THEN
            ServicePostingGroupL.SETFILTER("Make Code", '''''|%1', ServiceHeaderP."Make Code");
        IF ServiceHeaderP."Branch Code" <> '' THEN
            ServicePostingGroupL.SETFILTER("Branch Code", '''''|%1', ServiceHeaderP."Branch Code");
        FOR i := 1 TO 2 DO BEGIN
            IF ServiceHeaderP."Service Posting Group" = '' THEN BEGIN
                IF i > 1 THEN
                    EXIT(FALSE);
            END ELSE
                IF i = 1 THEN
                    ServicePostingGroupL.SETRANGE(Code, ServiceHeaderP."Service Posting Group")
                ELSE
                    ServicePostingGroupL.SETFILTER(Code, '<>%1', ServiceHeaderP."Service Posting Group");
            IF ServicePostingGroupL.FINDSET THEN BEGIN
                NameValueBufferTmpL.ID := 1;
                NameValueBufferTmpL.Name := UPPERCASE(COPYSTR(ServiceHeaderP."Model No.", 1, 2));
                NameValueBufferTmpL.INSERT;
                REPEAT
                    NameValueBufferTmpL.SETFILTER(Name, UPPERCASE(ServicePostingGroupL."DPG Model No. Filter"));
                    IF NOT NameValueBufferTmpL.ISEMPTY THEN BEGIN
                        ServPostGrpP := ServicePostingGroupL.Code;
                        EXIT(TRUE);
                    END;
                UNTIL ServicePostingGroupL.NEXT = 0;
            END;
        END;
        EXIT(FALSE);
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 5025634, 'OnPreLookupServPostingGrp', '', false, false)]
    local procedure T5025634_OnPreLookupServPostingGrp(var Sender: Record "Service Posting Group"; var DiscontinuedP: Boolean; var ServPostGrpFoundP: Boolean; CustP: Code[20]; ServHdrP: Record "Service Header"; var ServPostGrpP: Code[10])
    begin
        // Start DAFCZ.1
        IF DiscontinuedP THEN
            EXIT;
        IF T5025624_SetServicePostingGroup(CustP, ServHdrP, ServPostGrpP) THEN BEGIN
            DiscontinuedP := TRUE;
            ServPostGrpFoundP := TRUE;
        END;
        // Stop DAFCZ.1
    end;

    /* přesunuto do produktu
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnInsertGLEntryInside10', '', false, false)]
    local procedure C12_OnInsertGLEntryInside10(var GLEntryP: Record "G/L Entry"; var GenJnlLineP: Record "Gen. Journal Line")
    var
        CurrFactorL: Decimal;
        CurrencyL: Record Currency;
    begin
        // Start DAFCZ.1.01
        IF (GenJnlLineP."Currency Code" <> '') OR (GenJnlLineP."Source Currency Code" = '') THEN BEGIN
            IF (GenJnlLineP."Currency Code" = '') OR (GenJnlLineP."Currency Factor" = 0) THEN BEGIN
                GLEntryP."Currency Code" := '';
                GLEntryP."Amount (Currency)" := GLEntryP.Amount;
            END ELSE BEGIN
                GLEntryP."Currency Code" := GenJnlLineP."Currency Code";
                IF GLEntryP.Amount = GenJnlLineP."Amount (LCY)" THEN
                    GLEntryP."Amount (Currency)" := GenJnlLineP.Amount
                ELSE BEGIN
                    CurrencyL.GET(GenJnlLineP."Source Currency Code");
                    CurrencyL.TESTFIELD("Amount Rounding Precision");
                    GLEntryP."Amount (Currency)" := ROUND(GLEntryP.Amount * GenJnlLineP."Currency Factor", CurrencyL."Amount Rounding Precision", '=');
                END;
            END;
        END ELSE
            IF (GLEntryP.Amount = GenJnlLineP.Amount) AND (GenJnlLineP."Source Currency Amount" <> 0) THEN BEGIN
                GLEntryP."Currency Code" := GenJnlLineP."Source Currency Code";
                GLEntryP."Amount (Currency)" := GenJnlLineP."Source Currency Amount";
            END ELSE
                IF (GLEntryP.Amount = GenJnlLineP."VAT Amount") AND (GenJnlLineP."Source Curr. VAT Amount" <> 0) THEN BEGIN
                    GLEntryP."Currency Code" := GenJnlLineP."Source Currency Code";
                    GLEntryP."Amount (Currency)" := GenJnlLineP."Source Curr. VAT Amount";
                END ELSE
                    IF (GLEntryP.Amount = GenJnlLineP."VAT Base Amount") AND (GenJnlLineP."Source Curr. VAT Base Amount" <> 0) THEN BEGIN
                        GLEntryP."Currency Code" := GenJnlLineP."Source Currency Code";
                        GLEntryP."Amount (Currency)" := GenJnlLineP."Source Curr. VAT Base Amount";
                    END ELSE BEGIN
                        CurrFactorL := 0;
                        IF (CurrFactorL = 0) AND (GenJnlLineP."Source Currency Amount" <> 0) THEN
                            CurrFactorL := GenJnlLineP.Amount / GenJnlLineP."Source Currency Amount";
                        IF (CurrFactorL = 0) AND (GenJnlLineP."Source Curr. VAT Amount" <> 0) THEN
                            CurrFactorL := GenJnlLineP."VAT Amount" / GenJnlLineP."Source Curr. VAT Amount";
                        IF (CurrFactorL = 0) AND (GenJnlLineP."Source Curr. VAT Base Amount" <> 0) THEN
                            CurrFactorL := GenJnlLineP."VAT Base Amount" / GenJnlLineP."Source Curr. VAT Base Amount";
                        IF CurrFactorL = 0 THEN BEGIN
                            GLEntryP."Currency Code" := GenJnlLineP."Currency Code";
                            GLEntryP."Amount (Currency)" := GenJnlLineP.Amount;
                        END ELSE BEGIN
                            CurrencyL.GET(GenJnlLineP."Source Currency Code");
                            CurrencyL.TESTFIELD("Amount Rounding Precision");
                            GLEntryP."Currency Code" := GenJnlLineP."Source Currency Code";
                            GLEntryP."Amount (Currency)" := ROUND(GLEntryP.Amount / CurrFactorL, CurrencyL."Amount Rounding Precision", '=');
                        END;
                    END;
        // Stop DAFCZ.1.01
    end;
    */

    [EventSubscriber(ObjectType::Codeunit, 1057616, 'OnSuppressDateChange', '', false, false)]
    local procedure C1057616_OnSuppressDateChange(var SuppressDateChangeP: Boolean; var SalesHeaderP: Record "Sales Header")
    begin
        // Start 79017839 DAFCZ.1.02
        IF SuppressDateChangeP THEN
            EXIT;
        SuppressDateChangeP := (SalesHeaderP."Document Type" = SalesHeaderP."Document Type"::Invoice);
        // Stop 79017839 DAFCZ.1.02
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostCustomerEntry', '', false, false)]
    local procedure C80_OnOnRunInsideAfterPostCLE(var GenJnlLine: Record "Gen. Journal Line"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        DAFNMLSetupL: Record "DAF IML Setup";
        GenJournalLineL: Record "Gen. Journal Line";
        CustomerL: Record Customer;
        RebillingSetupL: Record "DPG Rebilling Setup";
    begin
        // Start 79017841 DAFCZ.1.03
        // Start 79021056 RH DAFCZ.1.05
        //IF (DAFNMLSetupL.GET) THEN BEGIN
        //  IF (DAFNMLSetupL."Enable Service Gate") AND (GenJournalLineP."Payment Method Code" = DAFNMLSetupL."SGate Payment Method Code") THEN BEGIN
        //    DAFNMLSetupL.TESTFIELD("Service Gate Customer");
        //    DAFNMLSetupL.TESTFIELD("Paym.MethodCode of SGate Cust.");
        IF RebillingSetupL.GET(GenJnlLine."Payment Method Code") THEN BEGIN
            RebillingSetupL.TESTFIELD("Rebilling Customer No.");
            RebillingSetupL.TESTFIELD("Rebilling Payment Method Code");

            IF GenJnlLine."Account No." <> RebillingSetupL."Rebilling Customer No." THEN BEGIN
                // Stop 79021056 RH DAFCZ.1.05
                GenJournalLineL.INIT;
                GenJournalLineL.VALIDATE("Posting Date", GenJnlLine."Posting Date");
                GenJournalLineL."Document Type" := GenJournalLineL."Document Type"::" ";
                GenJournalLineL."Document No." := GenJnlLine."Document No.";
                GenJournalLineL."Account Type" := GenJournalLineL."Account Type"::Customer;
                GenJournalLineL.VALIDATE("Account No.", GenJnlLine."Account No.");
                // Start 79021056 RH DAFCZ.1.05
                //    GenJournalLineL.VALIDATE("Payment Method Code",DAFNMLSetupL."Paym.MethodCode of SGate Cust.");
                GenJournalLineL.VALIDATE("Payment Method Code", RebillingSetupL."Rebilling Payment Method Code");
                // Stop 79021056 RH DAFCZ.1.05
                GenJournalLineL.VALIDATE("Currency Code", GenJnlLine."Currency Code");
                GenJournalLineL.VALIDATE(Amount, GenJnlLine.Amount * -1);
                GenJournalLineL.VALIDATE("Applies-to Doc. Type", GenJnlLine."Document Type");
                GenJournalLineL.VALIDATE("Applies-to Doc. No.", GenJnlLine."Document No.");
                GenJournalLineL.VALIDATE("Branch Code", GenJnlLine."Branch Code");
                GenJnlPostLine.RunWithCheck(GenJournalLineL);

                CLEAR(GenJournalLineL);
                GenJournalLineL.VALIDATE("Posting Date", GenJnlLine."Posting Date");
                GenJournalLineL."Document Type" := GenJournalLineL."Document Type"::" ";
                GenJournalLineL."Document No." := GenJnlLine."Document No.";
                GenJournalLineL."Account Type" := GenJournalLineL."Account Type"::Customer;
                // Start 79021056 RH DAFCZ.1.05
                //    GenJournalLineL.VALIDATE("Account No.",DAFNMLSetupL."Service Gate Customer");
                //    GenJournalLineL.VALIDATE("Payment Method Code",DAFNMLSetupL."Paym.MethodCode of SGate Cust.");
                GenJournalLineL.VALIDATE("Account No.", RebillingSetupL."Rebilling Customer No.");
                GenJournalLineL.VALIDATE("Payment Method Code", RebillingSetupL."Rebilling Payment Method Code");
                // Stop 79021056 RH DAFCZ.1.05
                // Start #20955  15.10.24 BH 
                GenJournalLineL.VALIDATE("Due Date", GenJnlLine."Due Date");
                // Stop #20955  15.10.24 BH
                GenJournalLineL.VALIDATE("Currency Code", GenJnlLine."Currency Code");
                GenJournalLineL.VALIDATE(Amount, GenJnlLine.Amount);
                GenJournalLineL.VALIDATE("Branch Code", GenJnlLine."Branch Code");
                // Start 79017841 DAFCZ.1.04
                CustomerL.GET(GenJnlLine."Account No.");
                GenJournalLineL.VALIDATE(Description, COPYSTR(STRSUBSTNO('%1 (%2)', CustomerL.Name, CustomerL."No."), 1, MAXSTRLEN(GenJournalLineL.Description)));
                // Stop 79017841 DAFCZ.1.04
                GenJnlPostLine.RunWithCheck(GenJournalLineL);
            END;
        END;
        // Stop 79017841 DAFCZ.1.03
    end;

    [EventSubscriber(ObjectType::Codeunit, 1057603 /* ET17,21,25,254 */, 'T17_OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure C1057603_T17_OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."DPG Description 2" := GenJournalLine."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, 1057603 /* ET17,21,25,254 */, 'T21_OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure C1057603_T21_OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."DPG Description 2" := GenJournalLine."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, 1057603 /* ET17,21,25,254 */, 'T25_OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure C1057603_T25_OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."DPG Description 2" := GenJournalLine."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnSetupNewLineOnBeforeIncrementDocumentNo', '', false, false)]
    local procedure T81_OnSetupNewLineOnBeforeIncrementDocumentNo(var HandledP: Boolean)
    begin
        HandledP := true;
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Header", 'OnValidatePostingDateInside1', '', false, false)]
    local procedure T38_OnValidatePostingDateInside1(var Sender: Record "Purchase Header")
    begin
        if Sender."Document Date" <> Sender."Posting Date" then
            Sender.Validate("Document Date", Sender."Posting Date");
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure T271_OnAfterCopyFromGenJnlLine(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."DPG Description 2" := GenJournalLine."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Check Ledger Entry", 'OnAfterCopyFromBankAccLedgEntry', '', false, false)]
    local procedure T272_OnAfterCopyFromBankAccLedgEntry(var CheckLedgerEntry: Record "Check Ledger Entry"; BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        BankAccountLedgerEntry."DPG Description 2" := BankAccountLedgerEntry."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Bank Acc. Reconciliation Line", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure T274_OnAfterValidateAccountNo(var Rec: Record "Bank Acc. Reconciliation Line"; var xRec: Record "Bank Acc. Reconciliation Line"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        if Rec."Account No." <> '' then
            CASE Rec."Account Type" OF
                Rec."Account Type"::Customer:
                    begin
                        Customer.GET(Rec."Account No.");
                        Rec.Description := Customer.Name;
                    end;
                Rec."Account Type"::Vendor:
                    begin
                        Vendor.GET(Rec."Account No.");
                        Rec.Description := Vendor.Name;
                    end;
            end;
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Bank Acc. Reconciliation Line", 'OnAfterValidateEvent', 'Transaction Text', false, false)]
    local procedure T274_OnAfterValidateTransactionText(var Rec: Record "Bank Acc. Reconciliation Line"; var xRec: Record "Bank Acc. Reconciliation Line"; CurrFieldNo: Integer)
    begin
        if Rec.Description = '' then
            Rec.Description := COPYSTR(Rec."Transaction Text", 1, MAXSTRLEN(Rec.Description));
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Resource", 'OnAfterInsertEvent', '', false, false)]
    local procedure T156_OnAfterInsert(var Rec: Record "Resource"; RunTrigger: Boolean)
    begin
        Rec."Absences In" := Rec."Absences In"::Hours;
        Rec.Modify(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnApplyCustPrepmtRefundsOnBeforePosting', '', false, false)]
    local procedure C12_OnApplyCustPrepmtRefundsOnBeforePosting(var GenJnlLineApplyP: Record "Gen. Journal Line"; var CustLedgEntryForApplyP: Record "Cust. Ledger Entry")
    begin
        GenJnlLineApplyP."DPG Description 2" := CustLedgEntryForApplyP."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnApplyVendPrepmtRefundsOnBeforePosting', '', false, false)]
    local procedure C12_OnApplyVendPrepmtRefundsOnBeforePosting(var GenJnlLineApplyP: Record "Gen. Journal Line"; var VendLedgEntryForApplyP: Record "Vendor Ledger Entry")
    begin
        GenJnlLineApplyP."DPG Description 2" := VendLedgEntryForApplyP."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", 'OnPostPaymentApplicationsOnAfterInitGenJnlLine', '', false, false)]
    local procedure C370_OnPostPaymentApplicationsOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    begin
        GenJournalLine."DPG Description 2" := BankAccReconciliationLine."DPG Description 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Adjustment", 'OnAllowSetItemLedgEntryPostingDate', '', false, false)]
    local procedure C5895_OnAllowSetItemLedgEntryPostingDate(var ItemJnlLineP: Record "Item Journal Line"; var OrigValueEntryP: Record "Value Entry"; LedgEntryPostingDateP: Date; FunctionP: Text; var AllowedP: Boolean)
    begin
        AllowedP := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ET36,37", 'T36_OnValidateBilltoCustomerNoInside1OnBeforeSetPrepaymentProc', '', false, false)]
    local procedure C5895_T36_OnValidateBilltoCustomerNoInside1OnBeforeSetPrepaymentProc(var SalesHeaderP: Record "Sales Header"; var CustomerP: Record Customer; var HandledP: Boolean)
    begin
        HandledP := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Master Records", 'OnCreateItemFromMasterOnBeforeModifyItem', '', false, false)]
    local procedure C5029100_OnCreateItemFromMasterOnBeforeModifyItem(var ItemMasterP: Record "Item Master"; var ItemP: Record Item; var ItemMasterAddtlItemP: Record "Item Master Additional Item")
    begin
        ItemP."No Inventory Tracking" := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Master Records", 'OnCreateDepositItemOnBeforeInsertItem', '', false, false)]
    local procedure C5029100_OnCreateDepositItemOnBeforeInsertItem(var DepositItemP: Record Item; var ItemMasterP: Record "Item Master")
    begin
        DepositItemP."No Inventory Tracking" := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Master Records", 'OnCreateDepositItemOnBeforeModifyItem', '', false, false)]
    local procedure C5029100_OnCreateDepositItemOnBeforeModifyItem(var DepositItemP: Record Item; var ItemMasterP: Record "Item Master")
    begin
        DepositItemP."No Inventory Tracking" := false;
    end;
}


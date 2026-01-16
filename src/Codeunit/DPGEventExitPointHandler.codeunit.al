codeunit 80003 "DPG Event/ExitPoint Handler"
{
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1    24.10.18 DV DAFCZ.1 New object
    // DAFCZ.1    31.10.18 RH DAFCZ.1 new EventSubscriber "R11700_OnBeforeInsertPaymentOrderLine"
    // DAFCZ.1    01.11.18 RH DAFCZ.1 new fncs "TestUserCanChangePaymentMethod", "IsCashPayment", "CheckPaymentOnDocumentHeader", "T18_OnBeforeValidatePaymentMethodCode", "T36_OnBeforeValidatePaymentMethodCode",
    //                               "T289_OnBeforeValidateCashPayment", "T5025624_OnBeforeValidatePaymentMethodCode" (Do not allow users to change Cash payment method),
    //                               "T5025422_OnAfterInsertEvent"
    // DAFCZ.1    27.02.19 LC DAFCZ.1 "VAT Country Code" returned xRec Value after validation "Ship-to Country Code" (new fnc "T36_OnAfterValidateEventShipToCountryCode")
    // DAFCZ.1.01 25.05.21 RH DAFCZ.1.01 new EventSubscribers "T36_OnAfterInsert", "T36_OnAfterModify" - temporary 'debugging' modification only
    // DAFCZ0003  25.05.21 RH DAFCZ.1.01 new EventSubscribers "T38_OnAfterValidatePayToVendorNo", "T38_OnAfterValidatePayToContactNo", "T38_OnAfterValidatePerformCountryRegionCode"
    //                                   new fnc "UpdateRegistrationNos"
    //FJC         30.07.25 FJC          adjusted functionality to properly generate bank account with prefix out of IBAN 
    //                                  new function update/create Customer bank account
    //                                  added permissions for TableDate 287   
    //FJC         1.10.25 FJC           added function to create IBAN from bank account for CZ Customers and Vendors.       
    //FJC        21.10.25 FJC           added logic for BIC based on table BIC Codes

    Permissions = TableData "Vendor Bank Account" = ri,
                  TableData "Customer Bank Account" = ri;
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 11760, 'OnAfterInsertEvent', '', true, true)]
    local procedure T11760_OnAfterInsertEvent(var Rec: Record "Uncertainty Payer Entry"; RunTrigger: Boolean)
    begin
        IF Rec."Entry Type" = Rec."Entry Type"::"Bank Account" THEN
            CreateOrUpdateBankAccount(Rec."Vendor No.", Rec."VAT Registration No.", Rec."Full Bank Account No.");
        IF Rec."Entry Type" = Rec."Entry Type"::"Bank Account" THEN
            CreateOrUpdateCustomerBankAccount(Rec."Customer No.", Rec."VAT Registration No.", Rec."Full Bank Account No.");
    end;

    [EventSubscriber(ObjectType::Table, 11760, 'OnAfterModifyEvent', '', true, true)]
    local procedure T11760_OnAfterModifyEvent(var Rec: Record "Uncertainty Payer Entry"; var xRec: Record "Uncertainty Payer Entry"; RunTrigger: Boolean)
    begin
        IF Rec."Entry Type" = Rec."Entry Type"::"Bank Account" THEN
            CreateOrUpdateBankAccount(Rec."Vendor No.", Rec."VAT Registration No.", Rec."Full Bank Account No.");
        IF Rec."Entry Type" = Rec."Entry Type"::"Bank Account" THEN
            CreateOrUpdateCustomerBankAccount(Rec."Customer No.", Rec."VAT Registration No.", Rec."Full Bank Account No.");
    end;

    local procedure CreateOrUpdateBankAccount(VendorNoP: Code[20]; VATRegistrationNoP: Code[20]; FullBankAccountNoP: Code[50])
    var
        VendorBankAccountL: Record "Vendor Bank Account";
        BankBranchNoL: Code[50];
        BankAccountNoL: Code[50];
        IBANL: Code[50];
        BankPrefixL: Code[50];
        BankAccountCodeL: Code[10];
        VendorL: Record Vendor;
        FullBankAccountFormatted: Code[100];
    begin
        IF VATRegistrationNoP = '' THEN EXIT;
        DecodeBankAccFJC(FullBankAccountNoP, BankBranchNoL, BankAccountNoL, IBANL, BankPrefixL);

        // FJC 1.10.25 start
        // Calculate IBAN if empty
        IF IBANL = '' THEN
            IBANL := CalculateIBAN(BankPrefixL, BankBranchNoL, BankAccountNoL);
        // FJC 1.10.25 stop 
        IF BankPrefixL <> '' THEN
            FullBankAccountFormatted := BankPrefixL + '-' + BankAccountNoL + '/' + BankBranchNoL
        ELSE
            FullBankAccountFormatted := BankAccountNoL + '/' + BankBranchNoL;

        IF VendorNoP <> '' THEN
            VendorL.SETRANGE("No.", VendorNoP)
        ELSE
            VendorL.SETRANGE("VAT Registration No.", VATRegistrationNoP);

        IF VendorL.FINDSET THEN
            REPEAT
                IF BankBranchNoL <> '' THEN BEGIN
                    BankAccountCodeL := GetBankAccountCode(VendorNoP, BankBranchNoL, FullBankAccountFormatted);
                    VendorBankAccountL.INIT;
                    VendorBankAccountL."Vendor No." := VendorL."No.";
                    VendorBankAccountL.Code := BankAccountCodeL;
                    VendorBankAccountL."Bank Branch No." := BankBranchNoL;
                    VendorBankAccountL."Bank Account No." := FullBankAccountFormatted;
                    VendorBankAccountL.IBAN := IBANL;
                    IF NOT VendorBankAccountL.INSERT(TRUE) THEN;
                END;
            UNTIL VendorL.NEXT = 0;
    end;

    local procedure CreateOrUpdateCustomerBankAccount(CustomerNoP: Code[20]; VATRegistrationNoP: Code[20]; FullBankAccountNoP: Code[50])
    var
        CustomerBankAccountL: Record "Customer Bank Account";
        BankBranchNoL: Code[50];
        BankAccountNoL: Code[50];
        IBANL: Code[50];
        BankPrefixL: Code[50];
        BankAccountCodeL: Code[10];
        CustomerL: Record Customer;
        FullBankAccountFormatted: Code[100];
        //FJC 21.10.25 start   
        BICL: Code[11];
    //FJC 21.10.25 stop
    begin
        IF VATRegistrationNoP = '' THEN EXIT;

        DecodeBankAccFJC(FullBankAccountNoP, BankBranchNoL, BankAccountNoL, IBANL, BankPrefixL);
        // FJC 1.10.25 start
        // Calculate IBAN if empty
        IF IBANL = '' THEN
            IBANL := CalculateIBAN(BankPrefixL, BankBranchNoL, BankAccountNoL);
        // FJC 1.10.25 stop
        //FJC 21.10.25 start        
        BICL := GetBIC(BankBranchNoL);
        //FJC 21.10.25 stop
        IF BankPrefixL <> '' THEN
            FullBankAccountFormatted := BankPrefixL + '-' + BankAccountNoL + '/' + BankBranchNoL
        ELSE
            FullBankAccountFormatted := BankAccountNoL + '/' + BankBranchNoL;

        IF CustomerNoP <> '' THEN
            CustomerL.SETRANGE("No.", CustomerNoP)
        ELSE
            CustomerL.SETRANGE("VAT Registration No.", VATRegistrationNoP);

        IF CustomerL.FINDSET THEN
            REPEAT
                IF BankBranchNoL <> '' THEN BEGIN
                    BankAccountCodeL := GetCustomerBankAccountCode(CustomerNoP, BankBranchNoL, FullBankAccountFormatted);
                    CustomerBankAccountL.INIT;
                    CustomerBankAccountL."Customer No." := CustomerL."No.";
                    CustomerBankAccountL.Code := BankAccountCodeL;
                    CustomerBankAccountL."Bank Branch No." := BankBranchNoL;
                    CustomerBankAccountL."Bank Account No." := FullBankAccountFormatted;
                    CustomerBankAccountL.IBAN := IBANL;
                    //FJC 21.10.25 start 
                    CustomerBankAccountL."SWIFT-BIC" := BICL;
                    //FJC 21.10.25 stop
                    IF NOT CustomerBankAccountL.INSERT(TRUE) THEN;
                END;
            UNTIL CustomerL.NEXT = 0;
    end;

    [Scope('Internal')]

    //FJC 6.10.2025 start


    local procedure GetBIC(BankBranchNo: Code[50]): Code[11]
    var
        BankBranchBIC: Record "DAF BIC Codes";
    begin
        if BankBranchBIC.Get(BankBranchNo) then
            exit(BankBranchBIC.BIC)
        else
            exit(''); // Or default, or error handling
    end;
    //FJC 21.10.2025 stop
    //FJC 6.10.2025 start
    local procedure DecodeBankAccFJC(FullBankAccountNo: Code[50]; var BankBranchNo: Code[50]; var BankAccountNo: Code[50]; var IBAN: Code[50]; var BankPrefix: Code[50])
    var
        SlashPos: Integer;
        DashPos: Integer;
        AccountPart: Text;
    begin
        IBAN := ''; // Initialize empty IBAN (will calculate later)

        // Extract BankBranchNo (after '/')
        SlashPos := STRPOS(FullBankAccountNo, '/');
        if SlashPos > 0 then
            BankBranchNo := COPYSTR(FullBankAccountNo, SlashPos + 1, STRLEN(FullBankAccountNo) - SlashPos)
        else
            BankBranchNo := '';

        // Extract account part (before '/')
        if SlashPos > 0 then
            AccountPart := COPYSTR(FullBankAccountNo, 1, SlashPos - 1)
        else
            AccountPart := FullBankAccountNo;

        // Extract BankPrefix and BankAccountNo (split by '-')
        DashPos := STRPOS(AccountPart, '-');

        if DashPos > 0 then begin
            BankPrefix := COPYSTR(AccountPart, 1, DashPos - 1);
            BankAccountNo := COPYSTR(AccountPart, DashPos + 1, STRLEN(AccountPart) - DashPos);
        end else begin
            BankPrefix := '';
            BankAccountNo := AccountPart;
        end;
    end;
    //FJC 6.10.2025 stop
    /* procedure DecodeBankAcc(FullBankAccountNoP: Code[50]; var BankBranchNoP: Code[50]; var BankAccountNoP: Code[50]; var IBANP: Code[50]; var BankPrefixP: Code[50])
     var
         SlashPositionL: Integer;
         BankAccPart1L: Code[50];
         BankAccPart2L: Code[50];
         //BankPrefixP: Code[50];
         FormattedBankAccount: Code[50];

     begin // FJC start
         IBANP := '';
         // Remove unwanted characters from FullBankAccountNoP
         FullBankAccountNoP := DELCHR(FullBankAccountNoP, '>', ' ');
         FullBankAccountNoP := DELCHR(FullBankAccountNoP, '<', '/');

         SlashPositionL := STRPOS(FullBankAccountNoP, '/');
         IF SlashPositionL <> 0 THEN BEGIN
             // Prefix is before the slash, main account number after slash
             BankAccPart1L := COPYSTR(FullBankAccountNoP, 1, SlashPositionL - 1);  // Bank account number
             BankAccPart2L := COPYSTR(FullBankAccountNoP, SlashPositionL + 1);      // Bank Branch Code

             BankAccountNoP := BankAccPart1L;  // Bank Account Number
             BankBranchNoP := BankAccPart2L;     // Bank Branch Code

         END ELSE BEGIN
             BankPrefixP := '';                // No prefix
             BankAccountNoP := FullBankAccountNoP;  // Entire part is Bank Account Number
         END;

         // If no prefix and BankAccountNoP does not start with digit, treat it as IBAN
         IF BankPrefixP = '' THEN
             IF NOT (BankAccountNoP[1] IN ['0' .. '9']) THEN
                 IBANP := BankAccountNoP;

         // Check if FullBankAccountNoP looks like a Czech IBAN (starts with CZ and length 24)
         IF ((STRLEN(FullBankAccountNoP) = 24) AND (COPYSTR(FullBankAccountNoP, 1, 2) = 'CZ')) THEN BEGIN
             // Czech IBAN format: CZkk bbbb ssss sscc cccc cccc
             // kk = check digits
             // bbbb = bank code (branch code)
             // ssss ss = prefix (account prefix)
             // cc cccc cccc = account number

             BankBranchNoP := COPYSTR(FullBankAccountNoP, 5, 4); // bank code (positions 5-8)
             BankPrefixP := COPYSTR(FullBankAccountNoP, 9, 6);   // prefix (positions 9-14)
             BankAccountNoP := COPYSTR(FullBankAccountNoP, 15, 10); // account number (positions 15-24)

             // Remove leading zeros from prefix and account number
             // BankBranchNoP := DELCHR(BankBranchNoP, '<', '0');
             BankPrefixP := DELCHR(BankPrefixP, '<', '0');
             BankAccountNoP := DELCHR(BankAccountNoP, '<', '0');
         END;

         // Now assemble final formatted bank account string
         IF BankPrefixP <> '' THEN
             FormattedBankAccount := FORMAT(BankPrefixP) + '-' + FORMAT(BankAccountNoP) + '/' + FORMAT(BankBranchNoP)
         ELSE
             FormattedBankAccount := FORMAT(BankAccountNoP) + '/' + FORMAT(BankBranchNoP);
     end; 
     */
    // FJC end

    local procedure GetBankAccountCode(VendorNoP: Code[20]; BankBranchNoP: Code[50]; FullBankAccountNo: Code[50]): Code[10]
    var
        VendorBankAccountL: Record "Vendor Bank Account";
        IteratorL: Integer;
    begin
        VendorBankAccountL.SETRANGE("Vendor No.", VendorNoP);
        VendorBankAccountL.SETRANGE("Bank Account No.", FullBankAccountNo);
        IF VendorBankAccountL.FINDFIRST THEN
            EXIT(VendorBankAccountL.Code);

        VendorBankAccountL.RESET;
        VendorBankAccountL.SETRANGE("Vendor No.", VendorNoP);
        VendorBankAccountL.SETRANGE(Code, BankBranchNoP);
        IF NOT VendorBankAccountL.FINDFIRST THEN
            EXIT(BankBranchNoP);
        IteratorL := 1;
        BankBranchNoP := COPYSTR(BankBranchNoP, 1, 4) + '_1';
        VendorBankAccountL.SETRANGE(Code, BankBranchNoP);
        WHILE ((VendorBankAccountL.FINDFIRST) AND (IteratorL <= 100)) DO BEGIN
            BankBranchNoP := INCSTR(BankBranchNoP);
            VendorBankAccountL.SETRANGE(Code, BankBranchNoP);
            IteratorL := IteratorL + 1;
        END;
        EXIT(BankBranchNoP);
    end;

    local procedure GetCustomerBankAccountCode(CustomerNoP: Code[20]; BankBranchNoP: Code[50]; FullBankAccountNo: Code[50]): Code[10]
    var
        CustomerBankAccountL: Record "Customer Bank Account";
        IteratorL: Integer;
        NewCode: Code[20];
    begin
        CustomerBankAccountL.SETRANGE("Customer No.", CustomerNoP);
        CustomerBankAccountL.SETRANGE("Bank Account No.", FullBankAccountNo);
        IF CustomerBankAccountL.FINDFIRST THEN
            EXIT(CustomerBankAccountL.Code);

        CustomerBankAccountL.RESET;
        CustomerBankAccountL.SETRANGE("Customer No.", CustomerNoP);
        CustomerBankAccountL.SETRANGE(Code, BankBranchNoP);
        IF NOT CustomerBankAccountL.FINDFIRST THEN
            EXIT(BankBranchNoP);
        IteratorL := 1;
        NewCode := BankBranchNoP + '_1';
        CustomerBankAccountL.SETRANGE(Code, NewCode);
        WHILE ((CustomerBankAccountL.FINDFIRST) AND (IteratorL <= 100)) DO BEGIN
            NewCode := INCSTR(NewCode);
            CustomerBankAccountL.SETRANGE(Code, NewCode);
            IteratorL := IteratorL + 1;
        END;
        EXIT(NewCode);
    end;
    // FJC 1.10.25 start

    local procedure PadLeft(Value: Text; Length: Integer): Text
    var
        ValueLength: Integer;
    begin
        ValueLength := STRLEN(Value);
        if ValueLength >= Length then
            exit(Value); // No truncation
        exit(RepeatStr('0', Length - ValueLength) + Value);
    end;

    local procedure PadRight(Value: Text; Length: Integer): Text
    var
        ValueLength: Integer;
    begin
        ValueLength := STRLEN(Value);
        if ValueLength >= Length then
            exit(Value); // No truncation
        exit(Value + RepeatStr('0', Length - ValueLength));
    end;

    local procedure RepeatStr(Character: Text[1]; Count: Integer): Text
    var
        ResultText: Text;
        i: Integer;
    begin
        ResultText := '';
        for i := 1 to Count do
            ResultText += Character;
        exit(ResultText);
    end;

    local procedure RemoveNonDigits(InputText: Text): Text
    var
        ResultText: Text;
        CharIndex: Integer;
        CurrentChar: Text[1];
        Digits: Text;
    begin
        ResultText := '';
        Digits := '0123456789';

        for CharIndex := 1 to STRLEN(InputText) do begin
            CurrentChar := COPYSTR(InputText, CharIndex, 1);
            if STRPOS(Digits, CurrentChar) > 0 then
                ResultText += CurrentChar;
        end;
        exit(ResultText);
    end;

    local procedure FormatCheckDigits(CheckDigits: Integer): Text[2]
    begin
        if CheckDigits < 10 then
            exit('0' + FORMAT(CheckDigits))
        else
            exit(FORMAT(CheckDigits));
    end;

    local procedure LettersToNumbers(InputText: Text): Text
    var
        ResultText: Text;
        CharIndex: Integer;
        CurrentChar: Text[1];
        Alphabet: Text;
        PosInAlphabet: Integer;
    begin
        Alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        ResultText := '';

        for CharIndex := 1 to STRLEN(InputText) do begin
            CurrentChar := COPYSTR(InputText, CharIndex, 1);
            PosInAlphabet := STRPOS(Alphabet, CurrentChar);

            if PosInAlphabet > 0 then
                ResultText += FORMAT(PosInAlphabet + 9) // A=10, B=11, ..., Z=35
            else
                ResultText += CurrentChar;
        end;

        exit(ResultText);
    end;

    local procedure Mod97(NumericString: Text): Integer
    var
        Temp: Integer;
        i: Integer;
        ChunkLength: Integer;
        Chunk: Text;
        ChunkValue: Integer;
    begin
        Temp := 0;
        i := 1;

        while i <= STRLEN(NumericString) do begin
            ChunkLength := 9 - STRLEN(FORMAT(Temp));
            if ChunkLength <= 0 then
                ChunkLength := 1;

            if i + ChunkLength - 1 > STRLEN(NumericString) then
                ChunkLength := STRLEN(NumericString) - i + 1;

            Chunk := COPYSTR(NumericString, i, ChunkLength);

            if not EVALUATE(ChunkValue, Chunk) then
                Error('Invalid numeric chunk: %1', Chunk);

            Temp := ((Temp * POWER(10, ChunkLength)) MOD 97 + ChunkValue) MOD 97;

            i += ChunkLength;
        end;

        exit(Temp);
    end;

    local procedure CalculateIBAN(BankPrefix: Code[50]; BankBranchNo: Code[50]; BankAccountNo: Code[50]): Code[50]
    var
        CountryCode: Text[2];
        BankCode: Text[4];
        AccountPrefixRaw: Text;
        AccountPrefix: Text[6];
        AccountNumberRaw: Text;
        AccountNumber: Text[10];
        BBAN: Text[20];
        NumericString: Text[100];
        CheckDigits: Integer;
        Mod97Result: Integer;
    begin
        CountryCode := 'CZ';

        BankCode := PadLeft(RemoveNonDigits(BankBranchNo), 4);

        AccountPrefixRaw := RemoveNonDigits(BankPrefix);
        if STRLEN(AccountPrefixRaw) = 0 then
            AccountPrefix := '000000'
        else
            AccountPrefix := PadLeft(AccountPrefixRaw, 6);

        AccountNumberRaw := RemoveNonDigits(BankAccountNo);
        if STRLEN(AccountNumberRaw) > 10 then
            AccountNumberRaw := COPYSTR(AccountNumberRaw, STRLEN(AccountNumberRaw) - 9, 10);

        AccountNumber := PadLeft(AccountNumberRaw, 10);

        BBAN := BankCode + AccountPrefix + AccountNumber;

        NumericString := LettersToNumbers(BBAN + CountryCode + '00');

        Mod97Result := Mod97(NumericString);

        CheckDigits := 98 - Mod97Result;

        exit(CountryCode + FormatCheckDigits(CheckDigits) + BBAN);
    end;

    // FJC 1.10.25 stop

    [EventSubscriber(ObjectType::Report, 11700, 'OnBeforeInsertPaymentOrderLine', '', false, false)]
    local procedure R11700_OnBeforeInsertPaymentOrderLine(var Sender: Report "Suggest Payments"; var PaymentOrderLineP: Record "Payment Order Line")
    begin
        // Start DAFCZ.1
        IF NOT PaymentOrderLineP."Skip Payment" THEN
            PaymentOrderLineP.VALIDATE("Skip Payment", TRUE);
        // Stop DAFCZ.1
    end;

    local procedure TestUserCanChangePaymentMethod()
    var
        UserSetupL: Record "User Setup";
    begin
        // Start DAFCZ.1
        UserSetupL.GET(USERID);
        UserSetupL.TESTFIELD("DPG Allow Change Payment Met.", TRUE);
        // Stop DAFCZ.1
    end;

    local procedure IsCashPayment(PaymentMethodCodeP: Code[20]): Boolean
    var
        PaymentMethodL: Record "Payment Method";
    begin
        // Start DAFCZ.1
        IF PaymentMethodL.GET(PaymentMethodCodeP) THEN
            EXIT(PaymentMethodL."Cash Payment");
        EXIT(FALSE);
        // Stop DAFCZ.1
    end;

    local procedure CheckPaymentOnDocumentHeader(PaymentMethodCodeP: Code[20]; CustNoP: Code[20])
    var
        CustL: Record Customer;
    begin
        // Start DAFCZ.1
        IF IsCashPayment(PaymentMethodCodeP) THEN
            EXIT;
        IF CustL.GET(CustNoP) THEN
            IF IsCashPayment(CustL."Payment Method Code") THEN
                TestUserCanChangePaymentMethod;
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnBeforeValidateEvent', 'Payment Method Code', false, false)]
    local procedure T18_OnBeforeValidatePaymentMethodCode(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        // Start DAFCZ.1
        IF IsCashPayment(xRec."Payment Method Code") AND (NOT IsCashPayment(Rec."Payment Method Code")) THEN
            TestUserCanChangePaymentMethod;
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Payment Method Code', false, false)]
    local procedure T36_OnBeforeValidatePaymentMethodCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ.1
        IF Rec."Document Type" IN [Rec."Document Type"::"Credit Memo", Rec."Document Type"::"Return Order"] THEN
            EXIT;
        CheckPaymentOnDocumentHeader(Rec."Payment Method Code", Rec."Bill-to Customer No.");
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Ship-to Country Code', false, false)]
    local procedure T36_OnAfterValidateEventShipToCountryCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ.1
        Rec.VALIDATE("VAT Country Code", xRec."VAT Country Code");
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterInsertEvent', '', false, false)]
    local procedure T36_OnAfterInsert(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        // Start DAFCZ.1.01 RH - temporary 'debugging' modification only
        IF (NOT GUIALLOWED) OR (Rec.ISTEMPORARY) OR (Rec."Currency Code" = '') OR (Rec."Currency Factor" = Rec."VAT Currency Factor") THEN
            EXIT;
        MESSAGE('Na %1 "%2" došlo při INSERT k nastavení rozdílného faktoru měnu a DPH faktoru měny. Prosíme o zaslání informace, co jste právě v Incadea provedli za akci na p. Jirce.',
          LOWERCASE(FORMAT(Rec."Document Type")), Rec."No.");
        // Stop DAFCZ.1.01 RH - temporary 'debugging' modification only
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterModifyEvent', '', false, false)]
    local procedure T36_OnAfterModify(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; RunTrigger: Boolean)
    var
        SalesHeaderL: Record "Sales Header";
    begin
        // Start DAFCZ.1.01 RH - temporary 'debugging' modification only
        IF (NOT GUIALLOWED) OR (Rec.ISTEMPORARY) OR (Rec."Currency Code" = '') OR (Rec."Currency Factor" = Rec."VAT Currency Factor") THEN
            EXIT;
        IF NOT SalesHeaderL.GET(Rec."Document Type", Rec."No.") THEN
            EXIT;
        IF (Rec."Currency Code" = SalesHeaderL."Currency Code") AND (SalesHeaderL."Currency Factor" <> SalesHeaderL."VAT Currency Factor") THEN
            EXIT;
        MESSAGE('Na %1 "%2" došlo při MODIFY k nastavení rozdílného faktoru měnu a DPH faktoru měny. Prosíme o zaslání informace, co jste právě v Incadea provedli za akci na p. Jirce.',
          LOWERCASE(FORMAT(Rec."Document Type")), Rec."No.");
        // Stop DAFCZ.1.01 RH - temporary 'debugging' modification only
    end;

    [EventSubscriber(ObjectType::Table, 289, 'OnBeforeValidateEvent', 'Cash Payment', false, false)]
    local procedure T289_OnBeforeValidateCashPayment(var Rec: Record "Payment Method"; var xRec: Record "Payment Method"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ.1
        IF Rec."Cash Payment" <> xRec."Cash Payment" THEN
            TestUserCanChangePaymentMethod;
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 5025624, 'OnBeforeValidateEvent', 'Payment Method Code', false, false)]
    local procedure T5025624_OnBeforeValidatePaymentMethodCode(var Rec: Record "Service Header"; var xRec: Record "Service Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ.1
        CheckPaymentOnDocumentHeader(Rec."Payment Method Code", Rec."Bill-to Customer No.");
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 5025422, 'OnAfterInsertEvent', '', false, false)]
    local procedure T5025422_OnAfterInsertEvent(var Rec: Record "Vehicle Option"; RunTrigger: Boolean)
    begin
        // Start DAFCZ.1
        IF (Rec.Type = Rec.Type::"Other G/L Account") AND (Rec."Copy-to Setting" <> Rec."Copy-to Setting"::"Do Not Copy") THEN BEGIN
            Rec."Copy-to Setting" := Rec."Copy-to Setting"::"Do Not Copy";
            Rec.MODIFY;
        END;
        // Stop DAFCZ.1
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Pay-to Vendor No.', false, false)]
    local procedure T38_OnAfterValidatePayToVendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ0003 RH DAFCZ.1.01
        UpdateRegistrationNos(Rec);
        // Stop DAFCZ0003 RH DAFCZ.1.01
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Pay-to Contact No.', false, false)]
    local procedure T38_OnAfterValidatePayToContactNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ0003 RH DAFCZ.1.01
        UpdateRegistrationNos(Rec);
        // Stop DAFCZ0003 RH DAFCZ.1.01
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Perform. Country/Region Code', false, false)]
    local procedure T38_OnAfterValidatePerformCountryRegionCode(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        // Start DAFCZ0003 RH DAFCZ.1.01
        UpdateRegistrationNos(Rec);
        // Stop DAFCZ0003 RH DAFCZ.1.01
    end;

    local procedure UpdateRegistrationNos(var PurchaseHeaderP: Record "Purchase Header")
    var
        VendorL: Record Vendor;
    begin
        // Start DAFCZ0003 RH DAFCZ.1.01
        IF NOT VendorL.GET(PurchaseHeaderP."Buy-from Vendor No.") THEN
            VendorL.INIT;
        PurchaseHeaderP."VAT Registration No." := VendorL."VAT Registration No.";
        PurchaseHeaderP."Registration No." := VendorL."Registration No.";
        PurchaseHeaderP."Tax Registration No." := VendorL."Tax Registration No.";
        // Stop DAFCZ0003 RH DAFCZ.1.01
    end;

    [EventSubscriber(ObjectType::Codeunit, 31000 /*Sales-Post Advances*/, 'OnCreateAdvanceInvLineBufOnAfterSalesLineBufferCreated', '', false, false)]
    local procedure C31000_OnCreateAdvanceInvLineBufOnAfterSalesLineBufferCreated(var SalesLineP: Record "Sales Line")
    var
        MaxSalesLineL: Record "Sales Line";
    begin
        if SalesLineP.FindSet() then begin
            MaxSalesLineL := SalesLineP;
            while (SalesLineP.Next() <> 0) do begin
                if (MaxSalesLineL."Prepmt. Amt. Incl. VAT" < SalesLineP."Prepmt. Amt. Incl. VAT") then
                    MaxSalesLineL := SalesLineP;
            end;
            SalesLineP.FindSet();
            repeat
                if (SalesLineP."Shortcut Dimension 1 Code" <> MaxSalesLineL."Shortcut Dimension 1 Code") or (SalesLineP."Shortcut Dimension 2 Code" <> MaxSalesLineL."Shortcut Dimension 2 Code") or (SalesLineP."Dimension Set ID" <> MaxSalesLineL."Dimension Set ID") then begin
                    SalesLineP."Shortcut Dimension 1 Code" := MaxSalesLineL."Shortcut Dimension 1 Code";
                    SalesLineP."Shortcut Dimension 2 Code" := MaxSalesLineL."Shortcut Dimension 2 Code";
                    SalesLineP."Dimension Set ID" := MaxSalesLineL."Dimension Set ID";
                    SalesLineP.Modify(false);
                end;
            until SalesLineP.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 31000 /*Sales-Post Advances*/, 'OnCreateAdvanceInvLineBufOnAfterServiceLineBufferCreated', '', false, false)]
    local procedure C31000_OnCreateAdvanceInvLineBufOnAfterServiceLineBufferCreated(var ServiceLineP: Record "Service Line")
    var
        MaxServiceLineL: Record "Service Line";
    begin
        if ServiceLineP.FindSet() then begin
            MaxServiceLineL := ServiceLineP;
            while (ServiceLineP.Next() <> 0) do begin
                if (MaxServiceLineL."Prepmt. Amt. Incl. VAT" < ServiceLineP."Prepmt. Amt. Incl. VAT") then
                    MaxServiceLineL := ServiceLineP;
            end;
            ServiceLineP.FindSet();
            repeat
                if (ServiceLineP."Department Code" <> MaxServiceLineL."Department Code") or (ServiceLineP."Make Code" <> MaxServiceLineL."Make Code") or (ServiceLineP."Dimension Set ID" <> MaxServiceLineL."Dimension Set ID") then begin
                    ServiceLineP."Department Code" := MaxServiceLineL."Department Code";
                    ServiceLineP."Make Code" := MaxServiceLineL."Make Code";
                    ServiceLineP."Dimension Set ID" := MaxServiceLineL."Dimension Set ID";
                    ServiceLineP.Modify(false);
                end;
            until ServiceLineP.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1057623 /*ET5025624,5025625*/, 'OnCreateAdvanceLetterFromAmountOnGetDefaultAmount', '', false, false)]
    local procedure C1057623_OnCreateAdvanceLetterFromAmountOnGetDefaultAmount(var ServiceHeaderP: Record "Service Header"; var AmountP: Decimal)
    var
        ServiceLine: Record "Service Line";
        MakeServPreview: Codeunit "Make Serv. Preview";
        SurchargeAmount: Decimal;
        SurchargeVATAmount: Decimal;
        SurchargeAmountLCY: Decimal;
        Currency: Record Currency;
    begin
        if AmountP <> 0 then
            exit;
        ServiceLine.Reset();
        ServiceLine.SetRange("Document Type", ServiceHeaderP."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeaderP."No.");
        ServiceLine.SetFilter("Amount Including VAT", '<>0');
        if ServiceLine.FindSet() then begin
            MakeServPreview.Surcharges(ServiceHeaderP, SurchargeAmount, SurchargeVATAmount, AmountP /*SurchargeAmountInclVAT*/, SurchargeAmountLCY, '');
            Currency.Initialize(ServiceHeaderP."Currency Code");
            repeat
                if Abs(ServiceLine."Quantity Invoiced") < Abs(ServiceLine.Quantity) then
                    if ServiceLine."Quantity Invoiced" = 0 then
                        AmountP += ServiceLine."Amount Including VAT"
                    else
                        AmountP += Round(ServiceLine."Amount Including VAT" * (1 - ServiceLine."Quantity Invoiced" / ServiceLine.Quantity), Currency."Amount Rounding Precision");
            until ServiceLine.Next() = 0;
        end;
    end;
}


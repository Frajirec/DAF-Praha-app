report 80009 "DPG MT940:IM" // 50050 "MT940:IM"
{
    // --- API Customization ---
    // API-SMPE-030817-API01   - prefix in bank account no
    // --- DAFCZ ---
    // DAFCZ.1    29.05.18 DV DAFCZ.1 Modified for ING bank
    // DAFCZ.1    23.10.18 DV DAFCZ.1 ING bank different order of payment details
    // DAFCZ.1    06.11.18 DV DAFCZ.1 ING bank different payment details
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/MT940IM.rdlc';

    Permissions = TableData "Bank Statement Header" = rimd,
                  TableData "Bank Statement Line" = rimd;

    dataset
    {
        dataitem(BankStatementLineFilter; "Bank Statement Line")
        {
        }
        dataitem(SourceHeader; "Bank Statement Header")
        {
            dataitem(Lines; "Integer")
            {
                DataItemTableView = SORTING(Number);

                trigger OnAfterGetRecord()
                var
                    i: Integer;
                    Day: Integer;
                    Year: Integer;
                //Sign: Integer;
                begin
                    //========== object specific code ===============
                    IF (gboReadNextLine = TRUE) THEN
                        Data := LoadRecord;

                    CASE TRUE OF
                        STRPOS(Data, ':20:') = 1:                                  //refference
                            ;
                        STRPOS(Data, ':21:') = 1:
                            ;
                        STRPOS(Data, ':25:') = 1:                                  //account identification
                            DecodeBankAcc(COPYSTR(Data, 5));
                        STRPOS(Data, ':28C:') = 1:                                 //statement number / page number
                            IF IsBlockForThisAccount THEN
                                TempHeader."External Document No." := FormatImportNo2(COPYSTR(Data, 6, 5));
                        STRPOS(Data, ':28:') = 1:                                 //statement number / page number
                            IF IsBlockForThisAccount THEN
                                TempHeader."External Document No." := FormatImportNo2(COPYSTR(Data, 5, 5));
                        STRPOS(Data, ':60F:') = 1:                                  //initial balance
                            IF IsBlockForThisAccount THEN BEGIN
                                TempHeader."Currency Code" := GetCurr(COPYSTR(Data, 13, 3));
                                //Sign := GetSign(COPYSTR(Data, 6, 1));
                            END;
                        STRPOS(Data, ':61:') = 1:                                  //transaction line
                            IF IsBlockForThisAccount THEN BEGIN
                                gboReadNextLine := ProcessTransactionLine;
                                LinesNo += 1;
                                TempLine.INSERT;
                            END;
                        STRPOS(Data, ':62F:') = 1:                                  //final balance
                            IF IsBlockForThisAccount THEN BEGIN
                                //Sign := GetSign(COPYSTR(Data, 6, 1));
                                TempHeader."Document Date" := GetDate(COPYSTR(Data, 7, 6), 'YYMMDD');
                                gboReadNextLine := TRUE;
                            END;
                        STRPOS(Data, ':64:') = 1:                                  //disponible balance
                            ;
                        STRPOS(Data, '-}') = 1:                                   //statement footer
                            ;
                        ELSE
                            gboReadNextLine := TRUE;
                    END;

                    IF (EOF)
                    THEN
                        CurrReport.BREAK;
                    //========== object specific code ===============
                end;

                trigger OnPreDataItem()
                begin
                    gboReadNextLine := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SkipUpdate := FALSE;

                TempHeader := SourceHeader;
                LinesNo := 0;
            end;

            trigger OnPostDataItem()
            begin
                IF SkipUpdate THEN
                    CurrReport.BREAK;

                Header.GET(TempHeader."No.");

                IF TempHeader."Bank Account No." <> '' THEN
                    CheckStatementBankAccNo(Header, TempHeader."Account No.")
                ELSE
                    CheckStatementBankAccNo(Header, TempHeader.IBAN);

                IF StatementExists(Header, TempHeader."Document Date", TempHeader."External Document No.") THEN
                    ERROR('');

                IF NOT Test THEN BEGIN
                    UpdateStatement(Header, TempHeader, TRUE);
                    Header."No. of Lines" := LinesNo;
                    Header."File Name" := FORMAT(FileName, -MAXSTRLEN(Header."File Name"));

                    Header.MODIFY;
                    IF TempLine.FINDSET THEN
                        REPEAT
                            Line := TempLine;
                            Line.INSERT;
                        UNTIL TempLine.NEXT = 0;
                END;

                CurrFile.CLOSE;

                FileMgt.DeleteServerFile(FileName);
            end;

            trigger OnPreDataItem()
            var
                lteSrcFile: Text[1024];
                lcoNo: Code[20];
            begin
                SETFILTER("No.", BankStatementLineFilter.GETFILTER("Bank Statement No."));

                IF COUNT <> 1 THEN
                    ERROR(Text001);

                FINDFIRST;

                IF NOT SelectBankStatementFileNameLoc(lteSrcFile) THEN
                    ERROR(FileErrorTxt);

                FileName := FileMgt.UploadFileSilent(lteSrcFile);
                CurrFile.OPEN(FileName);
                CurrFile.TEXTMODE(TRUE);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //UseDialog := TRUE;
    end;

    var
        Header: Record "Bank Statement Header";
        Line: Record "Bank Statement Line";
        TempHeader: Record "Bank Statement Header" temporary;
        TempLine: Record "Bank Statement Line" temporary;
        FileName: Text[1024];
        //UseDialog: Boolean;
        LinesNo: Integer;
        LineNo: Integer;
        Data: Text[1024];
        Test: Boolean;
        SkipUpdate: Boolean;
        MT940_VERSION: Text[250];
        DataBuffer: Text[1024];
        EOF: Boolean;
        IsBlockForThisAccount: Boolean;
        gboReadNextLine: Boolean;
        //FILETYPE: Label 'Text Files (*.sta)|*.sta|All Files (*.*)|*.*';
        Text001: Label 'You can import to one bank statement only.';
        BANKACC_ERR: Label 'Not same %1 (%2).';
        Text007: Label 'Open';
        Text009: Label 'All Files (*.*)|*.*';
        STAT_EXISTS: Label 'Bank Statement with number %1 already exists in this year. Continue?';
        FileMgt: Codeunit "File Management";
        CurrFile: File;
        FileErrorTxt: Label 'The fle was not selected.';

    local procedure ProcessTransactionLine(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
    begin
        LineNo += 10000;

        TempLine.INIT;
        TempLine."Bank Statement No." := TempHeader."No.";

        TempLine."Line No." := LineNo;
        TempLine."Currency Code" := TempHeader."Currency Code";

        IF STRPOS(TempHeader."Bank Account No.", '/') > 0 THEN
            MT940_VERSION := COPYSTR(TempHeader."Bank Account No.", STRPOS(TempHeader."Bank Account No.", '/') + 1);

        // Start DAFCZ.1
        IF STRLEN(MT940_VERSION) > 4 THEN
            MT940_VERSION := COPYSTR(MT940_VERSION, 1, 4);
        // Stop DAFCZ.1

        CASE MT940_VERSION OF
            '0300':
                MT940_VERSION := 'CSOB_090701';
            '2700':
                MT940_VERSION := 'UNICREDIT_110111';
            '5500':
                MT940_VERSION := 'RBS_070812';
            '0800':
                MT940_VERSION := 'CS_090418';
            '7910':
                MT940_VERSION := 'DEUTSCHEBANK_080901';
            '3500':
                MT940_VERSION := 'ING';
        END;

        CASE MT940_VERSION OF
            'CSOB_090701':
                EXIT(ProcessCSOB_090701);
            'CS_090418':
                EXIT(ProcessCS_090418);
            'RBS_070812':
                EXIT(ProcessRBS_070812);
            'UNICREDIT_110111':
                EXIT(ProcessUNICREDIT_110111);
            'DEUTSCHEBANK_080901':
                EXIT(ProcessDEUTSCHEBANK_080901);
            'TATRABANKA':
                EXIT(ProcessTATRABANKA);
            'ING':
                EXIT(ProcessING);
            'ABN':
                EXIT(ProcessABN);
            'VUB_121105':
                EXIT(ProcessVUB_121105);
            'OBER_121105':
                EXIT(ProcessOBER_121105);
            'UCBSK_121105':
                EXIT(ProcessUCBSK_121105);
            'LUDOVABANKA_130327':
                EXIT(ProcessLUDOVABANKA_130327);
        END;
    end;

    local procedure ProcessCSOB_090701(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
    begin
        Delimiter := '?';

        CluePosition := MAXINT(STRPOS(Data, 'FTRF'), STRPOS(Data, 'NTRF'));  //pokracovanie za cislom

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF (COPYSTR(Data, 15, 1) = 'R') OR
           (COPYSTR(Data, 16, 1) = 'K') OR
           (COPYSTR(Data, 16, 1) = 'R') THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '111': //domestic payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '00', Delimiter));

                    TempLine."Account No." := GetSubfieldOf86(Data, '20', Delimiter);
                    i := STRPOS(TempLine."Account No.", '/');
                    IF i <> 0 THEN
                        IF STRLEN(COPYSTR(TempLine."Account No.", i + 1)) > 4 THEN  //kod banky napr. v KB /0000100
                            TempLine."Account No." :=
                              FormatBankAccNo2(
                                COPYSTR(TempLine."Account No.", i + 1) +
                                  LPADSTR(DELCHR(COPYSTR(TempLine."Account No.", 1, i - 1), '<', '0'), 4, '0'));

                    TempLine."Variable Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '21', Delimiter));
                    TempLine."Specific Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '22', Delimiter));
                    TempLine."Constant Symbol" := COPYSTR(GetVSCSSS(GetSubfieldOf86(Data, '23', Delimiter)), 1, 4);
                END;
            '030': //international payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '20', Delimiter);
                    BankAcc := GetSubfieldOf86(Data, '25', Delimiter);
                    IF BankAcc IN ['0' .. '9'] THEN
                        TempLine."Account No." := BankAcc
                    ELSE
                        TempLine.IBAN := BankAcc;
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
            '040': //other payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '00', Delimiter));
                END;
            '166':
                BEGIN
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
            '211':
                BEGIN
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessCS_090418(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
    begin
        Delimiter := '?';

        CluePosition := STRPOS(Data, 'N');  //pokracovanie za cislom

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF (COPYSTR(Data, 15, 1) = 'R') OR
           (COPYSTR(Data, 16, 1) = 'K') OR
           (COPYSTR(Data, 16, 1) = 'R') THEN
            CancelOffset := 1;


        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '020': //domestic payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '25', Delimiter);
                    TempLine."Account No." := DELCHR(GetSubfieldOf86(Data, '23', Delimiter), '<', ' ');
                    i := STRPOS(TempLine."Account No.", '/');
                    IF i <> 0 THEN
                        TempLine."Account No." :=
                          FormatBankAccNo2(
                            COPYSTR(TempLine."Account No.", i + 1) + COPYSTR(TempLine."Account No.", 1, i - 1));

                    TempLine."Variable Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '21', Delimiter));
                    TempLine."Specific Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '22', Delimiter));
                    TempLine."Constant Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '20', Delimiter));
                END;
            '030': //international payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '20', Delimiter);
                    BankAcc := GetSubfieldOf86(Data, '25', Delimiter);
                    IF BankAcc IN ['0' .. '9'] THEN
                        TempLine."Account No." := BankAcc
                    ELSE
                        TempLine.IBAN := BankAcc;
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
            '040': //other payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '00', Delimiter);
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessRBS_070812(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        lteDelimiter: Text[1];
        lteTempCS: Text[1024];
        lreRecipientAccount: Text[1024];
    begin
        LineNo += 10000;

        lteDelimiter := '>';

        TempLine.INIT;
        TempLine."Bank Statement No." := TempHeader."No.";
        TempLine."Line No." := LineNo;
        TempLine."Currency Code" := TempHeader."Currency Code";

        CluePosition := MAXINT(STRPOS(Data, 'FTRF'), STRPOS(Data, 'NTRF'));

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF COPYSTR(Data, 15, 1) = 'R' THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord();

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '111', '110': //domestic payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '32', lteDelimiter);

                    lreRecipientAccount := GetSubfieldOf86(Data, '22', lteDelimiter);
                    IF (COPYSTR(lreRecipientAccount, 1, 1) = '/') THEN
                        TempLine."Account No." := COPYSTR(lreRecipientAccount, 2)
                    ELSE
                        TempLine."Account No." := lreRecipientAccount;

                    TempLine."Account No." := CONVERTSTR(TempLine."Account No.", '/', '-');

                    TempLine."Variable Symbol" := GetSubfieldOf86(Data, '20', lteDelimiter);
                    TempLine."Specific Symbol" := GetSubfieldOf86(Data, '23', lteDelimiter);

                    lteTempCS := GetSubfieldOf86(Data, '21', lteDelimiter);
                    IF (STRLEN(lteTempCS) >= 4) THEN BEGIN
                        TempLine."Constant Symbol" := COPYSTR(lteTempCS, STRLEN(lteTempCS) - 3);
                        TempLine."Account No." := TempLine."Account No." + '/' + COPYSTR(lteTempCS, 1, 4);
                    END ELSE BEGIN
                        TempLine."Constant Symbol" := '';
                    END;
                END;
            '100': //international payment transaction
                BEGIN
                    TempLine.Description := COPYSTR(GetSubfieldOf86(Data, '20', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '21', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '22', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '23', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '24', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '25', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '26', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '27', lteDelimiter),
                                                    1, 50);
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessUNICREDIT_110111(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
    begin
        Delimiter := '?';

        CluePosition := 0;

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF COPYSTR(Data, 15, 1) = 'R' THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '110', '111',
            '004', '008', '020', '051', '071', '082', '083', '087', '088': //domestic payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '00', Delimiter);
                    TempLine."Account No." := DELCHR(GetSubfieldOf86(Data, '20', Delimiter), '<', ' ');
                    TempLine."Variable Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '22', Delimiter));
                    TempLine."Specific Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '23', Delimiter));
                    TempLine."Constant Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '21', Delimiter));
                END;
            '030': //international payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '20', Delimiter);
                    BankAcc := GetSubfieldOf86(Data, '25', Delimiter);
                    IF BankAcc IN ['0' .. '9'] THEN
                        TempLine."Account No." := BankAcc
                    ELSE
                        TempLine.IBAN := BankAcc;
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
            '040', '808', '809', '814', '833', '835', '899': //other payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '00', Delimiter);
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessDEUTSCHEBANK_080901(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
    begin
        Delimiter := '?';

        CluePosition := MAXINT(STRPOS(Data, 'FTRF'), STRPOS(Data, 'NTRF'));  //pokracovanie za cislom

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF (COPYSTR(Data, 15, 1) = 'R') OR
           (COPYSTR(Data, 16, 1) = 'K') OR
           (COPYSTR(Data, 16, 1) = 'R') THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '020': //domestic payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '32', Delimiter));

                    TempLine."Account No." := GetSubfieldOf86(Data, '31', Delimiter);
                    TempLine."Account No." := TempLine."Account No." + '/' + GetSubfieldOf86(Data, '30', Delimiter);

                    TempLine."Variable Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '20', Delimiter));
                    TempLine."Specific Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '21', Delimiter));
                    TempLine."Constant Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '22', Delimiter));
                END;
            '030': //international payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '20', Delimiter);
                    BankAcc := GetSubfieldOf86(Data, '25', Delimiter);
                    IF BankAcc IN ['0' .. '9'] THEN
                        TempLine."Account No." := BankAcc
                    ELSE
                        TempLine.IBAN := BankAcc;
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
            '835': //other payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '20', Delimiter));
                END;
            '210': //other payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '20', Delimiter));
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessTATRABANKA(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
    begin
        Delimiter := '?';

        CluePosition := MAXINT(STRPOS(Data, 'FTRF'), STRPOS(Data, 'NTRF'));  //pokracovanie za cislom

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF (COPYSTR(Data, 15, 1) = 'R') OR
           (COPYSTR(Data, 16, 1) = 'K') OR
           (COPYSTR(Data, 16, 1) = 'R') THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '045': //domestic payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '32', Delimiter));

                    TempLine."Account No." := GetSubfieldOf86(Data, '20', Delimiter);
                    IF (STRLEN(TempLine."Account No.") > 4) THEN BEGIN
                        TempLine."Account No." :=
                          COPYSTR(TempLine."Account No.", 1, STRLEN(TempLine."Account No.") - 5) +
                          '/' +
                          COPYSTR(TempLine."Account No.", STRLEN(TempLine."Account No.") - 4);
                    END;

                    TempLine."Variable Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '21', Delimiter));
                    TempLine."Specific Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '22', Delimiter));
                    TempLine."Constant Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '61', Delimiter));
                END;
            '201': //international payment transaction
                BEGIN
                    TempLine.IBAN := DELCHR(COPYSTR(GetSubfieldOf86(Data, '22', Delimiter), 1, 35), '>', ' ');
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '27', Delimiter));
                END;
            '835': //other payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '20', Delimiter));
                END;
            '210': //other payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '20', Delimiter));
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessING(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        lteDetails: Text[1024];
        lteSomeSymbol: Text[1024];
        linSeparatorCount: Integer;
    begin
        Delimiter := '~';

        // Positions 11 & 12
        //
        // Debit/Credit Mark subfield 3 X(1)
        // C (= Credit) or
        // D (= Debit)
        //
        // Funds code subfiels 4 X(1) 3rd position of
        // the ISO 4217 currency code

        CASE COPYSTR(Data, 11, 1) OF
            'C':
                Sign := 1;  // credit
            'D':
                Sign := -1; // debit
        END;

        //1st character of Sub-field 6:Transaction Type Identification code always "N",
        CluePosition := STRPOS(Data, 'N');

        StartPosition := 13;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '110': //domestic payment transaction
                BEGIN
                    TempLine.Description := TEXT1250TO852(GetSubfieldOf86(Data, '32', Delimiter));

                    lteDetails := GetSubfieldOf86(Data, '25', Delimiter) +
                                  GetSubfieldOf86(Data, '26', Delimiter) +
                                  GetSubfieldOf86(Data, '27', Delimiter);

                    lteDetails := CONVERTSTR(lteDetails, ' ', ',');

                    linSeparatorCount := 0;
                    FOR i := 1 TO STRLEN(lteDetails) DO
                        IF lteDetails[i] = ',' THEN linSeparatorCount += 1;

                    // Start DAFCZ.1
                    IF linSeparatorCount >= 1 THEN BEGIN
                        // Stop DAFCZ.1
                        lteSomeSymbol := SELECTSTR(1, lteDetails);
                        lteSomeSymbol := DELCHR(lteSomeSymbol, '<', '0');
                        TempLine."Constant Symbol" := COPYSTR(lteSomeSymbol, 1, 4);
                    END;
                    // Start DAFCZ.1
                    IF linSeparatorCount >= 2 THEN BEGIN
                        // Stop DAFCZ.1
                        lteSomeSymbol := SELECTSTR(2, lteDetails);
                        lteSomeSymbol := DELCHR(lteSomeSymbol, '<', '0');
                        TempLine."Variable Symbol" := COPYSTR(lteSomeSymbol, 1, 10);
                    END;
                    // Start DAFCZ.1
                    IF linSeparatorCount >= 3 THEN BEGIN
                        // Stop DAFCZ.1
                        lteSomeSymbol := SELECTSTR(3, lteDetails);
                        lteSomeSymbol := DELCHR(lteSomeSymbol, '<', '0');
                        TempLine."Specific Symbol" := COPYSTR(lteSomeSymbol, 1, 10);
                    END;
                    /*
                    lteSomeSymbol := SELECTSTR(1, lteDetails);
                    TempLine."Constant Symbol" := COPYSTR(DELCHR(lteSomeSymbol,'<','0'), 1 , 4);
                    IF linSeparatorCount > 0 THEN BEGIN
                      lteSomeSymbol := SELECTSTR(2, lteDetails);
                    END ELSE lteSomeSymbol := '';
                    lteSomeSymbol := DELCHR(lteSomeSymbol,'<','0');
                    IF (STRLEN(lteSomeSymbol) = 10) THEN
                      TempLine."Variable Symbol" := COPYSTR(lteSomeSymbol, 1 , 10)
                    ELSE
                    BEGIN
                      TempLine."Specific Symbol" := COPYSTR(lteSomeSymbol, 1 ,10);
                      IF linSeparatorCount > 1 THEN BEGIN
                        lteSomeSymbol := SELECTSTR(3, lteDetails);
                      END ELSE lteSomeSymbol := '';
                      TempLine."Variable Symbol" := COPYSTR(DELCHR(lteSomeSymbol,'<','0'), 1, 10);
                    END;
                    */

                    IF linSeparatorCount >= 7 THEN BEGIN
                        TempLine."Account No." := CODE2DIGIT(SELECTSTR(7, lteDetails)) + '/' + SELECTSTR(5, lteDetails);
                    END;
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);

    end;

    local procedure ProcessABN(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        lteDelimiter: Text[1];
        lteTempCS: Text[1024];
        lreRecipientAccount: Text[1024];
    begin
        LineNo += 10000;

        lteDelimiter := '>';

        TempLine.INIT;
        TempLine."Bank Statement No." := TempHeader."No.";
        TempLine."Line No." := LineNo;
        TempLine."Currency Code" := TempHeader."Currency Code";

        CluePosition := MAXINT(STRPOS(Data, 'FTRF'), STRPOS(Data, 'NTRF'));

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF COPYSTR(Data, 15, 1) = 'R' THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord();

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '111', '110': //domestic payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '32', lteDelimiter);

                    lreRecipientAccount := GetSubfieldOf86(Data, '22', lteDelimiter);
                    IF (COPYSTR(lreRecipientAccount, 1, 1) = '/') THEN
                        TempLine."Account No." := COPYSTR(lreRecipientAccount, 2)
                    ELSE
                        TempLine."Account No." := lreRecipientAccount;

                    TempLine."Account No." := CONVERTSTR(TempLine."Account No.", '/', '-');

                    TempLine."Variable Symbol" := GetSubfieldOf86(Data, '20', lteDelimiter);
                    TempLine."Specific Symbol" := GetSubfieldOf86(Data, '23', lteDelimiter);

                    lteTempCS := GetSubfieldOf86(Data, '21', lteDelimiter);
                    IF (STRLEN(lteTempCS) >= 4) THEN BEGIN
                        TempLine."Constant Symbol" := COPYSTR(lteTempCS, STRLEN(lteTempCS) - 3);
                        TempLine."Account No." := TempLine."Account No." + '/' + COPYSTR(lteTempCS, 1, 4);
                    END ELSE BEGIN
                        TempLine."Constant Symbol" := '';
                    END;
                END;
            '100': //international payment transaction
                BEGIN
                    TempLine.Description := COPYSTR(GetSubfieldOf86(Data, '20', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '21', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '22', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '23', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '24', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '25', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '26', lteDelimiter) +
                                                    GetSubfieldOf86(Data, '27', lteDelimiter),
                                                    1, 50);
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure LoadRecord() Output: Text[1024]
    var
        ReadLine: Text[1024];
        ReadStatus: Integer;
        xxx: Integer;
        counter: Integer;
    begin
        IF STRLEN(DataBuffer) > 0 THEN BEGIN
            Output := DataBuffer;
            DataBuffer := '';
        END;

        REPEAT
            ReadStatus := 0;
            ReadLine := '';
            ReadStatus := ABOFileReadLine(ReadLine);
            IF ReadStatus = -1 THEN
                EOF := TRUE;

            // Start DAFCZ.1
            counter := 0;
            IF ((MT940_VERSION = 'UCBSK_121105') AND (ReadStatus = 0)) OR
               ((MT940_VERSION = 'ING') AND (ReadStatus = 0)) THEN BEGIN
                // Stop DAFCZ.1
                REPEAT
                    ReadLine := '';
                    ReadStatus := ABOFileReadLine(ReadLine);
                    // Start DAFCZ.1
                    counter := counter + 1;
                UNTIL (ReadStatus <> 0) OR (counter > 50);
                // Stop DAFCZ.1
            END;

            IF (STRLEN(ReadLine) > 0) THEN BEGIN
                IF (COPYSTR(ReadLine, 1, 1) <> ':') AND (STRPOS(ReadLine, '-}') = 0) THEN
                    Output := Output + ReadLine
                ELSE
                    DataBuffer := ReadLine;
            END ELSE
                ReadStatus := -1;
        UNTIL (COPYSTR(ReadLine, 1, 1) = ':') OR (STRPOS(ReadLine, '-}') = 1) OR (ReadStatus = -1);

        IF ReadStatus = -1 THEN
            EOF := TRUE;

        EXIT(Output);
    end;

    [Scope('Internal')]
    procedure GetSubfieldOf86(InputString: Text[1024]; SubfieldNo: Text[2]; Delimiter: Text[1]): Text[1024]
    var
        RemainingString: Text[1024];
        StartPosition: Integer;
    begin
        StartPosition := STRPOS(InputString, Delimiter + SubfieldNo);
        IF StartPosition > 0 THEN BEGIN
            RemainingString := COPYSTR(InputString, StartPosition + STRLEN(Delimiter) + STRLEN(SubfieldNo));
            StartPosition := STRPOS(RemainingString, Delimiter);
            IF StartPosition > 0 THEN BEGIN
                RemainingString := COPYSTR(RemainingString, 1, StartPosition - 1);
            END;
            RemainingString := DELCHR(RemainingString, '<>', ' ');
            RemainingString := DELCHR(RemainingString, '<', '.');
            EXIT(RemainingString);
        END ELSE
            EXIT('');
    end;

    [Scope('Internal')]
    procedure GetVSCSSS(InputString: Text[1024]): Text[1024]
    begin
        EXIT(DELCHR(CODE2DIGIT(InputString), '<', '0'));
    end;

    [Scope('Internal')]
    procedure DecodeBankAcc(BankAccData: Text[1024])
    var
        TempHeader2: Record "Bank Statement Header" temporary;
        i: Integer;
        BankAccData2: Text[1024];
        BankAccPart1: Code[50];
        BankAccPart2: Code[50];
        FoundedBankCode: Code[20];
        IsIBAN: Boolean;
    begin
        BankAccData2 := BankAccData;
        BankAccData := DELCHR(BankAccData, '>', ' ');
        BankAccData := DELCHR(BankAccData, '<', '/');
        i := STRPOS(BankAccData, '/');
        IF i <> 0 THEN BEGIN
            BankAccPart1 := COPYSTR(BankAccData, 1, i - 1);
            BankAccPart2 := COPYSTR(BankAccData, i + 1);
        END ELSE BEGIN
            BankAccPart1 := '';
            BankAccPart2 := BankAccData;
        END;


        IF BankAccPart1 = '' THEN BEGIN
            IF NOT (BankAccPart2[1] IN ['0' .. '9']) THEN
                TempHeader2.IBAN := BankAccPart2
            ELSE
                TempHeader2."Bank Account No." := FORMAT(BankAccPart2, -MAXSTRLEN(TempHeader2."Bank Account No."));
        END ELSE BEGIN
            IsIBAN := NOT (BankAccPart2[1] IN ['0' .. '9']);
            IF IsIBAN THEN BEGIN
                TempHeader2.IBAN := BankAccPart2;

                IF NOT (BankAccPart1[1] IN ['0' .. '9']) THEN BEGIN
                    FoundedBankCode := FindBankCode('CHAR', BankAccPart1, 'SWIFT');
                    IF FoundedBankCode <> '' THEN
                        TempHeader2."SWIFT Code" := FoundedBankCode
                    ELSE
                        TempHeader2."SWIFT Code" := BankAccPart1;
                END ELSE BEGIN
                    FoundedBankCode := FindBankCode('NUM', BankAccPart1, 'SWIFT');
                    IF FoundedBankCode <> '' THEN
                        TempHeader2."SWIFT Code" := FoundedBankCode;
                END;
            END ELSE BEGIN
                IF BankAccPart1[1] IN ['0' .. '9'] THEN BEGIN
                    TempHeader2."Bank Account No." := FormatBankAccNo2(BankAccPart2 + '/' + BankAccPart1);
                END ELSE BEGIN
                    FoundedBankCode := FindBankCode('', BankAccPart1, 'NUM');
                    IF FoundedBankCode <> '' THEN
                        TempHeader2."Bank Account No." := FormatBankAccNo2(BankAccPart2 + FoundedBankCode)
                    ELSE
                        TempHeader2."Bank Account No." := FORMAT(BankAccPart2 + '/' + BankAccPart1, -MAXSTRLEN(TempHeader2."Bank Account No."));
                END;
            END;
        END;

        BankAccData := TempHeader2."Bank Account No.";
        IF BankAccData = '' THEN
            BankAccData := TempHeader2.IBAN;

        IsBlockForThisAccount := CheckStatementBankAccNo2(SourceHeader, BankAccData, FALSE);
        IF NOT IsBlockForThisAccount THEN
            IsBlockForThisAccount := CheckStatementBankAccNo2(SourceHeader, BankAccData2, FALSE);

        // Start DAFCZ.1
        IF NOT IsBlockForThisAccount THEN
            IsBlockForThisAccount := CheckStatementBankAccNo2(SourceHeader, BankAccPart2, FALSE);
        // Stop DAFCZ.1

        IF IsBlockForThisAccount THEN BEGIN
            TempHeader."Bank Account No." := TempHeader2."Bank Account No.";
            TempHeader.IBAN := TempHeader2.IBAN;
            TempHeader."SWIFT Code" := TempHeader2."SWIFT Code";
        END;
    end;

    local procedure ProcessVUB_121105(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
    begin
        Delimiter := '?';

        CluePosition := 0;

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF COPYSTR(Data, 15, 1) = 'R' THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '000':
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '32', Delimiter);
                    TempLine."Account No." := DELCHR(GetSubfieldOf86(Data, '23', Delimiter), '<', ' ');
                    i := STRPOS(TempLine."Account No.", '/');
                    IF i <> 0 THEN
                        TempLine."Account No." :=
                          FormatBankAccNo2(
                                       TempLine."Account No.");

                    TempLine."Variable Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '20', Delimiter));
                    TempLine."Specific Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '22', Delimiter));
                    TempLine."Constant Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '21', Delimiter));
                END;
            '030': //international payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '20', Delimiter);
                    BankAcc := GetSubfieldOf86(Data, '25', Delimiter);
                    IF BankAcc IN ['0' .. '9'] THEN
                        TempLine."Account No." := BankAcc
                    ELSE
                        TempLine.IBAN := BankAcc;
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
            //'040':
            '040', '808', '809', '814', '833', '835', '899': //other payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '00', Delimiter);
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessOBER_121105(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
    begin
        Delimiter := '?';

        CluePosition := 0;
        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF COPYSTR(Data, 15, 1) = 'R' THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));
        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '020', '051', '083', '805', '820':
                BEGIN
                    TempLine.Description := COPYSTR(GetSubfieldOf86(Data, '20', Delimiter) +
                                                    GetSubfieldOf86(Data, '21', Delimiter) +
                                                    GetSubfieldOf86(Data, '22', Delimiter) +
                                                    GetSubfieldOf86(Data, '23', Delimiter) +
                                                    GetSubfieldOf86(Data, '24', Delimiter) +
                                                    GetSubfieldOf86(Data, '25', Delimiter) +
                                                    GetSubfieldOf86(Data, '26', Delimiter) +
                                                    GetSubfieldOf86(Data, '27', Delimiter) +
                                                    GetSubfieldOf86(Data, '28', Delimiter) +
                                                    GetSubfieldOf86(Data, '29', Delimiter), 1, 50);

                    TempLine."Account No." := GetSubfieldOf86(Data, '31', Delimiter) + '/' + GetSubfieldOf86(Data, '30', Delimiter);
                    i := STRPOS(TempLine."Account No.", '/');
                    IF i <> 0 THEN
                        TempLine."Account No." :=
                          FormatBankAccNo2(
                                       TempLine."Account No.");

                    TempLine."Variable Symbol" := GetVSCSSS2(TempLine.Description, 'VS:');
                    TempLine."Specific Symbol" := GetVSCSSS2(TempLine.Description, 'SS:');
                    TempLine."Constant Symbol" := GetVSCSSS2(TempLine.Description, 'KS:');
                END;
            '999':
                BEGIN
                    TempLine.Description := COPYSTR(Data, 8);
                END;
        END;

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    local procedure ProcessUCBSK_121105(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
        lTempText: Text[1024];
    begin
        Delimiter := '?';

        CluePosition := 0;
        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF COPYSTR(Data, 15, 1) = 'R' THEN
            CancelOffset := 1;

        StartPosition := 15 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            'REF':
                BEGIN

                    lTempText := COPYSTR(Data, 8);
                    TempLine.Description := COPYSTR(lTempText, 1, MAXSTRLEN(TempLine.Description));
                    IF Sign = 1 THEN
                        TempLine."Account No." := GetVSCSSS2(lTempText, 'Z:')
                    ELSE
                        TempLine."Account No." := GetVSCSSS2(lTempText, 'NA:');


                    i := STRPOS(TempLine."Account No.", '/');
                    IF i <> 0 THEN
                        TempLine."Account No." :=
                          FormatBankAccNo2(
                                       TempLine."Account No.");

                    TempLine."Variable Symbol" := GetVSCSSS2(lTempText, 'VS:');
                    TempLine."Specific Symbol" := GetVSCSSS2(lTempText, 'SS:');
                    TempLine."Constant Symbol" := GetVSCSSS2(lTempText, 'KS:');
                END;
        END;

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure GetVSCSSS2(InputString: Text[1024]; String2: Text[30]): Text[1024]
    var
        i: Integer;
        lRetValue: Text[1024];
    begin
        i := STRPOS(InputString, String2);
        IF i = 0 THEN
            EXIT('');

        InputString := COPYSTR(InputString, i + STRLEN(String2));
        InputString := DELCHR(InputString, '<', ' ');


        FOR i := 1 TO STRLEN(InputString) DO
            IF InputString[i] IN ['0' .. '9', '/'] THEN
                lRetValue := lRetValue + FORMAT(InputString[i])
            ELSE
                EXIT(lRetValue);
        EXIT(lRetValue);
    end;

    local procedure ProcessLUDOVABANKA_130327(): Boolean
    var
        Sign: Integer;
        CluePosition: Integer;
        CancelOffset: Integer;
        StartPosition: Integer;
        AmountText: Text[30];
        AmountText2: Text[30];
        i: Integer;
        Continue: Boolean;
        Delimiter: Text[1];
        BankAcc: Text[100];
        lteTempText: Text[1024];
    begin
        Delimiter := '?';

        CluePosition := 0;

        Sign := GetSign(COPYSTR(Data, 15, 2));

        CancelOffset := 0;
        IF COPYSTR(Data, 15, 1) = 'R' THEN
            CancelOffset := 1;

        StartPosition := 11 + CancelOffset + 1;
        CLEAR(AmountText);
        IF CluePosition = 0 THEN BEGIN
            AmountText2 := COPYSTR(Data, StartPosition, 15);
            i := 1;
            Continue := TRUE;
            WHILE (i <= STRLEN(AmountText2)) AND Continue DO BEGIN
                IF AmountText2[i] IN ['0' .. '9', ','] THEN
                    AmountText += FORMAT(AmountText2[i])
                ELSE
                    Continue := FALSE;
                i += 1;
            END;
        END ELSE
            AmountText := COPYSTR(Data, StartPosition, CluePosition - StartPosition);

        TempLine."Currency Code" := TempHeader."Currency Code";
        TempLine."Bank Statement Currency Code" := TempHeader."Bank Statement Currency Code";
        TempLine."Bank Statement Currency Factor" := TempHeader."Bank Statement Currency Factor";

        TempLine.VALIDATE(Amount, TXT2DEC(AmountText, Sign));

        Data := LoadRecord;

        IF COPYSTR(Data, 1, 4) <> ':86:' THEN
            EXIT(FALSE);

        CASE COPYSTR(Data, 5, 3) OF
            '004', '008', '020', '051', '071', '082', '083', '087', '088': //domestic payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '32', Delimiter);
                    TempLine."Account No." := DELCHR(GetSubfieldOf86(Data, '31', Delimiter), '<', ' ');
                    TempLine."Account No." := DELCHR(TempLine."Account No.", '<', '0');
                    TempLine."Account No." := TempLine."Account No." + DELCHR(GetSubfieldOf86(Data, '30', Delimiter), '<', ' ');
                    i := STRPOS(TempLine."Account No.", '/');
                    IF i <> 0 THEN
                        TempLine."Account No." :=
                          FormatBankAccNo2(
                            COPYSTR(TempLine."Account No.", i + 1) + COPYSTR(TempLine."Account No.", 1, i - 1));

                    TempLine."Variable Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '22', Delimiter));
                    TempLine."Specific Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '23', Delimiter));
                    TempLine."Constant Symbol" := GetVSCSSS(GetSubfieldOf86(Data, '21', Delimiter));
                END;
            '010':
                BEGIN
                    lteTempText := GetSubfieldOf86(Data, '20', Delimiter) +
                                   GetSubfieldOf86(Data, '21', Delimiter) +
                                   GetSubfieldOf86(Data, '22', Delimiter) +
                                   GetSubfieldOf86(Data, '23', Delimiter) +
                                   GetSubfieldOf86(Data, '24', Delimiter);
                    TempLine.Description := COPYSTR(lteTempText, 1, MAXSTRLEN(TempLine.Description));
                END;
            '030': //international payment transaction
                BEGIN
                    TempLine.Description := GetSubfieldOf86(Data, '20', Delimiter);
                    BankAcc := GetSubfieldOf86(Data, '25', Delimiter);
                    IF BankAcc IN ['0' .. '9'] THEN
                        TempLine."Account No." := BankAcc
                    ELSE
                        TempLine.IBAN := BankAcc;
                    TempLine."SWIFT Code" := COPYSTR(GetSubfieldOf86(Data, '30', Delimiter), 1, 20);
                    TempLine.IBAN := COPYSTR(GetSubfieldOf86(Data, '31', Delimiter), 1, 50);
                END;
            '040', '808', '809', '814', '833', '835', '899': //other payment transaction
                BEGIN
                    TempLine.Description := COPYSTR(GetSubfieldOf86(Data, '00', Delimiter) +
                                                    GetSubfieldOf86(Data, '20', Delimiter) +
                                                    GetSubfieldOf86(Data, '21', Delimiter) +
                                                    GetSubfieldOf86(Data, '22', Delimiter) +
                                                    GetSubfieldOf86(Data, '23', Delimiter) +
                                                    GetSubfieldOf86(Data, '24', Delimiter) +
                                                    GetSubfieldOf86(Data, '25', Delimiter) +
                                                    GetSubfieldOf86(Data, '26', Delimiter) +
                                                    GetSubfieldOf86(Data, '27', Delimiter) +
                                                    GetSubfieldOf86(Data, '28', Delimiter) +
                                                    GetSubfieldOf86(Data, '29', Delimiter), 1, 50);
                END;
        END;
        //========== object specific code ===============

        FormatBankAccNo(TempLine."Account No.");
        FormatVariableSymbol(TempLine."Variable Symbol");
        FormatSpecificSymbol(TempLine."Specific Symbol");
        FormatConstantSymbol(TempLine."Constant Symbol");

        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure "***Coversion Utils***"()
    begin
    end;

    [Scope('Internal')]
    procedure TEXT1250TO852(InText: Text[250]) OutText: Text[250]
    var
        Pos: Integer;
    begin
        OutText := '';
        FOR Pos := 1 TO STRLEN(InText) DO OutText := OutText + FORMAT(CP1250TO852(InText[Pos]));
    end;

    [Scope('Internal')]
    procedure BEZDIAKRITIKY(InText: Text[250]) OutText: Text[250]
    begin
        OutText := CONVERTSTR(InText, 'áäčďěéíĺľňóôöřšťúůýžÁÄČĎĚÉÍĹĽŇÓÖÔŘŠŤÚŮÝŽ',
                                     'aacdeeillnooorstuuyzAACDEEILLNOOORSTUUYZ');
    end;

    [Scope('Internal')]
    procedure CP1250TO852(Character: Char) New: Char
    begin
        IF Character > 127 THEN
            CASE Character OF
                138:
                    New := 230; // Š LATIN CAPITAL LETTER S WITH CARON
                140:
                    New := 151; // Ś LATIN CAPITAL LETTER S WITH ACUTE
                141:
                    New := 155; // Ť LATIN CAPITAL LETTER T WITH CARON
                142:
                    New := 166; // Ž LATIN CAPITAL LETTER Z WITH CARON
                143:
                    New := 141; // Ź LATIN CAPITAL LETTER Z WITH ACUTE
                154:
                    New := 231; // š LATIN SMALL LETTER S WITH CARON
                156:
                    New := 152; // ś LATIN SMALL LETTER S WITH ACUTE
                157:
                    New := 156; // ť LATIN SMALL LETTER T WITH CARON
                158:
                    New := 167; // ž LATIN SMALL LETTER Z WITH CARON
                159:
                    New := 171; // ź LATIN SMALL LETTER Z WITH ACUTE
                160:
                    New := 255; //   NO-BREAK SPACE
                161:
                    New := 243; // ˇ CARON
                162:
                    New := 244; // ˘ BREVE
                163:
                    New := 157; // Ł LATIN CAPITAL LETTER L WITH STROKE
                164:
                    New := 207; // ¤ CURRENCY SIGN
                165:
                    New := 164; // Ą LATIN CAPITAL LETTER A WITH OGONEK
                167:
                    New := 245; // § SECTION SIGN
                168:
                    New := 249; // ¨ DIAERESIS
                170:
                    New := 184; // Ş LATIN CAPITAL LETTER S WITH CEDILLA
                171:
                    New := 174; // « 171 LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
                173:
                    New := 240; // ­ SOFT HYPHEN
                175:
                    New := 189; // Ż LATIN CAPITAL LETTER Z WITH DOT ABOVE
                176:
                    New := 248; // ° DEGREE SIGN
                178:
                    New := 242; // ˛ OGONEK
                179:
                    New := 136; // ł LATIN SMALL LETTER L WITH STROKE
                180:
                    New := 239; // ´ ACUTE ACCENT
                184:
                    New := 247; // ¸ CEDILLA
                185:
                    New := 165; // ą LATIN SMALL LETTER A WITH OGONEK
                186:
                    New := 173; // ş LATIN SMALL LETTER S WITH CEDILLA
                187:
                    New := 175; // » RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
                188:
                    New := 149; // Ľ LATIN CAPITAL LETTER L WITH CARON
                189:
                    New := 241; // ˝ DOUBLE ACUTE ACCENT
                190:
                    New := 150; // ľ LATIN SMALL LETTER L WITH CARON
                191:
                    New := 190; // ż LATIN SMALL LETTER Z WITH DOT ABOVE
                192:
                    New := 232; // Ŕ LATIN CAPITAL LETTER R WITH ACUTE
                193:
                    New := 181; // Á LATIN CAPITAL LETTER A WITH ACUTE
                194:
                    New := 182; // Â LATIN CAPITAL LETTER A WITH CIRCUMFLEX
                195:
                    New := 198; // Ă LATIN CAPITAL LETTER A WITH BREVE
                196:
                    New := 142; // Ä LATIN CAPITAL LETTER A WITH DIAERESIS
                197:
                    New := 145; // Ĺ LATIN CAPITAL LETTER L WITH ACUTE
                198:
                    New := 143; // Ć LATIN CAPITAL LETTER C WITH ACUTE
                199:
                    New := 128; // Ç LATIN CAPITAL LETTER C WITH CEDILLA
                200:
                    New := 172; // Č LATIN CAPITAL LETTER C WITH CARON
                201:
                    New := 144; // É LATIN CAPITAL LETTER E WITH ACUTE
                202:
                    New := 168; // Ę LATIN CAPITAL LETTER E WITH OGONEK
                203:
                    New := 211; // Ë LATIN CAPITAL LETTER E WITH DIAERESIS
                204:
                    New := 183; // Ě LATIN CAPITAL LETTER E WITH CARON
                205:
                    New := 214; // Í LATIN CAPITAL LETTER I WITH ACUTE
                206:
                    New := 215; // Î LATIN CAPITAL LETTER I WITH CIRCUMFLEX
                207:
                    New := 210; // Ď LATIN CAPITAL LETTER D WITH CARON
                208:
                    New := 209; // Đ LATIN CAPITAL LETTER D WITH STROKE
                209:
                    New := 227; // Ń LATIN CAPITAL LETTER N WITH ACUTE
                210:
                    New := 213; // Ň LATIN CAPITAL LETTER N WITH CARON
                211:
                    New := 224; // Ó LATIN CAPITAL LETTER O WITH ACUTE
                212:
                    New := 226; // Ô LATIN CAPITAL LETTER O WITH CIRCUMFLEX
                213:
                    New := 138; // Ő LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
                214:
                    New := 153; // Ö LATIN CAPITAL LETTER O WITH DIAERESIS
                215:
                    New := 158; // × MULTIPLICATION SIGN
                216:
                    New := 252; // Ř LATIN CAPITAL LETTER R WITH CARON
                217:
                    New := 222; // Ů LATIN CAPITAL LETTER U WITH RING ABOVE
                218:
                    New := 233; // Ú LATIN CAPITAL LETTER U WITH ACUTE
                219:
                    New := 235; // Ű LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
                220:
                    New := 154; // Ü LATIN CAPITAL LETTER U WITH DIAERESIS
                221:
                    New := 237; // Ý LATIN CAPITAL LETTER Y WITH ACUTE
                222:
                    New := 221; // Ţ LATIN CAPITAL LETTER T WITH CEDILLA
                223:
                    New := 225; // ß LATIN SMALL LETTER SHARP S
                224:
                    New := 234; // ŕ LATIN SMALL LETTER R WITH ACUTE
                225:
                    New := 160; // á LATIN SMALL LETTER A WITH ACUTE
                226:
                    New := 131; // â LATIN SMALL LETTER A WITH CIRCUMFLEX
                227:
                    New := 199; // ă LATIN SMALL LETTER A WITH BREVE
                228:
                    New := 132; // ä LATIN SMALL LETTER A WITH DIAERESIS
                229:
                    New := 146; // ĺ LATIN SMALL LETTER L WITH ACUTE
                230:
                    New := 134; // ć LATIN SMALL LETTER C WITH ACUTE
                231:
                    New := 135; // ç LATIN SMALL LETTER C WITH CEDILLA
                232:
                    New := 159; // č LATIN SMALL LETTER C WITH CARON
                233:
                    New := 130; // é LATIN SMALL LETTER E WITH ACUTE
                234:
                    New := 169; // ę LATIN SMALL LETTER E WITH OGONEK
                235:
                    New := 137; // ë LATIN SMALL LETTER E WITH DIAERESIS
                236:
                    New := 216; // ě LATIN SMALL LETTER E WITH CARON
                237:
                    New := 161; // í LATIN SMALL LETTER I WITH ACUTE
                238:
                    New := 140; // î LATIN SMALL LETTER I WITH CIRCUMFLEX
                239:
                    New := 212; // ď LATIN SMALL LETTER D WITH CARON
                240:
                    New := 208; // đ LATIN SMALL LETTER D WITH STROKE
                241:
                    New := 228; // ń LATIN SMALL LETTER N WITH ACUTE
                242:
                    New := 229; // ň LATIN SMALL LETTER N WITH CARON
                243:
                    New := 162; // ó LATIN SMALL LETTER O WITH ACUTE
                244:
                    New := 147; // ô LATIN SMALL LETTER O WITH CIRCUMFLEX
                245:
                    New := 139; // ő LATIN SMALL LETTER O WITH DOUBLE ACUTE
                246:
                    New := 148; // ö LATIN SMALL LETTER O WITH DIAERESIS
                247:
                    New := 246; // ÷ DIVISION SIGN
                248:
                    New := 253; // ř LATIN SMALL LETTER R WITH CARON
                249:
                    New := 133; // ů LATIN SMALL LETTER U WITH RING ABOVE
                250:
                    New := 163; // ú LATIN SMALL LETTER U WITH ACUTE
                251:
                    New := 251; // ű LATIN SMALL LETTER U WITH DOUBLE ACUTE
                252:
                    New := 129; // ü LATIN SMALL LETTER U WITH DIAERESIS
                253:
                    New := 236; // ý LATIN SMALL LETTER Y WITH ACUTE
                254:
                    New := 238; // ţ LATIN SMALL LETTER T WITH CEDILLA
                255:
                    New := 250; // ˙ DOT ABOVE
            END
        ELSE
            New := Character;
    end;

    [Scope('Internal')]
    procedure "***ABO Management***"()
    begin
    end;

    [Scope('Internal')]
    procedure CheckStatementBankAccNo(BankStatHeader2: Record "Bank Statement Header"; ImportBankAccNo: Text[50])
    begin
        IF CheckStatementBankAccNo2(BankStatHeader2, ImportBankAccNo, TRUE) THEN;
    end;

    [Scope('Internal')]
    procedure CheckStatementBankAccNo2(BankStatHeader2: Record "Bank Statement Header"; ImportBankAccNo: Text[50]; ShowError: Boolean): Boolean
    var
        Found: Boolean;
        bankAccount: Record "Bank Account";
    begin
        IF bankAccount.GET(BankStatHeader2."Bank Account No.") THEN BEGIN
            //API-SMPE-030817-API01 ->
            IF (STRLEN(ImportBankAccNo) > 10) AND (STRPOS(ImportBankAccNo, '-') = 0) THEN
                bankAccount."Bank Account No." := DELCHR(bankAccount."Bank Account No.", '=', '-');
            //API-SMPE-030817-API01 <-
            IF bankAccount."Bank Account No." <> '' THEN
                Found := PADSTR(DELCHR(bankAccount."Bank Account No.", '<', '0'), 16, '0') = PADSTR(DELCHR(ImportBankAccNo, '<', '0'), 16, '0');

            IF NOT Found THEN
                Found := bankAccount.IBAN = ImportBankAccNo;
        END;

        IF ShowError THEN BEGIN
            IF NOT Found THEN
                ERROR(
                  BANKACC_ERR,
                  BankStatHeader2.FIELDCAPTION("Bank Account No."),
                  ImportBankAccNo
                )
            ELSE
                EXIT(TRUE);
        END ELSE
            EXIT(Found);
    end;

    [Scope('Internal')]
    procedure StatementExists(BankStatHeader2: Record "Bank Statement Header"; StatementDate: Date; ImportNo: Code[20]): Boolean
    var
        BankStatHeader: Record "Bank Statement Header";
    begin
        IF (StatementDate = 0D) OR (ImportNo = '') THEN
            EXIT(FALSE);

        BankStatHeader.SETFILTER("No.", '<>%1', BankStatHeader2."No.");
        BankStatHeader.SETRANGE("Bank Account No.", BankStatHeader2."Bank Account No.");
        BankStatHeader.SETRANGE("External Document No.", ImportNo);

        BankStatHeader.SETRANGE(
          "Document Date",
          CALCDATE('<CY-1Y+1D>', StatementDate),
          CALCDATE('<CY>', StatementDate)
        );
        IF NOT BankStatHeader.ISEMPTY THEN
            EXIT(NOT CONFIRM(STAT_EXISTS, FALSE, ImportNo))
        ELSE
            EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure UpdateStatement(var BankStatHeader: Record "Bank Statement Header"; var BankStatHeader2: Record "Bank Statement Header"; Replace: Boolean): Boolean
    begin
        IF Replace OR (NOT Replace AND (BankStatHeader2."External Document No." <> '')) THEN
            BankStatHeader."External Document No." := BankStatHeader2."External Document No.";
        IF Replace OR (NOT Replace AND (BankStatHeader2."Document Date" <> 0D)) THEN
            BankStatHeader."Document Date" := BankStatHeader2."Document Date";
        IF Replace OR (NOT Replace AND (BankStatHeader2."Currency Code" <> '')) THEN
            BankStatHeader."Currency Code" := BankStatHeader2."Currency Code";
        IF Replace OR (NOT Replace AND (BankStatHeader2."Currency Factor" <> 0)) THEN
            BankStatHeader."Currency Factor" := BankStatHeader2."Currency Factor";
    end;

    [Scope('Internal')]
    procedure "***ABO Functions***"()
    begin
    end;

    [Scope('Internal')]
    procedure MAXINT(Value1: Integer; Value2: Integer): Integer
    begin
        IF Value2 > Value1 THEN
            EXIT(Value2)
        ELSE
            EXIT(Value1);
    end;

    [Scope('Internal')]
    procedure GetSign(Text: Text[20]): Integer
    var
        Sign: Integer;
    begin
        CASE TRUE OF
            //credit or cancel debit or correction
            Text[1] = '+',
          Text[1] = 'C',
          COPYSTR(Text, 1, 2) = 'RD',
          Text[1] = '2',  //GPC
          Text[1] = '4'  //GPC
          :
                Sign := 1;

            //debit or cancel credit
            Text[1] = '-',
          Text[1] = 'D',
          COPYSTR(Text, 1, 2) = 'RC',
          Text[1] = '1',  //GPC
          Text[1] = '5'  //GPC
          :
                Sign := -1;
        END;
        EXIT(Sign);
    end;

    [Scope('Internal')]
    procedure TXT2DEC(Text: Text[250]; DecimalPlaces: Decimal) Amount: Decimal
    begin
        // Amount = Amount/DecimalPlaces {0=1; 100 (Amount = Text/100); etc...}
        // negative value is valid!

        Text := DELCHR(Text, '=', ' ');
        Text := CONVERTSTR(Text, ',', '.');
        IF Text[STRLEN(Text)] = '-' THEN
            Text := '-' + DELCHR(Text, '>', '-');
        IF Text[STRLEN(Text)] = '+' THEN
            Text := DELCHR(Text, '>', '+');
        IF NOT EVALUATE(Amount, Text) THEN BEGIN
            Text := CONVERTSTR(Text, '.', ',');
            IF NOT EVALUATE(Amount, Text) THEN
                EXIT(0);
        END;

        IF DecimalPlaces = 0 THEN
            DecimalPlaces := 1;

        Amount /= DecimalPlaces;
    end;

    [Scope('Internal')]
    procedure GetCorrection(Text: Text[20]): Boolean
    begin
        IF
          (COPYSTR(Text, 1, 2) = 'RD') OR
          (Text[1] = '5') OR  //GPC
          (COPYSTR(Text, 1, 2) = 'RC') OR
          (Text[1] = '4') OR //GPC
          (Text[1] = 'S')
        THEN
            EXIT(TRUE);

        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure FormatBankAccNo2(BankAccNo: Text[250]): Text[30]
    var
        BankAccNo2: Text[250];
        Prefix: Code[250];
        No: Code[250];
        Bank: Code[250];
        Pos1: Integer;
        Pos2: Integer;
        BANK_ACC_FORMAT: Label '%1-%2/%3';
        i: Integer;
    begin
        FormatBankAccNo(BankAccNo);
        EXIT(BankAccNo);
    end;

    [Scope('Internal')]
    procedure LPADSTR(Txt: Text[250]; Len: Integer; Filler: Text[1]): Text[250]
    begin
        IF STRLEN(Txt) > Len THEN
            EXIT(COPYSTR(Txt, STRLEN(Txt) - Len + 1, Len))
        ELSE BEGIN
            IF Filler = '' THEN
                Filler := ' ';
            WHILE STRLEN(Txt) < Len DO
                Txt := Filler + Txt;
            EXIT(Txt);
        END;
    end;

    [Scope('Internal')]
    procedure FormatBankAccNo(var BankAccNo: Text[250])
    var
        BankAccNo2: Text[250];
        Prefix: Code[250];
        No: Code[250];
        Bank: Code[250];
        Pos1: Integer;
        Pos2: Integer;
        BANK_ACC_FORMAT: Label '%1-%2/%3';
        i: Integer;
    begin
        BankAccNo := DELCHR(BankAccNo, '<', '0');
        IF COPYSTR(BankAccNo, 1, 1) = '-' THEN
            BankAccNo := DELCHR(COPYSTR(BankAccNo, 2), '<', '0');
    end;

    [Scope('Internal')]
    procedure FormatVariableSymbol(var VariableSymbol: Code[250])
    begin
        VariableSymbol := CODE2DIGIT(VariableSymbol);
        IF VariableSymbol = '' THEN
            EXIT;

        IF STRLEN(VariableSymbol) > 10 THEN
            VariableSymbol := COPYSTR(VariableSymbol, STRLEN(VariableSymbol) - 10 + 1);

        VariableSymbol := DELCHR(VariableSymbol, '<', '0');
    end;

    [Scope('Internal')]
    procedure FormatConstantSymbol(var ConstantSymbol: Code[250])
    begin
        ConstantSymbol := CODE2DIGIT(ConstantSymbol);
        IF ConstantSymbol = '' THEN
            EXIT;

        ConstantSymbol := LPADSTR(ConstantSymbol, 4, '0');
        IF STRLEN(ConstantSymbol) > 4 THEN
            ConstantSymbol := COPYSTR(ConstantSymbol, STRLEN(ConstantSymbol) - 4 + 1);
    end;

    [Scope('Internal')]
    procedure FormatSpecificSymbol(var SpecificSymbol: Code[250])
    begin
        SpecificSymbol := CODE2DIGIT(SpecificSymbol);
        IF SpecificSymbol = '' THEN
            EXIT;

        IF STRLEN(SpecificSymbol) > 10 THEN
            SpecificSymbol := COPYSTR(SpecificSymbol, STRLEN(SpecificSymbol) - 10 + 1);

        SpecificSymbol := DELCHR(SpecificSymbol, '<', '0');
    end;

    [Scope('Internal')]
    procedure CODE2DIGIT(Input: Code[250]) Out: Code[250]
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Input) DO
            IF Input[i] IN ['0' .. '9'] THEN
                Out := Out + FORMAT(Input[i]);

        EXIT(Out);
    end;

    [Scope('Internal')]
    procedure FindBankCode(FindTypeP: Code[5]; DataP: Code[20]; ReturnTypeP: Code[5]): Code[20]
    var
        FoundL: Boolean;
    begin
        IF DataP = '' THEN
            EXIT('');

        EXIT('');
    end;

    [Scope('Internal')]
    procedure FormatImportNo(var ImportNo: Code[250])
    begin
        ImportNo := CODE2DIGIT(ImportNo);
        IF ImportNo = '' THEN
            EXIT;

        IF (STRLEN(ImportNo) < 3) THEN
            ImportNo := LPADSTR(ImportNo, 3, '0');
    end;

    [Scope('Internal')]
    procedure FormatImportNo2(ImportNo: Code[250]): Code[250]
    begin
        FormatImportNo(ImportNo);
        EXIT(ImportNo);
    end;

    [Scope('Internal')]
    procedure GetCurr(CurrCode: Code[10]): Code[10]
    var
        generalLedgerSetup: Record "General Ledger Setup";
    begin
        generalLedgerSetup.GET;
        IF CurrCode = generalLedgerSetup."LCY Code" THEN
            CurrCode := '';

        EXIT(CurrCode);
    end;

    [Scope('Internal')]
    procedure GetDate(DateText: Text[30]; DateFormat: Text[20]): Date
    var
        MONTHS: Label 'JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC';
        Found: Boolean;
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        CASE DateFormat OF
            'DDmmmYY':  //26may09, 26MAY09
                BEGIN
                    DateText := UPPERCASE(DateText);
                    REPEAT
                        Month += 1;
                        Found := COPYSTR(DateText, 3, 3) = SELECTSTR(Month, MONTHS);
                    UNTIL Found OR (Month = 12);
                    IF Found THEN BEGIN
                        EVALUATE(Day, COPYSTR(DateText, 1, 2));
                        EVALUATE(Year, COPYSTR(DateText, 6, 2));
                        Year += 2000;
                        EXIT(DMY2DATE(Day, Month, Year));
                    END;
                END;
            'DDMMYY':  //260509
                BEGIN
                    EVALUATE(Day, COPYSTR(DateText, 1, 2));
                    EVALUATE(Month, COPYSTR(DateText, 3, 2));
                    EVALUATE(Year, COPYSTR(DateText, 5, 2));
                    Year += 2000;
                    EXIT(DMY2DATE(Day, Month, Year));
                END;
            'YYMMDD':  //090526
                BEGIN
                    EVALUATE(Day, COPYSTR(DateText, 5, 2));
                    EVALUATE(Month, COPYSTR(DateText, 3, 2));
                    EVALUATE(Year, COPYSTR(DateText, 1, 2));
                    Year += 2000;
                    EXIT(DMY2DATE(Day, Month, Year));
                END;
            'DD.MM.YYYY':  //02.08.2010
                BEGIN
                    EVALUATE(Day, COPYSTR(DateText, 1, 2));
                    EVALUATE(Month, COPYSTR(DateText, 4, 2));
                    EVALUATE(Year, COPYSTR(DateText, 7, 4));
                    EXIT(DMY2DATE(Day, Month, Year));
                END;
        END;
        EXIT(0D);
    end;

    [Scope('Internal')]
    procedure "***ABO File Management***"()
    begin
    end;

    [Scope('Internal')]
    procedure ABOFileReadLine(var DataP: Text[1024]): Integer
    begin
        EXIT(CurrFile.READ(DataP));
    end;

    [Scope('Internal')]
    procedure SelectBankStatementFileNameLoc(var lteReturnFileName: Text): Boolean
    var
        lcuFileMgt: Codeunit "File Management";
        ltcFileFilterTxt: Label 'Files (*.%1)|*.%1|All Files (*.*)|*.*';
        ltcFileFilterAllTxt: Label 'All Files (*.*)|*.*';
        lreBankAccount: Record "Bank Account";
        lreBankExportImportSetup: Record "Bank Export/Import Setup";
        lteFileType: Text;
        lteFileName: Text;
        ltcText001: Label 'Import Bank Statement';
    begin
        CLEAR(lteReturnFileName);

        SourceHeader.TESTFIELD("Bank Account No.");
        lreBankAccount.GET(SourceHeader."Bank Account No.");
        lreBankAccount.TESTFIELD("Bank Statement Import Format");
        lreBankExportImportSetup.GET(lreBankAccount."Bank Statement Import Format");
        lreBankExportImportSetup.TESTFIELD(Direction, lreBankExportImportSetup.Direction::Import);

        IF lreBankExportImportSetup."Default File Type" <> '' THEN
            lteFileType := STRSUBSTNO(ltcFileFilterTxt, lreBankExportImportSetup."Default File Type")
        ELSE
            lteFileType := ltcFileFilterAllTxt;

        lteReturnFileName := lcuFileMgt.OpenFileDialog(ltcText001, lreBankExportImportSetup."Default Folder Path", lteFileType);

        EXIT(lteReturnFileName <> '');
    end;
}


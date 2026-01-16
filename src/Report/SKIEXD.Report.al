report 80003 "DPG SKI:EXD" // 50051 "SKI:EXD"
{
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1    28.11.18 DV DAFCZ.1 Clear variables (79017688)
    // DAFCZ.1    30.11.18 DV DAFCZ.1 Due date always from header (79017688)
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/SKIEXD.rdlc';

    Permissions = TableData "Issued Payment Order Header" = rimd,
                  TableData "Issued Payment Order Line" = rimd;

    dataset
    {
        dataitem(IssuedPaymentOrderLineFilter; "Issued Payment Order Line")
        {
        }
        dataitem(SourceHeader; "Issued Payment Order Header")
        {
            dataitem(SourceLine; "Issued Payment Order Line")
            {

                trigger OnAfterGetRecord()
                var
                    lreGeneralLedgerSetup: Record "General Ledger Setup";
                begin

                    //========== object specific code ===============
                    EntryNo := INCSTR(EntryNo);

                    EntryType := '11';

                    LineAmount := FormatAmount(Amount, 'ID');
                    LineAmount := LPADSTR(LineAmount, 15, '0');
                    lreGeneralLedgerSetup.GET;
                    CurrCode := lreGeneralLedgerSetup."LCY Code";

                    EntryDate := FormatDate(TODAY, 'YYMMDD');

                    // Start DAFCZ.1
                    DueDate := FormatDate(SourceHeader."Document Date", 'YYMMDD');
                    // Stop DAFCZ.1

                    IF ("Constant Symbol" = '') THEN
                        ConstantSymbol := '0'
                    ELSE
                        ConstantSymbol := LPADSTR("Constant Symbol", 4, '0');

                    VariabileSymbol := LPADSTR("Variable Symbol", 10, '0');
                    SpecificSymbol := LPADSTR("Specific Symbol", 10, '0');

                    CLEAR(CreditBankNo);
                    CLEAR(CreditBankPrefix);
                    CLEAR(CreditBankCode);
                    // Start DAFCZ.1
                    CLEAR(AccName);
                    // Stop DAFCZ.1
                    SplitBankAccNo("Account No.", CreditBankPrefix, CreditBankNo, CreditBankCode);

                    CreditBankCode := LPADSTR(CreditBankCode, 4, '0');

                    CASE Type OF
                        Type::Customer:
                            BEGIN
                                Customer.GET("No.");
                                AccName := Customer.Name;
                            END;
                        Type::Vendor:
                            BEGIN
                                Vendor.GET("No.");
                                AccName := Vendor.Name;
                            END;
                        Type::"Bank Account":
                            BEGIN
                                BankAcc.GET("No.");
                                AccName := BankAcc.Name;
                            END;
                    END;
                    AccName := UPPERCASE(BEZDIAKRITIKY(COPYSTR(AccName, 1, 35)));
                    IF AccName = '' THEN
                        AccName := ' ';

                    OrderCount := INCSTR(OrderCount);
                    OrderTotalAmount += Amount;

                    CreditInfo2 := '';
                    SenderAccName := '';
                    RecipientAccName := '';
                    DebetVariabileSymbol := '0000000000';
                    DebetSpecificSymbol := '0000000000';
                    DebetInfo := '';
                    Advice := '';

                    CompName := UPPERCASE(BEZDIAKRITIKY(COPYSTR(CompInfo.Name, 1, 35)));
                    IF CompName = '' THEN
                        CompName := ' ';
                    CompAddress := COPYSTR(CompInfo.Address, 1, 35);
                    CompAddress := UPPERCASE(BEZDIAKRITIKY(CompAddress));
                    CompCity := COPYSTR(CompInfo.City, 1, 35);
                    CompCity := UPPERCASE(BEZDIAKRITIKY(CompCity));
                    CreditInfo := UPPERCASE(BEZDIAKRITIKY(COPYSTR(Description, 1, 35)));
                    IF CreditInfo = '' THEN
                        CreditInfo := ' ';

                    //write to file
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'HD:%1 %2 %3 %4 %5',
                        EntryType, DueDate, DebetBankCode, EntryNo, CreditBankCode
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'KC:%1 %2 %3',
                        LineAmount, '000000', CurrCode
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'UD:%1 %2 %3',
                        DebetBankPrefix, DebetBankNo, FORMAT(CompName, -20)
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'AD:%1',
                        DebetSpecificSymbol
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'DI:%1',
                        CompName
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        '   %1',
                        CompAddress
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        '   %1',
                        CompCity
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'UK:%1 %2 %3',
                        CreditBankPrefix, CreditBankNo, FORMAT(AccName, -20)
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'AK:%1',
                        SpecificSymbol
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'KI:%1',
                        AccName
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'EC:%1',
                        ConstantSymbol
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'ZD:%1',
                        DebetVariabileSymbol
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'ZK:%1',
                        VariabileSymbol
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'AV:%1',
                        CreditInfo
                      )
                    );
                    //========== object specific code ===============
                end;

                trigger OnPostDataItem()
                begin

                    //========== object specific code ===============
                    OrderTotalAmountTXT := FormatAmount(OrderTotalAmount, 'ID');
                    OrderTotalAmountTXT := LPADSTR(OrderTotalAmountTXT, 15, '0');

                    EncashTotalAmountTXT := FormatAmount(EncashTotalAmount, 'ID');
                    EncashTotalAmountTXT := LPADSTR(EncashTotalAmountTXT, 15, '0');

                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'S1:%1 %2',
                        OrderCount, OrderTotalAmountTXT
                      )
                    );
                    ABOFileWriteLine(
                      STRSUBSTNO(
                        'S3:%1 %2',
                        EncashCount, EncashTotalAmountTXT
                      )
                    );
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Payment Order No.", SourceHeader."No.");
                    SETRANGE(Status, Status::" ");


                    //========== object specific code ===============
                    EntryNo := '000000';
                    OrderCount := '000000000';
                    EncashCount := '000000000';
                    EncashTotalAmount := 0;

                    CLEAR(DebetBankNo);
                    CLEAR(DebetBankPrefix);
                    CLEAR(DebetBankCode);
                    SplitBankAccNo(SourceHeader."Account No.", DebetBankPrefix, DebetBankNo, DebetBankCode);

                    DebetBankCode := LPADSTR(DebetBankCode, 4, '0');
                    //========== object specific code ===============
                end;
            }

            trigger OnAfterGetRecord()
            begin

                TESTFIELD("Document Date");
            end;

            trigger OnPostDataItem()
            begin

                CurrFile.CLOSE;

                FileMgt.DownloadToFile(TmpFile, DestFile);

                Header.GET(SourceHeader."No.");
                Header."File Name" := FORMAT(DestFile, -MAXSTRLEN(Header."File Name"));
                //Header.MODIFY;
            end;

            trigger OnPreDataItem()
            var
                lcoNo: Code[20];
            begin
                SETFILTER("No.", IssuedPaymentOrderLineFilter.GETFILTER("Payment Order No."));

                IF COUNT <> 1 THEN
                    ERROR(Text001);

                FINDFIRST;

                IF NOT SelectPaymentOrderFileNameLoc(DestFile) THEN
                    ERROR(FileErrorTxt);

                TmpFile := FileMgt.ServerTempFileName('');
                CurrFile.CREATE(TmpFile);
                CurrFile.TEXTMODE(TRUE);

                //========== object specific code ===============
                CompInfo.GET;
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
        Header: Record "Issued Payment Order Header";
        Line: Record "Issued Payment Order Line";
        //UseDialog: Boolean;
        LinesNo: Integer;
        LineNo: Integer;
        Data: Text[1024];
        "***": Integer;
        CompInfo: Record "Company Information";
        EntryNo: Text[6];
        EntryType: Text[2];
        EntryDate: Text[6];
        DebetBankCode: Code[7];
        CreditBankCode: Code[7];
        LineAmount: Text[15];
        DueDate: Text[6];
        ConstantSymbol: Text[10];
        VariabileSymbol: Text[10];
        SpecificSymbol: Text[10];
        DebetBankPrefix: Code[6];
        DebetBankNo: Code[10];
        CreditBankPrefix: Code[6];
        CreditBankNo: Code[10];
        CreditInfo: Text[35];
        CreditInfo2: Text[70];
        SenderAccName: Text[20];
        RecipientAccName: Text[20];
        DebetVariabileSymbol: Text[10];
        DebetSpecificSymbol: Text[10];
        DebetInfo: Text[140];
        Advice: Text[140];
        CurrCode: Code[10];
        OrderCount: Text[9];
        OrderTotalAmount: Decimal;
        OrderTotalAmountTXT: Text[15];
        EncashCount: Text[9];
        EncashTotalAmount: Decimal;
        EncashTotalAmountTXT: Text[15];
        AccName: Text[50];
        CompName: Text[35];
        CompAddress: Text[35];
        CompCity: Text[35];
        BankAcc: Record "Bank Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FILETYPE: Label 'SKI Files (*.ski)|*.ski|Text Files (*.txt)|*.txt|All Files (*.*)|*.*';
        Text001: Label 'You can export from one payment order only.';
        BANKACC_ERR: Label 'Not same %1 (%2).';
        Text007: Label 'Open';
        Text009: Label 'All Files (*.*)|*.*';
        STAT_EXISTS: Label 'Bank Statement with number %1 already exists in this year. Continue?';
        Text006: Label 'Save';
        FileMgt: Codeunit "File Management";
        TmpFile: Text[1024];
        DestFile: Text[1024];
        CurrFile: File;
        FileErrorTxt: Label 'The fle was not selected.';

    [Scope('Internal')]
    procedure "***Coversion Utils***"()
    begin
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
    procedure CheckStatementBankAccNo2(BankStatHeader2: Record "Bank Statement Header"; ImportBankAccNo: Text[50]; ShowError: Boolean): Boolean
    var
        Found: Boolean;
        bankAccount: Record "Bank Account";
    begin
        IF bankAccount.GET(BankStatHeader2."Bank Account No.") THEN BEGIN
            IF bankAccount."Bank Account No." <> '' THEN
                Found := bankAccount."Bank Account No." = ImportBankAccNo;

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
    procedure "***ABO Functions***"()
    begin
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
        IF STRLEN(BankAccNo) > 0 THEN
            BankAccNo := COPYSTR(BankAccNo, 1, 30);
        EXIT;
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
    procedure FormatImportNo(var ImportNo: Code[250])
    begin
        ImportNo := CODE2DIGIT(ImportNo);
        IF ImportNo = '' THEN
            EXIT;

        //API-VADA-210613-ASW01 - START
        //ImportNo := LPADSTR(ImportNo,3,'0');
        IF (STRLEN(ImportNo) < 3) THEN
            ImportNo := LPADSTR(ImportNo, 3, '0');
        //API-VADA-210613-ASW01 - KONEC
    end;

    [Scope('Internal')]
    procedure SplitBankAccNo(FullAccountNo: Code[30]; var Prefix: Code[6]; var AccNo: Code[10]; var Bank: Code[7])
    var
        Pos: Integer;
        FromPos: Integer;
        ToPos: Integer;
    begin
        CLEAR(Prefix);
        CLEAR(AccNo);
        CLEAR(Bank);

        IF STRPOS(FullAccountNo, '/') <> 0 THEN BEGIN
            Pos := STRPOS(FullAccountNo, '/');
            IF COPYSTR(FullAccountNo, Pos - 3, 1) = '-' THEN BEGIN
                FullAccountNo := COPYSTR(FullAccountNo, 1, Pos - 3) + COPYSTR(FullAccountNo, Pos - 2);
            END;
        END;

        IF STRPOS(FullAccountNo, '-') <> 0 THEN
            Prefix := COPYSTR(FullAccountNo, 1, STRPOS(FullAccountNo, '-') - 1);

        FromPos := STRPOS(FullAccountNo, '-') + 1;
        ToPos := STRPOS(FullAccountNo, '/');
        IF FromPos = 0 THEN
            ToPos := STRLEN(FullAccountNo) + 1;
        IF FromPos < ToPos THEN
            AccNo := COPYSTR(FullAccountNo, FromPos, ToPos - FromPos);

        IF STRPOS(FullAccountNo, '/') <> 0 THEN
            Bank := COPYSTR(FullAccountNo, STRPOS(FullAccountNo, '/') + 1);
    end;

    [Scope('Internal')]
    procedure FormatAmount(AmountValue: Decimal; AmountFormat: Text[20]): Text[30]
    var
        AmountText: Text[30];
    begin
        CASE AmountFormat OF
            'I.D':  //1234.00
                AmountText := FORMAT(AmountValue, 0, '<Sign><Integer><Decimals,3><Comma,.>');
            'I.d':  //1234 or 1234.56
                AmountText := FORMAT(AmountValue, 0, '<Precision,0:3><Sign><Integer><Decimals><Comma,.>');
            'I,D':  //1234,00
                AmountText := FORMAT(AmountValue, 0, '<Sign><Integer><Decimals,3><Comma,,>');
            'I,d':  //1234 or 1234,56
                AmountText := FORMAT(AmountValue, 0, '<Precision,0:3><Sign><Integer><Decimals><Comma,,>');
            'ID':  //123400 = 1234.56
                BEGIN
                    AmountValue *= 100;
                    AmountText := FORMAT(AmountValue, 0, '<Sign><Integer><Decimals,0>');
                END;
            ELSE
                AmountText := FORMAT(AmountValue, 0, '<Standard Format,2>');
        END;
        EXIT(AmountText);
    end;

    [Scope('Internal')]
    procedure FormatDate(DateValue: Date; DateFormat: Text[20]): Text[30]
    begin
        IF DateValue = 0D THEN
            EXIT('');
        CASE DateFormat OF
            'YYMMDD':  //090526
                EXIT(FORMAT(DateValue, 0, '<Year><Month,2><Day,2>'));
            'YYYYMMDD':  //20090526
                EXIT(FORMAT(DateValue, 0, '<Year4><Month,2><Day,2>'));
            'DDMMYY':  //260509
                EXIT(FORMAT(DateValue, 0, '<Day,2><Month,2><Year>'));
        END;
        EXIT('');
    end;

    [Scope('Internal')]
    procedure ABOFileWriteLine(DataP: Text[1024])
    begin
        CurrFile.WRITE(DataP);
    end;

    [Scope('Internal')]
    procedure SelectPaymentOrderFileNameLoc(var lteReturnFileName: Text): Boolean
    var
        lcuFileMgt: Codeunit "File Management";
        ltcFileFilterTxt: Label 'Files (*.%1)|*.%1|All Files (*.*)|*.*';
        ltcFileFilterAllTxt: Label 'All Files (*.*)|*.*';
        lreBankAccount: Record "Bank Account";
        lreBankExportImportSetup: Record "Bank Export/Import Setup";
        lteFileType: Text;
        lteFileName: Text;
        ltcText001: Label 'Export Payment Order';
    begin
        CLEAR(lteReturnFileName);

        lreBankAccount.GET(SourceHeader."Bank Account No.");
        IF SourceHeader."Foreign Payment Order" THEN BEGIN
            lreBankAccount.TESTFIELD("Foreign Payment Export Format");
            lreBankExportImportSetup.GET(lreBankAccount."Foreign Payment Export Format");
        END ELSE BEGIN
            lreBankAccount.TESTFIELD("Payment Export Format");
            lreBankExportImportSetup.GET(lreBankAccount."Payment Export Format");
        END;

        lreBankExportImportSetup.TESTFIELD(Direction, lreBankExportImportSetup.Direction::Export);

        IF lreBankExportImportSetup."Default File Type" <> '' THEN
            lteFileType := STRSUBSTNO(ltcFileFilterTxt, lreBankExportImportSetup."Default File Type")
        ELSE
            lteFileType := ltcFileFilterAllTxt;

        lteReturnFileName := lcuFileMgt.SaveFileDialog(ltcText001, lreBankExportImportSetup."Default Folder Path", lteFileType);

        EXIT(lteReturnFileName <> '');
    end;
}


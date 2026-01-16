report 80010 "DPG Credit" // 31050 Credit
{
    // API.1.0.4   22.10.18 PV Add field "Due Date" on the layout
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1   26.10.18 DV DAFCZ.1 Added some text required by DAF CZ
    // DAFCZ.1   09.11.18 XX DAFCZ.1 negative "Remaining Amount" SummaryTextCaptionG modified
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Credit.rdlc';

    Caption = 'Credit';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Credit Header"; "Credit Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Company No.";
            column(Credit_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLopp; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(gteAddress; Addr)
                    {
                    }
                    column(gteName; Name)
                    {
                    }
                    column(greCompanyInfo__Registration_No__; CompanyInfo."Registration No.")
                    {
                    }
                    column(greCompanyInfo__Bank_Account_No__; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(greCompanyInfo_Address__________greCompanyInfo__Post_Code___________greCompanyInfo_City; CompanyInfo.Address + ', ' + CompanyInfo."Post Code" + '  ' + CompanyInfo.City)
                    {
                    }
                    column(greCompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(STRSUBSTNO_gtcText001__Credit_Header___Posting_Date__; STRSUBSTNO(Text001Lbl, "Credit Header"."Posting Date"))
                    {
                    }
                    column(STRSUBSTNO_gtcText000__Credit_Header___No___; STRSUBSTNO(Text000Lbl, "Credit Header"."No."))
                    {
                    }
                    column(gteRegNo; RegNo)
                    {
                    }
                    column(gteBank; Bank)
                    {
                    }
                    column(gteAddressCaption; AddrCaptionLbl)
                    {
                    }
                    column(gteNameCaption; NameCaptionLbl)
                    {
                    }
                    column(greCompanyInfo__Registration_No__Caption; CoInfoRegnNoCaptionLbl)
                    {
                    }
                    column(greCompanyInfo__Bank_Account_No__Caption; CoInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(greCompanyInfo_Address__________greCompanyInfo__Post_Code___________greCompanyInfo_CityCaption; greCompanyInfo_Address__________greCompanyInfo__Post_Code___________greCompanyInfo_CityCaptionLbl)
                    {
                    }
                    column(greCompanyInfo_NameCaption; greCompanyInfo_NameCaptionLbl)
                    {
                    }
                    column(by_reciprocally_credit_receibables_by_364_Business_LawCaption; by_reciprocally_credit_receibables_by_par364_Business_LawCaptionLbl)
                    {
                    }
                    column(gteRegNoCaption; gteRegNoCaptionLbl)
                    {
                    }
                    column(gteBankCaption; gteBankCaptionLbl)
                    {
                    }
                    column(ginOutputNo; OutputNo)
                    {
                    }
                    column(PageLopp_Number; Number)
                    {
                    }
                    dataitem("Credit Line"; "Credit Line")
                    {
                        DataItemLink = "Credit No." = FIELD("No.");
                        DataItemLinkReference = "Credit Header";
                        DataItemTableView = SORTING("Credit No.", "Line No.") WHERE("Source Type" = CONST(Customer));
                        column(STRSUBSTNO_gtcText002_greCompanyInfo_Name_; STRSUBSTNO(Text002Lbl, CompanyInfo.Name))
                        {
                        }
                        column(Credit_Line__Remaining_Amount_; "Remaining Amount")
                        {
                        }
                        column(Credit_Line_Amount; Amount)
                        {
                        }
                        column(Credit_Line__Ledg__Entry_Remaining_Amount_; "Ledg. Entry Remaining Amount")
                        {
                        }
                        column(Credit_Line__Ledg__Entry_Original_Amount_; "Ledg. Entry Original Amount")
                        {
                        }
                        column(gdaDueDate; FORMAT(DueDate))
                        {
                        }
                        column(Credit_Line__Currency_Code_; "Currency Code")
                        {
                        }
                        column(Credit_Line__Variable_Symbol_; "Variable Symbol")
                        {
                        }
                        column(Credit_Line__Document_No__; "Document No.")
                        {
                        }
                        column(Credit_Line__Document_Type_; "Document Type")
                        {
                        }
                        column(Credit_Line__Posting_Date_; FORMAT("Posting Date"))
                        {
                        }
                        column(Credit_Line__Remaining_Amount_Caption; Credit_Line__Remaining_Amount_CaptionLbl)
                        {
                        }
                        column(Credit_Line_AmountCaption; Credit_Line_AmountCaptionLbl)
                        {
                        }
                        column(Credit_Line__Ledg__Entry_Remaining_Amount_Caption; Credit_Line__Ledg__Entry_Remaining_Amount_CaptionLbl)
                        {
                        }
                        column(Credit_Line__Ledg__Entry_Original_Amount_Caption; Credit_Line__Ledg__Entry_Original_Amount_CaptionLbl)
                        {
                        }
                        column(gdaDueDateCaption; gdaDueDateCaptionLbl)
                        {
                        }
                        column(Credit_Line__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
                        {
                        }
                        column(Credit_Line__Variable_Symbol_Caption; FIELDCAPTION("Variable Symbol"))
                        {
                        }
                        column(Credit_Line__Document_No__Caption; FIELDCAPTION("Document No."))
                        {
                        }
                        column(Credit_Line__Document_Type_Caption; FIELDCAPTION("Document Type"))
                        {
                        }
                        column(Credit_Line__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                        {
                        }
                        column(Credit_Line_Credit_No_; "Credit No.")
                        {
                        }
                        column(Credit_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CASE "Source Type" OF
                                "Source Type"::Vendor:
                                    WITH VendLedgEntry DO BEGIN
                                        GET("Source Entry No.");
                                        DueDate := "Due Date";
                                    END;
                                "Source Type"::Customer:
                                    WITH CustLedgEntry DO BEGIN
                                        GET("Source Entry No.");
                                        DueDate := "Due Date";
                                    END;
                            END;

                            IF "Remaining Amount" <> 0 THEN BEGIN
                                TempCreditLine := "Credit Line";
                                TempCreditLine.INSERT;
                            END;

                            IF "Currency Code" = '' THEN BEGIN
                                GLSetup.TESTFIELD("LCY Code");
                                "Currency Code" := GLSetup."LCY Code";
                            END;
                        end;
                    }
                    dataitem(CreditLine2; "Credit Line")
                    {
                        DataItemLink = "Credit No." = FIELD("No.");
                        DataItemLinkReference = "Credit Header";
                        DataItemTableView = SORTING("Credit No.", "Line No.") WHERE("Source Type" = CONST(Vendor));
                        column(STRSUBSTNO_gtcText002_gteName_; STRSUBSTNO(Text002Lbl, Name))
                        {
                        }
                        column(Remaining_Amount_; -"Remaining Amount")
                        {
                        }
                        column(Amount; -Amount)
                        {
                        }
                        column(Ledg__Entry_Remaining_Amount_; -"Ledg. Entry Remaining Amount")
                        {
                        }
                        column(Ledg__Entry_Original_Amount_; -"Ledg. Entry Original Amount")
                        {
                        }
                        column(gdaDueDate2; FORMAT(DueDate2))
                        {
                        }
                        column(CreditLine2__Currency_Code_; "Currency Code")
                        {
                        }
                        column(CreditLine2__Variable_Symbol_; "Variable Symbol")
                        {
                        }
                        column(CreditLine2__Document_No__; "Document No.")
                        {
                        }
                        column(CreditLine2__Document_Type_; "Document Type")
                        {
                        }
                        column(CreditLine2__Posting_Date_; FORMAT("Posting Date"))
                        {
                        }
                        column(Remaining_Amount_Caption; Remaining_Amount_CaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Ledg__Entry_Remaining_Amount_Caption; Ledg__Entry_Remaining_Amount_CaptionLbl)
                        {
                        }
                        column(Ledg__Entry_Original_Amount_Caption; Ledg__Entry_Original_Amount_CaptionLbl)
                        {
                        }
                        column(gdaDueDate2Caption; gdaDueDate2CaptionLbl)
                        {
                        }
                        column(CreditLine2__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
                        {
                        }
                        column(CreditLine2__Variable_Symbol_Caption; FIELDCAPTION("Variable Symbol"))
                        {
                        }
                        column(CreditLine2__Document_No__Caption; FIELDCAPTION("Document No."))
                        {
                        }
                        column(CreditLine2__Document_Type_Caption; FIELDCAPTION("Document Type"))
                        {
                        }
                        column(CreditLine2__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                        {
                        }
                        column(CreditLine2_Credit_No_; "Credit No.")
                        {
                        }
                        column(CreditLine2_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CASE "Source Type" OF
                                "Source Type"::Vendor:
                                    WITH VendLedgEntry DO BEGIN
                                        GET("Source Entry No.");
                                        DueDate2 := "Due Date";
                                    END;
                                "Source Type"::Customer:
                                    WITH CustLedgEntry DO BEGIN
                                        GET("Source Entry No.");
                                        DueDate2 := "Due Date";
                                    END;
                            END;

                            IF "Remaining Amount" <> 0 THEN BEGIN
                                TempCreditLine2 := CreditLine2;
                                TempCreditLine2.INSERT;
                            END;

                            IF "Currency Code" = '' THEN BEGIN
                                GLSetup.TESTFIELD("LCY Code");
                                "Currency Code" := GLSetup."LCY Code";
                            END;
                        end;
                    }
                    dataitem("Integer"; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(STRSUBSTNO_gtcText003_gteRemName_; STRSUBSTNO(Text003Lbl, RemName))
                        {
                        }
                        column(DataItem1100162065; STRSUBSTNO(Text004Lbl, TempCreditLine."Variable Symbol", FORMAT(ABS(TempCreditLine."Remaining Amount"), 0, AmtFormatTxt), TempCreditLine."Currency Code"))
                        {
                        }
                        column(Integer_Number; Number)
                        {
                        }
                        column(SummaryTextCaption1; SummaryTextCaptionG)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TempCreditLine.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TempCreditLine.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            IF TempCreditLine."Credit No." <> '' THEN
                                IF TempCreditLine."Currency Code" = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    TempCreditLine."Currency Code" := GLSetup."LCY Code";
                                END;

                            // Start DAFCZ.1
                            IF TempCreditLine."Remaining Amount" > 0 THEN
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  "Credit Header"."Company Name",
                                                                  FORMAT(ABS(TempCreditLine."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempCreditLine."Currency Code",
                                                                  CompanyInfo.Name,
                                                                  "Credit Header"."DPG Due Date")
                            ELSE
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  CompanyInfo.Name,
                                                                  FORMAT(ABS(TempCreditLine."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempCreditLine."Currency Code",
                                                                  "Credit Header"."Company Name",
                                                                  "Credit Header"."DPG Due Date");
                            // Stop DAFCZ.1
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempCreditLine.SETRANGE("Source Type", TempCreditLine."Source Type"::Customer);
                            RemName := CompanyInfo.Name
                        end;
                    }
                    dataitem(Integer2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(STRSUBSTNO_gtcText003_gteRemName__Control1100171014; STRSUBSTNO(Text003Lbl, RemName))
                        {
                        }
                        column(DataItem1100171015; STRSUBSTNO(Text004Lbl, TempCreditLine2."Variable Symbol", FORMAT(ABS(TempCreditLine2."Remaining Amount"), 0, AmtFormatTxt), TempCreditLine2."Currency Code"))
                        {
                        }
                        column(Integer2_Number; Number)
                        {
                        }
                        column(SummaryTextCaption2; SummaryTextCaptionG)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TempCreditLine2.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TempCreditLine2.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            IF TempCreditLine2."Credit No." <> '' THEN
                                IF TempCreditLine2."Currency Code" = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    TempCreditLine2."Currency Code" := GLSetup."LCY Code";
                                END;

                            // Start DAFCZ.1
                            IF TempCreditLine2."Remaining Amount" < 0 THEN
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  CompanyInfo.Name,
                                                                  FORMAT(ABS(TempCreditLine2."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempCreditLine2."Currency Code",
                                                                  "Credit Header"."Company Name",
                                                                  "Credit Header"."DPG Due Date")
                            ELSE
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  "Credit Header"."Company Name",
                                                                  FORMAT(ABS(TempCreditLine2."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempCreditLine2."Currency Code",
                                                                  CompanyInfo.Name,
                                                                  "Credit Header"."DPG Due Date");
                            // Stop DAFCZ.1
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempCreditLine2.SETRANGE("Source Type", TempCreditLine2."Source Type"::Vendor);
                            RemName := Name;
                        end;
                    }
                    dataitem(xFoot; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        MaxIteration = 1;
                        column(gteName_Control1100171002; Name)
                        {
                        }
                        column(WORKDATE; FORMAT(WORKDATE()))
                        {
                        }
                        column(greCompanyInfo_Name_Control1100171009; CompanyInfo.Name)
                        {
                        }
                        column(EmptyStringCaption; EmptyStringCaptionLbl)
                        {
                        }
                        column(Name_and_SignatureCaption; Name_and_SignatureCaptionLbl)
                        {
                        }
                        column(EmptyStringCaption_Control1100171003; EmptyStringCaption_Control1100171003Lbl)
                        {
                        }
                        column(In_____________date_____Caption; In_____________date_____CaptionLbl)
                        {
                        }
                        column(EmptyStringCaption_Control1100171005; EmptyStringCaption_Control1100171005Lbl)
                        {
                        }
                        column(gteName_Control1100171002Caption; Name_Control1100171002CaptionLbl)
                        {
                        }
                        column(Name_and_SignatureCaption_Control1100171008; Name_and_SignatureCaption_Control1100171008Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1100171010; EmptyStringCaption_Control1100171010Lbl)
                        {
                        }
                        column(In______________date_____Caption; In______________date_____CaptionLbl)
                        {
                        }
                        column(WORKDATECaption; WORKDATECaptionLbl)
                        {
                        }
                        column(greCompanyInfo_Name_Control1100171009Caption; CoInfo_Name_Control1100171009CaptionLbl)
                        {
                        }
                        column(xFoot_Number; Number)
                        {
                        }
                        column(DueDateCpn_CH; "Credit Header".FIELDCAPTION("DPG Due Date"))
                        {
                        }
                        column(DueDate_CH; FORMAT("Credit Header"."DPG Due Date"))
                        {
                        }
                        column(SummaryCaption; SummaryTextCaptionG)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            // Start DAFCZ.1
                            SummaryTextCaptionG := STRSUBSTNO(SummaryText, '1', '', '', '', '');
                            // Stop DAFCZ.1
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
                        OutputNo += 1;

                    CurrReport.PAGENO := 1;

                    TempCreditLine.RESET;
                    TempCreditLine.DELETEALL;
                    CLEAR(TempCreditLine);

                    TempCreditLine2.RESET;
                    TempCreditLine2.DELETEALL;
                    CLEAR(TempCreditLine2);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopiesG) + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Vend: Record Vendor;
                Cust: Record Customer;
                Cont: Record Contact;
            begin
                CLEAR(Name);
                CLEAR(Addr);
                CLEAR(Bank);
                CLEAR(RegNo);

                Name := "Company Name";
                IF "Company Name 2" <> '' THEN
                    Name := Name + ' ' + "Company Name 2";

                Addr := "Company Address";
                IF "Company Address 2" <> '' THEN
                    Addr := Addr + ' ' + "Company Address 2";
                IF ("Company Post Code" <> '') OR ("Company City" <> '') THEN
                    Addr := Addr + ', ' + "Company Post Code" + ' ' + "Company City";

                CASE Type OF
                    Type::Vendor:
                        BEGIN
                            IF NOT Vend.GET("Company No.") THEN
                                CLEAR(Vend);
                            IF Vend."Registered Name" <> '' THEN
                                Name := Vend."Registered Name";
                            RegNo := Vend."Registration No.";
                        END;
                    Type::Customer:
                        BEGIN
                            IF NOT Cust.GET("Company No.") THEN
                                CLEAR(Cust);
                            IF Cust."Registered Name" <> '' THEN
                                Name := Cust."Registered Name";
                            RegNo := Cust."Registration No.";
                        END;
                    Type::Contact:
                        BEGIN
                            IF NOT Cont.GET("Company No.") THEN
                                CLEAR(Cont);
                            IF Cont."Registered Name" <> '' THEN
                                Name := Cont."Registered Name";
                            RegNo := Cont."Registration No.";
                        END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                GLSetup.GET;

                AmtFormatTxt := '<Precision,2:2><Sign><Integer><1000Character, ><Decimals>';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Možnosti")
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopiesG)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies the number of copies to print.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        VendLedgEntry: Record "Vendor Ledger Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        TempCreditLine: Record "Credit Line" temporary;
        TempCreditLine2: Record "Credit Line" temporary;
        Name: Text[250];
        Addr: Text[250];
        Bank: Text[250];
        RegNo: Text[250];
        RemName: Text[250];
        DueDate: Date;
        DueDate2: Date;
        NoOfCopiesG: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        Text000Lbl: Label 'AGREEMENT %1';
        Text001Lbl: Label 'To date %1';
        Text002Lbl: Label 'Receivables %1';
        Text003Lbl: Label 'The receivables of the company %1', Comment = '%1=Company Name';
        Text004Lbl: Label 'for the variable symbol %1 are %2 %3 after the credit.', Comment = '%1=variable symbol;%2=remaining amount;%3=currency code';
        AddrCaptionLbl: Label 'Domicile:';
        NameCaptionLbl: Label 'Business Name:';
        CoInfoRegnNoCaptionLbl: Label 'Reg. No.:';
        CoInfoBankAccNoCaptionLbl: Label 'Bank connection:';
        greCompanyInfo_Address__________greCompanyInfo__Post_Code___________greCompanyInfo_CityCaptionLbl: Label 'Domicile:';
        greCompanyInfo_NameCaptionLbl: Label 'Business Name:';
        by_reciprocally_credit_receibables_by_par364_Business_LawCaptionLbl: Label 'by reciprocally credit receivables and liabilities by PAR. 1982-1991 of Civil Code No. 89/2012';
        gteRegNoCaptionLbl: Label 'Reg. No.:';
        gteBankCaptionLbl: Label 'Bank connection:';
        Credit_Line__Remaining_Amount_CaptionLbl: Label 'Remaining Amount';
        Credit_Line_AmountCaptionLbl: Label 'Amount';
        Credit_Line__Ledg__Entry_Remaining_Amount_CaptionLbl: Label 'Ledg. Entry Remaining Amount';
        Credit_Line__Ledg__Entry_Original_Amount_CaptionLbl: Label 'Ledg. Entry Original Amount';
        gdaDueDateCaptionLbl: Label 'Due Date';
        Remaining_Amount_CaptionLbl: Label 'Remaining Amount';
        AmountCaptionLbl: Label 'Amount';
        Ledg__Entry_Remaining_Amount_CaptionLbl: Label 'Ledg. Entry Remaining Amount';
        Ledg__Entry_Original_Amount_CaptionLbl: Label 'Ledg. Entry Original Amount';
        gdaDueDate2CaptionLbl: Label 'Due Date';
        EmptyStringCaptionLbl: Label 'This Agreement shall enter into force upon signature by both Parties.';
        Name_and_SignatureCaptionLbl: Label 'Name and Signature';
        EmptyStringCaption_Control1100171003Lbl: Label '......................................................................';
        In_____________date_____CaptionLbl: Label 'In __________, date __________';
        EmptyStringCaption_Control1100171005Lbl: Label 'In case you agree, send one confirmed agreement back to our address.';
        Name_Control1100171002CaptionLbl: Label 'For';
        Name_and_SignatureCaption_Control1100171008Lbl: Label 'Name and Signature';
        EmptyStringCaption_Control1100171010Lbl: Label '......................................................................';
        In______________date_____CaptionLbl: Label 'In __________, date __________';
        WORKDATECaptionLbl: Label 'Make Date';
        CoInfo_Name_Control1100171009CaptionLbl: Label 'For';
        AmtFormatTxt: Text;
        SummaryText: Label '%1 pay the difference of this mutual settlement of receivables and payables of %2 %3 to company %4 to %5';
        [InDataSet]
        SummaryTextCaptionG: Text[1024];
}


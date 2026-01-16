report 80006 "DPG Posted Credit" // 31057 "Posted Credit"
{
    // API.1.0.4   22.10.18 PV Add field "Due Date" on the layout
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1   26.10.18 DV DAFCZ.1 Added some text required by DAF CZ
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PostedCredit.rdlc';

    Caption = 'Posted Credit';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Posted Credit Header"; "Posted Credit Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Company No.";
            column(Posted_Credit_Header_No_; "No.")
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
                    column(STRSUBSTNO_gtcText001__Posted_Credit_Header___Posting_Date__; STRSUBSTNO(Text001, "Posted Credit Header"."Posting Date"))
                    {
                    }
                    column(STRSUBSTNO_gtcText000__Posted_Credit_Header___No___; STRSUBSTNO(Text000, "Posted Credit Header"."No."))
                    {
                    }
                    column(gteRegNo; RegNo)
                    {
                    }
                    column(gteBank; Bank)
                    {
                    }
                    column(gteAddressCaption; gteAddressCaptionLbl)
                    {
                    }
                    column(gteNameCaption; gteNameCaptionLbl)
                    {
                    }
                    column(greCompanyInfo__Registration_No__Caption; greCompanyInfo__Registration_No__CaptionLbl)
                    {
                    }
                    column(greCompanyInfo__Bank_Account_No__Caption; greCompanyInfo__Bank_Account_No__CaptionLbl)
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
                    dataitem("Posted Credit Line"; "Posted Credit Line")
                    {
                        DataItemLink = "Credit No." = FIELD("No.");
                        DataItemLinkReference = "Posted Credit Header";
                        DataItemTableView = SORTING("Credit No.", "Line No.") WHERE("Source Type" = CONST(Customer));
                        column(STRSUBSTNO_gtcText002_greCompanyInfo_Name_; STRSUBSTNO(Text002, CompanyInfo.Name))
                        {
                        }
                        column(Posted_Credit_Line__Remaining_Amount_; "Remaining Amount")
                        {
                        }
                        column(Posted_Credit_Line_Amount; Amount)
                        {
                        }
                        column(Posted_Credit_Line__Ledg__Entry_Remaining_Amount_; "Ledg. Entry Remaining Amount")
                        {
                        }
                        column(Posted_Credit_Line__Ledg__Entry_Original_Amount_; "Ledg. Entry Original Amount")
                        {
                        }
                        column(gdaDueDate; FORMAT(DueDate))
                        {
                        }
                        column(Posted_Credit_Line__Currency_Code_; "Currency Code")
                        {
                        }
                        column(Posted_Credit_Line__Variable_Symbol_; "Variable Symbol")
                        {
                        }
                        column(Posted_Credit_Line__Document_No__; "Document No.")
                        {
                        }
                        column(Posted_Credit_Line__Document_Type_; "Document Type")
                        {
                        }
                        column(Posted_Credit_Line__Posting_Date_; FORMAT("Posting Date"))
                        {
                        }
                        column(Posted_Credit_Line__Remaining_Amount_Caption; Posted_Credit_Line__Remaining_Amount_CaptionLbl)
                        {
                        }
                        column(Posted_Credit_Line_AmountCaption; Posted_Credit_Line_AmountCaptionLbl)
                        {
                        }
                        column(Posted_Credit_Line__Ledg__Entry_Remaining_Amount_Caption; Posted_Credit_Line__Ledg__Entry_Remaining_Amount_CaptionLbl)
                        {
                        }
                        column(Posted_Credit_Line__Ledg__Entry_Original_Amount_Caption; Posted_Credit_Line__Ledg__Entry_Original_Amount_CaptionLbl)
                        {
                        }
                        column(gdaDueDateCaption; gdaDueDateCaptionLbl)
                        {
                        }
                        column(Posted_Credit_Line__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
                        {
                        }
                        column(Posted_Credit_Line__Variable_Symbol_Caption; FIELDCAPTION("Variable Symbol"))
                        {
                        }
                        column(Posted_Credit_Line__Document_No__Caption; FIELDCAPTION("Document No."))
                        {
                        }
                        column(Posted_Credit_Line__Document_Type_Caption; FIELDCAPTION("Document Type"))
                        {
                        }
                        column(Posted_Credit_Line__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                        {
                        }
                        column(Posted_Credit_Line_Credit_No_; "Credit No.")
                        {
                        }
                        column(Posted_Credit_Line_Line_No_; "Line No.")
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
                                TempPstdLineBuffer := "Posted Credit Line";
                                TempPstdLineBuffer.INSERT;
                            END;

                            IF "Currency Code" = '' THEN BEGIN
                                GLSetup.TESTFIELD("LCY Code");
                                "Currency Code" := GLSetup."LCY Code";
                            END;
                        end;
                    }
                    dataitem(CreditLine2; "Posted Credit Line")
                    {
                        DataItemLink = "Credit No." = FIELD("No.");
                        DataItemLinkReference = "Posted Credit Header";
                        DataItemTableView = SORTING("Credit No.", "Line No.") WHERE("Source Type" = CONST(Vendor));
                        column(STRSUBSTNO_gtcText002_gteName_; STRSUBSTNO(Text002, Name))
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
                                TempPstdLineBuffer2 := CreditLine2;
                                TempPstdLineBuffer2.INSERT;
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
                        column(STRSUBSTNO_gtcText003_gteRemName_; STRSUBSTNO(Text003, RemName))
                        {
                        }
                        column(DataItem1100162065; STRSUBSTNO(Text004, TempPstdLineBuffer."Variable Symbol", FORMAT(ABS(TempPstdLineBuffer."Remaining Amount"), 0, AmtFormatTxt), TempPstdLineBuffer."Currency Code"))
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
                                IF NOT TempPstdLineBuffer.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TempPstdLineBuffer.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            IF TempPstdLineBuffer."Credit No." <> '' THEN
                                IF TempPstdLineBuffer."Currency Code" = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    TempPstdLineBuffer."Currency Code" := GLSetup."LCY Code";
                                END;

                            // Start DAFCZ.1
                            IF TempPstdLineBuffer."Remaining Amount" > 0 THEN
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  "Posted Credit Header"."Company Name",
                                                                  FORMAT(ABS(TempPstdLineBuffer."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempPstdLineBuffer."Currency Code",
                                                                  CompanyInfo.Name,
                                                                  "Posted Credit Header"."DPG Due Date")
                            ELSE
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  CompanyInfo.Name,
                                                                  FORMAT(ABS(TempPstdLineBuffer."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempPstdLineBuffer."Currency Code",
                                                                  "Posted Credit Header"."Company Name",
                                                                  "Posted Credit Header"."DPG Due Date");
                            // Stop DAFCZ.1
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempPstdLineBuffer.SETRANGE("Source Type", TempPstdLineBuffer."Source Type"::Customer);
                            RemName := CompanyInfo.Name
                        end;
                    }
                    dataitem(Integer2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(STRSUBSTNO_gtcText003_gteRemName__Control1100171014; STRSUBSTNO(Text003, RemName))
                        {
                        }
                        column(DataItem1100171015; STRSUBSTNO(Text004, TempPstdLineBuffer2."Variable Symbol", FORMAT(ABS(TempPstdLineBuffer2."Remaining Amount"), 0, AmtFormatTxt), TempPstdLineBuffer2."Currency Code"))
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
                                IF NOT TempPstdLineBuffer2.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TempPstdLineBuffer2.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            IF TempPstdLineBuffer2."Credit No." <> '' THEN
                                IF TempPstdLineBuffer2."Currency Code" = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    TempPstdLineBuffer2."Currency Code" := GLSetup."LCY Code";
                                END;

                            // Start DAFCZ.1
                            IF TempPstdLineBuffer2."Remaining Amount" < 0 THEN
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  CompanyInfo.Name,
                                                                  FORMAT(ABS(TempPstdLineBuffer2."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempPstdLineBuffer2."Currency Code",
                                                                  "Posted Credit Header"."Company Name",
                                                                  "Posted Credit Header"."DPG Due Date")
                            ELSE
                                SummaryTextCaptionG := STRSUBSTNO(SummaryText,
                                                                  "Posted Credit Header"."Company Name",
                                                                  FORMAT(ABS(TempPstdLineBuffer2."Remaining Amount"), 0, AmtFormatTxt),
                                                                  TempPstdLineBuffer2."Currency Code",
                                                                  CompanyInfo.Name,
                                                                  "Posted Credit Header"."DPG Due Date");
                            // Stop DAFCZ.1
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempPstdLineBuffer2.SETRANGE("Source Type", TempPstdLineBuffer2."Source Type"::Vendor);
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
                        column(WORKDATE; FORMAT(WORKDATE))
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
                        column(gteName_Control1100171002Caption; gteName_Control1100171002CaptionLbl)
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
                        column(greCompanyInfo_Name_Control1100171009Caption; greCompanyInfo_Name_Control1100171009CaptionLbl)
                        {
                        }
                        column(xFoot_Number; Number)
                        {
                        }
                        column(DueDateCpn_PCH; "Posted Credit Header".FIELDCAPTION("DPG Due Date"))
                        {
                        }
                        column(DueDate_PCH; FORMAT("Posted Credit Header"."DPG Due Date"))
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
                        OutputNo += 1;

                    CurrReport.PAGENO := 1;

                    TempPstdLineBuffer.RESET;
                    TempPstdLineBuffer.DELETEALL;
                    CLEAR(TempPstdLineBuffer);

                    TempPstdLineBuffer2.RESET;
                    TempPstdLineBuffer2.DELETEALL;
                    CLEAR(TempPstdLineBuffer2);
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
        Text000: Label 'AGREEMENT %1';
        Text001: Label 'To date %1';
        Text002: Label 'Receivables %1';
        Text003: Label 'Remaining Receivable will be %1 after realize Credit.';
        Text004: Label 'by variable symbol %1, Amount is %2 %3';
        gteAddressCaptionLbl: Label 'Domicile:';
        gteNameCaptionLbl: Label 'Business Name:';
        greCompanyInfo__Registration_No__CaptionLbl: Label 'Reg. No.:';
        greCompanyInfo__Bank_Account_No__CaptionLbl: Label 'Bank connection:';
        greCompanyInfo_Address__________greCompanyInfo__Post_Code___________greCompanyInfo_CityCaptionLbl: Label 'Domicile:';
        greCompanyInfo_NameCaptionLbl: Label 'Business Name:';
        by_reciprocally_credit_receibables_by_par364_Business_LawCaptionLbl: Label 'by reciprocally credit receivables and liabilities by PAR. 1982-1991 of Civil Code No. 89/2012';
        gteRegNoCaptionLbl: Label 'Reg. No.:';
        gteBankCaptionLbl: Label 'Bank connection:';
        Posted_Credit_Line__Remaining_Amount_CaptionLbl: Label 'Remaining Amount';
        Posted_Credit_Line_AmountCaptionLbl: Label 'Amount';
        Posted_Credit_Line__Ledg__Entry_Remaining_Amount_CaptionLbl: Label 'Ledg. Entry Remaining Amount';
        Posted_Credit_Line__Ledg__Entry_Original_Amount_CaptionLbl: Label 'Ledg. Entry Original Amount';
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
        gteName_Control1100171002CaptionLbl: Label 'For';
        Name_and_SignatureCaption_Control1100171008Lbl: Label 'Name and Signature';
        EmptyStringCaption_Control1100171010Lbl: Label '......................................................................';
        In______________date_____CaptionLbl: Label 'In __________, date __________';
        WORKDATECaptionLbl: Label 'Make Date';
        greCompanyInfo_Name_Control1100171009CaptionLbl: Label 'For';
        CompanyInfo: Record "Company Information";
        VendLedgEntry: Record "Vendor Ledger Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        TempPstdLineBuffer: Record "Posted Credit Line" temporary;
        TempPstdLineBuffer2: Record "Posted Credit Line" temporary;
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
        AmtFormatTxt: Text;
        SummaryTextCaptionG: Text[1024];
        SummaryText: Label '%1 pay the difference of this mutual settlement of receivables and payables of %2 %3 to company %4 to %5';
}


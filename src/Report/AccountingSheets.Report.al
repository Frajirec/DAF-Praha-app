report 80001 "DPG Accounting Sheets" // 11770 "Accounting Sheets"
{
    // API.1.0.1  30.07.18 MH NAVCZ: - PurchInvoiceHeader_OrigDocVATDate,PurchInvoiceHeader_VIN
    // --- API Customization ---
    // --- DAFCZ ---
    // DAFCZ.1    22.10.18 DV DAFCZ.1 VIN to lines, EUR Amount, Don't group, Fixed posted by Name
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/AccountingSheets.rdlc';

    Caption = 'Accounting Sheets';

    dataset
    {
        dataitem(CommonLabels; "Integer")
        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;
            column(NameDescCaption; NameDescCaption)
            {
            }
            column(PostingDateCaption; "Sales Invoice Header".FIELDCAPTION("Posting Date"))
            {
            }
            column(VATDateCaption; "Sales Invoice Header".FIELDCAPTION("VAT Date"))
            {
            }
            column(DocumentDateCaption; "Sales Invoice Header".FIELDCAPTION("Document Date"))
            {
            }
            column(LastDataItem; LastDataItem)
            {
            }
            column(SalesInvHdrExists; SalesInvHdrExists)
            {
            }
            column(SalesCrMemoHdrExists; SalesCrMemoHdrExists)
            {
            }
            column(PurchInvHdrExists; PurchInvHdrExists)
            {
            }
            column(PurchCrMemoHdrExists; PurchCrMemoHdrExists)
            {
            }
            column(GeneralDocExists; GeneralDocExists)
            {
            }
            column(OrigDocVATDate_Caption; VATEntryG.FIELDCAPTION("Original Document VAT Date"))
            {
            }
            column(VIN_Caption; GLEntryG.FIELDCAPTION(VIN))
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF SumaG THEN
                    NameDescCaption := G_L_Account_NameCaptionLbl
                ELSE
                    NameDescCaption := DescriptionLbl;
            end;
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Posting Date";
            column(greCompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column("Účetn__doklad_"; "No.")
            {
            }
            column(Sales_Invoice_Header__Sell_to_Customer_Name_; "Sell-to Customer Name")
            {
            }
            column(Sales_Invoice_Header__Due_Date_; FORMAT("Due Date"))
            {
            }
            column(Sales_Invoice_Header_Amount; Amount)
            {
            }
            column(Amount_Including_VAT__Amount; "Amount Including VAT" - Amount)
            {
            }
            column(gdeFCYRate; FCYRate)
            {
                DecimalPlaces = 5 : 5;
            }
            column(Sales_Invoice_Header__Currency_Code_; "Currency Code")
            {
            }
            column("Účetn__doklad_Caption"; FIELDCAPTION("No."))
            {
            }
            column(Sales_Invoice_Caption; Sales_Invoice_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header__Sell_to_Customer_Name_Caption; Sales_Invoice_Header__Sell_to_Customer_Name_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header__Due_Date_Caption; Sales_Invoice_Header__Due_Date_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Amount_Including_VAT__AmountCaption; Amount_Including_VAT__AmountCaptionLbl)
            {
            }
            column(gdeFCYRateCaption; FCYRateCaptionLbl)
            {
            }
            column(Sales_Invoice_Header__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(SalesInvoiceHeader_PostingDate; "Posting Date")
            {
            }
            column(SalesInvoiceHeader_VATDate; "VAT Date")
            {
            }
            column(SalesInvoiceHeader_DocumentDate; "Document Date")
            {
            }
            column(SalesInvoiceHeader_VIN; GLEntryG.VIN)
            {
            }
            dataitem(GLEntry1; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    IF UserSetup."User ID" <> "User ID" THEN
                        IF NOT UserSetup.GET("User ID") THEN
                            UserSetup.INIT;

                    BufferGLEntry(GLEntry1);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", 1, LastGLEntry);
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(CurrReport_PAGENO; CurrReport.PAGENO())
                {
                }
                column("Účetn__doklad__Control285"; "Sales Invoice Header"."No.")
                {
                }
                column("Účetn__doklad__Control1100170003"; "Sales Invoice Header"."No.")
                {
                }
                column(greTGLEntry__Credit_Amount_; TempGLEntry."Credit Amount")
                {
                }
                column(greTGLEntry__Debit_Amount_; TempGLEntry."Debit Amount")
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code_; TempGLEntry."Global Dimension 2 Code")
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code_; TempGLEntry."Global Dimension 1 Code")
                {
                }
                column(NameDescText1; NameDescText)
                {
                }
                column(greTGLEntry__G_L_Account_No__; TempGLEntry."G/L Account No.")
                {
                }
                column(Sales_Invoice_Header___Posting_Date_; FORMAT("Sales Invoice Header"."Posting Date"))
                {
                }
                column(greUserSetup__User_Name_; UserSetup."User ID")
                {
                }
                column(Credit_AmountCaption; Credit_AmountCaptionLbl)
                {
                }
                column(Debit_AmountCaption; Debit_AmountCaptionLbl)
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code_Caption; CAPTIONCLASSTRANSLATE('1,1,2'))
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code_Caption; CAPTIONCLASSTRANSLATE('1,1,1'))
                {
                }
                column(G_L_AccountCaption; G_L_AccountCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column("Účetn__doklad__Control285Caption"; "Sales Invoice Header".FIELDCAPTION("No."))
                {
                }
                column("Účetn__doklad__Control1100170003Caption"; "Sales Invoice Header".FIELDCAPTION("No."))
                {
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control288; ContinuedCaption_Control288Lbl)
                {
                }
                column(Date_Caption; Date_CaptionLbl)
                {
                }
                column(Date_Caption_Control292; Date_Caption_Control292Lbl)
                {
                }
                column(Date_Caption_Control297; Date_Caption_Control297Lbl)
                {
                }
                column(Date_Caption_Control302; Date_Caption_Control302Lbl)
                {
                }
                column(EmptyStringCaption; FactualCorrectnessVerifiedByLbl)
                {
                }
                column(EmptyStringCaption_Control304; PostedByLbl)
                {
                }
                column(EmptyStringCaption_Control305; ApprovedByLbl)
                {
                }
                column(EmptyStringCaption_Control306; FormalCorrectnessVerifiedByLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        TempGLEntry.FINDSET
                    ELSE
                        TempGLEntry.NEXT;

                    GLAcc.GET(TempGLEntry."G/L Account No.");
                    IF SumaG THEN
                        NameDescText := GLAcc.Name
                    ELSE
                        NameDescText := TempGLEntry.Description;
                end;

                trigger OnPostDataItem()
                begin
                    IF NewPageG THEN
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem()
                begin
                    TempGLEntry.RESET;
                    SETRANGE(Number, 1, TempGLEntry.COUNT);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPageG THEN
                    CurrReport.PAGENO(1);
                TempGLEntry.DELETEALL;

                FCYRate := 0;
                IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN
                    FCYRate := 1 / "Currency Factor";

                // Start API.1.0.1 - SF
                GLEntryG.SETCURRENTKEY("Document No.");
                GLEntryG.SETRANGE("Document No.", "No.");
                IF NOT GLEntryG.FINDSET THEN
                    GLEntryG.INIT;
                // Stop API.1.0.1
            end;

            trigger OnPreDataItem()
            begin
                IF NOT "Sales Invoice Header".HASFILTER THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Sales Credit Memo Header"; "Sales Credit Memo Header")
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Posting Date";
            column("Účetn__doklad__Control3"; "No.")
            {
            }
            column(greCompanyInfo_Name_Control4; CompanyInfo.Name)
            {
            }
            column(Sales_Cr_Memo_Header__Due_Date_; FORMAT("Due Date"))
            {
            }
            column(Sales_Cr_Memo_Header__Sell_to_Customer_Name_; "Sell-to Customer Name")
            {
            }
            column(Amount_Including_VAT__Amount_Control235; "Amount Including VAT" - Amount)
            {
            }
            column(Sales_Cr_Memo_Header_Amount; Amount)
            {
            }
            column(Sales_Cr_Memo_Header__Currency_Code_; "Currency Code")
            {
            }
            column(gdeFCYRate_Control1100162004; FCYRate)
            {
                DecimalPlaces = 5 : 5;
            }
            column("Účetn__doklad__Control3Caption"; FIELDCAPTION("No."))
            {
            }
            column(Sales_Credit_Memo_Caption; Sales_Credit_Memo_CaptionLbl)
            {
            }
            column(Sales_Cr_Memo_Header__Due_Date_Caption; Sales_Cr_Memo_Header__Due_Date_CaptionLbl)
            {
            }
            column(Sales_Cr_Memo_Header__Sell_to_Customer_Name_Caption; Sales_Cr_Memo_Header__Sell_to_Customer_Name_CaptionLbl)
            {
            }
            column(Amount_Including_VAT__Amount_Control235Caption; Amount_Including_VAT__Amount_Control235CaptionLbl)
            {
            }
            column(Sales_Cr_Memo_Header_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Sales_Cr_Memo_Header__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(gdeFCYRate_Control1100162004Caption; FCYRate_Control1100162004CaptionLbl)
            {
            }
            column(SalesCrMemoHeader_PostingDate; "Posting Date")
            {
            }
            column(SalesCrMemoHeader_VATDate; "VAT Date")
            {
            }
            column(SalesCrMemoHeader_DocumentDate; "Document Date")
            {
            }
            column(SalesCrMemoHeader_VIN; GLEntryG.VIN)
            {
            }
            dataitem(GLEntry2; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    IF UserSetup."User ID" <> "User ID" THEN
                        IF NOT UserSetup.GET("User ID") THEN
                            UserSetup.INIT;

                    BufferGLEntry(GLEntry2);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", 1, LastGLEntry);
                end;
            }
            dataitem(Integer2; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(CurrReport_PAGENO_Control41; CurrReport.PAGENO())
                {
                }
                column("Účetn__doklad__Control43"; "Sales Credit Memo Header"."No.")
                {
                }
                column("Účetn__doklad__Control1100170007"; "Sales Credit Memo Header"."No.")
                {
                }
                column(greTGLEntry__Credit_Amount__Control90; TempGLEntry."Credit Amount")
                {
                }
                column(greTGLEntry__Debit_Amount__Control91; TempGLEntry."Debit Amount")
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code__Control106; TempGLEntry."Global Dimension 2 Code")
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code__Control112; TempGLEntry."Global Dimension 1 Code")
                {
                }
                column(NameDescText2; NameDescText)
                {
                }
                column(greTGLEntry__G_L_Account_No___Control115; TempGLEntry."G/L Account No.")
                {
                }
                column(Sales_Cr_Memo_Header___Posting_Date_; FORMAT("Sales Credit Memo Header"."Posting Date"))
                {
                }
                column(greUserSetup__User_Name__Control310; UserSetup."User ID")
                {
                }
                column(Credit_AmountCaption_Control20; Credit_AmountCaption_Control20Lbl)
                {
                }
                column(Debit_AmountCaption_Control24; Debit_AmountCaption_Control24Lbl)
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code__Control106Caption; CAPTIONCLASSTRANSLATE('1,1,2'))
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code__Control112Caption; CAPTIONCLASSTRANSLATE('1,1,1'))
                {
                }
                column(G_L_AccountCaption_Control29; G_L_AccountCaption_Control29Lbl)
                {
                }
                column(CurrReport_PAGENO_Control41Caption; CurrReport_PAGENO_Control41CaptionLbl)
                {
                }
                column("Účetn__doklad__Control43Caption"; "Sales Credit Memo Header".FIELDCAPTION("No."))
                {
                }
                column("Účetn__doklad__Control1100170007Caption"; "Sales Credit Memo Header".FIELDCAPTION("No."))
                {
                }
                column(ContinuedCaption_Control1100170024; ContinuedCaption_Control1100170024Lbl)
                {
                }
                column(ContinuedCaption_Control118; ContinuedCaption_Control118Lbl)
                {
                }
                column(Date_Caption_Control121; Date_Caption_Control121Lbl)
                {
                }
                column(Date_Caption_Control122; Date_Caption_Control122Lbl)
                {
                }
                column(Date_Caption_Control247; Date_Caption_Control247Lbl)
                {
                }
                column(Date_Caption_Control313; Date_Caption_Control313Lbl)
                {
                }
                column(EmptyStringCaption_Control314; FactualCorrectnessVerifiedByLbl)
                {
                }
                column(EmptyStringCaption_Control315; PostedByLbl)
                {
                }
                column(EmptyStringCaption_Control316; ApprovedByLbl)
                {
                }
                column(EmptyStringCaption_Control317; FormalCorrectnessVerifiedByLbl)
                {
                }
                column(Integer2_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        TempGLEntry.FINDSET
                    ELSE
                        TempGLEntry.NEXT;

                    GLAcc.GET(TempGLEntry."G/L Account No.");
                    IF SumaG THEN
                        NameDescText := GLAcc.Name
                    ELSE
                        NameDescText := TempGLEntry.Description;
                end;

                trigger OnPostDataItem()
                begin
                    IF NewPageG THEN
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem()
                begin
                    TempGLEntry.RESET;
                    SETRANGE(Number, 1, TempGLEntry.COUNT);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPageG THEN
                    CurrReport.PAGENO(1);
                TempGLEntry.DELETEALL;

                FCYRate := 0;
                IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN
                    FCYRate := 1 / "Currency Factor";

                // Start API.1.0.1 - SF
                GLEntryG.SETCURRENTKEY("Document No.");
                GLEntryG.SETRANGE("Document No.", "No.");
                IF NOT GLEntryG.FINDSET THEN
                    GLEntryG.INIT;
                // Stop API.1.0.1
            end;

            trigger OnPreDataItem()
            begin
                IF NOT "Sales Credit Memo Header".HASFILTER THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Purch. Invoice Header"; "Purch. Invoice Header")
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Posting Date";
            column("Účetn__doklad__Control6"; "No.")
            {
            }
            column(greCompanyInfo_Name_Control32; CompanyInfo.Name)
            {
            }
            column(Purch__Inv__Header__Due_Date_; FORMAT("Due Date"))
            {
            }
            column(Purch__Inv__Header__Buy_from_Vendor_Name_; "Buy-from Vendor Name")
            {
            }
            column(Purch__Inv__Header__Vendor_Invoice_No__; "Vendor Invoice No.")
            {
            }
            column(Purch__Inv__Header_Amount; Amount)
            {
            }
            column(Amount_Including_VAT__Amount_Control241; "Amount Including VAT" - Amount)
            {
            }
            column(Purch__Inv__Header__Currency_Code_; "Currency Code")
            {
            }
            column(gdeFCYRate_Control1100162009; FCYRate)
            {
                DecimalPlaces = 5 : 5;
            }
            column("Účetn__doklad__Control6Caption"; FIELDCAPTION("No."))
            {
            }
            column(Purchase_Invoice_Caption; Purchase_Invoice_CaptionLbl)
            {
            }
            column(Purch__Inv__Header__Due_Date_Caption; Purch__Inv__Header__Due_Date_CaptionLbl)
            {
            }
            column(Purch__Inv__Header__Buy_from_Vendor_Name_Caption; Purch__Inv__Header__Buy_from_Vendor_Name_CaptionLbl)
            {
            }
            column(Purch__Inv__Header__Vendor_Invoice_No__Caption; Purch__Inv__Header__Vendor_Invoice_No__CaptionLbl)
            {
            }
            column(Amount_Including_VAT__Amount_Control241Caption; Amount_Including_VAT__Amount_Control241CaptionLbl)
            {
            }
            column(Purch__Inv__Header_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Purch__Inv__Header__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(gdeFCYRate_Control1100162009Caption; FCYRate_Control1100162009CaptionLbl)
            {
            }
            column(PurchInvoiceHeader_PostingDate; "Posting Date")
            {
            }
            column(PurchInvoiceHeader_VATDate; "VAT Date")
            {
            }
            column(PurchInvoiceHeader_DocumentDate; "Document Date")
            {
            }
            column(PurchInvoiceHeader_OrigDocVATDate; VATEntryG."Original Document VAT Date")
            {
            }
            column(PurchInvoiceHeader_VIN; GLEntryG.VIN)
            {
            }
            column(PurchInvoiceHeaderPostingDescriptionCaption; "Purch. Invoice Header".FIELDCAPTION("Posting Description"))
            {
            }
            column(PurchInvoiceHeaderPostingDescription; "Purch. Invoice Header"."Posting Description")
            {
            }
            dataitem(GLEntry3; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    IF UserSetup."User ID" <> "User ID" THEN
                        IF NOT UserSetup.GET("User ID") THEN
                            UserSetup.INIT;

                    BufferGLEntry(GLEntry3);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", 1, LastGLEntry);
                end;
            }
            dataitem(Integer3; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(CurrReport_PAGENO_Control326; CurrReport.PAGENO)
                {
                }
                column("Účetn__doklad__Control328"; "Purch. Invoice Header"."No.")
                {
                }
                column("Účetn__doklad__Control1100170012"; "Purch. Invoice Header"."No.")
                {
                }
                column(greTGLEntry__Credit_Amount__Control331; TempGLEntry."Credit Amount")
                {
                }
                column(greTGLEntry__Debit_Amount__Control332; TempGLEntry."Debit Amount")
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code__Control334; TempGLEntry."Global Dimension 2 Code")
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code__Control335; TempGLEntry."Global Dimension 1 Code")
                {
                }
                column(NameDescText3; NameDescText)
                {
                }
                column(greTGLEntry__G_L_Account_No___Control338; TempGLEntry."G/L Account No.")
                {
                }
                column(Purch__Inv__Header___Posting_Date_; FORMAT("Purch. Invoice Header"."Posting Date"))
                {
                }
                column(greUserSetup__User_Name__Control352; UserSetup."User ID")
                {
                }
                column(Credit_AmountCaption_Control319; Credit_AmountCaption_Control319Lbl)
                {
                }
                column(Debit_AmountCaption_Control320; Debit_AmountCaption_Control320Lbl)
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code__Control334Caption; CAPTIONCLASSTRANSLATE('1,1,2'))
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code__Control335Caption; CAPTIONCLASSTRANSLATE('1,1,1'))
                {
                }
                column(G_L_AccountCaption_Control324; G_L_AccountCaption_Control324Lbl)
                {
                }
                column(CurrReport_PAGENO_Control326Caption; CurrReport_PAGENO_Control326CaptionLbl)
                {
                }
                column("Účetn__doklad__Control328Caption"; "Purch. Invoice Header".FIELDCAPTION("No."))
                {
                }
                column("Účetn__doklad__Control1100170012Caption"; "Purch. Invoice Header".FIELDCAPTION("No."))
                {
                }
                column(ContinuedCaption_Control1100170025; ContinuedCaption_Control1100170025Lbl)
                {
                }
                column(ContinuedCaption_Control341; ContinuedCaption_Control341Lbl)
                {
                }
                column(Date_Caption_Control343; Date_Caption_Control343Lbl)
                {
                }
                column(Date_Caption_Control347; Date_Caption_Control347Lbl)
                {
                }
                column(Date_Caption_Control350; Date_Caption_Control350Lbl)
                {
                }
                column(EmptyStringCaption_Control353; PostedByLbl)
                {
                }
                column(EmptyStringCaption_Control354; ApprovedByLbl)
                {
                }
                column(EmptyStringCaption_Control355; FormalCorrectnessVerifiedByLbl)
                {
                }
                column(EmptyStringCaption_Control357; FactualCorrectnessVerifiedByLbl)
                {
                }
                column(Date_Caption_Control359; Date_Caption_Control359Lbl)
                {
                }
                column(Integer3_Number; Number)
                {
                }
                column(PITempGLEntryAddCurrencyDebitAmountCaption; TempGLEntry.FIELDCAPTION("Add.-Currency Debit Amount"))
                {
                }
                column(PITempGLEntryAddCurrencyCreditAmountCaption; TempGLEntry.FIELDCAPTION("Add.-Currency Credit Amount"))
                {
                }
                column(PITempGLEntryAddCurrencyDebitAmount; TempGLEntry."Add.-Currency Debit Amount")
                {
                }
                column(PITempGLEntryAddCurrencyCreditAmount; TempGLEntry."Add.-Currency Credit Amount")
                {
                }
                column(PITempGLEntryVIN; TempGLEntry.VIN)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        TempGLEntry.FINDSET
                    ELSE
                        TempGLEntry.NEXT;

                    GLAcc.GET(TempGLEntry."G/L Account No.");
                    IF SumaG THEN
                        NameDescText := GLAcc.Name
                    ELSE
                        NameDescText := TempGLEntry.Description;
                end;

                trigger OnPostDataItem()
                begin
                    IF NewPageG THEN
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem()
                begin
                    TempGLEntry.RESET;
                    SETRANGE(Number, 1, TempGLEntry.COUNT);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPageG THEN
                    CurrReport.PAGENO(1);
                TempGLEntry.DELETEALL;

                FCYRate := 0;
                IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN
                    FCYRate := 1 / "Currency Factor";

                // Start API.1.0.1 - SF
                GLEntryG.SETCURRENTKEY("Document No.");
                GLEntryG.SETRANGE("Document No.", "No.");
                IF NOT GLEntryG.FINDSET THEN
                    GLEntryG.INIT;
                VATEntryG.SETCURRENTKEY("Document No.");
                VATEntryG.SETRANGE("Document No.", "No.");
                IF NOT VATEntryG.FINDSET THEN
                    VATEntryG.INIT;
                // Stop API.1.0.1
            end;

            trigger OnPreDataItem()
            begin
                IF NOT "Purch. Invoice Header".HASFILTER THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Purch. Credit Memo Header"; "Purch. Credit Memo Header")
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Posting Date";
            column("Účetn__doklad__Control34"; "No.")
            {
            }
            column(greCompanyInfo_Name_Control35; CompanyInfo.Name)
            {
            }
            column(Purch__Cr__Memo_Hdr___Due_Date_; FORMAT("Due Date"))
            {
            }
            column(Purch__Cr__Memo_Hdr___Buy_from_Vendor_Name_; "Buy-from Vendor Name")
            {
            }
            column(Purch__Cr__Memo_Hdr___Vendor_Cr__Memo_No__; "Vendor Cr. Memo No.")
            {
            }
            column(Purch__Cr__Memo_Hdr__Amount; Amount)
            {
            }
            column(Amount_Including_VAT__Amount_Control245; "Amount Including VAT" - Amount)
            {
            }
            column(gdeFCYRate_Control1100162011; FCYRate)
            {
                DecimalPlaces = 5 : 5;
            }
            column(Purch__Cr__Memo_Hdr___Currency_Code_; "Currency Code")
            {
            }
            column("Účetn__doklad__Control34Caption"; FIELDCAPTION("No."))
            {
            }
            column(Purchase_Credit_Memo_Caption; Purchase_Credit_Memo_CaptionLbl)
            {
            }
            column(Purch__Cr__Memo_Hdr___Due_Date_Caption; Purch__Cr__Memo_Hdr___Due_Date_CaptionLbl)
            {
            }
            column(Purch__Cr__Memo_Hdr___Buy_from_Vendor_Name_Caption; Purch__Cr__Memo_Hdr___Buy_from_Vendor_Name_CaptionLbl)
            {
            }
            column(Purch__Cr__Memo_Hdr___Vendor_Cr__Memo_No__Caption; Purch__Cr__Memo_Hdr___Vendor_Cr__Memo_No__CaptionLbl)
            {
            }
            column(Amount_Including_VAT__Amount_Control245Caption; Amount_Including_VAT__Amount_Control245CaptionLbl)
            {
            }
            column(Purch__Cr__Memo_Hdr__AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Purch__Cr__Memo_Hdr___Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(gdeFCYRate_Control1100162011Caption; FCYRate_Control1100162011CaptionLbl)
            {
            }
            column(PurchCrMemoHeader_PostingDate; "Posting Date")
            {
            }
            column(PurchCrMemoHeader_VATDate; "VAT Date")
            {
            }
            column(PurchCrMemoHeader_DocumentDate; "Document Date")
            {
            }
            column(PurchCrMemoHeader_OrigDocVATDate; VATEntryG."Original Document VAT Date")
            {
            }
            column(PurchCrMemoHeader_VIN; GLEntryG.VIN)
            {
            }
            column(PurchCreditMemoHeaderPostingDescriptionCaption; "Purch. Credit Memo Header".FIELDCAPTION("Posting Description"))
            {
            }
            column(PurchCreditMemoHeaderPostingDescription; "Purch. Credit Memo Header"."Posting Description")
            {
            }
            dataitem(GLEntry4; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    IF UserSetup."User ID" <> "User ID" THEN
                        IF NOT UserSetup.GET("User ID") THEN
                            UserSetup.INIT;

                    BufferGLEntry(GLEntry4);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", 1, LastGLEntry);
                end;
            }
            dataitem(Integer4; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(CurrReport_PAGENO_Control368; CurrReport.PAGENO)
                {
                }
                column("Účetn__doklad__Control370"; "Purch. Credit Memo Header"."No.")
                {
                }
                column("Účetn__doklad__Control1100170017"; "Purch. Credit Memo Header"."No.")
                {
                }
                column(greTGLEntry__Credit_Amount__Control373; TempGLEntry."Credit Amount")
                {
                }
                column(greTGLEntry__Debit_Amount__Control374; TempGLEntry."Debit Amount")
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code__Control376; TempGLEntry."Global Dimension 2 Code")
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code__Control377; TempGLEntry."Global Dimension 1 Code")
                {
                }
                column(NameDescText4; NameDescText)
                {
                }
                column(greTGLEntry__G_L_Account_No___Control380; TempGLEntry."G/L Account No.")
                {
                }
                column(Purch__Cr__Memo_Hdr____Posting_Date_; FORMAT("Purch. Credit Memo Header"."Posting Date"))
                {
                }
                column(greUserSetup__User_Name__Control394; UserSetup."User ID")
                {
                }
                column(Credit_AmountCaption_Control360; Credit_AmountCaption_Control360Lbl)
                {
                }
                column(Debit_AmountCaption_Control362; Debit_AmountCaption_Control362Lbl)
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code__Control376Caption; CAPTIONCLASSTRANSLATE('1,1,2'))
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code__Control377Caption; CAPTIONCLASSTRANSLATE('1,1,1'))
                {
                }
                column(G_L_AccountCaption_Control366; G_L_AccountCaption_Control366Lbl)
                {
                }
                column(CurrReport_PAGENO_Control368Caption; CurrReport_PAGENO_Control368CaptionLbl)
                {
                }
                column("Účetn__doklad__Control370Caption"; "Purch. Credit Memo Header".FIELDCAPTION("No."))
                {
                }
                column("Účetn__doklad__Control1100170017Caption"; "Purch. Credit Memo Header".FIELDCAPTION("No."))
                {
                }
                column(ContinuedCaption_Control1100170026; ContinuedCaption_Control1100170026Lbl)
                {
                }
                column(ContinuedCaption_Control383; ContinuedCaption_Control383Lbl)
                {
                }
                column(Date_Caption_Control385; Date_Caption_Control385Lbl)
                {
                }
                column(Date_Caption_Control387; Date_Caption_Control387Lbl)
                {
                }
                column(Date_Caption_Control392; Date_Caption_Control392Lbl)
                {
                }
                column(Date_Caption_Control397; Date_Caption_Control397Lbl)
                {
                }
                column(EmptyStringCaption_Control398; FactualCorrectnessVerifiedByLbl)
                {
                }
                column(EmptyStringCaption_Control399; PostedByLbl)
                {
                }
                column(EmptyStringCaption_Control400; ApprovedByLbl)
                {
                }
                column(EmptyStringCaption_Control401; FormalCorrectnessVerifiedByLbl)
                {
                }
                column(Integer4_Number; Number)
                {
                }
                column(PCTempGLEntryAddCurrencyDebitAmountCaption; TempGLEntry.FIELDCAPTION("Add.-Currency Debit Amount"))
                {
                }
                column(PCTempGLEntryAddCurrencyCreditAmountCaption; TempGLEntry.FIELDCAPTION("Add.-Currency Credit Amount"))
                {
                }
                column(PCTempGLEntryAddCurrencyDebitAmount; TempGLEntry."Add.-Currency Debit Amount")
                {
                }
                column(PCTempGLEntryAddCurrencyCreditAmount; TempGLEntry."Add.-Currency Credit Amount")
                {
                }
                column(PCTempGLEntryVIN; TempGLEntry.VIN)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        TempGLEntry.FINDSET
                    ELSE
                        TempGLEntry.NEXT;

                    GLAcc.GET(TempGLEntry."G/L Account No.");
                    IF SumaG THEN
                        NameDescText := GLAcc.Name
                    ELSE
                        NameDescText := TempGLEntry.Description;
                end;

                trigger OnPostDataItem()
                begin
                    IF NewPageG THEN
                        CurrReport.NEWPAGE;
                end;

                trigger OnPreDataItem()
                begin
                    TempGLEntry.RESET;
                    SETRANGE(Number, 1, TempGLEntry.COUNT);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NewPageG THEN
                    CurrReport.PAGENO(1);
                TempGLEntry.DELETEALL;

                FCYRate := 0;
                IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN
                    FCYRate := 1 / "Currency Factor";

                // Start API.1.0.1 - SF
                GLEntryG.SETCURRENTKEY("Document No.");
                GLEntryG.SETRANGE("Document No.", "No.");
                IF NOT GLEntryG.FINDSET THEN
                    GLEntryG.INIT;
                VATEntryG.SETCURRENTKEY("Document No.");
                VATEntryG.SETRANGE("Document No.", "No.");
                IF NOT VATEntryG.FINDSET THEN
                    VATEntryG.INIT;
                // Stop API.1.0.1
            end;

            trigger OnPreDataItem()
            begin
                IF NOT "Purch. Credit Memo Header".HASFILTER THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem(GeneralDoc; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date");
            RequestFilterFields = "Document No.", "Posting Date";
            RequestFilterHeading = 'General Document';
            column(greCompanyInfo_Name_Control14; CompanyInfo.Name)
            {
            }
            column("Účetn__doklad__Control22"; "Document No.")
            {
            }
            column(Credit_AmountCaption_Control13; Credit_AmountCaption_Control13Lbl)
            {
            }
            column(Debit_AmountCaption_Control15; Debit_AmountCaption_Control15Lbl)
            {
            }
            column(greTGLEntry__Global_Dimension_2_Code__Control104Caption; CAPTIONCLASSTRANSLATE('1,1,2'))
            {
            }
            column(General_Document_Caption; General_Document_CaptionLbl)
            {
            }
            column(greTGLEntry__Global_Dimension_1_Code__Control107Caption; CAPTIONCLASSTRANSLATE('1,1,1'))
            {
            }
            column(EmptyStringCaption_Control19; DescriptionLbl)
            {
            }
            column(G_L_Account_NameCaption_Control21; G_L_Account_NameCaption_Control21Lbl)
            {
            }
            column("Účetn__doklad__Control22Caption"; FIELDCAPTION("Document No."))
            {
            }
            column(G_L_AccountCaption_Control28; G_L_AccountCaption_Control28Lbl)
            {
            }
            column(GeneralDoc_Entry_No_; "Entry No.")
            {
            }
            column(GeneralDoc_VIN; VIN)
            {
            }
            dataitem(GLEntry5; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    IF UserSetup."User ID" <> "User ID" THEN
                        IF NOT UserSetup.GET("User ID") THEN
                            UserSetup.INIT;

                    BufferGLEntry(GLEntry5);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", 1, LastGLEntry);
                end;
            }
            dataitem(Integer5; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                column(CurrReport_PAGENO_Control142; CurrReport.PAGENO)
                {
                }
                column("Účetn__doklad__Control144"; GeneralDoc."Document No.")
                {
                }
                column("Účetn__doklad__Control1100170022"; GeneralDoc."Document No.")
                {
                }
                column(greTGLEntry__Credit_Amount__Control98; TempGLEntry."Credit Amount")
                {
                }
                column(greTGLEntry__Debit_Amount__Control99; TempGLEntry."Debit Amount")
                {
                }
                column(greTGLEntry__Global_Dimension_2_Code__Control104; TempGLEntry."Global Dimension 2 Code")
                {
                }
                column(greTGLEntry__Global_Dimension_1_Code__Control107; TempGLEntry."Global Dimension 1 Code")
                {
                }
                column(greTGLEntry_Description; TempGLEntry.Description)
                {
                }
                column(NameDescText5; NameDescText)
                {
                }
                column(greTGLEntry__G_L_Account_No___Control127; TempGLEntry."G/L Account No.")
                {
                }
                column(greTGLEntry__Posting_Date_; FORMAT(TempGLEntry."Posting Date"))
                {
                }
                column(greUserSetup__User_Name__Control55; UserSetup."User ID")
                {
                }
                column(CurrReport_PAGENO_Control142Caption; CurrReport_PAGENO_Control142CaptionLbl)
                {
                }
                column("Účetn__doklad__Control144Caption"; GeneralDoc.FIELDCAPTION("Document No."))
                {
                }
                column("Účetn__doklad__Control1100170022Caption"; GeneralDoc.FIELDCAPTION("Document No."))
                {
                }
                column(ContinuedCaption_Control1100170027; ContinuedCaption_Control1100170027Lbl)
                {
                }
                column(ContinuedCaption_Control61; ContinuedCaption_Control61Lbl)
                {
                }
                column(Date_Caption_Control44; Date_Caption_Control44Lbl)
                {
                }
                column(Date_Caption_Control45; Date_Caption_Control45Lbl)
                {
                }
                column(EmptyStringCaption_Control48; PostedByLbl)
                {
                }
                column(EmptyStringCaption_Control49; ApprovedByLbl)
                {
                }
                column(EmptyStringCaption_Control51; FormalCorrectnessVerifiedByLbl)
                {
                }
                column(Date_Caption_Control53; Date_Caption_Control53Lbl)
                {
                }
                column(EmptyStringCaption_Control57; FactualCorrectnessVerifiedByLbl)
                {
                }
                column(Date_Caption_Control59; Date_Caption_Control59Lbl)
                {
                }
                column(Integer5_Number; Number)
                {
                }
                column(GDTempGLEntryAddCurrencyDebitAmountCaption; TempGLEntry.FIELDCAPTION("Add.-Currency Debit Amount"))
                {
                }
                column(GDTempGLEntryAddCurrencyCreditAmountCaption; TempGLEntry.FIELDCAPTION("Add.-Currency Credit Amount"))
                {
                }
                column(GDTempGLEntryAddCurrencyDebitAmount; TempGLEntry."Add.-Currency Debit Amount")
                {
                }
                column(GDTempGLEntryAddCurrencyCreditAmount; TempGLEntry."Add.-Currency Credit Amount")
                {
                }
                column(GDTempGLEntryVIN; TempGLEntry.VIN)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        TempGLEntry.FINDSET
                    ELSE
                        TempGLEntry.NEXT;

                    GLAcc.GET(TempGLEntry."G/L Account No.");
                    IF SumaG THEN
                        NameDescText := GLAcc.Name
                    ELSE
                        NameDescText := TempGLEntry.Description;
                end;

                trigger OnPreDataItem()
                begin
                    TempGLEntry.RESET;
                    SETRANGE(Number, 1, TempGLEntry.COUNT);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF LastDocNo <> "Document No." THEN BEGIN
                    LastDocNo := "Document No.";
                    IF NewPageG THEN
                        CurrReport.NEWPAGE;
                    TempGLEntry.DELETEALL;
                    IF NewPageG THEN
                        CurrReport.PAGENO(1);
                END ELSE
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT HASFILTER THEN
                    CurrReport.BREAK;
                IF NewPageG THEN
                    CurrReport.PAGENO(1);
                LastDocNo := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Možnosti")
                {
                    Caption = 'Options';
                    field(Suma; SumaG)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Group same G/L accounts';
                        ToolTip = 'Specifies if the same G/L accounts have to be group.';
                    }
                    field(NewPage; NewPageG)
                    {
                        Caption = 'Document on new page';
                        ToolTip = 'Specifies if the each document has to be printed on new page.';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            NewPageG := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        SumaG := TRUE;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;

        GLEntry.RESET;
        IF GLEntry.FINDLAST THEN
            LastGLEntry := GLEntry."Entry No.";

        LastDataItem := GetLastDataItem;
        SalesInvHdrExists := NOT "Sales Invoice Header".ISEMPTY AND "Sales Invoice Header".HASFILTER;
        SalesCrMemoHdrExists := NOT "Sales Credit Memo Header".ISEMPTY AND "Sales Credit Memo Header".HASFILTER;
        PurchInvHdrExists := NOT "Purch. Invoice Header".ISEMPTY AND "Purch. Invoice Header".HASFILTER;
        PurchCrMemoHdrExists := NOT "Purch. Credit Memo Header".ISEMPTY AND "Purch. Credit Memo Header".HASFILTER;
        GeneralDocExists := NOT GeneralDoc.ISEMPTY AND GeneralDoc.HASFILTER;
    end;

    var
        CompanyInfo: Record "Company Information";
        GLAcc: Record "G/L Account";
        UserSetup: Record "User Setup";
        TempGLEntry: Record "G/L Entry" temporary;
        GLEntry: Record "G/L Entry";
        LastDocNo: Code[20];
        FCYRate: Decimal;
        LastGLEntry: Integer;
        LastDataItem: Integer;
        SumaG: Boolean;
        NewPageG: Boolean;
        SalesInvHdrExists: Boolean;
        SalesCrMemoHdrExists: Boolean;
        PurchInvHdrExists: Boolean;
        PurchCrMemoHdrExists: Boolean;
        GeneralDocExists: Boolean;
        NameDescCaption: Text;
        NameDescText: Text;
        Sales_Invoice_CaptionLbl: Label '(Sales Invoice)';
        Sales_Invoice_Header__Sell_to_Customer_Name_CaptionLbl: Label 'Customer';
        Sales_Invoice_Header__Due_Date_CaptionLbl: Label 'Due Date';
        Amount_Including_VAT__AmountCaptionLbl: Label 'VAT Amount';
        FCYRateCaptionLbl: Label 'Rate';
        Credit_AmountCaptionLbl: Label 'Credit Amount';
        Debit_AmountCaptionLbl: Label 'Debit Amount';
        G_L_Account_NameCaptionLbl: Label 'G/L Account Name';
        G_L_AccountCaptionLbl: Label 'G/L Account';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control288Lbl: Label 'Continued';
        Date_CaptionLbl: Label 'Date:';
        Date_Caption_Control292Lbl: Label 'Date:';
        Date_Caption_Control297Lbl: Label 'Date:';
        Date_Caption_Control302Lbl: Label 'Date:';
        FactualCorrectnessVerifiedByLbl: Label 'Factual Correctness Verified by :';
        PostedByLbl: Label 'Posted by :';
        ApprovedByLbl: Label 'Approved by :';
        FormalCorrectnessVerifiedByLbl: Label 'Formal Correctness Verified by:';
        Sales_Credit_Memo_CaptionLbl: Label '(Sales Credit Memo)';
        Sales_Cr_Memo_Header__Due_Date_CaptionLbl: Label 'Due Date';
        Sales_Cr_Memo_Header__Sell_to_Customer_Name_CaptionLbl: Label 'Customer';
        Amount_Including_VAT__Amount_Control235CaptionLbl: Label 'VAT Amount';
        FCYRate_Control1100162004CaptionLbl: Label 'Rate';
        Credit_AmountCaption_Control20Lbl: Label 'Credit Amount';
        Debit_AmountCaption_Control24Lbl: Label 'Debit Amount';
        G_L_AccountCaption_Control29Lbl: Label 'G/L Account';
        CurrReport_PAGENO_Control41CaptionLbl: Label 'Page';
        ContinuedCaption_Control1100170024Lbl: Label 'Continued';
        ContinuedCaption_Control118Lbl: Label 'Continued';
        Date_Caption_Control121Lbl: Label 'Date:';
        Date_Caption_Control122Lbl: Label 'Date:';
        Date_Caption_Control247Lbl: Label 'Date:';
        Date_Caption_Control313Lbl: Label 'Date:';
        Purchase_Invoice_CaptionLbl: Label '(Purchase Invoice)';
        Purch__Inv__Header__Due_Date_CaptionLbl: Label 'Due Date';
        Purch__Inv__Header__Buy_from_Vendor_Name_CaptionLbl: Label 'Vendor';
        Purch__Inv__Header__Vendor_Invoice_No__CaptionLbl: Label 'External No.';
        Amount_Including_VAT__Amount_Control241CaptionLbl: Label 'VAT Amount';
        FCYRate_Control1100162009CaptionLbl: Label 'Rate';
        Credit_AmountCaption_Control319Lbl: Label 'Credit Amount';
        Debit_AmountCaption_Control320Lbl: Label 'Debit Amount';
        G_L_AccountCaption_Control324Lbl: Label 'G/L Account';
        CurrReport_PAGENO_Control326CaptionLbl: Label 'Page';
        ContinuedCaption_Control1100170025Lbl: Label 'Continued';
        ContinuedCaption_Control341Lbl: Label 'Continued';
        Date_Caption_Control343Lbl: Label 'Date:';
        Date_Caption_Control347Lbl: Label 'Date:';
        Date_Caption_Control350Lbl: Label 'Date:';
        Date_Caption_Control359Lbl: Label 'Date:';
        Purchase_Credit_Memo_CaptionLbl: Label '(Purchase Credit Memo)';
        Purch__Cr__Memo_Hdr___Due_Date_CaptionLbl: Label 'Due Date';
        Purch__Cr__Memo_Hdr___Buy_from_Vendor_Name_CaptionLbl: Label 'Vendor';
        Purch__Cr__Memo_Hdr___Vendor_Cr__Memo_No__CaptionLbl: Label 'External No.';
        Amount_Including_VAT__Amount_Control245CaptionLbl: Label 'VAT Amount';
        FCYRate_Control1100162011CaptionLbl: Label 'Rate';
        Credit_AmountCaption_Control360Lbl: Label 'Credit Amount';
        Debit_AmountCaption_Control362Lbl: Label 'Debit Amount';
        G_L_AccountCaption_Control366Lbl: Label 'G/L Account';
        CurrReport_PAGENO_Control368CaptionLbl: Label 'Page';
        ContinuedCaption_Control1100170026Lbl: Label 'Continued';
        ContinuedCaption_Control383Lbl: Label 'Continued';
        Date_Caption_Control385Lbl: Label 'Date:';
        Date_Caption_Control387Lbl: Label 'Date:';
        Date_Caption_Control392Lbl: Label 'Date:';
        Date_Caption_Control397Lbl: Label 'Date:';
        Credit_AmountCaption_Control13Lbl: Label 'Credit Amount';
        Debit_AmountCaption_Control15Lbl: Label 'Debit Amount';
        General_Document_CaptionLbl: Label '(General Document)';
        DescriptionLbl: Label 'Description';
        G_L_Account_NameCaption_Control21Lbl: Label 'G/L Account Name';
        G_L_AccountCaption_Control28Lbl: Label 'G/L Account';
        CurrReport_PAGENO_Control142CaptionLbl: Label 'Page';
        ContinuedCaption_Control1100170027Lbl: Label 'Continued';
        ContinuedCaption_Control61Lbl: Label 'Continued';
        Date_Caption_Control44Lbl: Label 'Date:';
        Date_Caption_Control45Lbl: Label 'Date:';
        Date_Caption_Control53Lbl: Label 'Date:';
        Date_Caption_Control59Lbl: Label 'Date:';
        __API__: Boolean;
        VATEntryG: Record "VAT Entry";
        GLEntryG: Record "G/L Entry";

    [Scope('Internal')]
    procedure GetLastDataItem(): Integer
    begin
        CASE TRUE OF
            NOT GeneralDoc.ISEMPTY AND GeneralDoc.HASFILTER:
                EXIT(5);
            NOT "Purch. Credit Memo Header".ISEMPTY AND "Purch. Credit Memo Header".HASFILTER:
                EXIT(4);
            NOT "Purch. Invoice Header".ISEMPTY AND "Purch. Invoice Header".HASFILTER:
                EXIT(3);
            NOT "Sales Credit Memo Header".ISEMPTY AND "Sales Credit Memo Header".HASFILTER:
                EXIT(2);
            NOT "Sales Invoice Header".ISEMPTY AND "Sales Invoice Header".HASFILTER:
                EXIT(1);
        END;
    end;

    local procedure BufferGLEntry(GLEntryP: Record "G/L Entry")
    begin
        WITH GLEntry DO BEGIN
            IF Amount = 0 THEN
                EXIT;
            // Start  API.1.0.4
            //TempGLEntry.SETRANGE("G/L Account No.","G/L Account No.");
            //TempGLEntry.SETRANGE("Global Dimension 1 Code","Global Dimension 1 Code");
            //TempGLEntry.SETRANGE("Global Dimension 2 Code","Global Dimension 2 Code");
            //TempGLEntry.SETRANGE("Job No.","Job No.");
            //IF TempGLEntry.FINDFIRST AND Suma THEN BEGIN
            //  TempGLEntry."Debit Amount" += "Debit Amount";
            //  TempGLEntry."Credit Amount" += "Credit Amount";
            //  TempGLEntry.MODIFY;
            //END ELSE BEGIN
            TempGLEntry.INIT;
            TempGLEntry.TRANSFERFIELDS(GLEntryP);
            TempGLEntry.INSERT;
            //END;
            // Stop  API.1.0.4
        END;
    end;
}


report 80015 "DPG General Journal" // 11777 "General Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/GeneralJournal.rdlc';
    Caption = 'General Journal';

    dataset
    {
        dataitem(Date; Date)
        {
            DataItemTableView = SORTING("Period Type", "Period Start") WHERE("Period Type" = CONST(Date));
            PrintOnlyIfDetail = true;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(greTGLEntry_FIELDCAPTION__Posting_Date___________; TempGLEntry.FIELDCAPTION("Posting Date") + ': ' + GETFILTER("Period Start"))
            {
            }
            column(General_JournalCaption; General_JournalCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(greTGLEntry__Credit_Amount_Caption; TGLEntry__Credit_Amount_CaptionLbl)
            {
            }
            column(greTGLEntry__Debit_Amount_Caption; TGLEntry__Debit_Amount_CaptionLbl)
            {
            }
            column(greTGLEntry_DescriptionCaption; TGLEntry_DescriptionCaptionLbl)
            {
            }
            column(greTGLEntry__G_L_Account_No__Caption; TGLEntry__G_L_Account_No__CaptionLbl)
            {
            }
            column(greTGLEntry__External_Document_No__Caption; TGLEntry__External_Document_No__CaptionLbl)
            {
            }
            column(greTGLEntry__Document_No__Caption; TGLEntry__Document_No__CaptionLbl)
            {
            }
            column(greTGLEntry__Posting_Date_Caption; TGLEntry__Posting_Date_CaptionLbl)
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Posting Date" = FIELD("Period Start");
                DataItemTableView = SORTING("Posting Date", "G/L Account No.", "Dimension Set ID");

                trigger OnAfterGetRecord()
                begin
                    IF Amount = 0 THEN
                        CurrReport.SKIP;

                    IF (RecordNo MOD 100) = 0 THEN
                        Window.UPDATE(2, ROUND(RecordNo / NoOfRecords * 10000, 1));
                    RecordNo := RecordNo + 1;

                    TempGLEntry.SETRANGE("Document No.", "Document No.");
                    TempGLEntry.SETRANGE("G/L Account No.", "G/L Account No.");
                    TempGLEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                    TempGLEntry.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
                    TempGLEntry.SETRANGE("Job No.", "Job No.");

                    IF TempGLEntry.FINDSET AND Sum THEN BEGIN
                        TempGLEntry."Debit Amount" += "Debit Amount";
                        TempGLEntry."Credit Amount" += "Credit Amount";
                        TempGLEntry.MODIFY;
                    END ELSE BEGIN
                        TempGLEntry.INIT;
                        TempGLEntry.TRANSFERFIELDS("G/L Entry");
                        TempGLEntry.INSERT;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(RecordNo);
                    NoOfRecords := COUNT;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                column(greTGLEntry__Posting_Date_; TempGLEntry."Posting Date")
                {
                }
                column(greTGLEntry__Document_No__; TempGLEntry."Document No.")
                {
                }
                column(greTGLEntry__External_Document_No__; TempGLEntry."External Document No.")
                {
                }
                column(greTGLEntry__G_L_Account_No__; TempGLEntry."G/L Account No.")
                {
                }
                column(greTGLEntry_Description; TempGLEntry.Description)
                {
                }
                column(greTGLEntry__Debit_Amount_; TempGLEntry."Debit Amount")
                {
                }
                column(greTGLEntry__Credit_Amount_; TempGLEntry."Credit Amount")
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

                    GLAccount.GET(TempGLEntry."G/L Account No.");
                end;

                trigger OnPostDataItem()
                begin
                    TempGLEntry.DELETEALL;
                end;

                trigger OnPreDataItem()
                begin
                    TempGLEntry.RESET;
                    TempGLEntry.SETCURRENTKEY("Document No.", "Posting Date");

                    SETRANGE(Number, 1, TempGLEntry.COUNT);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Period Start");
                Window.UPDATE(2, 0);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Period Start", FromDate, ToDateG);

                Window.OPEN(Text000 + Text002);
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
                    field(FromDate; FromDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'From Date';
                        ToolTip = 'Specifies the first date of period.';
                    }
                    field(ToDate; ToDateG)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'To Date';
                        ToolTip = 'Specifies report to date';
                    }
                    field("Sum"; Sum)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sum Identical G/L Account';
                        ToolTip = 'Specifies if the identical G/L account have to be sumed.';
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

    trigger OnPreReport()
    begin
        IF FromDate = 0D THEN
            ERROR(FromDateErr);
    end;

    var
        FromDateErr: Label 'Enter the value "From Date".';
        Text000: Label 'Processing Date #1#########\\';
        Text002: Label 'Progress @2@@@@@@@@@@@@@';
        General_JournalCaptionLbl: Label 'General Journal';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TGLEntry__Credit_Amount_CaptionLbl: Label 'Credit Amount';
        TGLEntry__Debit_Amount_CaptionLbl: Label 'Debit Amount';
        TGLEntry_DescriptionCaptionLbl: Label 'Description';
        TGLEntry__G_L_Account_No__CaptionLbl: Label 'G/L Account No.';
        TGLEntry__External_Document_No__CaptionLbl: Label 'External Document No.';
        TGLEntry__Document_No__CaptionLbl: Label 'Document No.';
        TGLEntry__Posting_Date_CaptionLbl: Label 'Posting Date';
        GLAccount: Record "G/L Account";
        TempGLEntry: Record "G/L Entry" temporary;
        Window: Dialog;
        RecordNo: Integer;
        NoOfRecords: Integer;
        "Sum": Boolean;
        FromDate: Date;
        ToDateG: Date;
}


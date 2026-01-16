report 80011 "DPG Item Register" // 703 "Item Register"
{
    // // @ Area Parts
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number    Date
    // ------------------------------------------------
    // 
    // PA-Number  Date
    // ------------------------------------------------
    // PA032727   12.07.11 PR #3534679: Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA032727   12.07.11 PR Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA036090   04.07.14 GD 24080 Object Killed
    // PA036549   22.01.15 LR 32688 Redoo the report
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ItemRegister.rdlc';

    Caption = 'Item Register';

    dataset
    {
        dataitem("Item Register"; "Item Register")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
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
            column(Item_Register__TABLECAPTION__________ItemRegFilter; "Item Register".TABLECAPTION + ': ' + ItemRegFilter)
            {
            }
            column(Item_Register__No__; "No.")
            {
            }
            column(Item_Register__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(ArtikeljournalCaption; ArtikeljournalCaptionbl)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Item_Ledger_Entry__Entry_Type_; "Entry Type")
                {
                }
                column(Item_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Item_Ledger_Entry__Item_No__; "Item No.")
                {
                }
                column(ItemDescription; ItemDescription)
                {
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Item_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Item_Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                {
                }
                column(Item_Ledger_Entry__Entry_Type_Caption; FIELDCAPTION("Entry Type"))
                {
                }
                column(Item_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(ItemDescriptionCaption; ItemDescriptionCaptionbl)
                {
                }
                column(Item_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Item_Ledger_Entry__Entry_No__Caption; FIELDCAPTION("Entry No."))
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Item_Ledger_Entry_Location_Code; "Item Ledger Entry"."Location Code")
                {
                }
                column(Item_Ledger_Entry_Location_Caption; FIELDCAPTION("Location Code"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ItemDescription := Description;
                    IF ItemDescription = '' THEN BEGIN
                        IF NOT Item.GET("Item No.") THEN
                            Item.INIT;
                        ItemDescription := Item.Description;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", "Item Register"."From Entry No.", "Item Register"."To Entry No.");
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnPreReport()
    begin
        ItemRegFilter := "Item Register".GETFILTERS;
    end;

    var
        Item: Record Item;
        ItemRegFilter: Text[250];
        ItemDescription: Text[50];
        ItemDescriptionCaptionbl: Label 'Description';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ArtikeljournalCaptionbl: Label 'Item Register';
}


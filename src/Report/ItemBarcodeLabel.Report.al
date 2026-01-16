report 80016 "DPG Item Barcode Label" // 5206818 "Item Barcode Label"
{
    // // @ Area Barcode
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA032031   07.10.11 GS New Object for Barcode Scanner Interface to print barcoded Item Labels.
    // PA032672   02.02.12 GB #7033035: Add in ReqFilterFields "Location Filter"
    // PA033067   12.04.12 DR DE Captions implemented
    // PA033336   14.09.12 RDLC Development
    //                     - Conversion to RDLC Format
    //                     - RequestPage created
    //                     - Standardizing Font size across all controls
    //                     - DataSetFieldName generated for all controls.
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA041187   06.04.17 GD 93101 Modification in RDLC. Removed 2nd barcode line and increased 1st barcode line's height and content.
    // --- 7.2.0 ---
    // EU.0016448 02.02.18 GN Changed barcode font
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/ItemBarcodeLabel.rdlc';

    Caption = 'Item Barcode Label';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Location Filter";
            column(ItemNoG; ItemNoG)
            {
            }
            column(ItemBarCodeG; ItemBarCodeG)
            {
            }
            column(ItemBarCodeG_Control1119432010; ItemBarCodeG)
            {
            }
            column(DescriptionG; DescriptionG)
            {
            }
            column(BinG; BinG)
            {
            }
            column(PrintBinG; PrintBinG)
            {
                Description = 'PA033336';
            }
            column(ItemNoG_Control1119432000; ItemNoG)
            {
            }
            column(DescriptionG_Control1119432003; DescriptionG)
            {
            }
            column(ItemBarCodeG_Control1119432005; ItemBarCodeG)
            {
            }
            column(ItemBarCodeG_Control1119432006; ItemBarCodeG)
            {
            }
            column(PrintBin1G; PrintBinG)
            {
                Description = 'PA033336';
            }
            column(Item_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ItemBarCodeG := '*' + Item."No." + '*';
                ItemNoG := PrintFormat(Item."No.");
                DescriptionG := Item.Description;

                ItemBinG.RESET;
                ItemBinG.SETRANGE("Item No.", Item."No.");
                ItemBinG.SETRANGE("Location Code", Item.GETFILTER(Item."Location Filter"));
                ItemBinG.SETRANGE("Sales Default", TRUE);
                IF ItemBinG.FINDFIRST THEN BEGIN
                    BinG := ItemBinG."Bin Code";
                END ELSE BEGIN
                    ItemBinG.SETRANGE("Sales Default");
                    IF ItemBinG.FINDFIRST THEN
                        BinG := ItemBinG."Bin Code"
                    ELSE
                        BinG := Item."Shelf No.";
                END;
                IF BinG = '' THEN
                    BinG := '.....';
            end;

            trigger OnPreDataItem()
            begin
                IF Item.GETFILTERS = '' THEN
                    ERROR(C_BMW001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                Description = 'PA033336';
                group(Control1101207291)
                {
                    Description = 'PA033336';
                    ShowCaption = false;
                    field(PrintBinG; PrintBinG)
                    {
                        Caption = 'Print Bin Information';
                        Description = 'PA033336';
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
        BarCodeSetupG.GET;
        IF NOT GUIALLOWED THEN
            PrintBinG := BarCodeSetupG."Print Item Bin Information";
    end;

    var
        BarCodeSetupG: Record "Barcode Scanner Setup";
        ItemBinG: Record "Item Bin";
        DescriptionG: Text[50];
        ItemBarCodeG: Text[30];
        ItemNoG: Text[50];
        BinG: Code[20];
        C_BMW001: Label 'Please set filter for running this report!';
        PrintBinG: Boolean;

    [Scope('Internal')]
    procedure PrintFormat(ItemNoP: Text[30]) FormatItemNoR: Text[50]
    var
        LenL: Integer;
    begin
        FOR LenL := 1 TO STRLEN(ItemNoP) DO
            FormatItemNoR := FormatItemNoR + COPYSTR(ItemNoP, LenL, 1) + ' ';
    end;
}


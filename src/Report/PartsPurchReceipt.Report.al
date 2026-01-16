report 80020 "DPG Parts Purch. Receipt" // 5028815 "Parts Purch. Receipt"
{
    // // @ Area PartsPurchase
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033052   05.05.11 PR  Added code to print the report title from 'Report Selection' setup.
    // PA032727   12.07.11 PR  Removal of DocMS functionality. Deleted SetVariables() and code related to DocMS.
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033336   02.11.12 GC 9074533: RDL Layout Created
    // PA033336   07.11.12 GC 9213381: RDL Layout modifications
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA036549   05.01.15 GK 32272 RDLC Layout modified - No. column extended to take in at least 15 characters
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // PA041511   23.08.16 VJ Use the ôBuy-from Vendor No.ö instead of the ôSell to Customer No.ö to read the vendor information record.
    // PA041513   23.08.16 VJ Merge of PA041511
    // PA042484   28.12.16 PT Added the code to print word Duplicate if its not a original invoice
    // PA042484   20.01.17 PT Added the text box in RDLC to print word "DUPLICATE"
    // PA042485   10.05.17 PT 95156 Added the check on NoOfCopies value if its less than 0
    // --- 7.1.5 ---
    // PA041023   28.11.16 KB Report modified to Show VIN field.
    // PA041023   03.02.17 SV 87225 Report Modified to Show "Refernece License No." information and Caption change of "Refernece VIN"
    // --- 7.1.6 ---
    // EU.0002138 28.06.17 AK 2101 Merge of PA042484 & PA042485.95156
    // --- 7.2.0 ---
    // EU.0001175 10.10.17 AK Version List updated
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsPurchReceipt.rdlc';

    Caption = 'Parts Purch. Receipt';

    dataset
    {
        dataitem("Purch. Receipt Header"; "Purch. Receipt Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Parts Purchase Shipment';
            column(Purch__Receipt_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoopNo; CopyLoopNoG)
                {
                }
                column(PrintDangerous; PrintDangerousG)
                {
                }
                column(CopyLoopDocumentPageNo; Number)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(Field11; CompanyAddrG[1])
                    {
                    }
                    column(Field12; CompanyAddrG[2])
                    {
                    }
                    column(Field13; CompanyAddrG[4])
                    {
                    }
                    column(Field16; CoTelephoneG)
                    {
                    }
                    column(Field18; CoFaxG)
                    {
                    }
                    column(Field31; FORMAT("Purch. Receipt Header"."Document Date"))
                    {
                    }
                    column(Field29; "Purch. Receipt Header"."No.")
                    {
                    }
                    column(Field25; "Purch. Receipt Header"."Order No.")
                    {
                    }
                    column(Field14; CompanyAddrG[5])
                    {
                    }
                    column(Field20; CoEmailG)
                    {
                    }
                    column(Field01; CompAddrG)
                    {
                    }
                    column(Field27; FORMAT("Purch. Receipt Header"."Order Date"))
                    {
                    }
                    column(Field23; CustNoG)
                    {
                    }
                    column(Field17; CoFaxTextG)
                    {
                    }
                    column(Field19; CoEmailTextG)
                    {
                    }
                    column(Field15; CoTelephoneTextG)
                    {
                    }
                    column(Field02; ShipToAddrG[1])
                    {
                    }
                    column(Field03; ShipToAddrG[2])
                    {
                    }
                    column(Field04; ShipToAddrG[3])
                    {
                    }
                    column(Field05; ShipToAddrG[4])
                    {
                    }
                    column(Field06; ShipToAddrG[5])
                    {
                    }
                    column(Field07; ShipToAddrG[6])
                    {
                    }
                    column(Field08; ShipToAddrG[7])
                    {
                    }
                    column(Field09; ShipToAddrG[8])
                    {
                    }
                    column(Field33; SalesPurchG.Name)
                    {
                    }
                    column(Field10; CopyTextG)
                    {
                    }
                    column(Field21; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(HidePurchReceiptLineBody2; RDLHideOutput("Purch. Receipt Line".Type IN ["Purch. Receipt Line".Type::"Account (G/L)", "Purch. Receipt Line".Type::"Fixed Asset", "Purch. Receipt Line".Type::Item, "Purch. Receipt Line".Type::"Charge (Item)"]))
                    {
                    }
                    column(HidePurchReceiptLineBody3; RDLHideOutput("Purch. Receipt Line"."Description 2" <> ''))
                    {
                    }
                    column(Field28; Field28Lbl)
                    {
                    }
                    column(Field30; Field30Lbl)
                    {
                    }
                    column(Field34; Field34Lbl)
                    {
                    }
                    column(Field22; Field22Lbl)
                    {
                    }
                    column(Field32; Field32Lbl)
                    {
                    }
                    column(Field24; Field24Lbl)
                    {
                    }
                    column(Field26; Field26Lbl)
                    {
                    }
                    column(DuplicateText; DuplicateTextG)
                    {
                        Description = 'PA042484';
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Show_VIN_Boolean_Header; ShowVING)
                    {
                        Description = 'PA041023';
                    }
                    column(Purch_Receipt_Header_VIN; "Purch. Receipt Header"."Supply VIN")
                    {
                        Description = 'PA041023';
                    }
                    column(Purch_Receipt_Header_Reference_License_No; "Purch. Receipt Header"."Reference License No.")
                    {
                        Description = 'PA041023.87225';
                    }
                    dataitem("Header Text"; "Posted Purchase Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Receipt Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Receipt), "Header/Footer" = CONST(Header));
                        column(HideHeaderTextHeader1; RDLHideOutput(TRUE))
                        {
                        }
                        column(HeaderTextBody1; COPYSTR(Text, 1, 70))
                        {
                        }
                        column(HeaderTextBody2; COPYSTR(Text, 71, 30))
                        {
                        }
                        column(Header_Text_Document_Type; "Document Type")
                        {
                        }
                        column(Header_Text_Document_No_; "Document No.")
                        {
                        }
                        column(Header_Text_Header_Footer; "Header/Footer")
                        {
                        }
                        column(Header_Text_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem("Purch. Receipt Line"; "Purch. Receipt Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Receipt Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(PurchPriceTextG; PurchPriceTextG)
                        {
                        }
                        column(DiscTextG; DiscTextG)
                        {
                        }
                        column(HidePurchReceiptLineHeader1; RDLHideOutput(TRUE))
                        {
                        }
                        column(Purch__Receipt_Line_Description; Description)
                        {
                        }
                        column(Purch__Receipt_Line_Quantity; Quantity)
                        {
                        }
                        column(Purch__Receipt_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Purch__Receipt_Line__Direct_Unit_Cost_; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Receipt Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purch__Receipt_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(NoPropertyG; NoPropertyG)
                        {
                        }
                        column(Purch__Receipt_Line__Order_No__; OrderNoG)
                        {
                        }
                        column(PrintNoG; PrintNoG)
                        {
                        }
                        column(Purch__Receipt_Line__Description_2_; "Description 2")
                        {
                        }
                        column(No_Caption; No_CaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
                        {
                        }
                        column(UoMCaption; UoMCaptionLbl)
                        {
                        }
                        column(Order_No_Caption; Order_No_CaptionLbl)
                        {
                        }
                        column(CommentCaption; CommentCaptionLbl)
                        {
                        }
                        column(Purch__Receipt_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purch__Receipt_Line_Line_No_; "Line No.")
                        {
                        }
                        column(Show_VIN_Boolean; ShowVING)
                        {
                            Description = 'PA041023';
                        }
                        column(Purch_Receipt_Line_VIN; "Purch. Receipt Line"."Supply VIN")
                        {
                            Description = 'PA041023';
                        }
                        column(Purch_Receipt_Line_Reference_License_No; "Purch. Receipt Line"."Reference License No.")
                        {
                            Description = 'PA041023.87225';
                        }
                        dataitem(PurchRcptLine; "Purch. Receipt Line")
                        {
                            DataItemLink = "Document No." = FIELD("Document No."), "Attached to Line No." = FIELD("Line No.");
                            DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = CONST(" "));
                            column(PurchRcptLine_Description; Description)
                            {
                            }
                            column(PurchRcptLineBody1; RDLHideOutput(PurchRcptLine.Type = 0))
                            {
                            }
                            column(PurchRcptLine_Document_No_; "Document No.")
                            {
                            }
                            column(PurchRcptLine_Line_No_; "Line No.")
                            {
                            }
                            column(PurchRcptLine_Attached_to_Line_No_; "Attached to Line No.")
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemL: Record Item;
                            RefMasterL: Record "Reference Master";
                        begin
                            NoPropertyG := '';
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                                NoPropertyG := C_INC016;
                            IF (PrntDangerousGoodsListG) AND ("Purch. Receipt Line"."Item Type" = "Purch. Receipt Line"."Item Type"::Item) THEN BEGIN
                                IF ItemL.GET("Purch. Receipt Line"."No.") THEN BEGIN
                                    IF ItemL."Dangerous Goods Code" <> '' THEN BEGIN
                                        DangerousGoodsListTG.INIT;
                                        DangerousGoodsListTG."Entry No." := DangerousGoodsListTG."Entry No." + 1;
                                        DangerousGoodsListTG."Code 01" := ItemL."No.";
                                        DangerousGoodsListTG."Text 01" := ItemL.Description;
                                        DangerousGoodsListTG."Value 1" := "Purch. Receipt Line".Quantity;
                                        DangerousGoodsListTG."Code 02" := ItemL."Dangerous Goods Code";
                                        RefMasterL.SETRANGE("Make Code", ItemL."Make Code");
                                        RefMasterL.SETRANGE(Type, RefMasterL.Type::"Dangerous Goods Code");
                                        RefMasterL.SETRANGE(Code, ItemL."Dangerous Goods Code");
                                        IF RefMasterL.FIND('-') THEN
                                            DangerousGoodsListTG."Text 02" := RefMasterL.Description;
                                        DangerousGoodsListTG.INSERT;
                                    END;
                                END;
                            END;
                            // Start PA033336
                            OrderNoG := "Order No.";
                            IF "Purch. Receipt Line".Type IN ["Purch. Receipt Line".Type::"Account (G/L)", "Purch. Receipt Line".Type::"Fixed Asset",
                               "Purch. Receipt Line".Type::Item, "Purch. Receipt Line".Type::"Charge (Item)"]
                            THEN BEGIN
                                IF ("Line Discount %" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                    "Direct Unit Cost" := "Direct Unit Cost" / (100 - "Line Discount %") * 100;
                                    "Line Discount %" := 0;
                                END;
                                IF NOT ShowPricesG THEN BEGIN
                                    "Direct Unit Cost" := 0;
                                    "Line Discount %" := 0;
                                END;
                            END;
                            IF ("Purch. Receipt Line".Type = "Purch. Receipt Line".Type::Item) OR
                               ("Purch. Receipt Line".Type = "Purch. Receipt Line".Type::"Charge (Item)")
                            THEN BEGIN
                                PrintNoG := "Purch. Receipt Line"."No.";
                                IF "Purch. Receipt Line".Type = "Purch. Receipt Line".Type::Item THEN BEGIN
                                    IF ItemL.GET("Purch. Receipt Line"."No.") THEN BEGIN
                                        IF ItemL."Manufacturer No." <> '' THEN BEGIN
                                            PrintNoG := ItemL."Manufacturer No.";
                                        END;
                                    END;
                                END;
                            END;
                            IF ("Purch. Receipt Line".Type = "Purch. Receipt Line".Type::"Account (G/L)") OR
                               ("Purch. Receipt Line".Type = "Purch. Receipt Line".Type::"Fixed Asset")
                            THEN BEGIN
                                OrderNoG := '';
                                PrintNoG := '';
                                NoPropertyG := '';
                            END;
                            IF ("Purch. Receipt Line".Type = "Purch. Receipt Line".Type::"Charge (Item)") THEN BEGIN
                                NoPropertyG := '';
                            END;
                            // Stop PA033336
                        end;

                        trigger OnPreDataItem()
                        begin
                            CASE SortingLinesG OF
                                SortingLinesG::"No.":
                                    "Purch. Receipt Line".SETCURRENTKEY("Document No.", "No.", "Location Code", "Bin Code", "Shelf/Bin No.");
                                SortingLinesG::"Order No.":
                                    "Purch. Receipt Line".SETCURRENTKEY("Document No.", "Order No.", "Location Code", "Bin Code", "Shelf/Bin No.");
                                SortingLinesG::"Order No./No.":
                                    "Purch. Receipt Line".SETCURRENTKEY("Document No.", "Order No.", "No.", "Location Code", "Bin Code", "Shelf/Bin No.");
                            END;
                        end;
                    }
                    dataitem("Footer Text"; "Posted Purchase Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Receipt Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST(Receipt), "Header/Footer" = CONST(Footer));
                        column(HideFooterTextHeader1; RDLHideOutput(TRUE))
                        {
                        }
                        column(FooterTextBody1; COPYSTR(Text, 1, 70))
                        {
                        }
                        column(FooterTextBody2; COPYSTR(Text, 71, 30))
                        {
                        }
                        column(Footer_Text_Document_Type; "Document Type")
                        {
                        }
                        column(Footer_Text_Document_No_; "Document No.")
                        {
                        }
                        column(Footer_Text_Header_Footer; "Header/Footer")
                        {
                        }
                        column(Footer_Text_Line_No_; "Line No.")
                        {
                        }
                    }
                }
                dataitem(DangerousGoods; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(DangerousGoodsField01; CompAddrG)
                    {
                    }
                    column(DangerousGoodsField02; ShipToAddrG[1])
                    {
                    }
                    column(DangerousGoodsField03; ShipToAddrG[2])
                    {
                    }
                    column(DangerousGoodsField04; ShipToAddrG[3])
                    {
                    }
                    column(DangerousGoodsField05; ShipToAddrG[4])
                    {
                    }
                    column(DangerousGoodsField10; CopyTextG)
                    {
                    }
                    column(DangerousGoodsField11; CompanyAddrG[1])
                    {
                    }
                    column(DangerousGoodsField12; CompanyAddrG[2])
                    {
                    }
                    column(DangerousGoodsField13; CompanyAddrG[4])
                    {
                    }
                    column(DangerousGoodsField14; CompanyAddrG[5])
                    {
                    }
                    column(DangerousGoodsField17; CoFaxTextG)
                    {
                    }
                    column(DangerousGoodsField19; CoEmailTextG)
                    {
                    }
                    column(DangerousGoodsField15; CoTelephoneTextG)
                    {
                    }
                    column(DangerousGoodsField06; ShipToAddrG[5])
                    {
                    }
                    column(DangerousGoodsField16; CoTelephoneG)
                    {
                    }
                    column(DangerousGoodsField18; CoFaxG)
                    {
                    }
                    column(DangerousGoodsField20; CoEmailG)
                    {
                    }
                    column(DangerousGoodsField23; VendG."Our Account No.")
                    {
                    }
                    column(DangerousGoodsField07; ShipToAddrG[6])
                    {
                    }
                    column(DangerousGoodsField25; "Purch. Receipt Header"."Order No.")
                    {
                    }
                    column(DangerousGoodsField08; ShipToAddrG[7])
                    {
                    }
                    column(DangerousGoodsField27; FORMAT("Purch. Receipt Header"."Order Date"))
                    {
                    }
                    column(DangerousGoodsField09; ShipToAddrG[8])
                    {
                    }
                    column(DangerousGoodsField29; "Purch. Receipt Header"."No.")
                    {
                    }
                    column(DangerousGoodsField31; FORMAT("Purch. Receipt Header"."Document Date"))
                    {
                    }
                    column(DangerousGoodsField33; SalesPurchG.Name)
                    {
                    }
                    column(DangerousGoodsField35; OrderCustAddrLineG)
                    {
                    }
                    column(DangerousGoodsListTG__Text_02_; DangerousGoodsListTG."Text 02")
                    {
                    }
                    column(DangerousGoodsListTG__Code_02_; DangerousGoodsListTG."Code 02")
                    {
                    }
                    column(DangerousGoodsListTG__Value_1_; DangerousGoodsListTG."Value 1")
                    {
                    }
                    column(DangerousGoodsListTG__Text_01_; DangerousGoodsListTG."Text 01")
                    {
                    }
                    column(DangerousGoodsListTG__Code_01_; DangerousGoodsListTG."Code 01")
                    {
                    }
                    column(DangerousGoodsField21; DangerousGoodsField21Lbl)
                    {
                    }
                    column(DangerousGoodsField22; DangerousGoodsField22Lbl)
                    {
                    }
                    column(DangerousGoodsField24; DangerousGoodsField24Lbl)
                    {
                    }
                    column(DangerousGoodsField26; DangerousGoodsField26Lbl)
                    {
                    }
                    column(DangerousGoodsField28; DangerousGoodsField28Lbl)
                    {
                    }
                    column(DangerousGoodsField30; DangerousGoodsField30Lbl)
                    {
                    }
                    column(DangerousGoodsField32; DangerousGoodsField32Lbl)
                    {
                    }
                    column(DangerousGoodsField34; DangerousGoodsField34Lbl)
                    {
                    }
                    column(Qty_Caption_Control1109400067; Qty_Caption_Control1109400067Lbl)
                    {
                    }
                    column(DescriptionCaption_Control1109400068; DescriptionCaption_Control1109400068Lbl)
                    {
                    }
                    column(No_Caption_Control1109400069; No_Caption_Control1109400069Lbl)
                    {
                    }
                    column(Dangerous_Goods_CodeCaption; Dangerous_Goods_CodeCaptionLbl)
                    {
                    }
                    column(DescriptionCaption_Control1109400071; DescriptionCaption_Control1109400071Lbl)
                    {
                    }
                    column(DangerousGoods_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF DangerousGoods.Number = 1 THEN
                            DangerousGoodsListTG.FIND('-')
                        ELSE
                            DangerousGoodsListTG.NEXT;
                    end;

                    trigger OnPostDataItem()
                    begin
                        // Start PA033336
                        PrintDangerousG := FALSE;
                        DangerousGoodsListTG.DELETEALL;
                        // Stop PA033336
                    end;

                    trigger OnPreDataItem()
                    begin
                        DangerousGoodsListTG.RESET;
                        SETRANGE(Number, 1, DangerousGoodsListTG.COUNT);
                        // Start PA033336
                        IF NOT DangerousGoods.ISEMPTY THEN BEGIN
                            // Start PA042484
                            CopyLoopNoG := CopyLoopNoG + 1;
                            // Stop PA042484
                            PrintDangerousG := TRUE;
                        END ELSE BEGIN
                            // Start PA035597
                            CurrReport.BREAK;
                            // Stop PA035597
                        END;
                        // Stop PA033336
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN
                        CopyTextG := C_INC029;
                    // Start PA042484
                    IF ("Purch. Receipt Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN
                        DuplicateTextG := C_INC_DuplicateText;
                    CopyLoopNoG := CopyLoopNoG + 1;
                    // Stop PA042484
                end;

                trigger OnPostDataItem()
                begin
                    // Start PA032727
                    IF NOT CurrReport.PREVIEW THEN
                        RcptCountPrintedG.RUN("Purch. Receipt Header");
                    // Stop PA032727
                end;

                trigger OnPreDataItem()
                begin
                    // Start PA042484
                    CopyTextG := '';
                    SETRANGE(Number, 1, ABS(NoOfCopiesG) + 1);
                    DuplicateTextG := '';
                    // Stop PA042484
                end;
            }

            trigger OnAfterGetRecord()
            var
                OurAccNoL: Record "Our Account/Dealer No.";
            begin
                DangerousGoodsListTG.DELETEALL;
                // Start PA032727
                // Stop PA032727
                IF NOT LocationG.GET("Location Code") THEN
                    CLEAR(LocationG);
                IntCustG := CompanyInfoG."Internal Customer";
                IF LocationG."Internal Customer" <> '' THEN
                    IntCustG := LocationG."Internal Customer";
                IF (LocationG."Ship-to Address Code" <> '') AND
                   (OwnDelivAddressG.GET(IntCustG, LocationG."Ship-to Address Code"))
                THEN BEGIN
                    FormatAddrG.OwnCustomerAddress(CompanyAddrG, OwnDelivAddressG);
                    CoTelephoneG := OwnDelivAddressG."Phone No.";
                    CoFaxG := OwnDelivAddressG."Fax No.";
                    CoEmailG := OwnDelivAddressG."E-Mail";
                    FormatAddrG.OwnAddressLetterWindow(CoAddrSenderLineG, OwnDelivAddressG);
                END ELSE BEGIN
                    FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
                    FormatAddrG.CompanyLetterAddressWindow(CoAddrSenderLineG, CompanyInfoG);
                END;
                IF PrintSentFromLineG THEN
                    CompAddrG := FormatAddrG.GetWindowAddress(C_INC005);

                IF PrintAddrBlockG THEN BEGIN
                    CoTelephoneTextG := C_INC002;
                    CoFaxTextG := C_INC003;
                    CoEmailTextG := C_INC004;
                END ELSE BEGIN
                    CLEAR(CompanyAddrG);
                    CoTelephoneG := '';
                    CoFaxG := '';
                    CoEmailG := '';
                END;

                FormatAddrG.PurchRcptBuyFrom(ShipToAddrG, "Purch. Receipt Header");
                ShowCustAddrG := "Buy-from Vendor No." <> "Pay-to Vendor No.";
                FOR IG := 1 TO ARRAYLEN(VendAddrG) DO
                    IF VendAddrG[IG] <> ShipToAddrG[IG] THEN
                        ShowCustAddrG := TRUE;

                IF NOT SalesPurchG.GET("Purchaser Code") THEN
                    SalesPurchG.Name := "Purchaser Code";

                // Start PA041511
                VendG.GET("Buy-from Vendor No.");
                // Stop PA041511

                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscCheckPurchRcptLineG.SETRANGE("Document No.", "No.");
                    DiscCheckPurchRcptLineG.SETFILTER("Line Discount %", '>%1', 0);
                    IF DiscCheckPurchRcptLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';

                IF NOT ShowPricesG THEN BEGIN
                    DiscTextG := '';
                    PurchPriceTextG := '';
                END ELSE
                    PurchPriceTextG := C_INC011;
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(15) <> '';
                    IF LogInteractionG THEN
                        SegMgntG.LogDocument(
                          15, "No.", 0, 0, DATABASE::Vendor, "Pay-to Vendor No.",
                          "Purchaser Code", '', "Posting Description");
                END;
                CustNoG := OurAccNoL.GetOurAccDealerNo("Buy-from Vendor No.", "Shortcut Dimension 2 Code", "Location Code", "Order Type" + 1);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
                // Start PA042484
                CopyLoopNoG := 0;
                // Stop PA042484
            end;
        }
    }

    requestpage
    {
        Caption = 'Parts Purchases - Receipt';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Možnosti")
                {
                    Caption = 'Options';
                    field(NoOfCopiesG; NoOfCopiesG)
                    {
                        Caption = 'No. of Copies';

                        trigger OnValidate()
                        begin
                            // Start PA042485.95156
                            IF NoOfCopiesG < 0 THEN
                                ERROR(C_INC_NoOfCopiesValue);
                            //Stop PA042485.95156
                        end;
                    }
                    field(SortingLinesG; SortingLinesG)
                    {
                        Caption = 'Sorting';
                        OptionCaption = 'Item No.,Order No.,Order No./Item No.';
                    }
                    field(ShowPricesG; ShowPricesG)
                    {
                        Caption = 'Print Prices';
                    }
                    field(PrintSentFromLineG; PrintSentFromLineG)
                    {
                        Caption = 'Print Sent-From Line';
                    }
                    field(PrintAddrBlockG; PrintAddrBlockG)
                    {
                        Caption = 'Print Address Block';
                    }
                    field(PrintFooterLineG; PrintFooterLineG)
                    {
                        Caption = 'Print Footer Line';
                    }
                    field(PrntDangerousGoodsListG; PrntDangerousGoodsListG)
                    {
                        Caption = 'Print Dangerous Goods List';
                    }
                    field("Print VIN"; ShowVING)
                    {
                        Caption = 'Print VIN/License No';
                        Description = 'PA041023.87225';
                    }
                    field("Re-Print Original Invoice"; RePrintOriginalInvG)
                    {
                        Caption = 'Re-Print Original Invoice';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA032727
            // Start PA039225.51457
            // Start PA033336
            // Stop PA033336
            // Start PA033336
            // Stop PA033336
            // Stop PA032727
            GetReportSelection();
            // Stop PA039225.51457
        end;
    }

    labels
    {
        Supply_VIN_Caption = 'Reference VIN';
        Reference_License_No = 'Reference License No.';
    }

    trigger OnInitReport()
    begin
        // Start PA032727
        // Start PA039225.51457
        // Start PA035597
        // Stop PA035597
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        // Stop PA032727
        GetReportSelection();
        // Stop PA039225.51457
    end;

    var
        ReportSelectionG: Record "Report Selection";
        PrinterSelectionG: Record "Printer Selection";
        OwnDelivAddressG: Record "Ship-to Address";
        CompanyInfoG: Record "Company Information";
        VendG: Record Vendor;
        LocationG: Record Location;
        DiscCheckPurchRcptLineG: Record "Purch. Receipt Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        RcptCountPrintedG: Codeunit "Purch.Rcpt.-Printed";
        FormatAddrG: Codeunit "Format Address";
        IntCustG: Code[20];
        VendAddrG: array[8] of Text[50];
        ShipToAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        CompAddrG: Text[250];
        OrderCustAddrLineG: Text[250];
        CopyTextG: Text[30];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        DiscTextG: Text[30];
        NoPropertyG: Text[30];
        PurchPriceTextG: Text[30];
        CustNoG: Text[30];
        DuplicateTextG: Text[100];
        NoOfCopiesG: Integer;
        IG: Integer;
        ShowCustAddrG: Boolean;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        PrintWithoutDiscG: Boolean;
        C_INC009: Label 'Disc. %';
        ShowPricesG: Boolean;
        C_INC011: Label 'Unit Price';
        C_INC016: Label '*';
        C_INC029: Label 'Copy';
        PrintNoG: Code[20];
        SortingLinesG: Option "No.","Order No.","Order No./No.";
        SegMgntG: Codeunit SegManagement;
        LogInteractionG: Boolean;
        PrntDangerousGoodsListG: Boolean;
        DangerousGoodsListTG: Record "Temporary Statistics" temporary;
        ReportSelection2G: Record "Report Selection";
        C_INC033: Label 'Parts Purch. Receipt';
        CopyLoopNoG: Integer;
        PrintDangerousG: Boolean;
        OrderNoG: Code[20];
        C_INC_DuplicateText: Label 'D U P L I C A T E';
        C_INC_NoOfCopiesValue: Label 'Please enter value greater than 0 or equal to 0';
        Field28Lbl: Label 'Receipt No.';
        Field30Lbl: Label 'Receipt Date';
        Field34Lbl: Label 'Page';
        Field22Lbl: Label 'Our Customer No.';
        Field32Lbl: Label 'Purchaser';
        Field24Lbl: Label 'Order No.';
        Field26Lbl: Label 'Order Date';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        Order_No_CaptionLbl: Label 'Order No.';
        CommentCaptionLbl: Label 'Comment';
        DangerousGoodsField21Lbl: Label 'Dangerous Goods';
        DangerousGoodsField22Lbl: Label 'Our Customer No.';
        DangerousGoodsField24Lbl: Label 'Order No.';
        DangerousGoodsField26Lbl: Label 'Order Date';
        DangerousGoodsField28Lbl: Label 'Receipt No.';
        DangerousGoodsField30Lbl: Label 'Receipt Date';
        DangerousGoodsField32Lbl: Label 'Purchaser';
        DangerousGoodsField34Lbl: Label 'Page';
        Qty_Caption_Control1109400067Lbl: Label 'Qty.';
        DescriptionCaption_Control1109400068Lbl: Label 'Description';
        No_Caption_Control1109400069Lbl: Label 'No.';
        Dangerous_Goods_CodeCaptionLbl: Label 'Dangerous Goods Code';
        DescriptionCaption_Control1109400071Lbl: Label 'Description';
        UserSessionG: Codeunit "User Session Unit";
        ReportTitleG: Text[100];
        ShowVING: Boolean;
        RePrintOriginalInvG: Boolean;

    [Scope('Internal')]
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA033336
        EXIT(NOT ShowOutputP);
        // Stop PA033336
    end;

    [Scope('Internal')]
    procedure GetReportSelection()
    var
        RecordRefL: RecordRef;
        ReportIDTextL: Text;
        ReportIDL: Integer;
    begin
        // @ This function sets request page filters from Report Selection setup through User Session Unit.
        // Start PA039225.51457
        ReportSelectionG."Print Sent-From Line" := TRUE;
        ReportSelectionG."Print Address Block" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC033;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionG);
            IF ReportSelectionG."Print Report Title" THEN
                ReportTitleG := ReportSelectionG."Report Title"
            ELSE BEGIN
                ReportSelectionG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;

        PrintSentFromLineG := ReportSelectionG."Print Sent-From Line";
        PrintAddrBlockG := ReportSelectionG."Print Address Block";
        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        // Stop PA039225.51457
    end;
}


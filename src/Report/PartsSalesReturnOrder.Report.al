report 80024 "DPG Parts Sales Return Order" // 5045502 "Parts Sales Return Order"
{
    // // @ Area PartsSales
    // +----------------------------------------------+
    // | Copyright (c) incadea                        |
    // +----------------------------------------------+
    // PA-Number  Date
    // ------------------------------------------------
    // PA033042   04.04.11 PR Added 'VAT Identifier', 'VAT Text' controls in report section.
    //                        Added code to print the VAT Text details in the report footer.
    // PA032441   01.07.11 GC NAV 2009 SP1 W1 General Ledger Integration
    // PA032651   15.07.11 PR 4262653: Added code, text constants and footer for printing the VAT text Legends.
    //                        Moved the VATText, VATTextLine Dataitem position as last footer.
    //                        Increased width of 'VAT Identifier' control and right aligned.
    // PA033011   07.02.12 GC 5983155: VAT legend is not printed correctly
    // PA033067   12.04.12 DR DE Captions implemented
    // PA032651   25.04.12 DR 6012646: DEU and ENU Captions corrected
    // PA033019   29.05.12 DR 7275374: DEU and ENU Captions corrected
    // PA033259   22.08.12 AI Deletion of Start/Stop History in Code, update copyright and Version List
    // PA033259   18.09.12 DR Variable names changed according to incadea styleguide
    // PA033336   17.10.12 SS 8746211 - Modified Report - OnInitReport(), OnOpenForm trigger.
    // PA033336   08.11.12 GC 9200299: RDL Layout Created
    // PA033336   19.11.12 GC 9337117: RDL Layout Modifications
    // PA033259   22.11.12 DR Change the variable names according to incadea styleguide
    // PA033733   10.12.12 DR DE Captions added for version: N.6.1.2
    // PA035597   10.02.14 GC NAV 2013 R2 Technical Upgrade
    // PA035484   02.04.14 GF 20898 Modified code for PrintFooterLineG to get initial value
    //                        from report selection setup.
    // PA036549   15.01.15 GJ 32632 Fixed wrong Page Break.
    // PA037341   22.01.15 GD Merge N.6.1.4 to N.7.1.0 of PA035484.20898
    // PA036549   02.02.15 GP 33388 Report Layout Selection for print footer line corrected
    //                        RDLC layout corrections
    // PA038218   18.09.15 IS 44878 "Sales Person" field left indented and size of text box is extended in header.
    // PA039225   15.02.16 KR 51457 New function GetReportSelection added to fetch all parameters from report selection through User session unit.
    // PA039226   02.08.16 JS Merge of PA039225.51457.
    // 
    // DAFCZE     23.08.19 FJC Removed VAT lines from total, Removed payment condition and bank account number. Report rename
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/PartsSalesReturnOrder.rdlc';

    Caption = 'Parts Sales - Return Order';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST("Return Order"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Parts Sales Return Order';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoopNo; Number)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(Field02; CustAddrG[1])
                    {
                    }
                    column(Field14; CompanyAddrG[1])
                    {
                    }
                    column(Field15; CompanyAddrG[2])
                    {
                    }
                    column(Field04; CustAddrG[3])
                    {
                    }
                    column(Field05; CustAddrG[4])
                    {
                    }
                    column(Field16; CompanyAddrG[4])
                    {
                    }
                    column(Field19; CoTelephoneG)
                    {
                    }
                    column(Field06; CustAddrG[5])
                    {
                    }
                    column(Field21; CoFaxG)
                    {
                    }
                    column(Field32; "Sales Header"."No.")
                    {
                    }
                    column(Field17; CompanyAddrG[5])
                    {
                    }
                    column(Field23; CoEmailG)
                    {
                    }
                    column(Field01; CompAddrG)
                    {
                    }
                    column(Field34; FORMAT("Sales Header"."Order Date"))
                    {
                    }
                    column(Field30; CustG."No.")
                    {
                    }
                    column(Field03; CustAddrG[2])
                    {
                    }
                    column(Field20; CoFaxTextG)
                    {
                    }
                    column(Field22; CoEmailTextG)
                    {
                    }
                    column(Field18; CoTelephoneTextG)
                    {
                    }
                    column(Field07; CustAddrG[6])
                    {
                    }
                    column(Field08; CustAddrG[7])
                    {
                    }
                    column(Field09; CustAddrG[8])
                    {
                    }
                    column(Field36; SalesPurchG.Name)
                    {
                    }
                    column(Field13; CopyTextG)
                    {
                    }
                    column(Field11; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(Field10; CollectiveG.TextShowOutput("Sales Header".FIELDCAPTION("VAT Registration No."), "Sales Header"."VAT Registration No." <> ''))
                    {
                    }
                    column(Field24; CollectiveG.TextShowOutput(CompanyInfoG.FIELDCAPTION("VAT Registration No."), PrintAddrBlockG))
                    {
                    }
                    column(Field25; CollectiveG.TextShowOutput(CompanyInfoG."VAT Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(Field26; CollectiveG.TextShowOutput(C_INC033, PrintAddrBlockG))
                    {
                    }
                    column(Field27; CollectiveG.TextShowOutput(CompanyInfoG."Registration No.", PrintAddrBlockG))
                    {
                    }
                    column(Field28; ReportTitleG)
                    {
                        Description = 'PA033052,PA039225.51457';
                    }
                    column(Field12; OrderCustAddrLineG)
                    {
                    }
                    column(FooterField02; BankTextG)
                    {
                    }
                    column(FooterField03; RDLHideOutput(PrintFooterLineG))
                    {
                    }
                    column(Field37; Field37Lbl)
                    {
                    }
                    column(Field29; Field29Lbl)
                    {
                    }
                    column(Field35; Field35Lbl)
                    {
                    }
                    column(Field31; Field31Lbl)
                    {
                    }
                    column(Field33; Field33Lbl)
                    {
                    }
                    column(FooterField01; FooterField01Lbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Header Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Return Order"), "Header/Footer" = CONST(Header));
                        column(Header_Text_Text; Text)
                        {
                        }
                        column(HideHeaderTextBody1; RDLHideOutputAsInteger(1))
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
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST("Return Order"));
                        column(DiscTextG; DiscTextG)
                        {
                        }
                        column(HideSalesLineHeader1; RDLHideOutputAsInteger(2))
                        {
                        }
                        column(Amount____Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line_Description; Description)
                        {
                        }
                        column(HideSalesLineBody3; RDLHideOutput((Type = "Sales Line".Type::Header) OR ((Type = "Sales Line".Type::"Begin-Total") AND (PrintSubtotalsG))))
                        {
                        }
                        column(Sales_Line_Description_Control62; Description)
                        {
                        }
                        column(Sales_Line_Subtotal; Subtotal)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineBody4; RDLHideOutput((Type = Type::"End-Total") AND (PrintSubtotalsG)))
                        {
                        }
                        column(Sales_Line_Description_Control64; Description)
                        {
                        }
                        column(HideSalesLineBody5; RDLHideOutput(Type = 0))
                        {
                        }
                        column(Sales_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Line_Discount___; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control70; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__VAT_Identifier_; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HideSalesLineBody6; RDLHideOutput(Type = Type::"Account (G/L)"))
                        {
                        }
                        column(Sales_Line__No__; "No.")
                        {
                        }
                        column(Sales_Line_Description_Control73; Description)
                        {
                        }
                        column(Sales_Line_Quantity_Control74; Quantity)
                        {
                        }
                        column(Sales_Line__Unit_of_Measure__Control75; "Unit of Measure")
                        {
                        }
                        column(Sales_Line__Unit_Price__Control84; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Line_Discount____Control85; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Amount____Inv__Discount_Amount__Control86; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NoPropertyG; NoPropertyG)
                        {
                        }
                        column(Sales_Line__VAT_Identifier__Control1109400012; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HideSalesLineBody7; RDLHideOutput((Type = Type::Item) OR (Type = Type::Resource)))
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control1109400000; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__Line_Discount____Control1109400001; "Line Discount %")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(Sales_Line__Unit_of_Measure__Control1109400002; "Unit of Measure")
                        {
                        }
                        column(Sales_Line__Unit_Price__Control1109400003; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line_Description_Control1109400004; Description)
                        {
                        }
                        column(Sales_Line_Quantity_Control1109400005; Quantity)
                        {
                        }
                        column(Sales_Line__No___Control1109400006; "No.")
                        {
                        }
                        column(Sales_Line__VAT_Identifier__Control1109400013; "VAT Identifier")
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(HideSalesLineBody8; RDLHideOutput((Type = Type::"Charge (Item)")))
                        {
                        }
                        column(Sales_Line__Description_2_; "Description 2")
                        {
                        }
                        column(HideSalesLineBody9; RDLHideOutput(((Type = Type::Item) OR (Type = Type::Resource) OR (Type = Type::" ") OR (Type = Type::"Account (G/L)")) AND ("Description 2" <> '')))
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125; Amount + "Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumItemG; SumItemG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumOtherG; SumOtherG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvDiscountAmountTotalG; -InvDiscAmountTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideSalesLineFooter12; RDLHideOutput(InvDiscAmountTotalG <> 0))
                        {
                        }
                        column(ShowCurrencyG; ShowCurrencyG)
                        {
                        }
                        column(AmountTotalG; AmountTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATTotalG___AmountTotalG___ExchPartsTaxAmountTotalG; AmountIncludingVATTotalG - AmountTotalG - ExchPartsTaxAmountTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPctG; VATPctG)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(VATBaseAmountTotalG; VATBaseAmountTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC017; C_INC017)
                        {
                        }
                        column(HideSalesLineFooter13; RDLHideOutput(VATAmountLineG.COUNT <= 1))
                        {
                        }
                        column(ExchPartsTaxAmountTotalG; ExchPartsTaxAmountTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPctG; ExchTaxPctG)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(ExchPartsTaxBaseTotalG; ExchPartsTaxBaseTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016; C_INC016)
                        {
                        }
                        column(HideSalesLineFooter14; RDLHideOutput((VATAmountLineG.COUNT <= 1) AND (ExchPartsTaxAmountTotalG <> 0)))
                        {
                        }
                        column(TotalInclVATTextG; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
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
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(VAT_IdentifierCaption; VAT_IdentifierCaptionLbl)
                        {
                            Description = 'PA033042,PA032651';
                        }
                        column(Amount____Inv__Discount_Amount_Caption; Amount____Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(Amount____Inv__Discount_Amount__Control125Caption; Amount____Inv__Discount_Amount__Control125CaptionLbl)
                        {
                        }
                        column(SumItemGCaption; SumItemGCaptionLbl)
                        {
                        }
                        column(SumOtherGCaption; SumOtherGCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountTotalGCaption; InvDiscountAmountTotalGCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(VAT_ofCaption; VAT_ofCaptionLbl)
                        {
                        }
                        column(Exch__Tax_fromCaption; Exch__Tax_fromCaptionLbl)
                        {
                        }
                        column(Sales_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            TotalsLineL: Record "Sales Line";
                        begin
                            VATAmountLineG.INIT;
                            // Start PA033011.5983155
                            VATAmountLineG."VAT Identifier" := FORMAT("VAT %");
                            VATAmountLineG."Sales Amount" := Amount;
                            // Stop PA033011.5983155
                            VATAmountLineG."VAT %" := "VAT %";
                            IF "VAT %" <> 0 THEN
                                VATPctG := "VAT %";
                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."VAT Base" := "VAT Base Amount";
                            // Start PA032441
                            // Stop PA032441
                            IF "Exch. Parts VAT %" <> 0 THEN
                                ExchTaxPctG := "Exch. Parts VAT %";
                            // Start PA032441
                            // Stop PA032441
                            VATAmountLineG."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLineG.InsertLine;

                            NoPropertyG := '';
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Exch. Parts Tax" THEN
                                NoPropertyG := C_INC016;

                            IF Type = Type::Item THEN
                                SumItemG := SumItemG + Amount + "Inv. Discount Amount"
                            ELSE
                                SumOtherG := SumOtherG + Amount + "Inv. Discount Amount";

                            IF ConsolidateNegativePosG THEN BEGIN
                                IF (Type <> Type::" ") AND ((Amount <> 0) OR ("Amount Including VAT" <> 0)) THEN BEGIN
                                    TotalsLineL.RESET;
                                    TotalsLineL.SETCURRENTKEY("Document Type", "Document No.", Type, "No.", Description);
                                    TotalsLineL.SETRANGE("Document Type", "Document Type");
                                    TotalsLineL.SETRANGE("Document No.", "Document No.");
                                    TotalsLineL.SETRANGE(Type, Type);
                                    TotalsLineL.SETRANGE("No.", "No.");
                                    TotalsLineL.SETRANGE(Description, Description);
                                    TotalsLineL.SETRANGE("Unit Price", "Unit Price");
                                    TotalsLineL.CALCSUMS(Amount, "Amount Including VAT");
                                    IF (TotalsLineL.Amount = 0) AND (TotalsLineL."Amount Including VAT" = 0) THEN
                                        CurrReport.SKIP;
                                END;
                            END;

                            // Start PA033042
                            IF ("VAT Identifier" <> '') AND (Quantity <> 0) THEN
                                IF NOT VATIdentifierTempG.GET("Sales Line"."VAT Identifier") THEN BEGIN
                                    VATIdentifierTempG.INIT();
                                    VATIdentifierTempG.Code := "Sales Line"."VAT Identifier";
                                    VATIdentifierTempG.INSERT;
                                END;
                            // Stop PA033042
                            // Start PA033336.9200299
                            IF ("Line Discount Amount" < 0) OR ((PrintWithoutDiscG) AND (Quantity <> 0)) THEN BEGIN
                                "Unit Price" := (Amount + "Inv. Discount Amount") / Quantity;
                                "Line Discount %" := 0;
                            END;
                            InvDiscAmountTotalG += "Inv. Discount Amount";
                            AmountTotalG += Amount;
                            VATBaseAmountTotalG += "VAT Base Amount";
                            AmountIncludingVATTotalG += "Amount Including VAT";
                            ExchPartsTaxAmountTotalG += "Exch. Parts Tax Amount";
                            ExchPartsTaxBaseTotalG += "Exch. Parts Tax Base";
                            // Stop PA033336.9200299
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLineG.DELETEALL;

                            CurrReport.CREATETOTALS("Line Discount Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Exch. Parts Tax Amount",
                              "Exch. Parts Tax Base", "VAT Base Amount");

                            VATPctG := 0;
                            ExchTaxPctG := 0;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ShowCurrencyG_Control37; ShowCurrencyG)
                        {
                        }
                        column(AmountTotalG_Control38; AmountTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Base_; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount_; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT___; VATAmountLineG."VAT %")
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(VATAmountLineG__VAT_Base__Control106; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount__Control107; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(HideVATCounterBody3; RDLHideOutputAsInteger(3))
                        {
                        }
                        column(VATAmountLineG__VAT_Base__Control110; VATAmountLineG."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineG__VAT_Amount__Control111; VATAmountLineG."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ExchTaxPctG_Control94; ExchTaxPctG)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(ExchPartsTaxAmountTotalG_Control97; ExchPartsTaxAmountTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_INC016_Control55; C_INC016)
                        {
                        }
                        column(HideVATCounterFooter5; RDLHideOutput((ExchPartsTaxAmountTotalG <> 0)))
                        {
                        }
                        column(TotalInclVATTextG_Control44; TotalInclVATTextG)
                        {
                        }
                        column(AmountIncludingVATTotalG_Control46; AmountIncludingVATTotalG)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalCaption_Control99; TotalCaption_Control99Lbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(VAT_ofCaption_Control104; VAT_ofCaption_Control104Lbl)
                        {
                        }
                        column(ContinuedCaption_Control109; ContinuedCaption_Control109Lbl)
                        {
                        }
                        column(Exch__Tax_fromCaption_Control113; Exch__Tax_fromCaption_Control113Lbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLineG.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLineG.COUNT <= 1 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLineG.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLineG."VAT Base", VATAmountLineG."VAT Amount");
                        end;
                    }
                    dataitem("Footer Text"; "Sales Document Text")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Header/Footer", "Line No.") WHERE("Document Type" = CONST("Return Order"), "Header/Footer" = CONST(Footer));
                        column(Footer_Text_Text; Text)
                        {
                        }
                        column(HideFooterTextBody1; RDLHideOutputAsInteger(4))
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
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PaymentTermsG_Description; PaymentTermsG.Description)
                        {
                        }
                        column(HideTotalBody1; RDLHideOutputAsInteger(5))
                        {
                        }
                        column(PaymentTermsG_DescriptionCaption; PaymentTermsG_DescriptionCaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddrG THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(VATText; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATTextNumber; VATText.Number)
                        {
                        }
                        dataitem(VATTextLine; "VAT Text Line")
                        {
                            DataItemTableView = SORTING("VAT Identifier Code", "Language Code", "Line No.");
                            column(VATTextLine_Text; Text)
                            {
                                Description = 'PA033042,PA032651';
                            }
                            column(VATLegendsG; VATLegendsG)
                            {
                                Description = 'PA032651';
                            }
                            column(HideVATTextLineBody1; RDLHideOutputAsInteger(6))
                            {
                            }
                            column(VATTextLine_VAT_Identifier_Code; "VAT Identifier Code")
                            {
                            }
                            column(VATTextLine_Language_Code; "Language Code")
                            {
                            }
                            column(VATTextLine_Line_No_; "Line No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // Start PA033336.9200299
                                VATLegendsG := '';
                                IF IncrG = 1 THEN
                                    VATLegendsG := VATIdentifierTempG.Code + C_INC034;
                                IncrG := IncrG + 1;
                                // Stop PA033336.9200299
                            end;

                            trigger OnPreDataItem()
                            begin
                                // Start PA033042
                                SETRANGE("VAT Identifier Code", VATIdentifierTempG.Code);
                                SETRANGE("Language Code", VATTextHdrG.GetLanguageCode(VATIdentifierTempG.Code, "Sales Header"."Language Code"));
                                // Stop PA033042
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // Start PA033042
                            IF Number = 1 THEN
                                VATIdentifierTempG.FINDFIRST
                            ELSE
                                VATIdentifierTempG.NEXT;
                            // Stop PA033042

                            // Start PA032651
                            IncrG := 1;
                            // Stop PA032651
                        end;

                        trigger OnPreDataItem()
                        begin
                            // Start PA033042
                            SETRANGE(Number, 1, VATIdentifierTempG.COUNT);
                            // Stop PA033042
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    // Start PA035597
                    // Stop PA035597
                    IF Number > 1 THEN BEGIN
                        CopyTextG := C_INC029;
                    END;
                    // Start PA035597
                    // Stop PA035597

                    SumItemG := 0;
                    SumOtherG := 0;
                    // Start PA033336.9200299
                    InvDiscAmountTotalG := 0;
                    AmountTotalG := 0;
                    VATBaseAmountTotalG := 0;
                    AmountIncludingVATTotalG := 0;
                    ExchPartsTaxAmountTotalG := 0;
                    ExchPartsTaxBaseTotalG := 0;
                    // Stop PA033336.9200299
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrintedG.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoopsG := ABS(NoOfCopiesG) + 1;
                    CopyTextG := '';
                    SETRANGE(Number, 1, NoOfLoopsG);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Start PA033042
                VATIdentifierTempG.DELETEALL;
                // Stop PA033042

                IF "Sell-to Customer No." <> '' THEN
                    CustG.GET("Sell-to Customer No.")
                ELSE
                    CLEAR(CustG);
                CurrReport.LANGUAGE := CustG.PrintDocInCustLanguage();
                PrintWithoutDiscG := NOT "Show Discount";

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

                IF LocationG.GET("Location Code") AND (LocationG."Bank Code" <> '') AND
                   OwnBanksG.GET(IntCustG, LocationG."Bank Code")
                THEN
                    BankTextG := OwnBanksG.Name + C_INC006 + OwnBanksG."Bank Branch No." + C_INC007 + OwnBanksG."Bank Account No."
                ELSE
                    BankTextG := CompanyInfoG."Bank Name" + C_INC006 + CompanyInfoG."Bank Branch No." + C_INC007 + CompanyInfoG."Bank Account No.";

                IF "Currency Code" = '' THEN BEGIN
                    GLSetupG.TESTFIELD("LCY Code");
                    ShowCurrencyG := GLSetupG."LCY Code";
                END ELSE BEGIN
                    ShowCurrencyG := "Currency Code";
                END;
                TotalInclVATTextG := STRSUBSTNO(C_INC031, ShowCurrencyG);

                FormatAddrG.SalesHeaderBillTo(CustAddrG, "Sales Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTermsG.INIT
                ELSE
                    PaymentTermsG.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipMethodG.INIT
                ELSE
                    ShipMethodG.GET("Shipment Method Code");

                FormatAddrG.SalesHeaderShipTo(ShipToAddrG, "Sales Header");
                ShowShippingAddrG := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR IG := 1 TO ARRAYLEN(ShipToAddrG) DO
                    IF ShipToAddrG[IG] <> CustAddrG[IG] THEN
                        ShowShippingAddrG := TRUE;

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                IF "Sales Header"."Sell-to Customer No." <> "Sales Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddrG.SalesHeaderCust(OrderCustAddrG, "Sales Header");
                    OrderCustAddrLineG := C_INC008 + FormatAddrG.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';

                IF NOT PrintWithoutDiscG THEN BEGIN
                    DiscCheckSalLineG.SETRANGE("Document Type", "Document Type");
                    DiscCheckSalLineG.SETRANGE("Document No.", "No.");
                    DiscCheckSalLineG.SETFILTER("Line Discount Amount", '>%1', 0);
                    IF DiscCheckSalLineG.FIND('-') THEN
                        DiscTextG := C_INC009
                    ELSE
                        DiscTextG := ''
                END ELSE
                    DiscTextG := '';
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    LogInteractionG := SegMgntG.FindInteractTmplCode(18) <> '';
                    IF LogInteractionG THEN
                        SegMgntG.LogDocument(
                          18, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.",
                          "Salesperson Code", '', "Posting Description");
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfoG.GET;
            end;
        }
    }

    requestpage
    {
        Caption = 'Parts Sales - Order';
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
                    }
                    field(PrintSubtotalsG; PrintSubtotalsG)
                    {
                        Caption = 'Print Subtotals';
                    }
                    field(ConsolidateNegativePosG; ConsolidateNegativePosG)
                    {
                        Caption = 'Blind out Zero Positions';
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
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Start PA035484.20898
            // Start PA039225.51457
            // Stop PA035484.20898
            // Start PA036549.33388
            // Stop PA036549.33388
            // Start PA035484.20898
            // Stop PA035484.20898
            // Start PA036549.33388
            // Stop PA036549.33388
            // Start PA033336
            // Stop PA033336
            // Start PA033336
            // Stop PA033336
            GetReportSelection();
            // Stop PA039225.51457

            ConsolidateNegativePosG := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        // Start PA035484.20898
        // Start PA039225.51457
        // Stop PA035484.20898
        // Start PA035597
        // Stop PA035597
        GLSetupG.GET;
        // Start PA035484.20898
        // Stop PA035484.20898
        // Start PA035484.20898
        // Stop PA035484.20898
        // Start PA035484.20898
        // Stop PA035484.20898
        // Start PA033336
        // Stop PA033336
        // Start PA033336
        // Stop PA033336
        GetReportSelection();
        // Stop PA039225.51457

        ConsolidateNegativePosG := TRUE;
    end;

    var
        ReportSelectionsG: Record "Report Selection";
        CustG: Record Customer;
        PrinterSelectionG: Record "Printer Selection";
        OwnDelivAddressG: Record "Ship-to Address";
        OwnBanksG: Record "Customer Bank Account";
        GLSetupG: Record "General Ledger Setup";
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        ShipMethodG: Record "Shipment Method";
        VATAmountLineG: Record "VAT Amount Line" temporary;
        DiscCheckSalLineG: Record "Sales Line";
        SalesPurchG: Record "Salesperson/Purchaser";
        PaymentTermsG: Record "Payment Terms";
        SalesCountPrintedG: Codeunit "Sales-Printed";
        FormatAddrG: Codeunit "Format Address";
        CollectiveG: Codeunit "Collection Unit";
        IntCustG: Code[20];
        ShowCurrencyG: Text[30];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        BankTextG: Text[250];
        CustAddrG: array[8] of Text[50];
        ShipToAddrG: array[8] of Text[50];
        CompanyAddrG: array[8] of Text[50];
        CoAddrSenderLineG: array[8] of Text[50];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        CopyTextG: Text[30];
        CompAddrG: Text[250];
        NoPropertyG: Text[30];
        DiscTextG: Text[30];
        TotalInclVATTextG: Text[50];
        SumItemG: Decimal;
        SumOtherG: Decimal;
        VATPctG: Decimal;
        ExchTaxPctG: Decimal;
        NoOfCopiesG: Integer;
        NoOfLoopsG: Integer;
        IG: Integer;
        PrintSubtotalsG: Boolean;
        ShowShippingAddrG: Boolean;
        PrintSentFromLineG: Boolean;
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        C_INC002: Label 'Phone No.';
        C_INC003: Label 'Fax No.';
        C_INC004: Label 'E-Mail';
        C_INC005: Label ', ';
        C_INC006: Label ' - BBN:';
        C_INC007: Label ' - Acc.-No..:';
        PrintWithoutDiscG: Boolean;
        C_INC008: Label 'Order Customer:';
        C_INC009: Label 'Disc. %';
        C_INC016: Label '*';
        C_INC017: Label '* = Exchange part';
        C_INC029: Label 'Copy';
        C_INC031: Label 'Total %1 Incl. VAT';
        ConsolidateNegativePosG: Boolean;
        SegMgntG: Codeunit SegManagement;
        LogInteractionG: Boolean;
        VATTextHdrG: Record "VAT Text Header";
        VATIdentifierTempG: Record "VAT Identifier" temporary;
        VATLegendsG: Text[15];
        IncrG: Integer;
        C_INC032: Label 'Parts Sales - Return Order';
        ReportSelection2G: Record "Report Selection";
        C_INC033: Label 'Tax No.';
        C_INC034: Label ' =';
        InvDiscAmountTotalG: Decimal;
        VATBaseAmountTotalG: Decimal;
        AmountIncludingVATTotalG: Decimal;
        ExchPartsTaxAmountTotalG: Decimal;
        ExchPartsTaxBaseTotalG: Decimal;
        AmountTotalG: Decimal;
        Field37Lbl: Label 'Page';
        Field29Lbl: Label 'Customer No.';
        Field35Lbl: Label 'Salesperson';
        Field31Lbl: Label 'Order No.';
        Field33Lbl: Label 'Order Date';
        FooterField01Lbl: Label 'Payments to:';
        No_CaptionLbl: Label 'No.';
        DescriptionCaptionLbl: Label 'Description';
        Qty_CaptionLbl: Label 'Qty.';
        UoMCaptionLbl: Label 'UoM';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        VAT_IdentifierCaptionLbl: Label 'VAT Identifier';
        Amount____Inv__Discount_Amount_CaptionLbl: Label 'Continued';
        Amount____Inv__Discount_Amount__Control125CaptionLbl: Label 'Sum carried forward';
        SumItemGCaptionLbl: Label 'Sum Item';
        SumOtherGCaptionLbl: Label 'Sum Other';
        InvDiscountAmountTotalGCaptionLbl: Label 'Invoice Discount';
        TotalCaptionLbl: Label 'Total';
        VAT_ofCaptionLbl: Label '% VAT of';
        Exch__Tax_fromCaptionLbl: Label '% Exch. Tax from';
        TotalCaption_Control99Lbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        VAT_ofCaption_Control104Lbl: Label '% VAT of';
        ContinuedCaption_Control109Lbl: Label 'Continued';
        Exch__Tax_fromCaption_Control113Lbl: Label '% Exch. Tax from';
        PaymentTermsG_DescriptionCaptionLbl: Label 'Payment Terms';
        UserSessionG: Codeunit "User Session Unit";
        ReportTitleG: Text[100];

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
    procedure RDLHideOutputAsInteger(DummyIntegerP: Integer): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility with a dummy integer
        // @ Send different numbers to create new dataset fields
        // @ param DummyIntegerP - Integer
        // @ retval - Boolean
        // Start PA033336
        EXIT(FALSE);
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
        ReportSelectionsG."Print Sent-From Line" := TRUE;
        ReportSelectionsG."Print Address Block" := TRUE;
        ReportSelectionsG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := C_INC032;
        IF RecordRefL.NUMBER > 0 THEN BEGIN
            RecordRefL.SETTABLE(ReportSelectionsG);
            IF ReportSelectionsG."Print Report Title" THEN
                ReportTitleG := ReportSelectionsG."Report Title"
            ELSE BEGIN
                ReportSelectionsG.CALCFIELDS("Report Caption");
                ReportTitleG := COPYSTR(ReportSelectionsG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
            END;
        END;

        PrintSentFromLineG := ReportSelectionsG."Print Sent-From Line";
        PrintAddrBlockG := ReportSelectionsG."Print Address Block";
        PrintFooterLineG := ReportSelectionsG."Print Footer Line";

        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopiesG := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        // Stop PA039225.51457
    end;
}


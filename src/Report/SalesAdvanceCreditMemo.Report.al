report 80026 "DPG Sales-Advance Credit Memo" // 31002 "Sales - Advance Credit Memo CZ"
{
    // --- IncadeaCZ ---
    // API.1.0.1  02.05.18 PV New object created as a copy of Report 5028805 Parts Sales Invoice
    //                        NAVCZ fields and features added
    //                        RDLC Layout changed
    //                        ReportLayoutSetup Translation added
    // API.1.0.2  07.06.18 PV RDLC Layout changed, bank source, SK legislation, Payed amount,...
    // API.1.0.2  30.08.18 SD Function GetReportSelection() extended to support "Vehicle Sales Rep. Selection" & "Service Manag. Rep. Selection"
    // API.1.0.3  07.08.18 PV RDLC Layout changed - VAT recap. table column size
    // API.1.0.4  23.11.18 RS CZ.P0096 - New function IsReportInPreviewMode
    // 
    // --- DAF ---
    // FJC       29.5.2020 FJC VAT date added
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/SalesAdvanceCreditMemo.rdlc';

    Caption = 'Sales - Advance Credit Memo CZ';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Credit Memo Header"; "Sales Credit Memo Header")
        {
            DataItemTableView = SORTING("Letter No.") WHERE("Letter No." = FILTER(<> ''));
            column(LCYCode_GeneralLedgerSetup; GeneralLedgerSetup."LCY Code")
            {
            }
            column(DocumentLbl; DocumentLbl)
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(CopyLbl; CopyLbl)
            {
            }
            column(VendorLbl; VendLbl)
            {
            }
            column(CustomerLbl; CustLbl)
            {
            }
            column(SalespersonLbl; SalespersonLbl)
            {
            }
            column(CreatorLbl; CreatorLbl)
            {
            }
            column(VATIdentLbl; VATIdentLbl)
            {
            }
            column(VATPercentLbl; VATPercentLbl)
            {
            }
            column(VATBaseLbl; VATBaseLbl)
            {
            }
            column(VATAmtLbl; VATAmtLbl)
            {
            }
            column(TotalLbl; TotalLbl)
            {
            }
            column(VATLbl; VATLbl)
            {
            }
            column(AdvanceLetterLbl; AdvanceLetterLbl)
            {
            }
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(VATRegistrationNo_SalesCrMemoHeaderCaption; FIELDCAPTION("VAT Registration No."))
            {
            }
            column(VATRegistrationNo_SalesCrMemoHeader; "VAT Registration No.")
            {
            }
            column(RegistrationNo_SalesCrMemoHeaderCaption; FIELDCAPTION("Registration No."))
            {
            }
            column(RegistrationNo_SalesCrMemoHeader; "Registration No.")
            {
            }
            column(BankAccountNo_SalesCrMemoHeaderCaption; FIELDCAPTION("Bank Account No."))
            {
            }
            column(BankAccountNo_SalesCrMemoHeader; "Bank Account No.")
            {
            }
            column(IBAN_SalesCrMemoHeaderCaption; FIELDCAPTION(IBAN))
            {
            }
            column(IBAN_SalesCrMemoHeader; IBAN)
            {
            }
            column(BIC_SalesCrMemoHeaderCaption; FIELDCAPTION("SWIFT Code"))
            {
            }
            column(BIC_SalesCrMemoHeader; "SWIFT Code")
            {
            }
            column(DocumentDate_SalesCrMemoHeaderCaption; FIELDCAPTION("Document Date"))
            {
            }
            column(DocumentDate_SalesCrMemoHeader; "Document Date")
            {
            }
            column(VATDate_SalesCrMemoHeaderCaption; FIELDCAPTION("VAT Date"))
            {
            }
            column(VATDate_SalesCrMemoHeader; "VAT Date")
            {
            }
            column(PaymentTerms; PaymentTerms.Description)
            {
            }
            column(PaymentMethod; PaymentMethod.Description)
            {
            }
            column(CurrencyCode_SalesCrMemoHeader; "Currency Code")
            {
            }
            column(CalculatedExchRate; CalculatedExchRate)
            {
            }
            column(ExchRateText; ExchRateText)
            {
            }
            column(DocFooterText; DocFooterText)
            {
            }
            column(LetterNo_SalesCrMemoHeader; "Letter No.")
            {
            }
            column(CustAddr1; CustAddr[1])
            {
            }
            column(CustAddr2; CustAddr[2])
            {
            }
            column(CustAddr3; CustAddr[3])
            {
            }
            column(CustAddr4; CustAddr[4])
            {
            }
            column(CustAddr5; CustAddr[5])
            {
            }
            column(CustAddr6; CustAddr[6])
            {
            }
            column(CustAddr7; CustAddr[7])
            {
            }
            column(CompanyAddr_1_; CompanyAddr[1])
            {
            }
            column(CompanyAddr_2_; CompanyAddr[2])
            {
            }
            column(CompanyAddr_3_; CompanyAddr[3])
            {
            }
            column(CompanyAddr_4_; CompanyAddr[4])
            {
            }
            column(CompanyAddr_5_; CompanyAddr[5])
            {
            }
            column(CompanyAddr_6_; CompanyAddr[6])
            {
                Description = 'PA040669.61957';
            }
            column(IsRepSelectionSetupAvailableG; RDLHideOutput(IsRepSelectionSetupAvailableG))
            {
                Description = 'PA035395.18593';
            }
            column(ReportLayoutSetupG__Swap_Sections_6_7_; ReportLayoutSetupG."Swap Sections 6/7")
            {
                Description = 'PA040669.61957';
            }
            column(DuplicateTextG; DuplicateTextG)
            {
                Description = 'PA031550';
            }
            column(ReportLayoutSetupG__Duplicate_Graphic_; ReportLayoutSetupG."Duplicate Graphic")
            {
                Description = 'PA033336';
            }
            column(ReportLayoutSetupG__Header_Graphic_Center_; ReportLayoutSetupG."Header Graphic Center")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Header_Graphic_Right_; ReportLayoutSetupG."Header Graphic Right")
            {
                Description = 'PA033336';
            }
            column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
            {
                Description = 'PA033336';
            }
            column(ReportLayoutSetupG__Auth__Left_Alignment_; ReportLayoutSetupG."Auth. Left Alignment")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Center_Alignment_; ReportLayoutSetupG."Auth. Center Alignment")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Right_Alignment_; ReportLayoutSetupG."Auth. Right Alignment")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Left_Line_1_; ReportLayoutSetupG."Auth. Left Line 1")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Left_Line_2_; ReportLayoutSetupG."Auth. Left Line 2")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Left_Line_3_; ReportLayoutSetupG."Auth. Left Line 3")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Left_Line_4_; ReportLayoutSetupG."Auth. Left Line 4")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Left_Line_5_; ReportLayoutSetupG."Auth. Left Line 5")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Center_Line_1_; ReportLayoutSetupG."Auth. Center Line 1")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Center_Line_2_; ReportLayoutSetupG."Auth. Center Line 2")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Center_Line_3_; ReportLayoutSetupG."Auth. Center Line 3")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Center_Line_4_; ReportLayoutSetupG."Auth. Center Line 4")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Center_Line_5_; ReportLayoutSetupG."Auth. Center Line 5")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Right_Line_1_; ReportLayoutSetupG."Auth. Right Line 1")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Right_Line_2_; ReportLayoutSetupG."Auth. Right Line 2")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Right_Line_3_; ReportLayoutSetupG."Auth. Right Line 3")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Right_Line_4_; ReportLayoutSetupG."Auth. Right Line 4")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Auth__Right_Line_5_; ReportLayoutSetupG."Auth. Right Line 5")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Footer_Graphic_Left_; ReportLayoutSetupG."Footer Graphic Left")
            {
                Description = 'PA033336';
            }
            column(ReportLayoutSetupG__Footer_Graphic_Right_; ReportLayoutSetupG."Footer Graphic Right")
            {
                Description = 'PA033336';
            }
            column(ReportLayoutSetupG__One_Column_Footer_; ReportLayoutSetupG."One Column Footer")
            {
                Description = 'PA040669.61957';
            }
            column(ReportLayoutSetupG__Footer_6_6_; ReportLayoutSetupG."Footer 6-6")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_5_4_; ReportLayoutSetupG."Footer 5-4")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_6_4_; ReportLayoutSetupG."Footer 6-4")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_5_5_; ReportLayoutSetupG."Footer 5-5")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_6_5_; ReportLayoutSetupG."Footer 6-5")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_5_6_; ReportLayoutSetupG."Footer 5-6")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_2_3_; ReportLayoutSetupG."Footer 2-3")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_3_3_; ReportLayoutSetupG."Footer 3-3")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_4_3_; ReportLayoutSetupG."Footer 4-3")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_5_3_; ReportLayoutSetupG."Footer 5-3")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_6_3_; ReportLayoutSetupG."Footer 6-3")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_2_4_; ReportLayoutSetupG."Footer 2-4")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_3_4_; ReportLayoutSetupG."Footer 3-4")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_4_4_; ReportLayoutSetupG."Footer 4-4")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_2_5_; ReportLayoutSetupG."Footer 2-5")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_3_5_; ReportLayoutSetupG."Footer 3-5")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_4_5_; ReportLayoutSetupG."Footer 4-5")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_2_6_; ReportLayoutSetupG."Footer 2-6")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_3_6_; ReportLayoutSetupG."Footer 3-6")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_4_6_; ReportLayoutSetupG."Footer 4-6")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_6_2_; ReportLayoutSetupG."Footer 6-2")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_5_2_; ReportLayoutSetupG."Footer 5-2")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_4_2_; ReportLayoutSetupG."Footer 4-2")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_3_2_; ReportLayoutSetupG."Footer 3-2")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_2_2_; ReportLayoutSetupG."Footer 2-2")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_1_2_; ReportLayoutSetupG."Footer 1-2")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_1_3_; ReportLayoutSetupG."Footer 1-3")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_1_4_; ReportLayoutSetupG."Footer 1-4")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_1_5_; ReportLayoutSetupG."Footer 1-5")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_1_6_; ReportLayoutSetupG."Footer 1-6")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_1_1_; ReportLayoutSetupG."Footer 1-1")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_2_1_; ReportLayoutSetupG."Footer 2-1")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_3_1_; ReportLayoutSetupG."Footer 3-1")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_4_1_; ReportLayoutSetupG."Footer 4-1")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_5_1_; ReportLayoutSetupG."Footer 5-1")
            {
                Description = 'PA033052';
            }
            column(ReportLayoutSetupG__Footer_6_1_; ReportLayoutSetupG."Footer 6-1")
            {
                Description = 'PA033052';
            }
            column(OrderCustAddrLine; OrderCustAddrLineG)
            {
            }
            column(Cust__No__; CustG."No.")
            {
            }
            column(CoTelephone; CoTelephoneG)
            {
            }
            column(CoFax; CoFaxG)
            {
            }
            column(CoEmail; CoEmailG)
            {
            }
            column(CoFaxText; CoFaxTextG)
            {
            }
            column(CoEmailText; CoEmailTextG)
            {
            }
            column(CoTelephoneText; CoTelephoneTextG)
            {
            }
            column(ReportTitleG; ReportTitleG)
            {
            }
            column(BankName; BankNameG)
            {
            }
            column(BankBranchNo; BankBranchNoG)
            {
            }
            column(BankSwift; BankSwiftG)
            {
            }
            column(BankIban; BankIbanG)
            {
            }
            column(BankAccountNo; BankAccountNoG)
            {
            }
            column(PaymentMethodCode_SCH; "Sales Credit Memo Header"."Payment Method Code")
            {
            }
            column(VariableSymbol_SCH; "Sales Credit Memo Header"."Variable Symbol")
            {
            }
            column(VATDate_SCH; "Sales Credit Memo Header"."VAT Date")
            {
            }
            column(RegistrationNo_SCH; "Sales Credit Memo Header"."Registration No.")
            {
            }
            column(VATRegistrationNo_SCH; "Sales Credit Memo Header"."VAT Registration No.")
            {
            }
            column(TaxRegistrationNo_SCH; "Sales Credit Memo Header"."Tax Registration No.")
            {
            }
            column(RegistrationNo_Comp; CompanyInfoG."Registration No.")
            {
            }
            column(VATRegistrationNo_Comp; CompanyInfoG."VAT Registration No.")
            {
            }
            column(TaxRegistrationNo_Comp; CompanyInfoG."Tax Registration No.")
            {
            }
            column(Description_PayMethod; PaymentMethodG.Description)
            {
            }
            column(SellToAddr1; OrderCustAddrG[1])
            {
            }
            column(SellToAddr2; OrderCustAddrG[2])
            {
            }
            column(SellToAddr3; OrderCustAddrG[3])
            {
            }
            column(SellToAddr4; OrderCustAddrG[4])
            {
            }
            column(SellToAddr5; OrderCustAddrG[5])
            {
            }
            column(SellToAddr6; OrderCustAddrG[6])
            {
            }
            column(SellToAddr7; OrderCustAddrG[7])
            {
            }
            column(SellToAddr8; OrderCustAddrG[8])
            {
            }
            column(ColonLbl; ColonLbl)
            {
            }
            column(SlashLbl; SlashLbl)
            {
            }
            column(ReceiverLbl; ReceiverLbl)
            {
            }
            column(IssuedByLbl; IssuedByLbl)
            {
            }
            column(TaxRegNoLbl; TaxRegNoLbl)
            {
            }
            column(VATRegNoLbl; VATRegNoLbl)
            {
            }
            column(RegNoLbl; RegNoLbl)
            {
            }
            column(BankInstitutionLbl; BankInstitutionLbl)
            {
            }
            column(BankAccountNoLbl; BankAccountNoLbl)
            {
            }
            column(IbanSwiftLbl; IbanSwiftLbl)
            {
            }
            column(DocumentDateLbl; DocumentDateLbl)
            {
            }
            column(DueDateCpn_SCH; "Sales Credit Memo Header".FIELDCAPTION("Due Date"))
            {
            }
            column(VATDateCpn_SCH; "Sales Credit Memo Header".FIELDCAPTION("VAT Date"))
            {
            }
            column(VariableSymbolCpn_SCH; "Sales Credit Memo Header".FIELDCAPTION("Variable Symbol"))
            {
            }
            column(EmailCpn_Comp; CompanyInfoG.FIELDCAPTION("E-Mail"))
            {
            }
            column(PhoneLbl; PhoneLbl)
            {
            }
            column(IbanCpn_Comp; CompanyInfoG.FIELDCAPTION(IBAN))
            {
            }
            column(SwiftLbl; SwiftLbl)
            {
            }
            column(PaymentMethodDescLbl; PaymentMethodDescLbl)
            {
            }
            column(PrintDocTitleAndNoUp; PrintDocTitleAndNoUpG)
            {
            }
            column(TitleTextLeft; TitleTextLeftG)
            {
            }
            column(TitleTextCenter; TitleTextCenterG)
            {
            }
            column(TitleTextRight; TitleTextRightG)
            {
            }
            column(ShowDuplicateImage; ShowDuplicateImageG)
            {
            }
            column(EmployeeFullName; EmployeeFullNameG)
            {
            }
            column(DateOfIssueLbl; DateOfIssueLbl)
            {
            }
            column(PostingDate_SCH; "Sales Credit Memo Header"."Posting Date")
            {
            }
            column(ShipToAddrG1; ShipToAddrG[1])
            {
            }
            column(ShipToAddrG2; ShipToAddrG[2])
            {
            }
            column(ShipToAddrG3; ShipToAddrG[3])
            {
            }
            column(ShipToAddrG4; ShipToAddrG[4])
            {
            }
            column(ShipToAddrG5; ShipToAddrG[5])
            {
            }
            column(ShipToAddrG6; ShipToAddrG[6])
            {
            }
            column(ShipToAddrG7; ShipToAddrG[7])
            {
            }
            column(ShipToAddrG8; ShipToAddrG[8])
            {
            }
            column(VATDateLbl; VATDateLbl)
            {
            }
            column(BillToLbl; BillToLbl)
            {
            }
            column(ShipToLbl; ShipToLbl)
            {
            }
            column(SellToLbl; SellToLbl)
            {
            }
            column(ShowTaxNoG; ShowTaxNoG)
            {
            }
            column(ToDateLbl; ToDateLbl)
            {
            }
            column(ReasonCodeLbl; ReasonCodeLbl)
            {
            }
            column(Description_ReasonCode; ReasonCodeG.Description)
            {
            }
            column(OrderNoG; OrderNoG)
            {
            }
            column(OrderNoLbl; OrderNoLbl)
            {
            }
            column(AppliesToDocNo_SCH; "Sales Credit Memo Header"."Applies-to Doc. No.")
            {
            }
            column(AppliesToDocNoLbl; AppliesToDocNoLbl)
            {
            }
            column(SalesPurchNameLbl; SalesPurchNameLbl)
            {
            }
            column(Name_SalPur; SalesPurchG.Name)
            {
            }
            column(PayedAmountLbl; PayedAmountLbl)
            {
            }
            column(Amount_AdvLink; AdvancelinkG.Amount)
            {
            }
            column(AmountLCY_AdvLink; AdvancelinkG."Amount (LCY)")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyNo; CopyNo)
                {
                }
                dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
                {
                    DataItemLink = Code = FIELD("Salesperson Code");
                    DataItemLinkReference = "Sales Credit Memo Header";
                    DataItemTableView = SORTING(Code);
                    column(Name_SalespersonPurchaser; Name)
                    {
                    }
                    column(EMail_SalespersonPurchaser; "E-Mail")
                    {
                    }
                    column(PhoneNo_SalespersonPurchaser; "Phone No.")
                    {
                    }
                }
                dataitem("VAT Entry"; "VAT Entry")
                {
                    DataItemLink = "Document No." = FIELD("No."), "Posting Date" = FIELD("Posting Date");
                    DataItemLinkReference = "Sales Credit Memo Header";
                    DataItemTableView = SORTING("Document No.", "Posting Date");

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group") THEN
                            VATPostingSetup.INIT;

                        TempVATAmountLine.INIT;
                        TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                        TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                        TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                        TempVATAmountLine."VAT %" := VATPostingSetup."VAT %";
                        TempVATAmountLine."VAT Base" := "Advance Base";
                        TempVATAmountLine."Amount Including VAT" := "Advance Base" + Amount;
                        TempVATAmountLine.InsertLine;
                    end;

                    trigger OnPreDataItem()
                    begin
                        TempVATAmountLine.DELETEALL;
                    end;
                }
                dataitem(VATCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                    {
                    }
                    column(VATAmtLineVATPer; TempVATAmountLine."VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                    {
                        AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                    {
                        AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATAmtLineVATBaseLCY; TempVATAmountLine."VAT Base (LCY)")
                    {
                        AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATAmtLineVATAmtLCY; TempVATAmountLine."VAT Amount (LCY)")
                    {
                        AutoFormatExpression = "Sales Credit Memo Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountIncludingVAT_VAL; TempVATAmountLine."Amount Including VAT")
                    {
                    }
                    column(AmountIncludingVATLCY_VAL; TempVATAmountLine."Amount Including VAT (LCY)")
                    {
                    }
                    column(AmountIncludingVATCpn_VAL; TempVATAmountLine.FIELDCAPTION("Amount Including VAT"))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TempVATAmountLine.GetLine(Number);

                        IF CalculatedExchRate <> 1 THEN BEGIN
                            TempVATAmountLine."VAT Base (LCY)" := TempVATAmountLine."VAT Base";
                            TempVATAmountLine."VAT Amount (LCY)" := TempVATAmountLine."VAT Amount";
                            TempVATAmountLine."VAT Base" :=
                              ROUND(TempVATAmountLine."VAT Base (LCY)" / CalculatedExchRate * CurrExchRate."Exchange Rate Amount");
                            TempVATAmountLine."VAT Amount" :=
                              ROUND(TempVATAmountLine."VAT Amount (LCY)" / CalculatedExchRate * CurrExchRate."Exchange Rate Amount");
                            //Start API.1.0.2
                            TempVATAmountLine."Amount Including VAT (LCY)" := TempVATAmountLine."Amount Including VAT";
                            TempVATAmountLine."Amount Including VAT" :=
                              ROUND(TempVATAmountLine."Amount Including VAT (LCY)" / CalculatedExchRate * CurrExchRate."Exchange Rate Amount");
                            //Stop API.1.0.2
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                    end;
                }
                dataitem(VATClauseEntryCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATClauseIdentifier; TempVATAmountLine."VAT Identifier")
                    {
                    }
                    column(VATClauseDescription; VATClause.Description)
                    {
                    }
                    column(VATClauseDescription2; VATClause."Description 2")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TempVATAmountLine.GetLine(Number);
                        IF NOT VATClause.GET(TempVATAmountLine."VAT Clause Code") THEN
                            CurrReport.SKIP;
                        VATClause.TranslateDescription("Sales Credit Memo Header"."Language Code");
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                    end;
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("User ID");
                    DataItemLinkReference = "Sales Credit Memo Header";
                    DataItemTableView = SORTING("User ID");
                    dataitem(Employee; Employee)
                    {
                        DataItemLink = "No." = FIELD("Employee No.");
                        DataItemTableView = SORTING("No.");
                        column(FullName_Employee; Employee.FullName)
                        {
                        }
                        column(PhoneNo_Employee; Employee."Phone No.")
                        {
                        }
                        column(CompanyEMail_Employee; Employee."Company E-Mail")
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        CopyNo := 1
                    ELSE
                        CopyNo += 1;

                    //Start API.1.0.2  ?vapa Add RePrintOriginalInvG into Req.page?
                    // ShowDuplicateImageG := FALSE; //  API.1      01.03.18 PV
                    // IF ("Sales Invoice Header"."No. Printed" > 0) AND NOT RePrintOriginalInvG THEN BEGIN
                    //  IF NOT (ReportLayoutSetupG."Duplicate Graphic".HASVALUE) THEN
                    //    DuplicateTextG := C_INC001
                    //  ELSE
                    //    ShowDuplicateImageG := TRUE;
                    // END;
                    //Stop API.1.0.2
                end;

                trigger OnPostDataItem()
                begin
                    //Start API.1.0.4 - CZ.P0096
                    //IF NOT CurrReport.PREVIEW THEN
                    IF NOT IsReportInPreviewMode THEN
                        //Stop API.1.0.4 - CZ.P0096
                        CODEUNIT.RUN(CODEUNIT::"Sales Cr. Memo-Printed", "Sales Credit Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;

                    SETRANGE(Number, 1, NoOfLoops);

                    DuplicateTextG := ''; //API.1.0.2
                end;
            }

            trigger OnAfterGetRecord()
            var
                bankAccount: Record "Bank Account";
                salesInvoiceHeaderL: Record "Sales Invoice Header";
            begin
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");

                //Start API.1.0.1  02.05.18 PV
                IsRepSelectionSetupAvailableG := ReportSelectionG.GetFooterDetails(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code",
                  REPORT::"DPG Sales-Advance Credit Memo");
                CLEAR(ReportLayoutSetupG);
                IF IsRepSelectionSetupAvailableG THEN
                    ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, "Shortcut Dimension 2 Code", "Location Code");

                ReportLayoutSetupG.TranslateTexts(ReportLayoutSetupG, "Sales Credit Memo Header"."Language Code");
                SetTitles;
                EmployeeFullNameG := GetUserIDFullName(USERID);
                IF GLSetupG.Legislation = GLSetupG.Legislation::SK THEN
                    ShowTaxNoG := TRUE
                ELSE
                    ShowTaxNoG := FALSE;

                IF ReasonCodeG.GET("Sales Credit Memo Header"."Reason Code") THEN;

                IF salesInvoiceHeaderL.GET("Sales Credit Memo Header"."Applies-to Doc. No.") THEN
                    //OrderNoG := salesInvoiceHeaderL."Applies-to Doc. No."
                    OrderNoG := salesInvoiceHeaderL."Order No."
                ELSE
                    OrderNoG := '';

                //incadea
                IF NOT LocationG.GET("Location Code") THEN
                    CLEAR(LocationG);
                IntCustG := CompanyInfoG."Internal Customer";
                IF LocationG."Internal Customer" <> '' THEN
                    IntCustG := LocationG."Internal Customer";
                IF (LocationG."Ship-to Address Code" <> '') AND
                   (OwnDelivAddressG.GET(IntCustG, LocationG."Ship-to Address Code"))
                THEN BEGIN
                    FormatAddr.OwnCustomerAddress(CompanyAddr, OwnDelivAddressG);
                    CoTelephoneG := OwnDelivAddressG."Phone No.";
                    CoFaxG := OwnDelivAddressG."Fax No.";
                    CoEmailG := OwnDelivAddressG."E-Mail";
                    FormatAddr.OwnAddressLetterWindow(CoAddrSenderLineG, OwnDelivAddressG);
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfoG);
                    CoTelephoneG := CompanyInfoG."Phone No.";
                    CoFaxG := CompanyInfoG."Fax No.";
                    CoEmailG := CompanyInfoG."E-Mail";
                    FormatAddr.CompanyLetterAddressWindow(CoAddrSenderLineG, CompanyInfoG);
                END;

                BankAccountNoG := "Bank Account No.";
                BankIbanG := IBAN;
                BankSwiftG := "SWIFT Code";

                bankAccount.RESET;
                IF bankAccount.GET("Sales Credit Memo Header"."Bank Account Code") THEN BEGIN
                    BankNameG := bankAccount.Name;
                    BankBranchNoG := bankAccount."Bank Branch No."; //not used on layout
                                                                    //vapa??
                                                                    //  IF BankAccountNoG = '' THEN BEGIN
                                                                    //    BankAccountNoG := bankAccount."Bank Account No.";
                                                                    //    BankIbanG:= bankAccount.IBAN;
                                                                    //    BankSwiftG := bankAccount."SWIFT Code";
                                                                    //  END;
                END;

                FormatAddr.SalesCrMemoShipTo(ShipToAddrG, "Sales Credit Memo Header");

                // IF SalesAdvLetterHeaderG.GET("Sales Credit Memo Header"."Letter No.") THEN
                //  SalesAdvLetterHeaderG.CALCFIELDS("Amount Including VAT");
                //Stop API.1.0.1  02.05.18 PV

                DocFooter.SETFILTER("Language Code", '%1|%2', '', "Language Code");
                IF DocFooter.FINDLAST THEN
                    DocFooterText := DocFooter."Footer Text"
                ELSE
                    DocFooterText := '';

                IF "Currency Code" = '' THEN
                    "Currency Code" := GeneralLedgerSetup."LCY Code";

                IF ("Currency Factor" <> 0) AND ("Currency Factor" <> 1) THEN BEGIN
                    CurrExchRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate := ROUND(1 / "Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.00001);
                    ExchRateText :=
                      STRSUBSTNO(Text009Txt, CalculatedExchRate, GeneralLedgerSetup."LCY Code",
                        CurrExchRate."Exchange Rate Amount", "Currency Code");
                END ELSE
                    CalculatedExchRate := 1;

                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Credit Memo Header");
                //Start API.1.0.1  02.05.18 PV
                IF NOT CustG.GET("Bill-to Customer No.") THEN
                    IF NOT CustG.GET("Sell-to Customer No.") THEN
                        CustG."No." := "Sell-to Customer No.";

                CLEAR(OrderCustAddrG);
                IF "Sales Credit Memo Header"."Sell-to Customer No." <> "Sales Credit Memo Header"."Bill-to Customer No." THEN BEGIN
                    FormatAddr.SalesCrMemoCust(OrderCustAddrG, "Sales Credit Memo Header");
                    OrderCustAddrLineG := FormatAddr.GetWindowAddress(C_INC005);
                END ELSE
                    OrderCustAddrLineG := '';

                IF NOT SalesPurchG.GET("Salesperson Code") THEN
                    SalesPurchG.Name := "Salesperson Code";

                GetAdvanceLink("Sales Credit Memo Header"."No.", "Sales Credit Memo Header"."Letter No.");
                //Stop API.1.0.1  02.05.18 PV

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT
                ELSE
                    PaymentMethod.GET("Payment Method Code");
            end;

            trigger OnPreDataItem()
            begin
                //Start API.1.0.1  02.05.18 PV
                //"Company Information"
                CompanyInfoG.GET;
                GLSetupG.GET;
                GeneralLedgerSetup.GET;
                //Stop API.1.0.1  02.05.18 PV
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
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
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

    trigger OnPreReport()
    begin
        //Start API.1.0.2
        GetReportSelection;
        //Stop API.1.0.2
    end;

    var
        LanguageG: Record Language;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CurrExchRate: Record "Currency Exchange Rate";
        DocFooter: Record "Document Footer";
        VATClause: Record "VAT Clause";
        VATPostingSetup: Record "VAT Posting Setup";
        FormatAddr: Codeunit "Format Address";
        ExchRateText: Text[50];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        DocFooterText: Text[250];
        CalculatedExchRate: Decimal;
        NoOfCopies: Integer;
        CopyNo: Integer;
        NoOfLoops: Integer;
        Text009Txt: Label 'Exchange Rate %1 %2 / %3 %4', Comment = '%1=calculatedexchrate;%2=general ledger setup.LCY Code;%3=currexchrate.exchange rate amount;%4=currency code';
        DocumentLbl: Label 'VAT Credit Memo to Received Payment';
        PageLbl: Label 'Page';
        CopyLbl: Label 'Copy';
        VendLbl: Label 'Vendor';
        CustLbl: Label 'Customer';
        SalespersonLbl: Label 'Salesperson';
        CreatorLbl: Label 'Posted by';
        VATIdentLbl: Label 'VAT Recapitulation';
        VATPercentLbl: Label 'VAT %';
        VATBaseLbl: Label 'VAT Base';
        VATAmtLbl: Label 'VAT Amount';
        TotalLbl: Label 'total';
        VATLbl: Label 'VAT';
        AdvanceLetterLbl: Label 'VAT Document to Advance Letter';
        _incLocalization: Integer;
        ReportSelectionsG: Record "Report Selection";
        ReportSelectionG: Record "Report Selection";
        PrinterSelectionG: Record "Printer Selection";
        ReportLayoutSetupG: Record "Report Layout Setup";
        PrintAddrBlockG: Boolean;
        PrintFooterLineG: Boolean;
        UserSessionG: Codeunit "User Session Unit";
        IsRepSelectionSetupAvailableG: Boolean;
        ReportTitleG: Text[250];
        OrderCustAddrG: array[8] of Text[50];
        OrderCustAddrLineG: Text[250];
        LocationG: Record Location;
        CompanyInfoG: Record "Company Information";
        CompanyAddrG: array[8] of Text[50];
        IntCustG: Code[20];
        OwnDelivAddressG: Record "Ship-to Address";
        CoAddrSenderLineG: array[8] of Text[50];
        CoTelephoneG: Text[30];
        CoFaxG: Text[30];
        CoEmailG: Text[80];
        CoTelephoneTextG: Text[30];
        CoFaxTextG: Text[30];
        CoEmailTextG: Text[80];
        DuplicateTextG: Text[30];
        CustG: Record Customer;
        ShipToAddrG: array[8] of Text[50];
        SalesPurchG: Record "Salesperson/Purchaser";
        "_API.1_": Integer;
        LogoPositiononDocuments_SalesReceivablesSetup: Integer;
        BankNameG: Text[50];
        BankBranchNoG: Text[20];
        BankSwiftG: Code[20];
        BankIbanG: Code[50];
        BankAccountNoG: Text[34];
        PaymentMethodG: Record "Payment Method";
        PrintDocTitleAndNoUpG: Boolean;
        TitleTextLeftG: Text;
        TitleTextCenterG: Text;
        TitleTextRightG: Text;
        ShowDuplicateImageG: Boolean;
        EmployeeFullNameG: Text;
        GLSetupG: Record "General Ledger Setup";
        ShowTaxNoG: Boolean;
        SalesAdvLetterHeaderG: Record "Sales Advance Letter Header";
        GeneralLedgerSetup: Record "General Ledger Setup";
        C_INC005: Label ', ';
        ColonLbl: Label ': ';
        SlashLbl: Label ' / ';
        ReceiverLbl: Label 'Receiver';
        IssuedByLbl: Label 'Document Issued By';
        TaxRegNoLbl: Label 'Tax Reg.No.';
        VATRegNoLbl: Label 'VAT Reg.No.';
        RegNoLbl: Label 'Reg. No.';
        IbanSwiftLbl: Label 'IBAN/SWIFT';
        DocumentDateLbl: Label 'Date of Issue';
        BankInstitutionLbl: Label 'Banking Institution';
        PaymentMethodDescLbl: Label 'Payment method';
        BankAccountNoLbl: Label 'Account No.';
        PhoneLbl: Label 'Phone';
        SwiftLbl: Label 'SWIFT';
        DateOfIssueLbl: Label 'Date of Issue';
        VATDateLbl: Label 'VAT Date';
        BillToLbl: Label 'Bill-to';
        ShipToLbl: Label 'Final receiver';
        SellToLbl: Label 'Customer';
        VendorLbl: Label 'Vendor';
        ToDateLbl: Label 'to date';
        PayedAmountLbl: Label 'Payed amount';
        AdvancelinkG: Record "Advance Link";
        ReasonCodeG: Record "Reason Code";
        OrderNoG: Code[20];
        OrderNoLbl: Label 'Order No.';
        AppliesToDocNoLbl: Label 'Applied to';
        ReasonCodeLbl: Label 'Reason Code';
        SalesPurchNameLbl: Label 'Salesperson';
        VehicleSalesRepSelectionG: Record "Vehicle Sales Rep. Selection";
        ServiceManagRepSelectionG: Record "Service Manag. Rep. Selection";

    [Scope('Internal')]
    procedure RDLHideOutput(ShowOutputP: Boolean): Boolean
    begin
        // @ Use this function to transfer to RDL the ShowOutput statement as Hidden Visibility
        // @ param ShowOutputP - Boolean
        // @ retval - Boolean
        // Start PA033890.9272400
        EXIT(NOT ShowOutputP);
        // Stop PA033890.9272400
    end;

    [Scope('Internal')]
    procedure GetReportSelection()
    var
        RecordRefL: RecordRef;
        ReportIDTextL: Text;
        ReportIDL: Integer;
    begin
        // @ This function sets request page filters from Report Selection setup through User Session Unit.
        //Start API.1.0.2
        ReportSelectionsG."Print Sent-From Line" := TRUE;
        ReportSelectionsG."Print Address Block" := TRUE;
        ReportSelectionsG."Print Footer Line" := TRUE;
        UserSessionG.GetRecordRef(RecordRefL);
        ReportTitleG := DocumentLbl;
        UserSessionG.GetRecordRef(RecordRefL);

        CASE RecordRefL.NUMBER OF
            DATABASE::"Report Selection":
                BEGIN
                    RecordRefL.SETTABLE(ReportSelectionsG);
                    IF ReportSelectionsG."Print Report Title" THEN
                        ReportTitleG := ReportSelectionsG."Report Title"
                    ELSE BEGIN
                        ReportSelectionsG.CALCFIELDS("Report Caption");
                        ReportTitleG := COPYSTR(ReportSelectionsG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
                    END;
                END;
            DATABASE::"Vehicle Sales Rep. Selection":
                BEGIN
                    RecordRefL.SETTABLE(VehicleSalesRepSelectionG);
                    IF VehicleSalesRepSelectionG."Print Report Title" THEN
                        ReportTitleG := VehicleSalesRepSelectionG."Report Title"
                    ELSE BEGIN
                        VehicleSalesRepSelectionG.CALCFIELDS("Report Caption");
                        ReportTitleG := COPYSTR(VehicleSalesRepSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
                    END;
                END;
            DATABASE::"Service Manag. Rep. Selection":
                BEGIN
                    RecordRefL.SETTABLE(ServiceManagRepSelectionG);
                    IF ServiceManagRepSelectionG."Print Report Title" THEN
                        ReportTitleG := ServiceManagRepSelectionG."Report Title"
                    ELSE BEGIN
                        ServiceManagRepSelectionG.CALCFIELDS("Report Caption");
                        ReportTitleG := COPYSTR(ServiceManagRepSelectionG."Report Caption", 1, MAXSTRLEN(ReportTitleG));
                    END;
                END;
        END;

        // API.1      01.03.18 PV note: PrintAddrBlockG is used to (not)show just for some data ("VAT Registration No.") in layout
        //    and (not) fill email, fax and phone - usage is not consistent
        PrintAddrBlockG := ReportSelectionsG."Print Address Block";
        PrintFooterLineG := ReportSelectionsG."Print Footer Line";
        ReportIDTextL := CurrReport.OBJECTID(FALSE);
        WHILE STRPOS(ReportIDTextL, ' ') > 0 DO
            ReportIDTextL := DELSTR(ReportIDTextL, 1, STRPOS(ReportIDTextL, ' '));
        EVALUATE(ReportIDL, ReportIDTextL);
        NoOfCopies := PrinterSelectionG.GetNoOfCopies(ReportIDL);
        //Stop API.1.0.2
    end;

    local procedure SetTitles()
    var
        headerGraphicCount: Integer;
    begin
        // @ This function sets variables to  identify whether and where (not) to print Report title and "Document No.", ... on layout
        // Start API.1      01.03.18 PV
        PrintDocTitleAndNoUpG := (ReportLayoutSetupG."Auth. Left Line 1" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 2" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 3" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 4" = '')
                              AND (ReportLayoutSetupG."Auth. Left Line 5" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 1" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 2" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 3" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 4" = '')
                              AND (ReportLayoutSetupG."Auth. Center Line 5" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 1" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 2" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 3" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 4" = '')
                              AND (ReportLayoutSetupG."Auth. Right Line 5" = '');

        headerGraphicCount := 0;
        IF PrintDocTitleAndNoUpG THEN BEGIN
            IF (ReportLayoutSetupG."Header Graphic Left".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := '';
                TitleTextCenterG := ReportTitleG;
                TitleTextRightG := "Sales Credit Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Center".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := '';
                TitleTextRightG := "Sales Credit Memo Header"."No.";
            END;
            IF (ReportLayoutSetupG."Header Graphic Right".HASVALUE) THEN BEGIN
                headerGraphicCount += 1;
                TitleTextLeftG := ReportTitleG;
                TitleTextCenterG := "Sales Credit Memo Header"."No.";
                TitleTextRightG := '';
            END;
        END ELSE BEGIN
            TitleTextLeftG := '';
            TitleTextCenterG := '';
            TitleTextRightG := '';
        END;
        IF headerGraphicCount > 1 THEN
            PrintDocTitleAndNoUpG := FALSE;
        // Stop API.1      01.03.18 PV
    end;

    local procedure GetUserIDFullName(UserIDP: Code[50]) FullNameR: Text
    var
        userSetupL: Record "User Setup";
        employeeL: Record Employee;
    begin
        // @ This function get fullname from Employee table of passed user id
        // @ param UserIDP - Code[50]
        // @ retval FullNameR - Text
        // Start API.1      01.03.18 PV
        FullNameR := '';
        IF userSetupL.GET(UserIDP) THEN BEGIN
            IF employeeL.GET(userSetupL."Employee No.") THEN
                FullNameR := employeeL.FullName;
        END;
        EXIT(FullNameR);
        // Stop API.1      01.03.18 PV
    end;

    local procedure GetAdvanceLink(VATDocLetterNoP: Code[20]; LetterNoP: Code[20])
    begin
        // Start API.1.0.2
        AdvancelinkG.RESET;
        AdvancelinkG.SETRANGE("Entry Type", AdvancelinkG."Entry Type"::Application);
        //AdvancelinkG.SETRANGE("Document No.", LetterNoP);
        //AdvancelinkG.SETRANGE("Invoice No.", VATDocLetterNoP);
        AdvancelinkG.SETRANGE("Document No.", VATDocLetterNoP);
        AdvancelinkG.SETRANGE(Type, AdvancelinkG.Type::Sale);
        IF NOT AdvancelinkG.FINDSET THEN
            AdvancelinkG.INIT;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        //API.1.0.4 - CZ.P0096
        EXIT(CurrReport.PREVIEW OR MailManagement.IsHandlingGetEmailBody);
        //API.1.0.4 - CZ.P0096
    end;
}


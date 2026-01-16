
report 80047 "Mass Uncert. Payer Get Cust"
{
    Caption = 'Mass Uncertainty Payer Get Cust';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Blocked = FILTER(<> All));
            RequestFilterFields = "No.", "Customer Posting Group", "Country/Region Code", "Tax Area Code";

            trigger OnAfterGetRecord()
            begin
                if UncPayerMgt.IsVATRegNoExportPossible("VAT Registration No.", "Country/Region Code") then begin
                    UncPayerMgt.AddVATRegNoToBuffer("VAT Registration No.");
                    CustCount += 1;
                end;
            end;

            trigger OnPostDataItem()
            begin
                if CustCount > 0 then
                    UncPayerMgt.ImportUncPayerStatus(false);

                if GuiAllowed then
                    Message(SuccessfullyMsg);
            end;

            trigger OnPreDataItem()
            begin
                if GuiAllowed then
                    if not Confirm(UpdatedStatusQst, true, Count) then
                        Error('');
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
                    field(ActOnlyUncert; ActOnlyUncert)
                    {
                        ApplicationArea = Basic, Suite;
                        AssistEdit = true;
                        Caption = 'Actualize Only Uncertainly';
                        Editable = false;
                        ExtendedDatatype = URL;
                        Style = Strong;
                        StyleExpr = true;
                        ToolTip = 'Specifies if this batch job has to be only uncertainly payer actualized.';

                        trigger OnAssistEdit()
                        begin
                            UncPayerMgt.ImportUncPayerList(true);
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        ElectronicallyGovernSetup.Get();
        ElectronicallyGovernSetup.TestField(UncertaintyPayerWebService);
    end;

    var
        ElectronicallyGovernSetup: Record "Electronically Govern. Setup";
        UncPayerMgt: Codeunit "Unc. Payer Mgt.";
        CustCount: Integer;
        ActOnlyUncert: Text[10]; // Correct declaration with length
        UpdatedStatusQst: Label 'Really actualize uncertainty status for %1 customers?', Comment = '%1=COUNT';
        SuccessfullyMsg: Label 'Uncertainty status actualize succesfully.';

}
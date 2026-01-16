report 80008 "DPG Multiple Update Ares" // 1057704 "Multiple Update Ares"
{
    // --- NML SOL ---
    // --- DAFCZ ---
    // DAFCZ0004  27.08.21 MG DAFCZ.1 NEW OBJECT

    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Registration No.";

            trigger OnAfterGetRecord()
            var
                RegistrationLogL: Record "Registration Log";
                RegLookupExtDataHndlL: Codeunit "Reg. Lookup Ext. Data Hndl";
            begin
                IF FreeRequestCountG <= UsedRequestCountG THEN
                    CurrReport.BREAK;
                IF (NOT AresManagementG.IsCustomerOrVendorInBuffer(Customer."No.", Customer.RECORDID.TABLENO, RequestOutOfBufferG))
                  AND (NOT AresManagementG.IsCustomerOrVendorExcluded(Customer."No.", Customer.RECORDID.TABLENO)) THEN
                    IF Customer."Registration No." = '' THEN BEGIN
                        MissingRegistrationNoG += 1;
                        IF CustomerFilterG = '' THEN
                            CustomerFilterG := Customer."No."
                        ELSE
                            IF STRLEN(CustomerFilterG) <= 1003 THEN
                                CustomerFilterG := STRSUBSTNO('%1|%2', CustomerFilterG, Customer."No.");
                    END
                    ELSE BEGIN
                        RegistrationLogL.INIT;
                        RegistrationLogL."Account Type" := RegistrationLogL."Account Type"::Customer;
                        RegistrationLogL."Account No." := Customer."No.";
                        RegistrationLogL."Registration No." := Customer."Registration No.";
                        AresManagementG.RUN(RegistrationLogL);
                        UsedRequestCountG += 1;
                    END;
                WindowG.UPDATE(1, (UsedRequestCountG / FreeRequestCountG * 10000) DIV 1);
            end;
        }
        dataitem(Vendor; Vendor)
        {

            trigger OnAfterGetRecord()
            var
                RegistrationLogL: Record "Registration Log";
                RegLookupExtDataHndlL: Codeunit "Reg. Lookup Ext. Data Hndl";
            begin
                IF FreeRequestCountG <= UsedRequestCountG THEN
                    CurrReport.BREAK;
                IF (NOT AresManagementG.IsCustomerOrVendorInBuffer(Vendor."No.", Vendor.RECORDID.TABLENO, RequestOutOfBufferG))
                  AND (NOT AresManagementG.IsCustomerOrVendorExcluded(Vendor."No.", Vendor.RECORDID.TABLENO)) THEN BEGIN
                    IF Vendor."Registration No." = '' THEN BEGIN
                        MissingRegistrationNoG += 1;
                        IF VendorFilterG = '' THEN
                            VendorFilterG := Vendor."No."
                        ELSE
                            IF STRLEN(VendorFilterG) <= 1003 THEN
                                VendorFilterG := STRSUBSTNO('%1|%2', VendorFilterG, Vendor."No.");
                    END
                    ELSE BEGIN
                        RegistrationLogL.INIT;
                        RegistrationLogL."Account Type" := RegistrationLogL."Account Type"::Vendor;
                        RegistrationLogL."Account No." := Vendor."No.";
                        RegistrationLogL."Registration No." := Vendor."Registration No.";
                        AresManagementG.RUN(RegistrationLogL);
                        UsedRequestCountG += 1;
                    END;
                END;
                WindowG.UPDATE(1, (UsedRequestCountG / FreeRequestCountG * 10000) DIV 1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Nastavení")
                {
                    Caption = 'Options';
                    field(RequestOutofBuffer; RequestOutOfBufferG)
                    {
                        Caption = 'Request Out of Buffer';
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

    trigger OnInitReport()
    begin
        RequestOutOfBufferG := TRUE;
    end;

    trigger OnPostReport()
    var
        CustomerListL: Page "Customer List";
        VendorListL: Page "Vendor List";
        CustomerL: Record Customer;
        VendorL: Record Vendor;
    begin
        WindowG.CLOSE;
        AresManagementG.SetCountofUsedRequest(UsedRequestCountG);
        IF CustomerFilterG <> '' THEN BEGIN
            CustomerL.SETFILTER("No.", CustomerFilterG);
            CustomerListL.LOOKUPMODE(TRUE);
            CustomerListL.EDITABLE(TRUE);
            CustomerListL.SETTABLEVIEW(CustomerL);
            CustomerListL.RUN;
        END;

        IF VendorFilterG <> '' THEN BEGIN
            VendorL.SETFILTER("No.", VendorFilterG);
            VendorListL.LOOKUPMODE(TRUE);
            VendorListL.EDITABLE(TRUE);
            VendorListL.SETTABLEVIEW(VendorL);
            VendorListL.RUN;
        END;
    end;

    trigger OnPreReport()
    begin
        FreeRequestCountG := AresManagementG.GetFreeRequestCount();
        IF FreeRequestCountG <= 0 THEN
            ERROR(NoFreeRequest_ErrTEXT);
        CLEAR(UsedRequestCountG);
        CLEAR(MissingRegistrationNoG);
        CLEAR(CustomerFilterG);
        WindowG.OPEN(ProcessingData_TEXT);
    end;

    var
        AresManagementG: Codeunit "DPG Ares Management";
        FreeRequestCountG: Integer;
        NoFreeRequest_ErrTEXT: Label 'There is no free request.';
        RequestOutOfBufferG: Boolean;
        UsedRequestCountG: Integer;
        MissingRegistrationNoG: Integer;
        CustomerFilterG: Text;
        VendorFilterG: Text;
        WindowG: Dialog;
        ProcessingData_TEXT: Label 'Processing data... @1@@@@@@@@@@';
}


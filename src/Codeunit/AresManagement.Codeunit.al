codeunit 80000 "DPG Ares Management" // 1057706 "Ares Management"
{
    // --- NML SOL ---
    // --- DAFCZ ---
    // DAFCZ0004  29.08.21 MG DAFCZ.1 NEW OBJECT

    TableNo = "Registration Log";
    Permissions =
        tabledata "Address Salutation" = R,
        tabledata Customer = RM,
        tabledata "DPG Ares Excluded Cust./Vendor" = RIM,
        tabledata "DPG Ares Setup" = RM,
        tabledata "General Ledger Setup" = R,
        tabledata "Registration Log" = RM,
        tabledata TempBlob = RIM,
        tabledata Vendor = RM;

    trigger OnRun()
    var
        AresUpdateL: Report "Ares Update";
        CompanyInfoL: Record "Company Information";
        CountryCodeL: Code[10];
        ContractUpdateSetupL: Record "Contact Online Update Setup";
        RegLookupExtDataHndL: Codeunit "Reg. Lookup Ext. Data Hndl";
    begin
        RegistrationLogG := Rec;

        LookupRegistrationFromService(TRUE);

        Rec := RegistrationLogG;
    end;

    var
        //OnlineSetupErr: Label 'On-line setup for country code %1 is missing.';
        RegistrationLogMgt: Codeunit "Registration Log Mgt.";
        NamespaceTxt: Label 'http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_datatypes/v_1.0.3', Locked = true;
        ResponseTempBlob: Record TempBlob;
        AddressMgtG: Codeunit "Address Management";
        RegistrationLogG: Record "Registration Log";
        T225Fnc: Codeunit "ET4,9,79,92,93,225,260,270,277";
        //InvalidMsg: Label '%1 %2 is not valid.', Comment = '%1=Caption;%2=VATReqNo';
        ProcessingData_TEXT: Label 'Processing data... @1@@@@@@@@@@';
        NothingToHandleErr: Label 'Nothing to handle.';

    [Scope('Internal')]
    procedure MassiveUpdate(FilterP: Text)
    var
        RegistrationLogL: Record "Registration Log";
        WindowL: Dialog;
        TotalCountL: Integer;
        ActualCountL: Integer;
    begin
        RegistrationLogL.RESET;
        RegistrationLogL.SETFILTER("Entry No.", FilterP);
        RegistrationLogL.SETRANGE(Status, RegistrationLogL.Status::Valid);
        TotalCountL := RegistrationLogL.COUNT;
        ActualCountL := 0;
        IF NOT RegistrationLogL.FINDFIRST THEN
            ERROR(NothingToHandleErr);
        WindowL.OPEN(ProcessingData_TEXT);
        REPEAT
            IF RegistrationLogL."Account Type" = RegistrationLogL."Account Type"::Customer THEN
                UpdateCustomer(RegistrationLogL);
            IF RegistrationLogL."Account Type" = RegistrationLogL."Account Type"::Vendor THEN
                UpdateVendor(RegistrationLogL);
            ActualCountL += 1;
            WindowL.UPDATE(1, (ActualCountL / TotalCountL * 10000) DIV 1);
        UNTIL RegistrationLogL.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure GetFreeRequestCount(): Integer
    var
        AresSetupL: Record "DPG Ares Setup";
    begin
        AresSetupL.GET;
        IF (AresSetupL."Last Request Date" = TODAY) THEN
            EXIT(AresSetupL."Daily Request Limit" - AresSetupL."Count of Used Request");

        AresSetupL."Last Request Date" := TODAY;
        AresSetupL."Count of Used Request" := 0;
        AresSetupL.MODIFY;
        EXIT(AresSetupL."Daily Request Limit" - AresSetupL."Count of Used Request");
    end;

    [Scope('Internal')]
    procedure SetCountofUsedRequest(UsedRequestCountP: Integer)
    var
        AresSetupL: Record "DPG Ares Setup";
    begin
        AresSetupL.GET;
        AresSetupL."Count of Used Request" := AresSetupL."Count of Used Request" + UsedRequestCountP;
        AresSetupL.MODIFY;
    end;

    [Scope('Internal')]
    procedure IsCustomerOrVendorInBuffer(NoP: Code[20]; TableNoP: Integer; OutOfBufferP: Boolean): Boolean
    var
        RegistrationLogL: Record "Registration Log";
    begin
        IF NOT OutOfBufferP THEN
            EXIT(FALSE);
        RegistrationLogL.RESET;
        IF TableNoP = DATABASE::Customer THEN
            RegistrationLogL.SETRANGE("Account Type", RegistrationLogL."Account Type"::Customer);
        IF TableNoP = DATABASE::Vendor THEN
            RegistrationLogL.SETRANGE("Account Type", RegistrationLogL."Account Type"::Vendor);
        RegistrationLogL.SETRANGE("Account No.", NoP);
        EXIT(NOT RegistrationLogL.IsEmpty());
    end;

    [Scope('Internal')]
    procedure IsCustomerOrVendorExcluded(NoP: Code[20]; TableNoP: Integer): Boolean
    var
        AresExcludedCustomerVendorL: Record "DPG Ares Excluded Cust./Vendor";
    begin
        AresExcludedCustomerVendorL.RESET;
        IF TableNoP = DATABASE::Customer THEN
            IF AresExcludedCustomerVendorL.GET(AresExcludedCustomerVendorL."Account Type"::Customer, NoP) THEN
                EXIT(TRUE);

        IF TableNoP = DATABASE::Vendor THEN
            IF AresExcludedCustomerVendorL.GET(AresExcludedCustomerVendorL."Account Type"::Vendor, NoP) THEN
                EXIT(TRUE);

        EXIT(FALSE);
    end;

    local procedure SendRequest(ShowErrors: Boolean; var ResponseInStream: InStream)
    var
        GLSetup: Record "General Ledger Setup";
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        HttpStatusCode: DotNet HttpStatusCode;
        ResponseHeaders: DotNet NameValueCollection;
        URL: Text;
        RegLookupExtDataHndl: codeunit "Reg. Lookup Ext. Data Hndl";
        ErrorTextL: text;
    begin
        GLSetup.GET;
        GLSetup.TESTFIELD("Reg. No. Validation URL");

        // Start INCCZ20182 MG SOL.2.1.11
        //URL := STRSUBSTNO('%1?ico=%2',GLSetup."Reg. No. Validation URL",RegistrationLog."Registration No.");
        URL := STRSUBSTNO('%1/%2', RegLookupExtDataHndl.GetRegistrationNoValidationWebServiceURL, RegistrationLogG."Registration No.");
        // Stop INCCZ20182 MG SOL.2.1.11

        HttpWebRequestMgt.Initialize(URL);
        // Start INCCZ20182 MG SOL.2.1.11
        HttpWebRequestMgt.SetContentType('application/json; charset=utf-8');
        HttpWebRequestMgt.SetReturnType('application/json; charset=utf-8');
        HttpWebRequestMgt.AddSecurityProtocolTls12;
        IF NOT GUIALLOWED THEN
            // Stop INCCZ20182 MG SOL.2.1.11
            HttpWebRequestMgt.DisableUI;

        IF NOT HttpWebRequestMgt.GetResponse(ResponseInStream, HttpStatusCode, ResponseHeaders) AND ShowErrors THEN begin
            HttpWebRequestMgt.ProcessFaultResponse2('');
            ErrorTextL := HttpWebRequestMgt.GetErrorText();
        end;
    end;

    local procedure InsertLogEntry(JSONText: Text)
    var
        XMLDOMManagement: Codeunit "XML DOM Management";
        XmlDoc: DotNet XmlDocument;
    begin
        //        XMLDOMManagement.LoadXMLDocumentFromInStream(ResponseInStream, XmlDoc);
        //        RegistrationLogMgt.LogVerification(RegistrationLogG, XmlDoc, NamespaceTxt);

        // Start INCCZ20182 MG SOL.2.1.11
        RegistrationLogMgt.LogVerification2(RegistrationLogG, JSONText);
        // Stop INCCZ20182 MG SOL.2.1.11

        CheckLogVsCard(RegistrationLogG);
    end;

    local procedure LookupRegistrationFromService(ShowErrors: Boolean)
    var
        ResponseInStream: InStream;
        JSONString: Text;
    begin
        CLEAR(ResponseTempBlob);
        ResponseTempBlob.INIT;
        ResponseTempBlob.Blob.CREATEINSTREAM(ResponseInStream);

        SendRequest(ShowErrors, ResponseInStream);

        // Start INCCZ20182 MG SOL.2.1.11
        JSONString := ResponseTempBlob.ReadAsText('', TEXTENCODING::UTF8);
        InsertLogEntry(JSONString);
        // Stop INCCZ20182 MG SOL.2.1.11
        //        InsertLogEntry(ResponseInStream);

        COMMIT;
    end;

    local procedure CheckLogVsCard(RegistrationLogP: Record "Registration Log")
    var
        CustomerL: Record Customer;
        VendorL: Record Vendor;
    begin
        IF RegistrationLogP."Account Type" = RegistrationLogP."Account Type"::Customer THEN
            IF CustomerL.GET(RegistrationLogP."Account No.") THEN
                IF (CustomerL.Name = RegistrationLogP."Verified Name") AND (CustomerL.Address = RegistrationLogP."Verified Address") AND (CustomerL.City = RegistrationLogP."Verified City")
                  AND (CustomerL."Post Code" = RegistrationLogP."Verified Post Code") AND (CustomerL."VAT Registration No." = RegistrationLogP."Verified VAT Registration No.") AND
                  (CustomerL."Tax Registration No." = RegistrationLogP."Verified VAT Registration No.") THEN BEGIN
                    RegistrationLogP."DPG Up to Date" := TRUE;
                    RegistrationLogP.MODIFY;
                END;

        IF RegistrationLogP."Account Type" = RegistrationLogP."Account Type"::Vendor THEN
            IF VendorL.GET(RegistrationLogP."Account No.") THEN
                IF (VendorL.Name = RegistrationLogP."Verified Name") AND (VendorL.Address = RegistrationLogP."Verified Address") AND (VendorL.City = RegistrationLogP."Verified City")
                  AND (VendorL."Post Code" = RegistrationLogP."Verified Post Code") AND (VendorL."VAT Registration No." = RegistrationLogP."Verified VAT Registration No.") AND
                  (VendorL."Tax Registration No." = RegistrationLogP."Verified VAT Registration No.") THEN BEGIN
                    RegistrationLogP."DPG Up to Date" := TRUE;
                    RegistrationLogP.MODIFY;
                END;
    end;

    [Scope('Internal')]
    procedure OpenCard(RegistrationLogP: Record "Registration Log")
    var
        CustomerCardL: Page "Customer Card";
        CustomerL: Record Customer;
        VendorCardL: Page "Vendor Card";
        VendorL: Record Vendor;
    begin
        IF RegistrationLogP."Account Type" = RegistrationLogP."Account Type"::Customer THEN
            IF CustomerL.GET(RegistrationLogP."Account No.") THEN
                PAGE.RUN(PAGE::"Customer Card", CustomerL);

        IF RegistrationLogP."Account Type" = RegistrationLogP."Account Type"::Vendor THEN
            IF VendorL.GET(RegistrationLogP."Account No.") THEN
                PAGE.RUN(PAGE::"Vendor Card", VendorL);
    end;

    [Scope('Internal')]
    procedure ExcludeCustomerOrVendor(NoP: Code[20]; TableNoP: Integer)
    var
        AresExcludedCustomerVendorL: Record "DPG Ares Excluded Cust./Vendor";
    begin
        AresExcludedCustomerVendorL.INIT;
        IF TableNoP = DATABASE::Customer THEN
            AresExcludedCustomerVendorL."Account Type" := AresExcludedCustomerVendorL."Account Type"::Customer;
        IF TableNoP = DATABASE::Vendor THEN
            AresExcludedCustomerVendorL."Account Type" := AresExcludedCustomerVendorL."Account Type"::Vendor;
        AresExcludedCustomerVendorL."Account No." := NoP;
        AresExcludedCustomerVendorL.INSERT;
    end;

    local procedure UpdateCustomer(RegistrationLogP: Record "Registration Log")
    var
        CustContUpdate: Codeunit "CustCont-Update";
        Updated: Boolean;
        i: Integer;
        xRec: Record Customer;
        AddressSalutationL: Record "Address Salutation";
        Cust: Record Customer;
    begin
        IF NOT Cust.GET(RegistrationLogP."Account No.") THEN EXIT;
        IF IsCustomerOrVendorExcluded(RegistrationLogP."Account No.", DATABASE::Customer) THEN EXIT;
        xRec := Cust;

        WITH Cust DO BEGIN
            IF xRec."Last Name" <> COPYSTR(RegistrationLogP."Verified Name", 1, MAXSTRLEN("Last Name")) THEN BEGIN
                "First Name" := '';
                "Last Name" := COPYSTR(RegistrationLogP."Verified Name", 1, MAXSTRLEN("Last Name"));
                "Registered Name" := COPYSTR(RegistrationLogP."Verified Name", 1, MAXSTRLEN("Registered Name"));
                Name := AddressMgtG.CreateNameField('', "First Name", "Last Name", "Name 2");
                "Search Name" := AddressMgtG.UpdateSearchNameField(
                  xRec."Search Name",
                  xRec."First Name",
                  xRec."Last Name",
                  xRec."Name 2",
                  "First Name",
                  "Last Name",
                  "Name 2");
                CreateAddress(FALSE);
            END;
            "Address 2" := '';
            Address := COPYSTR(RegistrationLogP."Verified Address", 1, MAXSTRLEN(Address));
            IF STRLEN(RegistrationLogP."Verified Address") > MAXSTRLEN(Address) THEN
                "Address 2" := COPYSTR(RegistrationLogP."Verified Address", MAXSTRLEN(Address) + 1, MAXSTRLEN("Address 2"));
            City := COPYSTR(RegistrationLogP."Verified City", 1, MAXSTRLEN(City));
            "Post Code" := T225Fnc.T225_FormatPostCode(COPYSTR(RegistrationLogP."Verified Post Code", 1, MAXSTRLEN("Post Code")));
            VALIDATE("VAT Registration No.",
              COPYSTR(RegistrationLogP."Verified VAT Registration No.", 1, MAXSTRLEN("VAT Registration No.")));
            Updated := TRUE;

            IF Updated THEN BEGIN
                AddressSalutationL.SETRANGE("Customer Type", AddressSalutationL."Customer Type"::Business);
                AddressSalutationL.FindFirst();
                VALIDATE("Address Salutation Code", AddressSalutationL.Code);
                MODIFY(TRUE);
                CustContUpdate.OnModify(Cust);
            END;
            RegistrationLogP."DPG Up to Date" := TRUE;
            RegistrationLogP.MODIFY;
        END;
    end;

    [Scope('Internal')]
    procedure UpdateVendor(RegistrationLogP: Record "Registration Log")
    var
        VendContUpdate: Codeunit "VendCont-Update";
        Updated: Boolean;
        i: Integer;
        xRec: Record Vendor;
        Vend: Record Vendor;
    begin
        IF NOT Vend.GET(RegistrationLogP."Account No.") THEN EXIT;
        IF IsCustomerOrVendorExcluded(RegistrationLogP."Account No.", DATABASE::Vendor) THEN EXIT;
        WITH Vend DO BEGIN
            IF xRec."Last Name" <> COPYSTR(RegistrationLogP."Verified Name", 1, MAXSTRLEN("Last Name")) THEN BEGIN
                "Last Name" := COPYSTR(RegistrationLogP."Verified Name", 1, MAXSTRLEN("Last Name"));
                "Registered Name" := COPYSTR(RegistrationLogP."Verified Name", 1, MAXSTRLEN("Registered Name"));
                Name := AddressMgtG.CreateNameField('', "First Name", "Last Name", "Name 2");
                "Search Name" := AddressMgtG.UpdateSearchNameField(
                  xRec."Search Name",
                  xRec."First Name",
                  xRec."Last Name",
                  xRec."Name 2",
                  "First Name",
                  "Last Name",
                  "Name 2");
                CreateAddress(FALSE);

            END;
            "Address 2" := '';
            Address := COPYSTR(RegistrationLogP."Verified Address", 1, MAXSTRLEN(Address));
            IF STRLEN(RegistrationLogP."Verified Address") > MAXSTRLEN(Address) THEN
                "Address 2" := COPYSTR(RegistrationLogP."Verified Address", MAXSTRLEN(Address) + 1, MAXSTRLEN("Address 2"));
            City := COPYSTR(RegistrationLogP."Verified City", 1, MAXSTRLEN(City));
            "Post Code" := T225Fnc.T225_FormatPostCode(COPYSTR(RegistrationLogP."Verified Post Code", 1, MAXSTRLEN("Post Code")));
            VALIDATE("VAT Registration No.",
              COPYSTR(RegistrationLogP."Verified VAT Registration No.", 1, MAXSTRLEN("VAT Registration No.")));
            Updated := TRUE;
            IF Updated THEN BEGIN
                MODIFY(TRUE);
                VendContUpdate.OnModify(Vend);
            END;
            RegistrationLogP."DPG Up to Date" := TRUE;
            RegistrationLogP.MODIFY;
        END;
    end;
}


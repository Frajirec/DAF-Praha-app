page 80019 "DPG Data Privacy FactBox"
{
    // --- API Customization ---
    // 79027073    27.08.20 RK DAFCZ.1 new object

    Caption = 'Data Privacy Log';
    Editable = false;
    PageType = CardPart;
    SourceTable = Contact;

    layout
    {
        area(content)
        {
            group(Business)
            {
                Caption = 'Business';
                field("ConsentStatusG[1]"; ConsentStatusG[1])
                {
                    Caption = 'Status Privacy Policy';

                    trigger OnDrillDown()
                    begin
                        // Start EU.0025812
                        DataPrivManagementG.ShowAvailableDataPrivList(
                          DataPrivSetupG."Check Modus"::CheckQuery,
                          FALSE,
                          DATABASE::Contact,
                          "No.",
                          FALSE);
                        // Stop EU.0025812
                    end;
                }
                field("ExpiryDateG[1]"; ExpiryDateG[1])
                {
                    Caption = 'Consent Expiration Date';
                }
                field("CustDisagreementG[1]"; CustDisagreementG[1])
                {
                    Caption = 'Customer Disagreement';
                }
            }
            group(Marketing)
            {
                Caption = 'Marketing';
                field("ConsentStatusG[2]"; ConsentStatusG[2])
                {
                    Caption = 'Status Privacy Policy';

                    trigger OnDrillDown()
                    begin
                        // Start EU.0025812
                        DataPrivManagementG.ShowAvailableDataPrivList(
                          DataPrivSetupG."Check Modus"::CheckQuery,
                          FALSE,
                          DATABASE::Contact,
                          "No.",
                          FALSE);
                        // Stop EU.0025812
                    end;
                }
                field("ExpiryDateG[2]"; ExpiryDateG[2])
                {
                    Caption = 'Consent Expiration Date';
                }
                field("CustDisagreementG[2]"; CustDisagreementG[2])
                {
                    Caption = 'Customer Disagreement';
                }
            }
            group("MAX")
            {
                Caption = 'MAX';
                field("ConsentStatusG[3]"; ConsentStatusG[3])
                {
                    Caption = 'Status Privacy Policy';

                    trigger OnDrillDown()
                    begin
                        // Start EU.0025812
                        DataPrivManagementG.ShowAvailableDataPrivList(
                          DataPrivSetupG."Check Modus"::CheckQuery,
                          FALSE,
                          DATABASE::Contact,
                          "No.",
                          FALSE);
                        // Stop EU.0025812
                    end;
                }
                field("ExpiryDateG[3]"; ExpiryDateG[3])
                {
                    Caption = 'Consent Expiration Date';
                }
                field("CustDisagreementG[3]"; CustDisagreementG[3])
                {
                    Caption = 'Customer Disagreement';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        MainConsentCodeL: Code[10];
    begin
        DataPrivacyEnableCheck();
        CLEAR(InterDataPrivQueryLogG."Privacy Policy Status");
        ContG := Rec;

        //LastDataPrivacyQueryDateG := 0D;
        FOR i := 1 TO 3 DO BEGIN
            CLEAR(RegMailG[i]);
            CLEAR(EMailG[i]);
            CLEAR(SMSG[i]);
            CLEAR(FaxG[i]);
            CLEAR(PhoneG[i]);
            CLEAR(MobPhoneG[i]);
            CLEAR(ConsentStatusG[i]);
            CLEAR(ExpiryDateG[i]);
            CLEAR(CustDisagreementG[i]);
        END;
        i := 0;

        InterDataPrivQueryLogG.RESET;
        InterDataPrivQueryLogG.SETCURRENTKEY("Contact / Contact Person No.");
        InterDataPrivQueryLogG.SETRANGE("Contact / Contact Person No.", "No.");
        IF NOT ConsentLevelSetupG.ISEMPTY THEN BEGIN
            ConsentLevelSetupG.RESET;
            IF ConsentLevelSetupG.FINDSET THEN
                REPEAT
                    InterDataPrivQueryLogG.SETRANGE("Consent Level Code", ConsentLevelSetupG."Consent Level Code");
                    IF InterDataPrivQueryLogG.FINDLAST THEN BEGIN
                        CASE ConsentLevelSetupG."Consent Level Code" OF
                            'BUSINESS':
                                i := 1;
                            'MARKETING':
                                i := 2;
                            'MAX':
                                i := 3;
                        END;
                        //ContG."Data Approval" := InterDataPrivQueryG.GetDataApprovalStatus(InterDataPrivQueryLogG);
                        //LastDataPrivacyQueryDateG := DT2DATE(InterDataPrivQueryLogG."Last Modified");

                        // Regular Mail
                        IF InterDataPrivQueryLogG."Question A1" THEN BEGIN
                            RegMailG[i] := STRSUBSTNO(C_INC_IsAllowed, C_INC_RegularMail);
                        END ELSE
                            RegMailG[i] := STRSUBSTNO(C_INC_IsMissing, C_INC_RegularMail);
                        // E-Mail
                        IF InterDataPrivQueryLogG."Question A2" THEN BEGIN
                            EMailG[i] := STRSUBSTNO(C_INC_IsAllowed, C_INC_EMail);
                        END ELSE
                            EMailG[i] := STRSUBSTNO(C_INC_IsMissing, C_INC_EMail);
                        // SMS
                        IF InterDataPrivQueryLogG."Question A3" THEN BEGIN
                            SMSG[i] := STRSUBSTNO(C_INC_IsAllowed, C_INC_SMS);
                        END ELSE
                            SMSG[i] := STRSUBSTNO(C_INC_IsMissing, C_INC_SMS);
                        // Fax
                        IF InterDataPrivQueryLogG."Question A4" THEN BEGIN
                            FaxG[i] := STRSUBSTNO(C_INC_IsAllowed, C_INC_Fax);
                        END ELSE
                            FaxG[i] := STRSUBSTNO(C_INC_IsMissing, C_INC_Fax);
                        // Phone
                        IF InterDataPrivQueryLogG."Question B1" THEN BEGIN
                            PhoneG[i] := STRSUBSTNO(C_INC_IsAllowed, C_INC_Phone);
                        END ELSE
                            PhoneG[i] := STRSUBSTNO(C_INC_IsMissing, C_INC_Phone);
                        // Mobile Phone
                        IF InterDataPrivQueryLogG."Question B2" THEN BEGIN
                            MobPhoneG[i] := STRSUBSTNO(C_INC_IsAllowed, C_INC_MobilePhone);
                        END ELSE
                            MobPhoneG[i] := STRSUBSTNO(C_INC_IsMissing, C_INC_MobilePhone);
                        // Privacy Policy Status
                        ConsentStatusG[i] := InterDataPrivQueryLogG."Privacy Policy Status" + 1;
                        // Expiry Date
                        ExpiryDateG[i] := InterDataPrivQueryLogG."Consent Expiration Date";
                        // Customer Disagreement
                        CustDisagreementG[i] := InterDataPrivQueryLogG."Customer Disagreement";
                    END;
                UNTIL ConsentLevelSetupG.NEXT = 0;
        END;
    end;

    var
        InterDataPrivSetupG: Record "Internat. Data Privacy Setup";
        //InterDataPrivQueryG: Record "Internat. Data Privacy Query";
        InterDataPrivQueryLogG: Record "Internat. Data Priv. Query Log";
        C_INC_IsAllowed: Label ' %1 Allowed';
        C_INC_IsMissing: Label '** %1 missing **';
        C_INC_RegularMail: Label 'Regular Mail';
        C_INC_EMail: Label 'E-Mail';
        ContG: Record Contact;
        ConsentLevelSetupG: Record "Consent Level";
        DataPrivSetupG: Record "Data Privacy Setup";
        //InterDataPrivCheckG: Codeunit "Internat. Data Privacy Check";
        DataPrivManagementG: Codeunit "Data Privacy Management";
        //LastDataPrivacyQueryDateG: Date;
        RegMailG: array[3] of Text[100];
        EMailG: array[3] of Text[100];
        SMSG: array[3] of Text[100];
        FaxG: array[3] of Text[100];
        PhoneG: array[3] of Text[100];
        MobPhoneG: array[3] of Text[100];
        C_INC_SMS: Label 'SMS';
        C_INC_Fax: Label 'Fax';
        C_INC_Phone: Label 'Phone';
        C_INC_MobilePhone: Label 'Mobile Phone';
        //Text19042668: Label ' ';
        i: Integer;
        ConsentStatusG: array[3] of Option "N/A","Not Completed","Completed Not Signed","Completed and Signed";
        ExpiryDateG: array[3] of Date;
        CustDisagreementG: array[3] of Boolean;

    [Scope('Internal')]
    procedure DataPrivacyEnableCheck()
    begin
        // Start PA036373
        IF NOT InterDataPrivSetupG.GET THEN
            InterDataPrivSetupG.INIT;
        // Stop PA036373
    end;
}

